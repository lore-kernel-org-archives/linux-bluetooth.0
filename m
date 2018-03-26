Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5] Add support for requiring min key size for access GATT characteristics
Date: Mon, 26 Mar 2018 16:07:37 +0200
Message-ID: <2653731.9petFYBjHZ@ix>
In-Reply-To: <20180323130821.24265-1-szymon.janc@codecoup.pl>
References: <20180323130821.24265-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday, 23 March 2018 14:08:21 CEST Szymon Janc wrote:
> This allows to configure bluetoothd to require minimum encryption key
> size when accessing GATT server characteristics. It is a global
> configuration option affecting whole GATT database.
> ---
> V5: No changes, just rebase on top of master.
> 
>  peripheral/gatt.c        |  2 +-
>  src/adapter.c            | 45 ++++++++++++++++++++++++++++++++-------------
> src/device.c             | 15 +++++++++++++--
>  src/device.h             |  1 +
>  src/hcid.h               |  2 ++
>  src/main.c               | 17 ++++++++++++++---
>  src/main.conf            |  5 +++++
>  src/shared/att.c         | 22 +++++++++++++++++++---
>  src/shared/att.h         |  3 ++-
>  src/shared/gatt-client.c |  4 ++--
>  src/shared/gatt-server.c | 47
> +++++++++++++++++++++++++++++++++++++++-------- src/shared/gatt-server.h | 
> 3 ++-
>  tools/btgatt-server.c    |  2 +-
>  unit/test-gatt.c         |  2 +-
>  14 files changed, 134 insertions(+), 36 deletions(-)
> 
> diff --git a/peripheral/gatt.c b/peripheral/gatt.c
> index 5ae19a8e5..08541c424 100644
> --- a/peripheral/gatt.c
> +++ b/peripheral/gatt.c
> @@ -128,7 +128,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
> 
>  	bt_att_set_security(conn->att, BT_SECURITY_MEDIUM);
> 
> -	conn->gatt = bt_gatt_server_new(gatt_db, conn->att, mtu);
> +	conn->gatt = bt_gatt_server_new(gatt_db, conn->att, mtu, 0);
>  	if (!conn->gatt) {
>  		fprintf(stderr, "Failed to create GATT server\n");
>  		bt_att_unref(conn->att);
> diff --git a/src/adapter.c b/src/adapter.c
> index 6d7d61504..6b9222bcf 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3441,25 +3441,27 @@ failed:
>  	return ltk;
>  }
> 
> -static GSList *get_ltk_info(GKeyFile *key_file, const char *peer,
> +static struct smp_ltk_info *get_ltk_info(GKeyFile *key_file, const char
> *peer, +							uint8_t bdaddr_type)
> +{
> +	DBG("%s", peer);
> +
> +	return get_ltk(key_file, peer, bdaddr_type, "LongTermKey");
> +}
> +
> +static struct smp_ltk_info *get_slave_ltk_info(GKeyFile *key_file,
> +							const char *peer,
>  							uint8_t bdaddr_type)
>  {
>  	struct smp_ltk_info *ltk;
> -	GSList *l = NULL;
> 
>  	DBG("%s", peer);
> 
> -	ltk = get_ltk(key_file, peer, bdaddr_type, "LongTermKey");
> -	if (ltk)
> -		l = g_slist_append(l, ltk);
> -
>  	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> -	if (ltk) {
> +	if (ltk)
>  		ltk->master = false;
> -		l = g_slist_append(l, ltk);
> -	}
> 
> -	return l;
> +	return ltk;
>  }
> 
>  static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
> @@ -4019,7 +4021,9 @@ static void load_devices(struct btd_adapter *adapter)
>  		char filename[PATH_MAX];
>  		GKeyFile *key_file;
>  		struct link_key_info *key_info;
> -		GSList *list, *ltk_info;
> +		struct smp_ltk_info *ltk_info;
> +		struct smp_ltk_info *slave_ltk_info;
> +		GSList *list;
>  		struct irk_info *irk_info;
>  		struct conn_param *param;
>  		uint8_t bdaddr_type;
> @@ -4044,7 +4048,13 @@ static void load_devices(struct btd_adapter *adapter)
> bdaddr_type = get_le_addr_type(key_file);
> 
>  		ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
> -		ltks = g_slist_concat(ltks, ltk_info);
> +		if (ltk_info)
> +			ltks = g_slist_append(ltks, ltk_info);
> +
> +		slave_ltk_info = get_slave_ltk_info(key_file, entry->d_name,
> +								bdaddr_type);
> +		if (slave_ltk_info)
> +			ltks = g_slist_append(ltks, slave_ltk_info);
> 
>  		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
>  		if (irk_info)
> @@ -4079,9 +4089,16 @@ device_exist:
>  			device_set_bonded(device, BDADDR_BREDR);
>  		}
> 
> -		if (ltk_info) {
> +		if (ltk_info || slave_ltk_info) {
>  			device_set_paired(device, bdaddr_type);
>  			device_set_bonded(device, bdaddr_type);
> +
> +			if (ltk_info)
> +				device_set_ltk_enc_size(device,
> +							ltk_info->enc_size);
> +			else if (slave_ltk_info)
> +				device_set_ltk_enc_size(device,
> +						slave_ltk_info->enc_size);
>  		}
> 
>  free:
> @@ -7464,6 +7481,8 @@ static void new_long_term_key_callback(uint16_t index,
> uint16_t length, device_set_bonded(device, addr->type);
>  	}
> 
> +	device_set_ltk_enc_size(device, ev->key.enc_size);
> +
>  	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
>  }
> 
> diff --git a/src/device.c b/src/device.c
> index bf5441543..780458fd7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -243,6 +243,7 @@ struct btd_device {
> 
>  	struct csrk_info *local_csrk;
>  	struct csrk_info *remote_csrk;
> +	uint8_t ltk_enc_size;
> 
>  	sdp_list_t	*tmp_records;
> 
> @@ -1460,6 +1461,12 @@ bool device_is_disconnecting(struct btd_device
> *device) return device->disconn_timer > 0;
>  }
> 
> +void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
> +{
> +	device->ltk_enc_size = enc_size;
> +	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
> +}
> +
>  static void device_set_auto_connect(struct btd_device *device, gboolean
> enable) {
>  	char addr[18];
> @@ -4837,10 +4844,14 @@ static void gatt_server_init(struct btd_device
> *device,
> 
>  	gatt_server_cleanup(device);
> 
> -	device->server = bt_gatt_server_new(db, device->att, device->att_mtu);
> -	if (!device->server)
> +	device->server = bt_gatt_server_new(db, device->att, device->att_mtu,
> +						main_opts.min_enc_key_size);
> +	if (!device->server) {
>  		error("Failed to initialize bt_gatt_server");
> +		return;
> +	}
> 
> +	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
>  	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
> 
>  	btd_gatt_database_att_connected(database, device->att);
> diff --git a/src/device.h b/src/device.h
> index bc046f780..306c813fc 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -130,6 +130,7 @@ void device_add_connection(struct btd_device *dev,
> uint8_t bdaddr_type); void device_remove_connection(struct btd_device
> *device, uint8_t bdaddr_type); void device_request_disconnect(struct
> btd_device *device, DBusMessage *msg); bool device_is_disconnecting(struct
> btd_device *device);
> +void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
> 
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean
> removal, void *user_data);
> diff --git a/src/hcid.h b/src/hcid.h
> index 62e2bd606..2c2b89d9c 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -54,6 +54,8 @@ struct main_opts {
> 
>  	bt_mode_t	mode;
>  	bt_gatt_cache_t gatt_cache;
> +
> +	uint8_t		min_enc_key_size;
>  };
> 
>  extern struct main_opts main_opts;
> diff --git a/src/main.c b/src/main.c
> index 21f0b14a4..7e6af42cd 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -103,6 +103,7 @@ static const char *policy_options[] = {
> 
>  static const char *gatt_options[] = {
>  	"Cache",
> +	"MinEncKeySize",
>  	NULL
>  };
> 
> @@ -402,12 +403,22 @@ static void parse_config(GKeyFile *config)
>  	if (err) {
>  		g_clear_error(&err);
>  		main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
> -		return;
> +	} else {
> +		main_opts.gatt_cache = parse_gatt_cache(str);
> +		g_free(str);
>  	}
> 
> -	main_opts.gatt_cache = parse_gatt_cache(str);
> +	val = g_key_file_get_integer(config, "GATT",
> +						"MinEncKeySize", &err);
> +	if (err) {
> +		DBG("%s", err->message);
> +		g_clear_error(&err);
> +	} else {
> +		DBG("MinEncKeySize=%d", val);
> 
> -	g_free(str);
> +		if (val >=7 && val <= 16)
> +			main_opts.min_enc_key_size = val;
> +	}
>  }
> 
>  static void init_defaults(void)
> diff --git a/src/main.conf b/src/main.conf
> index 21986b386..cbae32ec5 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -77,6 +77,11 @@
>  # Default: always
>  #Cache = always
> 
> +# Minimum required Encryption Key Size for accessing secured
> characteristics. +# Possible values: 0 and 7-16. 0 means don't care.
> +# Defaults to 0
> +# MinEncKeySize = 0
> +
>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 0aab246d6..8bf3f4611 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -55,6 +55,7 @@ struct bt_att {
>  	struct io *io;
>  	bool io_on_l2cap;
>  	int io_sec_level;		/* Only used for non-L2CAP */
> +	uint8_t enc_size;
> 
>  	struct queue *req_queue;	/* Queued ATT protocol requests */
>  	struct att_send_op *pending_req;
> @@ -602,7 +603,7 @@ static bool change_security(struct bt_att *att, uint8_t
> ecode) if (att->io_sec_level != BT_ATT_SECURITY_AUTO)
>  		return false;
> 
> -	security = bt_att_get_security(att);
> +	security = bt_att_get_security(att, NULL);
> 
>  	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
>  					security < BT_ATT_SECURITY_MEDIUM) {
> @@ -1454,7 +1455,7 @@ bool bt_att_unregister_all(struct bt_att *att)
>  	return true;
>  }
> 
> -int bt_att_get_security(struct bt_att *att)
> +int bt_att_get_security(struct bt_att *att, uint8_t *enc_size)
>  {
>  	struct bt_security sec;
>  	socklen_t len;
> @@ -1462,14 +1463,21 @@ int bt_att_get_security(struct bt_att *att)
>  	if (!att)
>  		return -EINVAL;
> 
> -	if (!att->io_on_l2cap)
> +	if (!att->io_on_l2cap) {
> +		if (enc_size)
> +			*enc_size = att->enc_size;
> +
>  		return att->io_sec_level;
> +	}
> 
>  	memset(&sec, 0, sizeof(sec));
>  	len = sizeof(sec);
>  	if (getsockopt(att->fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
>  		return -EIO;
> 
> +	if (enc_size)
> +		*enc_size = att->enc_size;
> +
>  	return sec.level;
>  }
> 
> @@ -1496,6 +1504,14 @@ bool bt_att_set_security(struct bt_att *att, int
> level) return true;
>  }
> 
> +void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size)
> +{
> +	if (!att)
> +		return;
> +
> +	att->enc_size = enc_size;
> +}
> +
>  static bool sign_set_key(struct sign_info **sign, uint8_t key[16],
>  				bt_att_counter_func_t func, void *user_data)
>  {
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 7bffee7d6..49d93269b 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -84,8 +84,9 @@ bool bt_att_unregister_disconnect(struct bt_att *att,
> unsigned int id);
> 
>  bool bt_att_unregister_all(struct bt_att *att);
> 
> -int bt_att_get_security(struct bt_att *att);
> +int bt_att_get_security(struct bt_att *att, uint8_t *enc_size);
>  bool bt_att_set_security(struct bt_att *att, int level);
> +void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size);
> 
>  bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
>  			bt_att_counter_func_t func, void *user_data);
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 5721f3e5c..6b97ee70e 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -2565,7 +2565,7 @@ unsigned int bt_gatt_client_write_without_response(
> 
>  	/* Only use signed write if unencrypted */
>  	if (signed_write) {
> -		security = bt_att_get_security(client->att);
> +		security = bt_att_get_security(client->att, NULL);
>  		op = security > BT_SECURITY_LOW ?  BT_ATT_OP_WRITE_CMD :
>  						BT_ATT_OP_SIGNED_WRITE_CMD;
>  	} else
> @@ -3281,5 +3281,5 @@ int bt_gatt_client_get_security(struct bt_gatt_client
> *client) if (!client)
>  		return -1;
> 
> -	return bt_att_get_security(client->att);
> +	return bt_att_get_security(client->att, NULL);
>  }
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index faa56abeb..4b554f665 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -103,6 +103,8 @@ struct bt_gatt_server {
>  	unsigned int prep_write_id;
>  	unsigned int exec_write_id;
> 
> +	uint8_t min_enc_size;
> +
>  	struct queue *prep_queue;
>  	unsigned int max_prep_queue_len;
> 
> @@ -379,9 +381,18 @@ done:
>  	process_read_by_type(op);
>  }
> 
> +static bool check_min_key_size(uint8_t min_size, uint8_t size)
> +{
> +	if (!min_size || !size)
> +		return true;
> +
> +	return min_size <= size;
> +}
> +
>  static uint8_t check_permissions(struct bt_gatt_server *server,
>  				struct gatt_db_attribute *attr, uint32_t mask)
>  {
> +	uint8_t enc_size;
>  	uint32_t perm;
>  	int security;
> 
> @@ -397,15 +408,33 @@ static uint8_t check_permissions(struct bt_gatt_server
> *server, if (!perm)
>  		return 0;
> 
> -	security = bt_att_get_security(server->att);
> -	if (perm & BT_ATT_PERM_SECURE && security < BT_ATT_SECURITY_FIPS)
> -		return BT_ATT_ERROR_AUTHENTICATION;
> +	security = bt_att_get_security(server->att, &enc_size);
> +	if (security < 0)
> +		return BT_ATT_ERROR_UNLIKELY;
> 
> -	if (perm & BT_ATT_PERM_AUTHEN && security < BT_ATT_SECURITY_HIGH)
> -		return BT_ATT_ERROR_AUTHENTICATION;
> +	if (perm & BT_ATT_PERM_SECURE) {
> +		if (security < BT_ATT_SECURITY_FIPS)
> +			return BT_ATT_ERROR_AUTHENTICATION;
> 
> -	if (perm & BT_ATT_PERM_ENCRYPT && security < BT_ATT_SECURITY_MEDIUM)
> -		return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
> +		if (!check_min_key_size(server->min_enc_size, enc_size))
> +			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
> +	}
> +
> +	if (perm & BT_ATT_PERM_AUTHEN) {
> +		if (security < BT_ATT_SECURITY_HIGH)
> +			return BT_ATT_ERROR_AUTHENTICATION;
> +
> +		if (!check_min_key_size(server->min_enc_size, enc_size))
> +			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
> +	}
> +
> +	if (perm & BT_ATT_PERM_ENCRYPT) {
> +		if (security < BT_ATT_SECURITY_MEDIUM)
> +			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
> +
> +		if (!check_min_key_size(server->min_enc_size, enc_size))
> +			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
> +	}
> 
>  	return 0;
>  }
> @@ -1481,7 +1510,8 @@ static bool gatt_server_register_att_handlers(struct
> bt_gatt_server *server) }
> 
>  struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
> -					struct bt_att *att, uint16_t mtu)
> +					struct bt_att *att, uint16_t mtu,
> +					uint8_t min_enc_size)
>  {
>  	struct bt_gatt_server *server;
> 
> @@ -1494,6 +1524,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct
> gatt_db *db, server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
>  	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
>  	server->prep_queue = queue_new();
> +	server->min_enc_size = min_enc_size;
> 
>  	if (!gatt_server_register_att_handlers(server)) {
>  		bt_gatt_server_free(server);
> diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
> index 74a6c721e..d5d209350 100644
> --- a/src/shared/gatt-server.h
> +++ b/src/shared/gatt-server.h
> @@ -26,7 +26,8 @@
>  struct bt_gatt_server;
> 
>  struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
> -					struct bt_att *att, uint16_t mtu);
> +					struct bt_att *att, uint16_t mtu,
> +					uint8_t min_enc_size);
>  uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server);
> 
>  struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index fadaff2ad..89812bd75 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -583,7 +583,7 @@ static struct server *server_create(int fd, uint16_t
> mtu, bool hr_visible) goto fail;
>  	}
> 
> -	server->gatt = bt_gatt_server_new(server->db, server->att, mtu);
> +	server->gatt = bt_gatt_server_new(server->db, server->att, mtu, 0);
>  	if (!server->gatt) {
>  		fprintf(stderr, "Failed to create GATT server\n");
>  		goto fail;
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 5d79e94c0..c7e28f865 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -667,7 +667,7 @@ static struct context *create_context(uint16_t mtu,
> gconstpointer data) g_assert(context->server_db);
> 
>  		context->server = bt_gatt_server_new(context->server_db,
> -							context->att, mtu);
> +							context->att, mtu, 0);
>  		g_assert(context->server);
> 
>  		bt_gatt_server_set_debug(context->server, print_debug,

Applied.

-- 
pozdrawiam
Szymon Janc


