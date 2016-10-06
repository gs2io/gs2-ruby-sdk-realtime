require 'gs2/core/AbstractClient.rb'

module Gs2 module Realtime
  
  # GS2-Realtime クライアント
  #
  # @author Game Server Services, Inc.
  class Client < Gs2::Core::AbstractClient
  
    @@ENDPOINT = 'realtime'
  
    # コンストラクタ
    # 
    # @param region [String] リージョン名
    # @param gs2_client_id [String] GSIクライアントID
    # @param gs2_client_secret [String] GSIクライアントシークレット
    def initialize(region, gs2_client_id, gs2_client_secret)
      super(region, gs2_client_id, gs2_client_secret)
    end
    
    # デバッグ用。通常利用する必要はありません。
    def self.ENDPOINT(v = nil)
      if v
        @@ENDPOINT = v
      else
        return @@ENDPOINT
      end
    end

    # ギャザリングプールリストを取得
    # 
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * gatheringPoolId => ギャザリングプールID
    #       * ownerId => オーナーID
    #       * name => ギャザリングプール名
    #       * description => 説明文
    #       * createAt => 作成日時
    #   * nextPageToken => 次ページトークン
    def describe_gathering_pool(pageToken = nil, limit = nil)
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Realtime', 
            'DescribeGatheringPool', 
            @@ENDPOINT, 
            '/gatheringPool',
            query);
    end
    
    # ギャザリングプールを作成<br>
    # <br>
    # GS2-Realtime を利用するには、まずギャザリングプールを作成する必要があります。<br>
    # ギャザリングプールには複数のギャザリングを紐付けることができます。<br>
    # 
    # @param request [Array]
    #   * name => マッチメイキング名
    #   * description => 説明文
    # @return [Array]
    #   * item
    #     * gatheringPoolId => ギャザリングプールID
    #     * ownerId => オーナーID
    #     * name => ギャザリングプール名
    #     * description => 説明文
    #     * createAt => 作成日時
    def create_gathering_pool(request)
      if not request; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('description'); body['description'] = request['description']; end
      query = {}
      return post(
            'Gs2Realtime', 
            'CreateGatheringPool', 
            @@ENDPOINT, 
            '/gatheringPool',
            body,
            query);
    end
  
    # ギャザリングプールを取得
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    # @return [Array]
    #   * item
    #     * gatheringPoolId => ギャザリングプールID
    #     * ownerId => オーナーID
    #     * name => ギャザリングプール名
    #     * description => 説明文
    #     * createAt => 作成日時
    def get_gathering_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Realtime',
          'GetGatheringPool',
          @@ENDPOINT,
          '/gatheringPool/' + request['gatheringPoolName'],
          query);
    end
  
    # ギャザリングプールを更新
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    #   * description => 説明文
    # @return [Array]
    #   * item
    #     * gatheringPoolId => ギャザリングプールID
    #     * ownerId => オーナーID
    #     * name => ギャザリングプール名
    #     * description => 説明文
    #     * createAt => 作成日時
    def update_gathering_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('description'); body['description'] = request['description']; end
      query = {}
      return put(
          'Gs2Realtime',
          'UpdateGatheringPool',
          @@ENDPOINT,
          '/gatheringPool/' + request['gatheringPoolName'],
          body,
          query);
    end
    
    # ギャザリングプールを削除
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    def delete_gathering_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Realtime', 
            'DeleteGatheringPool', 
            @@ENDPOINT, 
            '/gatheringPool/' + request['gatheringPoolName'],
            query);
    end
    
    # ギャザリングリストを取得
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * gatheringId => ギャザリングID
    #       * ownerId => オーナーID
    #       * name => ギャザリング名
    #       * hostId => ホストID
    #       * ipAddress => IPアドレス
    #       * port => 待ち受けポート
    #       * secret => 暗号鍵
    #       * userIds => 参加ユーザIDリスト
    #       * createAt => 作成日時
    #   * nextPageToken => 次ページトークン
    def describe_gathering(request, pageToken = nil, limit = nil)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Realtime', 
            'DescribeGathering', 
            @@ENDPOINT, 
            '/gatheringPool/' + request['gatheringPoolName'] + '/gathering',
            query);
    end
    
    # ギャザリングを作成<br>
    # <br>
    # ギャザリングを作成すると、ゲームサーバが起動します。<br>
    # ゲームサーバはWebSocketで接続することができ、同じゲームサーバに接続しているユーザ間でメッセージをやり取りすることができます。<br>
    # ゲームサーバとの通信プロトコルの説明については別途ドキュメントを確認してください。<br>
    # <br>
    # userIds にユーザIDを指定することで、ギャザリングに参加できるユーザのIDを制限することができます。<br>
    # ギャザリング作成時に参加するユーザが確定している場合は指定してください。<br>
    # 省略すると、暗号鍵を知っていれば誰でも参加することができます。<br>
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    #   * name => ギャザリング名
    #   * userIds => 参加ユーザIDリスト
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * ownerId => オーナーID
    #     * name => ギャザリング名
    #     * hostId => ホストID
    #     * ipAddress => IPアドレス
    #     * port => 待ち受けポート
    #     * secret => 暗号鍵
    #     * userIds => 参加ユーザIDリスト
    #     * createAt => 作成日時
    def create_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('userIds')
        body['userIds'] = request['userIds']
        if body['userIds'].is_a?(Array); body['userIds'] = body['userIds'].join(','); end
      end
      query = {}
      return post(
            'Gs2Realtime', 
            'CreateGathering', 
            @@ENDPOINT, 
            '/gatheringPool/' + request['gatheringPoolName'] + '/gathering',
            body,
            query);
    end
  
    # ギャザリングを取得
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    #   * gatheringName => ギャザリング名
    # @return [Array]
    #   * item
    #     * gatheringId => ギャザリングID
    #     * ownerId => オーナーID
    #     * name => ギャザリング名
    #     * hostId => ホストID
    #     * ipAddress => IPアドレス
    #     * port => 待ち受けポート
    #     * secret => 暗号鍵
    #     * userIds => 参加ユーザIDリスト
    #     * createAt => 作成日時
    def get_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringName'); raise ArgumentError.new(); end
      if not request['gatheringName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Realtime',
          'GetGathering',
          @@ENDPOINT,
          '/gatheringPool/' + request['gatheringPoolName'] + '/gathering/' + request['gatheringName'],
          query);
    end
    
    # ギャザリングを削除
    # 
    # @param request [Array]
    #   * gatheringPoolName => ギャザリングプール名
    #   * gatheringName => ギャザリング名
    def delete_gathering(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('gatheringPoolName'); raise ArgumentError.new(); end
      if not request['gatheringPoolName']; raise ArgumentError.new(); end
      if not request.has_key?('gatheringName'); raise ArgumentError.new(); end
      if not request['gatheringName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Realtime', 
            'DeleteGathering', 
            @@ENDPOINT, 
            '/gatheringPool/' + request['gatheringPoolName'] + '/gathering/' + request['gatheringName'],
            query);
    end
  end
end end