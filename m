Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BlueZ] core/adapter: Add support for enabling privacy
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1470052433-21116-1-git-send-email-michal.narajowski@codecoup.pl>
Date: Mon, 1 Aug 2016 15:15:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <772531BA-59CA-44E3-B8F1-DEA3FD64C2FF@holtmann.org>
References: <1470052433-21116-1-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> This adds support for loading local IRK key when adapter is configured.
> In case IRK is not present new key is generated and stored.
> ---
> src/adapter.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 136 insertions(+), 5 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 3742398..fc8d10c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -433,6 +433,12 @@ static void store_adapter_info(struct btd_adapter *adapter)
> 
> 	key_file = g_key_file_new();
> 
> +	ba2str(&adapter->bdaddr, address);
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
> +
> +	/* IRK must be preserved in the file, so load contents first */
> +	g_key_file_load_from_file(key_file, filename, 0, NULL);
> +

is this really needed? I mean, the IRK should be already present in memory and synced to the settings file after its creation. Sounds to me like we are hacking around a bug here.

> 	if (adapter->pairable_timeout != main_opts.pairto)
> 		g_key_file_set_integer(key_file, "General", "PairableTimeout",
> 					adapter->pairable_timeout);
> @@ -455,11 +461,6 @@ static void store_adapter_info(struct btd_adapter *adapter)
> 		g_key_file_set_string(key_file, "General", "Alias",
> 							adapter->stored_alias);
> 
> -	ba2str(&adapter->bdaddr, address);
> -	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
> -
> -	create_file(filename, S_IRUSR | S_IWUSR);
> -
> 	str = g_key_file_to_data(key_file, &length, NULL);
> 	g_file_set_contents(filename, str, length, NULL);
> 	g_free(str);
> @@ -3141,6 +3142,130 @@ static struct conn_param *get_conn_param(GKeyFile *key_file, const char *peer,
> 	return param;
> }
> 
> +static int generate_random_buffer(uint8_t *buf, int buflen)
> +{
> +	int fd;
> +
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0) {
> +		error("Error opening /dev/urandom: %s", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (read(fd, buf, buflen) != buflen) {
> +		error("Reading from urandom failed");
> +		close(fd);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}

Please use bt_crypto_random_bytes so that we eventually can move this towards the new system call or AF_ALG since opening manually /dev/urandom in multiple locations is a bad idea.

I would not even mind creating bt_crypto_generate_irk for this simple purpose.

> +
> +static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file, const char *filename)
> +{
> +	char str_irk_out[33];
> +	gsize length = 0;
> +	int i;
> +	char *str;
> +
> +	if (generate_random_buffer(irk, 16)) {
> +		error("Failed to generate IRK");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < 16; i++)
> +		sprintf(str_irk_out + (i * 2), "%02x", irk[i]);
> +
> +	str_irk_out[32] = '\0';
> +	info("Generated IRK successfully");
> +
> +	g_key_file_set_string(key_file, "Keys", "IRK", str_irk_out);

I think we opted to always use the long names. So IdentityResolvingKey please. And of course this needs to be documented in doc/settings-format.txt as well.

In addition I would combine these under [Identity] since besides the IRK itself, this might have the choice between using the Public Address or a generated Static Random Address that we have to store as well.

> +	str = g_key_file_to_data(key_file, &length, NULL);
> +	g_file_set_contents(filename, str, length, NULL);
> +	g_free(str);
> +	DBG("Generated IRK written to file");
> +	return 0;
> +}
> +
> +static int load_irk(struct btd_adapter *adapter, uint8_t *irk)
> +{
> +	GKeyFile *key_file;
> +	char filename[PATH_MAX];
> +	char address[18];
> +	char *str_irk;
> +	int ret;
> +
> +	ba2str(&adapter->bdaddr, address);
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
> +
> +	key_file = g_key_file_new();
> +	g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +	str_irk = g_key_file_get_string(key_file, "Keys", "IRK", NULL);
> +	if (!str_irk) {
> +		info("No IRK for %s, creating new IRK", address);
> +		ret = generate_and_write_irk(irk, key_file, filename);
> +		g_key_file_free(key_file);
> +		return ret;
> +	}
> +
> +	g_key_file_free(key_file);
> +
> +	if (strlen(str_irk) != 32 || str2buf(str_irk, irk, 16)) {
> +		/* TODO re-create new IRK here? */
> +		error("Invalid IRK format, not enabling privacy");
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
> +	struct btd_adapter *adapter = user_data;
> +
> +	if (status != MGMT_STATUS_SUCCESS) {
> +		btd_error(adapter->dev_id, "Failed to set privacy: %s (0x%02x)",
> +						mgmt_errstr(status), status);
> +		return;
> +	}
> +
> +	DBG("Successfuly set privacy for index %u", adapter->dev_id);
> +}
> +
> +static int set_privacy(struct btd_adapter *adapter)
> +{
> +	struct mgmt_cp_set_privacy cp;
> +	int err;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	/* TODO privacy mode should be configured from main.conf */

Yes, the main.conf should get a Privacy option (which defaults to off). And in addition the settings file might override it individually per controller.

> +	cp.privacy = 0x01;
> +	err = load_irk(adapter, cp.irk);
> +
> +	/* TODO should we disable if IRK is invalid? */
> +	if (err)
> +		return err;

Yes, if there is no IRK available, and we can not generate one, then we should not enable privacy. And in addition if privacy has already been enabled, we need to disable it.

> +
> +	DBG("sending set privacy command for index %u", adapter->dev_id);
> +	DBG("setting privacy mode %u for index %u", cp.privacy, adapter->dev_id);
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
> static void load_link_keys_complete(uint8_t status, uint16_t length,
> 					const void *param, void *user_data)
> {
> @@ -7893,6 +8018,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
> 	if (missing_settings & MGMT_SETTING_SECURE_CONN)
> 		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, 0x01);
> 
> +	/*
> +	 * Always reload privacy settings and set IRK.
> +	 */

I don't like this comment. It has no meaning for me on what we are doing. Either leave it out or explain exactly what is going on here.

> +	if (adapter->supported_settings & MGMT_SETTING_PRIVACY)
> +		set_privacy(adapter);
> +

I also wonder if this should have the main.conf checks here. Like we do with the others.

> 	if (main_opts.fast_conn &&
> 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
> 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);

Regards

Marcel

