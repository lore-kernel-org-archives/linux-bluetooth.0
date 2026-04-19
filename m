Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A63126C03
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776565727; cv=pass; b=dHZvbYH0hcFOTR89/+8lT+WuUcZGGz3X7ssKHqfzKEMuiw4H12lC5dGll13r6XGDiuhCyipv3td2R/aLv1KY2kXB5MZ6vkIV1WVQEgndj1e/zlOfR3cO7b83TWFDOMtGqCfGVOS/0L/AZRimsVElqnjCoM9LwUy8iREUtGGZTiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776565727; c=relaxed/simple;
	bh=N/nqYV5bgtlXlMmr4m3DdkHJufE4ZAr4iwinAN4yw6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHIoy6lypKsblJgVzJF8Xkh9hGyuLXL0+PTXqjAwK5A4EOPdYLdC0jHg+8mzD6RbK3ru+TuFUDhEhqJkvfggyNB5dQd6pxvpepDO3qM4fDQsp0O8bZ5x/xXk+X316z3ip9wXpGIUeQEQsc+aTcEQJItBeCOLTLUMYTkjCYaQiU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB7yO2be; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB7yO2be"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so2610639d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 19:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776565725; cv=none;
        d=google.com; s=arc-20240605;
        b=OQ08bv5B2UkG73B1COWArJ81/HtJHiB4SRoFw3gFCAKF2br/EYLbMDt8d43jkUmuBX
         8Naf8vhIh3Rs5sN0NflYJHyh1vVfEOyEL72DhnzRiqV6MJDuPi3dXpVAYZLuJAbLF9Qd
         lFiiobyhYwfxyk9q7HDMyDrkb/XquLbk6s12F4G2A1GDglN9daKu2KkEJhmJC5NoLGo/
         iSVofqdjaqaZU2XlckKoMEyyKYp9wROnRlSGeogNY+w0T52tH3cGn6VsOQdg6KxjpR4G
         Ih7Ul/1WIdRLv8Zzg/uPyzbhguuDVTLpV8Yf6gz5NAItvdb426W7ZZH9EYKWY8FAA6Ue
         gR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+8F0k11TkC3yrOJ2/vTD+apOlw1WW7H3kFADaqQE9U=;
        fh=MI3N5zbzmRpMMFqGR7RBUwdd+3W2i0HQBWn+5G62ugE=;
        b=e9dUXvFitdUUeyAhFWCjhW6T2NuIGms/adHQBqdyPLv+zU7lB0nwbnL2OSjkN8jEi0
         3JVLmGGrTaeNPg9fZDrqY+uT3b6uEGb5ULoP5MHR5JlWZFB1w2AC71A1cj37VzTuI8nR
         aLLMmxc1XUmEg25lIx8Ipu0jt9/S91ZsdkGnBY7sUjvUnvVh84ELbBA8rmfwiom1HQ9f
         9xPKfrMIHfa9YzdkeYl48LCtlxerb2GfcJmg5QN3Txrw47oV43dCRl998ARLDVmafb5D
         XWPFcKiefMtBJdEG7Jggab4jx/VTE7v6UhGftUe3LChnl38xwWLU2myU6KIUWQ6xMHrd
         So8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776565725; x=1777170525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+8F0k11TkC3yrOJ2/vTD+apOlw1WW7H3kFADaqQE9U=;
        b=YB7yO2bef29RkoQLzhinakCq6cP7UD1XIa0Mdbem6hety/F3Ttrepg93x7p6ZrAKQ7
         ykXXOKXO41x8l1z50NI98CFko3EIS00JNH7XsOQ2I8uzTfeSeAZCaVaCJPhi7ccGwyQj
         DtyoM2zyskXYptIOAazw0r9NEKwvwQcV7Lrt6ZpsGjpuGhqDXxS7LXdusoxA2aAhVUr7
         gyisTqne0AUVtjTT0+xL6QJ5PTvwD4MWas1hHiJQWqHcs/Ccb48/EExap6OQ3bTB/s6p
         /FtII91Ciiz89SsQvpiD6fO/XwE/3lUdYXur+7pn9qcSC0OtFVQcJ4+F6xZWP42D/cpL
         W+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776565725; x=1777170525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+8F0k11TkC3yrOJ2/vTD+apOlw1WW7H3kFADaqQE9U=;
        b=i6TmJAaELD0EwvbGdX+NFtpA7SgSFt2un+5BF/i7ViHLV7huFiDlII2CNf/+xbxmUc
         kX6uu11BJxYJd2gbIlcvhDGYj2LHKUDk6kmgJjlJlWR0NU7zlOYiublPoM6MBdTbVhvJ
         7grEZQr/fseEC/6g0k8ds9tmrtZsK8VMKqwsyvcCdFnVug6Vg+kBtjyVckz3todAKxO/
         eeh1Odf4TXaBObryE0xV7AGHYJmt0BjWzbTzldYvbLZrghbvm9vYeTjjcaV5y2FNebdg
         naZqrjlgo6t+BxDzZ9oJtgRkCNci927BwsuVcCS4fjyYYgLBBGRXyCPvBwdhAKa6C3Qc
         32qg==
X-Gm-Message-State: AOJu0YwMVNSayhGLgjgMLqZ3euFTJGHCLgL6FfrM7353Qi2WZPVXwkOO
	72YY6KPWdIa6R+PcFZa6OtwnlLiInb9zP88lVIRHuwYFXN41zKoRbc5pUKXioxdYeW4yK7vObB3
	iDSfoBp3E8hhHD5ARmTP21EmeFKmF4tabOiob
X-Gm-Gg: AeBDieu2CN6k5d8TykD+GWv/ue7BN4RnFvgzD2t76WNCqEKEIf6BY2ME+D1sMkKpymy
	kxgtKRPMriSoigstNuhwwpzuSBhNEllmTD3nNtPWT7bRj6i7R9PL9bV2DRKyzsEhbZ4Dl+F+wDj
	CjJ5SB8s6jFwb/hbXwJ/zstmQDVXG30dzcJj0alpov2659qA26M84xVgEqDanKylTv7zQfGKGsG
	lySaTYipe3ycMD7GcFDVnjDt0wqeTTJNKpKMzMB3WaEVfq+A+g7IeyaIlWZu3n00N3whkJUJGHb
	4HEwU3t3/xllrl10/DpO6OhOvPefLlPwVrsBnO/IlrVEsnsiot/qOsJaAVACO936BDaYqKVrSr+
	3MgkqLAkcpbdC
X-Received: by 2002:a05:690e:4006:b0:652:f16e:345d with SMTP id
 956f58d0204a3-65311bc3dfamr6096816d50.30.1776565725045; Sat, 18 Apr 2026
 19:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418132740.235614-1-condorachest@gmail.com>
In-Reply-To: <20260418132740.235614-1-condorachest@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 18 Apr 2026 22:28:33 -0400
X-Gm-Features: AQROBzBoIhphrwkfHwZ_KKmmIP0DJISXBwtx7RbVTgVPmXt82uj84ioinDm5YM0
Message-ID: <CABBYNZL_uud4S6BmYGnVJctQbMy8UupSfj0bJXyMo9Mbrodrbg@mail.gmail.com>
Subject: Re: [PATCH] adapter: add DisableDiscoveryOnConnect option for combo
 chip coexistence
To: StefanCondorache <condorachest@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 18, 2026 at 9:27=E2=80=AFAM StefanCondorache <condorachest@gmai=
l.com> wrote:
>
> From: Bastien Nocera <hadess@hadess.net>
>
> On systems with combo chips (shared Wi-Fi/Bluetooth antenna), background
> LE scanning for auto-connect devices competes with active connections,
> causing audio stuttering and Wi-Fi packet loss due to antenna
> multiplexing via Packet Traffic Arbitration (PTA).
>
> Add a DisableDiscoveryOnConnect boolean option to the [General] section
> of main.conf. When enabled and an active connection exists, the option
> suppresses adding devices to the kernel auto-connect list in
> adapter_auto_connect_add() on kernels supporting KERNEL_CONN_CONTROL,
> and gates trigger_passive_scanning() on older kernels.
>
> The option defaults to false to preserve existing behavior.
>
> Signed-off-by: StefanCondorache <condorachest@gmail.com>
> ---
>  client/mgmt.c             |  4 ----
>  mesh/prov-initiator.c     |  3 +--
>  src/adapter.c             | 24 ++++++++++++++++++++++++
>  src/btd.h                 |  2 ++
>  src/device.c              |  4 ----
>  src/gatt-database.c       |  4 ----
>  src/main.c                |  4 ++++
>  src/main.conf             |  6 ++++++
>  src/shared/gatt-client.c  |  8 --------
>  src/shared/gatt-helpers.c |  4 ----
>  src/shared/ringbuf.c      |  4 ----
>  src/shared/uhid.c         |  4 ----
>  src/shared/vcp.h          |  8 --------
>  tools/advtest.c           |  3 ---
>  tools/btgatt-server.c     |  4 ----
>  tools/hcitool.c           |  4 ----
>  tools/parser/rfcomm.h     |  2 --
>  17 files changed, 37 insertions(+), 55 deletions(-)
>
> diff --git a/client/mgmt.c b/client/mgmt.c
> index 71fcd21ff..50558a313 100644
> --- a/client/mgmt.c
> +++ b/client/mgmt.c
> @@ -67,10 +67,6 @@ static struct {
>
>  static int pending_index =3D 0;
>
> -#ifndef MIN
> -#define MIN(x, y) ((x) < (y) ? (x) : (y))
> -#endif
> -
>  static void mgmt_menu_pre_run(const struct bt_shell_menu *menu);
>
>  #define PROMPT_ON      COLOR_BLUE "[mgmt]" COLOR_OFF "> "
> diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
> index d46081c7a..29c0be713 100644
> --- a/mesh/prov-initiator.c
> +++ b/mesh/prov-initiator.c
> @@ -18,6 +18,7 @@
>
>  #include "src/shared/ad.h"
>  #include "src/shared/ecc.h"
> +#include "src/shared/util.h"
>
>  #include "mesh/mesh-defs.h"
>  #include "mesh/util.h"
> @@ -34,8 +35,6 @@
>  #include "mesh/agent.h"
>  #include "mesh/error.h"
>
> -#define MIN(x, y) ((x) < (y) ? (x) : (y))
> -
>  /* Quick size sanity check */
>  static const uint16_t expected_pdu_size[] =3D {
>         2,      /* PROV_INVITE */
> diff --git a/src/adapter.c b/src/adapter.c
> index 6df66b3e0..4a18adfe0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1594,6 +1594,18 @@ static void trigger_passive_scanning(struct btd_ad=
apter *adapter)
>         if (!adapter->connect_list)
>                 return;
>
> +       /*
> +        * If the user has enabled DisableDiscoveryOnConnect, suppress
> +        * passive scanning whenever there is at least one active connect=
ion.
> +        * This prevents antenna multiplexing conflicts on combo chips wh=
ere
> +        * Wi-Fi and Bluetooth share the same 2.4 GHz radio, which causes
> +        * audio drops and Wi-Fi packet loss during background scans.
> +        */
> +       if (btd_opts.disable_discovery_on_connect && adapter->connections=
) {
> +               DBG("suppress passive scan: active connection present");
> +               return;
> +       }
> +
>         adapter->passive_scan_timeout =3D timeout_add_seconds(CONN_SCAN_T=
IMEOUT,
>                                         passive_scanning_timeout, adapter=
,
>                                         NULL);
> @@ -5717,6 +5729,18 @@ void adapter_auto_connect_add(struct btd_adapter *=
adapter,
>                 return;
>         }
>
> +       /*
> +        * If DisableDiscoveryOnConnect is enabled, suppress adding devic=
es
> +        * to the kernel auto-connect list while an active connection exi=
sts.
> +        * On combo chips (shared Wi-Fi/Bluetooth antenna), the kernel's
> +        * background scanning for auto-connect devices competes with act=
ive
> +        * connections, causing audio drops and Wi-Fi packet loss.
> +        */
> +       if (btd_opts.disable_discovery_on_connect && adapter->connections=
) {
> +               DBG("suppress kernel auto-connect: active connection pres=
ent");
> +               return;
> +       }
> +
>         bdaddr =3D device_get_address(device);
>         bdaddr_type =3D btd_device_get_bdaddr_type(device);
>
> diff --git a/src/btd.h b/src/btd.h
> index c84a600d1..07c4d85ba 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -144,6 +144,8 @@ struct btd_opts {
>         bool            experimental;
>         bool            testing;
>         bool            filter_discoverable;
> +       bool            disable_discovery_on_connect;
> +
>         struct queue    *kernel;
>
>         uint16_t        did_source;
> diff --git a/src/device.c b/src/device.c
> index 470340c2d..28515054c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -72,10 +72,6 @@
>  #define DISCOVERY_TIMER                1
>  #define INVALID_FLAGS          0xff
>
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  #define RSSI_THRESHOLD         8
>  #define AUTH_FAILURES_THRESHOLD        3
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 39e6a2593..680a52952 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -54,10 +54,6 @@
>  #define UUID_GATT      0x1801
>  #define UUID_DIS       0x180a
>
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  struct gatt_record {
>         struct btd_gatt_database *database;
>         uint32_t handle;
> diff --git a/src/main.c b/src/main.c
> index 818f7c06e..d7ddf5643 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -92,6 +92,7 @@ static const char *supported_options[] =3D {
>         "KernelExperimental",
>         "RemoteNameRequestRetryDelay",
>         "FilterDiscoverable",
> +       "DisableDiscoveryOnConnect",
>         NULL
>  };
>
> @@ -1072,6 +1073,8 @@ static void parse_general(GKeyFile *config)
>                                         0, UINT32_MAX);
>         parse_config_bool(config, "General", "FilterDiscoverable",
>                                                 &btd_opts.filter_discover=
able);
> +       parse_config_bool(config, "General", "DisableDiscoveryOnConnect",
> +                                       &btd_opts.disable_discovery_on_co=
nnect);
>  }
>
>  static void parse_gatt_cache(GKeyFile *config)
> @@ -1283,6 +1286,7 @@ static void init_defaults(void)
>         btd_opts.name_request_retry_delay =3D DEFAULT_NAME_REQUEST_RETRY_=
DELAY;
>         btd_opts.secure_conn =3D SC_ON;
>         btd_opts.filter_discoverable =3D true;
> +       btd_opts.disable_discovery_on_connect =3D false;
>
>         btd_opts.defaults.num_entries =3D 0;
>         btd_opts.defaults.br.page_scan_type =3D 0xFFFF;
> diff --git a/src/main.conf b/src/main.conf
> index d31dd1b8f..22507c465 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -157,6 +157,12 @@
>  # some stacks) or when testing bad/unintended behavior.
>  #FilterDiscoverable =3D true
>
> +# Disables background LE passive scanning when an active connection is
> +# established. Recommended for combo chips (shared Wi-Fi/Bluetooth anten=
na)
> +# to prevent audio stuttering and packet loss caused by antenna multiple=
xing.
> +# Defaults to false.
> +#DisableDiscoveryOnConnect =3D false

Wrong place, wrong design. If the controller can't handle passive
scanning and wants to disable it while connected, it really needs to
do that at the driver level, not in userspace=E2=80=94possibly with a quirk=
.
This is honestly a bad design at the controller side; since it
controls passive scanning it should have managed coexistence with
Wi-Fi. It really beats me how something like this reaches the market.
Anyway, let's have the driver deal with the controller specific mess.

>  [BR]
>  # The following values are used to load default adapter parameters for B=
R/EDR.
>  # BlueZ loads the values into the kernel before the adapter is powered i=
f the
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index df1541b88..a6abe8ac2 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -25,14 +25,6 @@
>  #include <limits.h>
>  #include <sys/uio.h>
>
> -#ifndef MAX
> -#define MAX(a, b) ((a) > (b) ? (a) : (b))
> -#endif
> -
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
>
>  #define GATT_SVC_UUID  0x1801
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 8dee34a9e..b3d5d8f1a 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -20,10 +20,6 @@
>  #include "src/shared/gatt-helpers.h"
>  #include "src/shared/util.h"
>
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  struct bt_gatt_result {
>         uint8_t opcode;
>         void *pdu;
> diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
> index 957d355f9..7460dd483 100644
> --- a/src/shared/ringbuf.c
> +++ b/src/shared/ringbuf.c
> @@ -21,10 +21,6 @@
>  #include "src/shared/util.h"
>  #include "src/shared/ringbuf.h"
>
> -#ifndef MIN
> -#define MIN(x,y) ((x)<(y)?(x):(y))
> -#endif
> -
>  struct ringbuf {
>         void *buffer;
>         size_t size;
> diff --git a/src/shared/uhid.c b/src/shared/uhid.c
> index 207afa55e..919618a71 100644
> --- a/src/shared/uhid.c
> +++ b/src/shared/uhid.c
> @@ -26,10 +26,6 @@
>
>  #define UHID_DEVICE_FILE "/dev/uhid"
>
> -#ifndef MIN
> -#define MIN(x, y) ((x) < (y) ? (x) : (y))
> -#endif
> -
>  struct uhid_replay {
>         bool active;
>         struct queue *out;
> diff --git a/src/shared/vcp.h b/src/shared/vcp.h
> index 89efaa09c..e031beafd 100644
> --- a/src/shared/vcp.h
> +++ b/src/shared/vcp.h
> @@ -23,14 +23,6 @@
>  #define BT_VCP_UNMUTE                  0x05
>  #define BT_VCP_MUTE                    0x06
>
> -#ifndef MAX
> -#define MAX(a, b) ((a) > (b) ? (a) : (b))
> -#endif
> -
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  struct bt_vcp;
>
>  typedef void (*bt_vcp_destroy_func_t)(void *user_data);
> diff --git a/tools/advtest.c b/tools/advtest.c
> index 7e744dca8..a67a03c43 100644
> --- a/tools/advtest.c
> +++ b/tools/advtest.c
> @@ -39,9 +39,6 @@
>                         "\xe1\x23\x99\xc1\xca\x9a\xc3\x31"
>  #define SCAN_IRK       "\xfa\x73\x09\x11\x3f\x03\x37\x0f" \
>                         "\xf4\xf9\x93\x1e\xf9\xa3\x63\xa6"
> -#ifndef MIN
> -#define MIN(x, y) ((x) < (y) ? (x) : (y))
> -#endif
>
>  static struct mgmt *mgmt;
>  static uint16_t index1 =3D MGMT_INDEX_NONE;
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index 449c34203..18e8b9542 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -48,10 +48,6 @@
>                 print_prompt(); \
>         } while (0)
>
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  #define COLOR_OFF      "\x1B[0m"
>  #define COLOR_RED      "\x1B[0;91m"
>  #define COLOR_GREEN    "\x1B[0;92m"
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 834f83e7a..1903d859b 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -34,10 +34,6 @@
>
>  #include "src/oui.h"
>
> -#ifndef MIN
> -#define MIN(a, b) ((a) < (b) ? (a) : (b))
> -#endif
> -
>  /* Unofficial value, might still change */
>  #define LE_LINK                0x80
>
> diff --git a/tools/parser/rfcomm.h b/tools/parser/rfcomm.h
> index b1cb1741c..d1b093a90 100644
> --- a/tools/parser/rfcomm.h
> +++ b/tools/parser/rfcomm.h
> @@ -33,8 +33,6 @@
>  /* Returns the P/F-bit */
>  #define GET_PF(ctr) (((ctr) >> 4) & 0x1)
>
> -#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> -
>  /* Endian-swapping macros for structs */
>  #define swap_long_frame(x) ((x)->h.length.val =3D le16_to_cpu((x)->h.len=
gth.val))
>  #define swap_mcc_long_frame(x) (swap_long_frame(x))
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
