Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D82D3ECA
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619289; cv=none; b=IuWY9yRw9XZ9cxj/ZDVJG1xXT0k7cWd/47gFnqd1WRPhVjKzGyMHVjN2TiIaPIvK3Yu8GqoHyxhhP4kqtGmTadwoekvww1fIT8XG1fNj1OLlWZXIpdxa9JlZudvuiCraiWiSE4Whu8Fs78uIHwMzKxcwdEROC7xRSCs3Uow8TEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619289; c=relaxed/simple;
	bh=ysj+VcTtpyWoVDRfQQzFv612xvR9Vc0gZR5JlglJZjE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q37vqsnb9iYzNqBsWyeMpZCwNuwN4XwlRaQWP4x3opE4ASruK9EloUJ92HnQPtHYr30xdgXXFeWRooeIvjucjE49I0a60J73ApGDpSJULyH4PTi2xsaw+V7SzMNsi2PRf+9MROXuzHaxMBGXBztlQhNhnjEuZp6yz2uT7td4qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D069143180
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 08:54:43 +0000 (UTC)
Message-ID: <2345c42ca398511d63b535a54b1732f957f11f8a.camel@hadess.net>
Subject: Re: [PATCH BlueZ 01/19] android: Fix typos
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 04 Jul 2025 10:54:43 +0200
In-Reply-To: <20250703085630.935452-2-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
	 <20250703085630.935452-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This one can be dropped as the android/ directory is gone, and none of
the files moved from android/ to unit/ were affected.

Cheers

On Thu, 2025-07-03 at 10:53 +0200, Bastien Nocera wrote:
> Found using codespell.
> ---
> =C2=A0android/a2dp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0android/audio-ipc-api.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0android/bluetoothd.te=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/client/haltest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0android/client/if-bt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 16 ++++++++--------
> =C2=A0android/client/if-gatt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 14 +++++++-------
> =C2=A0android/client/if-hl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/gatt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0android/hal-audio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/hal-ipc-api.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 32 ++++++++++++++++---------------
> -
> =C2=A0android/handsfree-client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 =
++++----
> =C2=A0android/hardware/audio_effect.h |=C2=A0 4 ++--
> =C2=A0android/hardware/bluetooth.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/hardware/bt_hf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 2 +-
> =C2=A0android/hardware/bt_hh.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 8 ++++----
> =C2=A0android/hardware/bt_rc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 6 +++---
> =C2=A0android/hardware/hardware.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0android/health.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0android/hidhost.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0android/pics-avctp.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/pics-avrcp.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/pics-gap.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/pics-opp.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0android/pts-gatt.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/system-emulator.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0android/system/audio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0android/tester-gatt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0android/tester-hidhost.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 2 +-
> =C2=A0android/tester-main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A029 files changed, 81 insertions(+), 81 deletions(-)
>=20
> diff --git a/android/a2dp.c b/android/a2dp.c
> index ee607a32dabe..8d0e4d62e10c 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -295,13 +295,13 @@ static int sbc_check_config(void *caps, uint8_t
> caps_len, void *conf,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (config->max_bitpool < cap->min_bitpool) {
> -		error("SBC: Invalid maximun bitpool (%u < %u)",
> +		error("SBC: Invalid maximum bitpool (%u < %u)",
> =C2=A0					config->max_bitpool, cap-
> >min_bitpool);
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (config->min_bitpool > cap->max_bitpool) {
> -		error("SBC: Invalid minimun bitpool (%u > %u)",
> +		error("SBC: Invalid minimum bitpool (%u > %u)",
> =C2=A0					config->min_bitpool, cap-
> >min_bitpool);
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -375,7 +375,7 @@ static int aptx_check_config(void *caps, uint8_t
> caps_len, void *conf,
> =C2=A0	config =3D conf;
> =C2=A0
> =C2=A0	if (!(cap->frequency & config->frequency)) {
> -		error("APTX: Unsupported frequenct (%u) by
> endpoint",
> +		error("APTX: Unsupported frequency (%u) by
> endpoint",
> =C2=A0							config-
> >frequency);
> =C2=A0		return -EINVAL;
> =C2=A0	}
> diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
> index f4a497dd8d5b..ba4d1c1c86d0 100644
> --- a/android/audio-ipc-api.txt
> +++ b/android/audio-ipc-api.txt
> @@ -46,7 +46,7 @@ Audio Service (ID 0)
> =C2=A0
> =C2=A0		Response parameters: Status (1 octet)
> =C2=A0
> -	Opcode 0x01 - Open Audio Endpoint commmand
> +	Opcode 0x01 - Open Audio Endpoint command
> =C2=A0
> =C2=A0		Command parameters: Service UUID (16 octets)
> =C2=A0				=C2=A0=C2=A0=C2=A0 Codec ID (1 octet)
> diff --git a/android/bluetoothd.te b/android/bluetoothd.te
> index 532bfbb353ae..1ac719b62161 100644
> --- a/android/bluetoothd.te
> +++ b/android/bluetoothd.te
> @@ -12,7 +12,7 @@ allow bluetoothd
> bluetooth_data_file:notdevfile_class_set create_file_perms;
> =C2=A0allow bluetoothd self:capability { setuid net_admin net_bind_servic=
e
> net_raw };
> =C2=A0allow bluetoothd kernel:system module_request;
> =C2=A0
> -# TODO: this may be romoved for userbuild where we don't use
> bluetoothd_wrapper
> +# TODO: this may be removed for userbuild where we don't use
> bluetoothd_wrapper
> =C2=A0allow bluetoothd bluetoothd_main_exec:file { execute
> execute_no_trans read open };
> =C2=A0
> =C2=A0# IPC socket communication
> diff --git a/android/client/haltest.c b/android/client/haltest.c
> index cb5f68833fe8..f1b3f7261c81 100644
> --- a/android/client/haltest.c
> +++ b/android/client/haltest.c
> @@ -145,7 +145,7 @@ static void help_p(int argc, const char **argv)
> =C2=A0		}
> =C2=A0
> =C2=A0		terminal_print("\nTo get help on methods for each
> interface type:\n");
> -		terminal_print("\n\thelp <inerface>\n");
> +		terminal_print("\n\thelp <interface>\n");
> =C2=A0		terminal_print("\nBasic scenario:\n\tbluetooth
> init\n");
> =C2=A0		terminal_print("\tbluetooth enable\n\tbluetooth
> start_discovery\n");
> =C2=A0		terminal_print("\tbluetooth get_profile_interface
> handsfree\n");
> @@ -217,7 +217,7 @@ static struct method commands[] =3D {
> =C2=A0	END_METHOD
> =C2=A0};
> =C2=A0
> -/* Gets comman by name */
> +/* Gets command by name */
> =C2=A0struct method *get_command(const char *name)
> =C2=A0{
> =C2=A0	return get_method(commands, name);
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index 68001a15132e..978834ebefc4 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -65,7 +65,7 @@ static void dump_properties(int num_properties,
> bt_property_t *properties)
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_properties; i++) {
> =C2=A0		/*
> -		 * properities sometimes come unaligned hence memcp
> to
> +		 * properties sometimes come unaligned hence memcp
> to
> =C2=A0		 * aligned buffer
> =C2=A0		 */
> =C2=A0		bt_property_t prop;
> @@ -152,7 +152,7 @@ static void add_remote_device_from_props(int
> num_properties,
> =C2=A0
> =C2=A0	for (i =3D 0; i < num_properties; i++) {
> =C2=A0		/*
> -		 * properities sometimes come unaligned hence memcp
> to
> +		 * properties sometimes come unaligned hence memcp
> to
> =C2=A0		 * aligned buffer
> =C2=A0		 */
> =C2=A0		bt_property_t property;
> @@ -216,7 +216,7 @@ static void
> discovery_state_changed_cb(bt_discovery_state_t state)
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * Buffer for remote addres that came from one of bind request.
> + * Buffer for remote address that came from one of bind request.
> =C2=A0 * It's stored for command completion.
> =C2=A0 */
> =C2=A0static char last_remote_addr[MAX_ADDR_STR_LEN];
> @@ -595,7 +595,7 @@ static void complete_addr_c(int argc, const char
> **argv, enum_func *enum_func,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -/* Just addres to complete, use complete_addr_c */
> +/* Just address to complete, use complete_addr_c */
> =C2=A0#define get_remote_device_properties_c complete_addr_c
> =C2=A0
> =C2=A0static void get_remote_device_properties_p(int argc, const char
> **argv)
> @@ -696,7 +696,7 @@ static void get_remote_service_record_p(int argc,
> const char **argv)
> =C2=A0	EXEC(if_bluetooth->get_remote_service_record, &addr, &uuid);
> =C2=A0}
> =C2=A0
> -/* Just addres to complete, use complete_addr_c */
> +/* Just address to complete, use complete_addr_c */
> =C2=A0#define get_remote_services_c complete_addr_c
> =C2=A0
> =C2=A0static void get_remote_services_p(int argc, const char **argv)
> @@ -723,7 +723,7 @@ static void cancel_discovery_p(int argc, const
> char **argv)
> =C2=A0	EXEC(if_bluetooth->cancel_discovery);
> =C2=A0}
> =C2=A0
> -/* Just addres to complete, use complete_addr_c */
> +/* Just address to complete, use complete_addr_c */
> =C2=A0#define create_bond_c complete_addr_c
> =C2=A0
> =C2=A0static void create_bond_p(int argc, const char **argv)
> @@ -748,7 +748,7 @@ static void create_bond_p(int argc, const char
> **argv)
> =C2=A0#endif
> =C2=A0}
> =C2=A0
> -/* Just addres to complete, use complete_addr_c */
> +/* Just address to complete, use complete_addr_c */
> =C2=A0#define remove_bond_c complete_addr_c
> =C2=A0
> =C2=A0static void remove_bond_p(int argc, const char **argv)
> @@ -761,7 +761,7 @@ static void remove_bond_p(int argc, const char
> **argv)
> =C2=A0	EXEC(if_bluetooth->remove_bond, &addr);
> =C2=A0}
> =C2=A0
> -/* Just addres to complete, use complete_addr_c */
> +/* Just address to complete, use complete_addr_c */
> =C2=A0#define cancel_bond_c complete_addr_c
> =C2=A0
> =C2=A0static void cancel_bond_p(int argc, const char **argv)
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index d00afffcb5ce..89a48171cf09 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -89,7 +89,7 @@ const btgatt_interface_t *if_gatt =3D NULL;
> =C2=A0						"No min interval
> specified\n")
> =C2=A0#define VERIFY_MAX_INTERVAL(n, v) VERIFY_INT_ARG(n, v, \
> =C2=A0						"No max interval
> specified\n")
> -#define VERIFY_APPEARANCE(n, v) VERIFY_INT_ARG(n, v, "No apperance
> specified\n")
> +#define VERIFY_APPEARANCE(n, v) VERIFY_INT_ARG(n, v, "No appearance
> specified\n")
> =C2=A0#define VERIFY_MANUFACTURER_LEN(n, v) VERIFY_INT_ARG(n, v, \
> =C2=A0					"No manufacturer len
> specified\n")
> =C2=A0#define VERIFY_SERVICE_DATA_LEN(n, v) VERIFY_INT_ARG(n, v, \
> @@ -311,7 +311,7 @@ static void gatt_str2bt_uuid_t(const char *str,
> int len, bt_uuid_t *uuid)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -/* char_id formating function */
> +/* char_id formatting function */
> =C2=A0static char *btgatt_gatt_id_t2str(const btgatt_gatt_id_t *char_id,
> char *buf)
> =C2=A0{
> =C2=A0	char uuid_buf[MAX_UUID_STR_LEN];
> @@ -346,7 +346,7 @@ static void str2btgatt_gatt_id_t(const char *buf,
> btgatt_gatt_id_t *char_id)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -/* service_id formating function */
> +/* service_id formatting function */
> =C2=A0static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id,
> char *buf)
> =C2=A0{
> =C2=A0	char uuid_buf[MAX_UUID_STR_LEN];
> @@ -653,7 +653,7 @@ static void gattc_read_remote_rssi_cb(int
> client_if, bt_bdaddr_t *bda, int rssi,
> =C2=A0{
> =C2=A0	char buf[MAX_ADDR_STR_LEN];
> =C2=A0
> -	haltest_info("%s: client_if=3D%d bda=3D%s rssi=3D%d satus=3D%d\n",
> __func__,
> +	haltest_info("%s: client_if=3D%d bda=3D%s rssi=3D%d status=3D%d\n",
> __func__,
> =C2=A0			client_if, bt_bdaddr_t2str(bda, buf), rssi,
> status);
> =C2=A0}
> =C2=A0
> @@ -1413,7 +1413,7 @@ static void write_characteristic_c(int argc,
> const char **argv,
> =C2=A0					enum_func *enum_func, void
> **user)
> =C2=A0{
> =C2=A0	/*
> -	 * This should be from tGATT_WRITE_TYPE but it's burried
> +	 * This should be from tGATT_WRITE_TYPE but it's buried
> =C2=A0	 * inside bluedroid guts
> =C2=A0	 */
> =C2=A0	static const char *wrtypes[] =3D { "1", "2", "3", NULL };
> @@ -1492,7 +1492,7 @@ static void write_descriptor_c(int argc, const
> char **argv,
> =C2=A0					enum_func *enum_func, void
> **user)
> =C2=A0{
> =C2=A0	/*
> -	 * This should be from tGATT_WRITE_TYPE but it's burried
> +	 * This should be from tGATT_WRITE_TYPE but it's buried
> =C2=A0	 * inside bluedroid guts
> =C2=A0	 */
> =C2=A0	static const char *wrtypes[] =3D { "1", "2", "3", NULL };
> @@ -2646,7 +2646,7 @@ static struct method server_methods[] =3D {
> =C2=A0	GATTS_METHODCH(add_included_service,
> =C2=A0			"<server_if> <service_handle>
> <included_handle>"),
> =C2=A0	GATTS_METHODCH(add_characteristic,
> -		"<server_if> <service_handle> <uuid> <properites>
> <permissions>"),
> +		"<server_if> <service_handle> <uuid> <properties>
> <permissions>"),
> =C2=A0	GATTS_METHODCH(add_descriptor,
> =C2=A0			"<server_if> <service_handle> <uuid>
> <permissions>"),
> =C2=A0	GATTS_METHODCH(start_service,
> diff --git a/android/client/if-hl.c b/android/client/if-hl.c
> index 826c81750478..90a4a1fab4a7 100644
> --- a/android/client/if-hl.c
> +++ b/android/client/if-hl.c
> @@ -173,7 +173,7 @@ static void register_application_p(int argc,
> const char **argv)
> =C2=A0	memset(&reg, 0, sizeof(reg));
> =C2=A0
> =C2=A0	if (argc !=3D ((atoi(argv[6]) * 4) + 7)) {
> -		haltest_error("mdep cfg argumetns are not
> proper\n");
> +		haltest_error("mdep cfg arguments are not
> proper\n");
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> diff --git a/android/gatt.c b/android/gatt.c
> index 89fcdb114429..aba88fcf8c87 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3500,7 +3500,7 @@ static void
> handle_client_write_descriptor(const void *buf, uint16_t len)
> =C2=A0	DBG("");
> =C2=A0
> =C2=A0	if (len !=3D sizeof(*cmd) + cmd->len) {
> -		error("Invalid write desriptor command (%u bytes),
> terminating",
> +		error("Invalid write descriptor command (%u bytes),
> terminating",
> =C2=A0							=09
> 	len);
> =C2=A0		raise(SIGTERM);
> =C2=A0		return;
> @@ -4742,7 +4742,7 @@ static void read_cb(struct gatt_db_attribute
> *attrib, unsigned int id,
> =C2=A0
> =C2=A0	app =3D find_app_by_id(app_id);
> =C2=A0	if (!app) {
> -		error("gatt: read_cb, cound not found app id");
> +		error("gatt: read_cb, could not found app id");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> @@ -4753,7 +4753,7 @@ static void read_cb(struct gatt_db_attribute
> *attrib, unsigned int id,
> =C2=A0
> =C2=A0	conn =3D find_conn(&bdaddr, app->id);
> =C2=A0	if (!conn) {
> -		error("gatt: read_cb, cound not found connection");
> +		error("gatt: read_cb, could not found connection");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> @@ -6433,7 +6433,7 @@ static void write_confirm(struct
> gatt_db_attribute *attrib,
> =C2=A0	if (!err)
> =C2=A0		return;
> =C2=A0
> -	error("Error writting attribute %p", attrib);
> +	error("Error writing attribute %p", attrib);
> =C2=A0}
> =C2=A0
> =C2=A0static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index f3d9b40a62fe..f9169bf289db 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -500,7 +500,7 @@ static bool open_endpoint(struct audio_endpoint
> **epp,
> =C2=A0		}
> =C2=A0
> =C2=A0	if (!ep) {
> -		error("Cound not find opened endpoint");
> +		error("Could not find opened endpoint");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index e3b7798b3d26..3c41e9871db6 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1162,7 +1162,7 @@ Commands and responses:
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data type (2 octets)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Channel type (1 octet)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MDEP description length=
 (2
> octets)
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MDEP description (MDEP
> desciption length)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MDEP description (MDEP
> description length)
> =C2=A0		Response parameters: <none>
> =C2=A0
> =C2=A0		In case of an error, the error response will be
> returned.
> @@ -1827,7 +1827,7 @@ Commands and responses:
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transaction ID (4 octet=
s)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Handle (2 octets)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Offset (2 octets)
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Auth Request (1 octect)
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Auth Request (1 octet)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status (4 octets)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GATT Response (4 octets=
)
> =C2=A0		Response parameters: <none>
> @@ -2352,14 +2352,14 @@ Commands and response:
> =C2=A0
> =C2=A0	Opcode 0x00 - Error response
> =C2=A0
> -	Opcode 0x01 - Connect command/respose
> +	Opcode 0x01 - Connect command/response
> =C2=A0
> -		Command parameters: Remote address (6 octects)
> +		Command parameters: Remote address (6 octets)
> =C2=A0		Response parameters: <none>
> =C2=A0
> =C2=A0		 In case of an error, the error response will be
> returned.
> =C2=A0
> -	Opcode 0x02 - Disonnect command/response
> +	Opcode 0x02 - Disconnect command/response
> =C2=A0
> =C2=A0		Command parameters: Remote address (6 octetcs)
> =C2=A0		Response parameters: <none>
> @@ -2440,7 +2440,7 @@ Commands and response:
> =C2=A0
> =C2=A0		In case of an error, the error response will be
> returned.
> =C2=A0
> -	Opcode 0x11 - Query Current Calls commad/response
> +	Opcode 0x11 - Query Current Calls command/response
> =C2=A0
> =C2=A0		Command parameters: <none>
> =C2=A0		Response parameters: <none>
> @@ -2512,7 +2512,7 @@ Notifications:
> =C2=A0			1	Release active calls and accept
> other call
> =C2=A0			2	Release specified active call only
> =C2=A0			3	Place all active calls on hold and
> accept other call
> -			4	Request private mode with secified
> call
> +			4	Request private mode with specified
> call
> =C2=A0			5	Add a held call to the multiparty
> =C2=A0			6	Connect two calls and leave
> multiparty
> =C2=A0			7-31	Reserved for future use
> @@ -2563,7 +2563,7 @@ Notifications:
> =C2=A0
> =C2=A0		Notification parameters: Name (string)
> =C2=A0
> -	Opcode 0x89 - Call Indicatior notification
> +	Opcode 0x89 - Call Indicator notification
> =C2=A0
> =C2=A0		Notification parameters: Call (1 octet)
> =C2=A0
> @@ -2587,7 +2587,7 @@ Notifications:
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x01 =3D Hold and Active
> =C2=A0					0x02 =3D Hold
> =C2=A0
> -	Opcode 0x8c - Resposne and Hold Status notification
> +	Opcode 0x8c - Response and Hold Status notification
> =C2=A0
> =C2=A0		Notification parameters: Status (1 octet)
> =C2=A0
> @@ -2617,13 +2617,13 @@ Notifications:
> =C2=A0		Valid Direction values: 0x00 =3D Outgoing
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x01 =3D Incoming
> =C2=A0
> -		Valid Call Sate values: 0x00 =3D Active
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01 =
=3D Held
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x02 =
=3D Dialing
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x03 =
=3D Alerting
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x04 =
=3D Incoming
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x05 =
=3D Waiting
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x06 =
=3D Call held by Response
> and Hold
> +		Valid Call State values: 0x00 =3D Active
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x01 =3D Held
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x02 =3D Dialing
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x03 =3D Alerting
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x04 =3D Incoming
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x05 =3D Waiting
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x06 =3D Call held by
> Response and Hold
> =C2=A0
> =C2=A0		Valid Multiparty values: 0x00 =3D Single Call
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x01 =3D Multiparty
> (conference) Call
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index c8f9e690eaa7..31be27fc3247 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -1308,7 +1308,7 @@ static void slc_cind_status_resp(enum
> hfp_result result,
> =C2=A0	/* Continue with SLC creation */
> =C2=A0	if (!hfp_hf_send_command(dev->hf, slc_cmer_resp, dev,
> =C2=A0							"AT+CMER=3D3,0
> ,0,1")) {
> -		error("hf-client: Counld not send AT+CMER");
> +		error("hf-client: Could not send AT+CMER");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> @@ -1335,13 +1335,13 @@ static void slc_cind_resp(enum hfp_result
> result, enum hfp_error cme_err,
> =C2=A0	/* Continue with SLC creation */
> =C2=A0	if (!hfp_hf_register(dev->hf, slc_cind_status_cb, "+CIND",
> dev,
> =C2=A0								NULL
> )) {
> -		error("hf-client: Counld not register +CIND");
> +		error("hf-client: Could not register +CIND");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!hfp_hf_send_command(dev->hf, slc_cind_status_resp, dev,
> =C2=A0								"AT+
> CIND?")) {
> -		error("hf-client: Counld not send AT+CIND?");
> +		error("hf-client: Could not send AT+CIND?");
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> @@ -1886,7 +1886,7 @@ static void confirm_cb(GIOChannel *chan,
> gpointer data)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (dev->state !=3D HAL_HF_CLIENT_CONN_STATE_DISCONNECTED) {
> -		/* TODO: Handle colision */
> +		/* TODO: Handle collision */
> =C2=A0		error("hf-client: Connections is up or ongoing ?");
> =C2=A0		goto drop;
> =C2=A0	}
> diff --git a/android/hardware/audio_effect.h
> b/android/hardware/audio_effect.h
> index 2c63f1ccf4ca..1f9b5463376a 100644
> --- a/android/hardware/audio_effect.h
> +++ b/android/hardware/audio_effect.h
> @@ -63,7 +63,7 @@ typedef struct effect_descriptor_s {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t cpuLoad;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 // CPU load indication (see below)
> =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t memoryUsage;=C2=A0=C2=A0 // Data Memory=
 usage (see below)
> =C2=A0=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0 name[EFFECT_STRING_LEN_MA=
X];=C2=A0=C2=A0 // human readable effect
> name
> -=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0 implementor[EFFECT_STRING_LEN_=
MAX];=C2=A0=C2=A0=C2=A0 // human readable
> effect implementor name
> +=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0 implementor[EFFECT_STRING_LEN_=
MAX];=C2=A0=C2=A0=C2=A0 // human readable
> effect implementer name
> =C2=A0} effect_descriptor_t;
> =C2=A0
> =C2=A0// CPU load and memory usage indication: each effect implementation
> must provide an indication of
> @@ -911,7 +911,7 @@ typedef struct audio_effect_library_s {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t version;
> =C2=A0=C2=A0=C2=A0=C2=A0 // Name of this library
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> -=C2=A0=C2=A0=C2=A0 // Author/owner/implementor of the library
> +=C2=A0=C2=A0=C2=A0 // Author/owner/implementer of the library
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *implementor;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0
> /////////////////////////////////////////////////////////////////////
> ///////////
> diff --git a/android/hardware/bluetooth.h
> b/android/hardware/bluetooth.h
> index 21253e00ab91..0808a11fc053 100644
> --- a/android/hardware/bluetooth.h
> +++ b/android/hardware/bluetooth.h
> @@ -420,7 +420,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 size_t size;
> =C2=A0=C2=A0=C2=A0=C2=A0 /**
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Opens the interface and provides the cal=
lback routines
> -=C2=A0=C2=A0=C2=A0=C2=A0 * to the implemenation of this interface.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * to the implementation of this interface.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 int (*init)(bt_callbacks_t* callbacks );
> =C2=A0
> diff --git a/android/hardware/bt_hf.h b/android/hardware/bt_hf.h
> index c3f952415c25..6cc37ed89128 100644
> --- a/android/hardware/bt_hf.h
> +++ b/android/hardware/bt_hf.h
> @@ -282,7 +282,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 /** Closes the interface. */
> =C2=A0=C2=A0=C2=A0=C2=A0 void=C2=A0 (*cleanup)( void );
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /** configureation for the SCO codec */
> +=C2=A0=C2=A0=C2=A0 /** configuration for the SCO codec */
> =C2=A0=C2=A0=C2=A0=C2=A0 bt_status_t (*configure_wbs)( bt_bdaddr_t *bd_ad=
dr
> ,bthf_wbs_config_t config );
> =C2=A0} bthf_interface_t;
> =C2=A0
> diff --git a/android/hardware/bt_hh.h b/android/hardware/bt_hh.h
> index 2dd61beacaf2..51bb75ae5c6f 100644
> --- a/android/hardware/bt_hh.h
> +++ b/android/hardware/bt_hh.h
> @@ -34,7 +34,7 @@ typedef enum
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_HS_HID_NOT_READY,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* handshake error : device not
> ready */
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_HS_INVALID_RPT_ID,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* handshake error : invalid
> report ID */
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_HS_TRANS_NOT_SPT,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* handshake error : transaction
> not spt */
> -=C2=A0=C2=A0=C2=A0 BTHH_HS_INVALID_PARAM,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* handshake error : invalid
> paremter */
> +=C2=A0=C2=A0=C2=A0 BTHH_HS_INVALID_PARAM,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* handshake error : invalid
> parameter */
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_HS_ERROR,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* handshake erro=
r : unspecified
> HS error */
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_ERR,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* general BTA HH error */
> =C2=A0=C2=A0=C2=A0=C2=A0 BTHH_ERR_SDP,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SDP erro=
r */
> @@ -79,8 +79,8 @@ typedef struct
> =C2=A0 */
> =C2=A0typedef void (* bthh_connection_state_callback)(bt_bdaddr_t
> *bd_addr, bthh_connection_state_t state);
> =C2=A0
> -/** Callback for vitual unplug api.
> - *=C2=A0 the status of the vitual unplug
> +/** Callback for virtual unplug api.
> + *=C2=A0 the status of the virtual unplug
> =C2=A0 */
> =C2=A0typedef void (* bthh_virtual_unplug_callback)(bt_bdaddr_t *bd_addr,
> bthh_status_t hh_status);
> =C2=A0
> @@ -100,7 +100,7 @@ typedef void (*
> bthh_idle_time_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_
> =C2=A0
> =C2=A0
> =C2=A0/** Callback for get report api.
> - *=C2=A0 if staus is ok rpt_data contains the report data
> + *=C2=A0 if status is ok rpt_data contains the report data
> =C2=A0 */
> =C2=A0typedef void (* bthh_get_report_callback)(bt_bdaddr_t *bd_addr,
> bthh_status_t hh_status, uint8_t* rpt_data, int rpt_size);
> =C2=A0
> diff --git a/android/hardware/bt_rc.h b/android/hardware/bt_rc.h
> index c1290aeb1f59..1b34fa734519 100644
> --- a/android/hardware/bt_rc.h
> +++ b/android/hardware/bt_rc.h
> @@ -111,7 +111,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t text[BTRC_MAX_ATTR_STR_LEN];
> =C2=A0} btrc_element_attr_val_t;
> =C2=A0
> -/** Callback for the controller's supported feautres */
> +/** Callback for the controller's supported features */
> =C2=A0typedef void (* btrc_remote_features_callback)(bt_bdaddr_t *bd_addr=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> btrc_remote_features_t features);
> =C2=A0
> @@ -189,7 +189,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 bt_status_t (*init)( btrc_callbacks_t* callbacks=
 );
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /** Respose to GetPlayStatus request. Contains the cu=
rrent
> +=C2=A0=C2=A0=C2=A0 /** Response to GetPlayStatus request. Contains the c=
urrent
> =C2=A0=C2=A0=C2=A0=C2=A0 **=C2=A0 1. Play status
> =C2=A0=C2=A0=C2=A0=C2=A0 **=C2=A0 2. Song duration/length
> =C2=A0=C2=A0=C2=A0=C2=A0 **=C2=A0 3. Song position
> @@ -243,7 +243,7 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 /**Send current volume setting to remote side. S=
upport limited
> to SetAbsoluteVolume
> =C2=A0=C2=A0=C2=A0=C2=A0 ** This can be enhanced to support Relative Volu=
me (AVRCP 1.0).
> =C2=A0=C2=A0=C2=A0=C2=A0 ** With RelateVolume, we will send VOLUME_UP/VOL=
UME_DOWN opposed
> to absolute volume level
> -=C2=A0=C2=A0=C2=A0 ** volume: Should be in the range 0-127. bit7 is rese=
ved and
> cannot be set
> +=C2=A0=C2=A0=C2=A0 ** volume: Should be in the range 0-127. bit7 is rese=
rved and
> cannot be set
> =C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 bt_status_t (*set_volume)(uint8_t volume);
> =C2=A0
> diff --git a/android/hardware/hardware.h
> b/android/hardware/hardware.h
> index 74470a31a41e..dc55b73b3264 100644
> --- a/android/hardware/hardware.h
> +++ b/android/hardware/hardware.h
> @@ -44,7 +44,7 @@ __BEGIN_DECLS
> =C2=A0#define HARDWARE_HAL_API_VERSION HARDWARE_MAKE_API_VERSION(1, 0)
> =C2=A0
> =C2=A0/*
> - * Helper macros for module implementors.
> + * Helper macros for module implementers.
> =C2=A0 *
> =C2=A0 * The derived modules should provide convenience macros for
> supported
> =C2=A0 * versions so that implementations can explicitly specify
> module/device
> @@ -122,7 +122,7 @@ typedef struct hw_module_t {
> =C2=A0=C2=A0=C2=A0=C2=A0 /** Name of this module */
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /** Author/owner/implementor of the module */
> +=C2=A0=C2=A0=C2=A0 /** Author/owner/implementer of the module */
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *author;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /** Modules methods */
> diff --git a/android/health.c b/android/health.c
> index 9a29964b1be2..39cf3748e36a 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -948,7 +948,7 @@ static void bt_health_mdep_cfg_data(const void
> *buf, uint16_t len)
> =C2=A0	 * register with different role and different
> configurations.
> =C2=A0	 * 1) Does device supports SOURCE and SINK at the same time
> ?
> =C2=A0	 * 2) Does it require different SDP records or one record
> with
> -	 *=C2=A0=C2=A0=C2=A0 multile MDEP configurations ?
> +	 *=C2=A0=C2=A0=C2=A0 multiple MDEP configurations ?
> =C2=A0	 */
> =C2=A0	if (update_sdp_record(app) < 0) {
> =C2=A0		error("health: HDP SDP record preparation failed");
> @@ -1221,7 +1221,7 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl
> *mdl, void *data)
> =C2=A0
> =C2=A0static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
> =C2=A0{
> -	DBG("Not Implemeneted");
> +	DBG("Not Implemented");
> =C2=A0}
> =C2=A0
> =C2=A0static struct health_device *create_device(struct health_app *app,
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 598bec326ca8..2e88f8c7292e 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -357,7 +357,7 @@ static void bt_hid_notify_get_report(struct
> hid_device *dev, uint8_t *buf,
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> -	 * Report porotocol mode reply contains id after hdr, in
> boot
> +	 * Report protocol mode reply contains id after hdr, in boot
> =C2=A0	 * protocol mode id doesn't exist
> =C2=A0	 */
> =C2=A0	ev_len +=3D (dev->boot_dev) ? (len - 1) : (len - 2);
> @@ -366,7 +366,7 @@ static void bt_hid_notify_get_report(struct
> hid_device *dev, uint8_t *buf,
> =C2=A0	bdaddr2android(&dev->dst, ev->bdaddr);
> =C2=A0
> =C2=A0	/*
> -	 * Report porotocol mode reply contains id after hdr, in
> boot
> +	 * Report protocol mode reply contains id after hdr, in boot
> =C2=A0	 * protocol mode id doesn't exist
> =C2=A0	 */
> =C2=A0	if (dev->boot_dev) {
> @@ -1043,7 +1043,7 @@ static void bt_hid_info(const void *buf,
> uint16_t len)
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> -	 * Data from hal_cmd_hidhost_set_info is usefull only when
> we create
> +	 * Data from hal_cmd_hidhost_set_info is useful only when we
> create
> =C2=A0	 * UHID device. Once device is created all the transactions
> will be
> =C2=A0	 * done through the fd. There is no way to use this
> information
> =C2=A0	 * once device is created with HID internals.
> diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
> index 34479623c9f0..1262feed8422 100644
> --- a/android/pics-avctp.txt
> +++ b/android/pics-avctp.txt
> @@ -41,7 +41,7 @@ TSPC_AVCTP_2_2	True		Transaction
> label management (M)
> =C2=A0TSPC_AVCTP_2_3	True		Packet type field management (M)
> =C2=A0TSPC_AVCTP_2_4	True		Message type field management (M)
> =C2=A0TSPC_AVCTP_2_5	True		PID field management (M)
> -TSPC_AVCTP_2_6	True		IPID field mangement (M)
> +TSPC_AVCTP_2_6	True		IPID field management (M)
> =C2=A0TSPC_AVCTP_2_7	True		Message information management (M)
> =C2=A0TSPC_AVCTP_2_8	False		Event registration for message
> reception (O)
> =C2=A0TSPC_AVCTP_2_9	False		Event registration for connection
> request (O)
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index 7bd68fa77213..f6ab74d88c32 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -617,7 +617,7 @@ TSPC_AVRCP_11_24=C2=A0 False		TG: category
> 4 - Operation id: 9 (O)
> =C2=A0TSPC_AVRCP_11_25=C2=A0 False		TG: category 4 - Operation
> id: dot (O)
> =C2=A0TSPC_AVRCP_11_26=C2=A0 False		TG: category 4 - Operation
> id: enter (O)
> =C2=A0TSPC_AVRCP_11_27=C2=A0 False		TG: category 4 - Operation
> id: clear (O)
> -TSPC_AVRCP_11_28=C2=A0 False		TG: category 4 - Operation
> id: disply (O)
> +TSPC_AVRCP_11_28=C2=A0 False		TG: category 4 - Operation
> id: display (O)
> =C2=A0TSPC_AVRCP_11_29=C2=A0 False		TG: category 4 - Operation
> id: help (O)
> =C2=A0TSPC_AVRCP_11_30=C2=A0 False		TG: category 4 - Operation
> id: page up (O)
> =C2=A0TSPC_AVRCP_11_31=C2=A0 False		TG: category 4 - Operation
> id: page down (O)
> diff --git a/android/pics-gap.txt b/android/pics-gap.txt
> index 37759955f8a4..a96984a4873d 100644
> --- a/android/pics-gap.txt
> +++ b/android/pics-gap.txt
> @@ -101,7 +101,7 @@ C.2: Excluded if TSPC_GAP_2_7 is supported,
> otherwise Optional.
> =C2=A0C.5: Mandatory If (TSPC_GAP_2_5 or TSPC_GAP_2_6 or TSPC_GAP_2_7) is
> supported,
> =C2=A0	otherwise Optional.
> =C2=A0C.4: Mandatory if (Core Spec 2.1 or later) is supported, otherwise
> Excluded.
> -Note 2. If a Core 2.0 and earlier design claims to support secure
> communcation
> +Note 2. If a Core 2.0 and earlier design claims to support secure
> communication
> =C2=A0	it should support either Security mode 2 or 3.
> =C2=A0Note 3. A Core 2.1 or later device shall always support secure
> communication
> =C2=A0	in Security Mode 4, and shall use that mode to connect with
> another
> diff --git a/android/pics-opp.txt b/android/pics-opp.txt
> index 145198d487fa..846d6f68fc00 100644
> --- a/android/pics-opp.txt
> +++ b/android/pics-opp.txt
> @@ -75,7 +75,7 @@ TSPC_OPP_2_14	False		Client: vCard 2.1
> (C.1)
> =C2=A0TSPC_OPP_2_15	False		Client: Exchange business card (O)
> =C2=A0TSPC_OPP_2_16	False		Client: vCard 2.1 (C.2)
> =C2=A0TSPC_OPP_2_17	False		GOEP v2 (C.9)
> -TSPC_OPP_2_18	False		GOEP v2 Backward Compability (C.9)
> +TSPC_OPP_2_18	False		GOEP v2 Backward Compatibility (C.9)
> =C2=A0TSPC_OPP_2_19	False		OBEX over L2CAP (C.9)
> =C2=A0TSPC_OPP_2_20	False		OBEX Reliable Session (C.10)
> =C2=A0TSPC_OPP_2_21	False		OBEX SRM (C.10)
> @@ -147,7 +147,7 @@ TSPC_OPP_3_16	False		Server:
> Business card exchange (O.2)
> =C2=A0TSPC_OPP_3_17	False		Server: vCard 2.1 (C.2)
> =C2=A0TSPC_OPP_3_18	False		Server: Business card exchange
> reject. (O)
> =C2=A0TSPC_OPP_3_19	False		GOEP v2 (C.5)
> -TSPC_OPP_3_20	False		GOEP v2 Backward Compability (C.5)
> +TSPC_OPP_3_20	False		GOEP v2 Backward Compatibility (C.5)
> =C2=A0TSPC_OPP_3_21	False		OBEX over L2CAP (C.5)
> =C2=A0TSPC_OPP_3_22	False		OBEX Reliable Session (C.16)
> =C2=A0TSPC_OPP_3_23	False		OBEX SRM (C.6)
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 3531ccae9e7c..04c7ebe721ae 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -925,7 +925,7 @@ TC_GAW_SR_BV_01_C	PASS	haltest:
> =C2=A0TC_GAW_SR_BV_02_C	PASS	haltest:
> =C2=A0				gatts add service
> =C2=A0				gatts add_characteristics:
> -					<properties> 66 <permisions>
> 145
> +					<properties> 66
> <permissions> 145
> =C2=A0				gatts start_service
> =C2=A0				gattc listen
> =C2=A0				gatts send_response: (twice)
> diff --git a/android/system-emulator.c b/android/system-emulator.c
> index 50bb088d3188..48423b842d5e 100644
> --- a/android/system-emulator.c
> +++ b/android/system-emulator.c
> @@ -137,7 +137,7 @@ static void snoop_start(void)
> =C2=A0
> =C2=A0static void snoop_stop(void)
> =C2=A0{
> -	printf("Stoping %s/%s\n", exec_dir, "bluetoothd-snoop");
> +	printf("Stopping %s/%s\n", exec_dir, "bluetoothd-snoop");
> =C2=A0
> =C2=A0	kill(snoop_pid, SIGTERM);
> =C2=A0}
> diff --git a/android/system/audio.h b/android/system/audio.h
> index 0c5af5e8404a..337866264f99 100644
> --- a/android/system/audio.h
> +++ b/android/system/audio.h
> @@ -224,8 +224,8 @@ typedef enum {
> =C2=A0 * The main format indicates the main codec type. The sub format
> field
> =C2=A0 * indicates options and parameters for each format. The sub format
> is mainly
> =C2=A0 * used for record to indicate for instance the requested bitrate o=
r
> profile.
> - * It can also be used for certain formats to give informations not
> present in
> - * the encoded audio stream (e.g. octet alignement for AMR).
> + * It can also be used for certain formats to give information not
> present in
> + * the encoded audio stream (e.g. octet alignment for AMR).
> =C2=A0 */
> =C2=A0typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 AUDIO_FORMAT_INVALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0xFFFFFFFFUL,
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 30db7684d66e..42006bbc003a 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -3582,7 +3582,7 @@ static struct test_case test_cases[] =3D {
> =C2=A0		ACTION_SUCCESS(bluetooth_disable_action, NULL),
> =C2=A0		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED,
> BT_STATE_OFF),
> =C2=A0	),
> -	/* This tests embeded ccc */
> +	/* This tests embedded ccc */
> =C2=A0	TEST_CASE_BREDRLE("Gatt Server - Srvc change write req.
> success",
> =C2=A0		ACTION_SUCCESS(bluetooth_enable_action, NULL),
> =C2=A0		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED,
> BT_STATE_ON),
> diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
> index f9daf559067a..53a5d778775c 100644
> --- a/android/tester-hidhost.c
> +++ b/android/tester-hidhost.c
> @@ -241,7 +241,7 @@ static void hid_ctrl_cid_hook_cb(const void
> *data, uint16_t len,
> =C2=A0		hid_prepare_reply_report(cid_data);
> =C2=A0		break;
> =C2=A0	/*
> -	 * HID device doesnot reply for this commads, so reaching
> pdu's
> +	 * HID device doesn't reply for this commands, so reaching
> pdu's
> =C2=A0	 * to hid device means assuming test passed
> =C2=A0	 */
> =C2=A0	case HID_SET_INPUT_REPORT:
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 361c519ef5a3..6e635b77d3e9 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -498,20 +498,20 @@ static bool match_mas_inst(btmce_mas_instance_t
> *exp_inst,
> =C2=A0				btmce_mas_instance_t *rec_inst, int
> inst_num)
> =C2=A0{
> =C2=A0	if (exp_inst->id && (exp_inst->id !=3D rec_inst->id)) {
> -		tester_debug("MAS inst. [%d] id missmatch %d vs %d",
> inst_num,
> +		tester_debug("MAS inst. [%d] id mismatch %d vs %d",
> inst_num,
> =C2=A0						rec_inst->id,
> exp_inst->id);
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (exp_inst->scn && (exp_inst->scn !=3D rec_inst->scn)) {
> -		tester_debug("MAS inst. [%d] scn missmatch %d vs
> %d", inst_num,
> +		tester_debug("MAS inst. [%d] scn mismatch %d vs %d",
> inst_num,
> =C2=A0						rec_inst->scn,
> exp_inst->scn);
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (exp_inst->msg_types &&
> =C2=A0			(exp_inst->msg_types !=3D rec_inst-
> >msg_types)) {
> -		tester_debug("Mas inst. [%d] mesg type missmatch %d
> vs %d",
> +		tester_debug("Mas inst. [%d] mesg type mismatch %d
> vs %d",
> =C2=A0					inst_num, rec_inst->scn,
> exp_inst->scn);
> =C2=A0		return 0;
> =C2=A0	}
> @@ -614,7 +614,7 @@ static bool match_data(struct step *step)
> =C2=A0	exp =3D queue_peek_head(data->steps);
> =C2=A0
> =C2=A0	if (!exp) {
> -		/* Can occure while test passed already */
> +		/* Can occur while test passed already */
> =C2=A0		tester_debug("Cannot get step to match");
> =C2=A0		return false;
> =C2=A0	}
