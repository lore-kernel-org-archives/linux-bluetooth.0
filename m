Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?TWljaGHFgg==?= Narajowski
        <michal.narajowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] core/adapter: Add support for enabling privacy
Date: Sat, 22 Oct 2016 21:39:38 +0200
Message-ID: <8794210.oQFfbkaes0@ix>
In-Reply-To: <1476783077-7120-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476783077-7120-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Tuesday, 18 October 2016 11:31:17 CEST Micha=C5=82 Narajowski wrote:
> This adds support for loading local IRK key when adapter is configured.
> In case IRK is not present new key is generated and stored.
> In case of errors privacy is explicitly disabled. We ensure that we
> memset IRK to zero before disabling privacy.
> IRK is stored in %s/identity file. Privacy setting is configured
> globally in main.conf. In the future we may add per device
> configuration in %s/settings.
> ---
>  doc/settings-storage.txt |  12 +++++
>  src/adapter.c            | 122
> +++++++++++++++++++++++++++++++++++++++++++++++ src/hcid.h               =
|=20
>  2 +
>  src/main.c               |  21 ++++++++
>  src/main.conf            |   7 +++
>  5 files changed, 164 insertions(+)
>=20
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> index 2c34ec4..6a708b4 100644
> --- a/doc/settings-storage.txt
> +++ b/doc/settings-storage.txt
> @@ -89,6 +89,18 @@ Sample:
>    DiscoverableTimeout=3D0
>=20
>=20
> +Identity file format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Identity file contains one [General] group that holds identity informati=
on
> +such as keys and adresses:
> +
> +	IdentityResolvingKey	String	128-bit value of the IRK
> +
> +Sample:
> +  [General]
> +  IdentityResolvingKey=3D00112233445566778899aabbccddeeff
> +
> +
>  Attributes file format
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/src/adapter.c b/src/adapter.c
> index b096d48..500df91 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3141,6 +3141,125 @@ static struct conn_param *get_conn_param(GKeyFile
> *key_file, const char *peer, return param;
>  }
>=20
> +static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file,
> +							const char *filename)
> +{
> +	struct bt_crypto *crypto;
> +	char str_irk_out[33];
> +	gsize length =3D 0;
> +	char *str;
> +	int i;
> +
> +	crypto =3D bt_crypto_new();
> +	if (!crypto) {
> +		error("Failed to open crypto");
> +		return -1;
> +	}
> +
> +	if (!bt_crypto_random_bytes(crypto, irk, 16)) {
> +		error("Failed to generate IRK");
> +		bt_crypto_unref(crypto);
> +		return -1;
> +	}
> +
> +	bt_crypto_unref(crypto);
> +
> +	for (i =3D 0; i < 16; i++)
> +		sprintf(str_irk_out + (i * 2), "%02x", irk[i]);
> +
> +	str_irk_out[32] =3D '\0';
> +	info("Generated IRK successfully");
> +
> +	g_key_file_set_string(key_file, "General", "IdentityResolvingKey",
> +								str_irk_out);
> +	str =3D g_key_file_to_data(key_file, &length, NULL);
> +	g_file_set_contents(filename, str, length, NULL);
> +	g_free(str);
> +	DBG("Generated IRK written to file");
> +	return 0;
> +}
> +
> +static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
> +{
> +	char filename[PATH_MAX];
> +	GKeyFile *key_file;
> +	char address[18];
> +	char *str_irk;
> +	int ret;
> +
> +	ba2str(&adapter->bdaddr, address);
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/identity", address);
> +
> +	key_file =3D g_key_file_new();
> +	g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +	str_irk =3D g_key_file_get_string(key_file, "General",
> +						"IdentityResolvingKey", NULL);
> +	if (!str_irk) {
> +		info("No IRK for %s, creating new IRK", address);
> +		ret =3D generate_and_write_irk(irk, key_file, filename);
> +		g_key_file_free(key_file);
> +		return ret;
> +	}
> +
> +	g_key_file_free(key_file);
> +
> +	if (strlen(str_irk) !=3D 32 || str2buf(str_irk, irk, 16)) {
> +		/* TODO re-create new IRK here? */
> +		error("Invalid IRK format, disabling privacy");
> +		g_free(str_irk);
> +		return -1;
> +	}
> +
> +	g_free(str_irk);
> +	DBG("Successfully read IRK from file");
> +	return 0;
> +}
> +
> +static void set_privacy_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	struct btd_adapter *adapter =3D user_data;
> +
> +	if (status !=3D MGMT_STATUS_SUCCESS) {
> +		btd_error(adapter->dev_id, "Failed to set privacy: %s (0x%02x)",
> +						mgmt_errstr(status), status);
> +		return;
> +	}
> +
> +	DBG("Successfuly set privacy for index %u", adapter->dev_id);
> +}
> +
> +static int set_privacy(struct btd_adapter *adapter, uint8_t privacy)
> +{
> +	struct mgmt_cp_set_privacy cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +
> +	if (privacy) {
> +		uint8_t irk[16];
> +
> +		if (load_irk(adapter, irk) =3D=3D 0) {
> +			cp.privacy =3D privacy;
> +			memcpy(cp.irk, irk, 16);
> +		}
> +	}
> +
> +	DBG("sending set privacy command for index %u", adapter->dev_id);
> +	DBG("setting privacy mode 0x%02x for index %u", cp.privacy,
> +							adapter->dev_id);
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PRIVACY,
> +				adapter->dev_id, sizeof(cp), &cp,
> +				set_privacy_complete, adapter, NULL) > 0)
> +		return 0;
> +
> +	btd_error(adapter->dev_id, "Failed to set privacy for index %u",
> +							adapter->dev_id);
> +
> +	return -1;
> +}
> +
>  static void load_link_keys_complete(uint8_t status, uint16_t length,
>  					const void *param, void *user_data)
>  {
> @@ -7896,6 +8015,9 @@ static void read_info_complete(uint8_t status,
> uint16_t length, if (missing_settings & MGMT_SETTING_SECURE_CONN)
>  		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, 0x01);
>=20
> +	if (adapter->supported_settings & MGMT_SETTING_PRIVACY)
> +		set_privacy(adapter, main_opts.privacy);
> +
>  	if (main_opts.fast_conn &&
>  			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
>  		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
> diff --git a/src/hcid.h b/src/hcid.h
> index 60e2b0a..0b785ee 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -35,6 +35,8 @@ struct main_opts {
>  	uint16_t	autoto;
>  	uint32_t	pairto;
>  	uint32_t	discovto;
> +	uint8_t		privacy;
> +
>  	gboolean	reverse_sdp;
>  	gboolean	name_resolv;
>  	gboolean	debug_keys;
> diff --git a/src/main.c b/src/main.c
> index ebc93f5..bcc1e6f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -89,6 +89,7 @@ static const char * const supported_options[] =3D {
>  	"DebugKeys",
>  	"ControllerMode",
>  	"MultiProfile",
> +	"Privacy",
>  };
>=20
>  GKeyFile *btd_get_main_conf(void)
> @@ -255,6 +256,26 @@ static void parse_config(GKeyFile *config)
>  		main_opts.autoto =3D val;
>  	}
>=20
> +	str =3D g_key_file_get_string(config, "General", "Privacy", &err);
> +	if (err) {
> +		DBG("%s", err->message);
> +		g_clear_error(&err);
> +		main_opts.privacy =3D 0x00;
> +	} else {
> +		DBG("privacy=3D%s", str);
> +
> +		if (!strcmp(str, "device"))
> +			main_opts.privacy =3D 0x01;
> +		else if (!strcmp(str, "off"))
> +			main_opts.privacy =3D 0x00;
> +		else {
> +			DBG("Invalid privacy option: %s", str);
> +			main_opts.privacy =3D 0x00;
> +		}
> +
> +		g_free(str);
> +	}
> +
>  	str =3D g_key_file_get_string(config, "General", "Name", &err);
>  	if (err) {
>  		DBG("%s", err->message);
> diff --git a/src/main.conf b/src/main.conf
> index 49528b9..d9cd9e0 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -64,6 +64,13 @@
>  # 'false'.
>  #FastConnectable =3D false
>=20
> +# Default privacy setting.
> +# Enables use of private address.
> +# Possible values: "off", "device", "network"
> +# "network" option not supported currently
> +# Defaults to "off"
> +# Privacy =3D off
> +
>  #[Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try

Patch applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc
