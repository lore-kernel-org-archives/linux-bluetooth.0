Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBE3FF1B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805668; cv=pass; b=TmA0fAGf0GkBaViZGXQ3E/UTerdPKHUNvjtxKoMHS6gNZuHNfn5uESuAacPYDKPAVuVUwtRMSV9s/ZRTyplDSvbJ5YPd+y7XAeZ/v3mrPBlKfoIZdTdAawNPfRhLWU2s8TjYR/BV5GGPIfNqpvHcOgmv/9wwxWKnYKClE3RMGV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805668; c=relaxed/simple;
	bh=MzmtGan8PTnSOijcnbye5MKrT0WPkFqK+HShyzCe7GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC0oB/jefscxZYsOZVvFK/6w/fkWOMbtwXx2xLjtWrU81S2blM3KYMNoDAu0LlQK2m1+M5G8Lhv/KJaGfjYe/MtWr4ZMlSXniOxvLWT4ReF4S9VQvcghQzQ8w35neQN0OqDiJbtszOdgkSjcugfiP/A9Rn3ZkD1jg0Va/z6AjqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKMNjkEn; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKMNjkEn"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c7ddf514so9542490d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805663; cv=none;
        d=google.com; s=arc-20240605;
        b=BsaUYXCk1cTIruOht/TSau0v0MGyu4r4dpoo8vnR5CWTydypJwD26XZD5IUeD5kVN8
         lpOHakWPdEbfscai5kTgTO0uogSKiPOS+FIuL0MZkGInWvYPOeaXWGc9Lhjbx2k3hnk3
         bdsPPIBgkcTdJimvH+frKPARgNUUayQvv9LQfl+Es/cPPMbce/wcZLswjj+FiIh5JzZu
         Qs9g2HISVRGGtMazEotSpsfQsuHAKuuSQSzmOEAqAf63PE94GxMGK4b5StAikadEsA6P
         j53S3Cg8R5xSAigjTecXme9jwUKRyiQRQxLbNoxEYClgJroLJ1ENZh1AyPt5c7ohH629
         jy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JUuyBnxl9eqOBTIzc1J3TceD+Ogwid+KI+UjVNOME0k=;
        fh=8dRV5l/Mw3iEGgaLe/RD18nOtHQGWvwuW7ilD0v+L2g=;
        b=WgIAzipx6A6E/jUJOsVXTUKsqMebeEAKsU/qftclgiwh3ZNyeT7JA3ipTe2rld2coy
         PPHZsoN97DxkXkwOJmLy0GGcPAWu9kdXk+zUPEZNItDcmdCZ/zrI90Wca6SuPhJTl6IN
         7GLTVuXCJgL3vr1McSe6eUFRt4pXcmMLmHKSnKMP2uOpuXdxTq5ex1/pN8jXFZPo1LCC
         JXlzaGggXR+RubrIcrZi0AeIuTUW6QS6sePxO2Rjt/3uOQlqxpoJ8BFTkdh8+mxvqH4D
         WcUGWDnVWS3OleJmKo6KkxpeMAvfbjv2O/lMQWTN7Kzvd4cKrRE2x1+BkZd00q9hPZoH
         EDXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805663; x=1780410463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUuyBnxl9eqOBTIzc1J3TceD+Ogwid+KI+UjVNOME0k=;
        b=DKMNjkEnvNrYwfggNlnuIsBpRAi18rv8mOUYnB0ma2NJEuldDp3uI2Xvokg2vBTEbl
         BRcb5r5lUpdGTMsnQXmV3rAflISkctPGYYRlRwImNA99I8MYm44rUX5sWaQ6WWWNjmyI
         rLA6On8Rm9uSnDnGal0FHh3+YKQ2lXBmgkIRohYZ7ewQZql9K19DpM83Sdqqa6veoXx0
         MxyyxqKZwAUbskYCtYAyM2cjkhcgLoJnPjXcNJEfvqoGd04KT97TuJBSVS90V3oExmFI
         YmkUbLh438BDSMzv7S+L+WsP5I4fBnFMH/Eo/erWNHrXr/yPlnVjfaDly4lr2KdGWv1E
         jh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805663; x=1780410463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUuyBnxl9eqOBTIzc1J3TceD+Ogwid+KI+UjVNOME0k=;
        b=TyT50EL5cnzpvajVci/A7QKlAzgo2i1OCOzkhESKdn1WbrWB8W/xUVDnre36XM0+o2
         LnrlrlzyQbRQwoq13kqNRu9p/ILRO7cgSgqYHMqnW0YCriXrKKi5XtcT99ueknoo1nrp
         JIpkGZEV13f+r5u9Wb5PhW+aTSUyJ8DtQbvjHjXjQ5c1sei5GAMW1nP3Nt9Xnm9sRIAD
         Pas2y+T0vY9NSl/Bu/O9jO+lp9Mg+ZZpHM2SEi1X91cjVoj9gmTNpH9RJmXlpWz/9rp1
         paGWE3mvSJl9Vc0BMMMebXfELK9Dm9vm3sd0SkgMqULIk7jSGaJXf88hRqvnp/a6FPBp
         Sn9g==
X-Gm-Message-State: AOJu0YzsmeYTapAAsE31e9Fy9v110ALDViIHdBpXCRy6qhNK/tNoorpi
	slyOxbqFbJpB2xbpwH2D9UPrkcuonG71Gp0A0lcm9fjktqqYL6SUQh9XlKwaFlSjoHJSEjapOzY
	hqLD28jS6qvEDGIOAGZW9WzzTo5tFdYA25A==
X-Gm-Gg: Acq92OGlr1wg5NCO0vuhO+cPJ5ZNvNYq9AhBwNjzLeuUB+A9rTILtK409hrF8HJOw4Q
	WRFKBFftJbHAMHWYdpUO0TEIvubTHUuKdh/1HaVGPGvNzNr2qFLhaTQxxDgP7IMnk+dsHNdKcbY
	KhOPfXqxo09CN0WE3wcv/jujWLf4ffGRTztpQOvBMTwFvoKjqUM0WQudZmtOI52L6GRmbKMuMAF
	6YCUmZA4VNB54n8NgTdcZhoAds016wPIPT5USBkIKP6eLDY+xsu+IQzaCyHH52VIZyMgdH0fjcE
	ktFvboUGNZ01MtEZyx0ZopMzRzeIvCvSzCGEJrumev3bzZSOsJNXxIvXgMyVUSmPGTg=
X-Received: by 2002:a53:c049:0:20b0:65c:2b92:f8ed with SMTP id
 956f58d0204a3-65ec9772e6amr14866087d50.22.1779805663455; Tue, 26 May 2026
 07:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524221421.258593-1-tarjeib@gmail.com> <20260524221421.258593-2-tarjeib@gmail.com>
In-Reply-To: <20260524221421.258593-2-tarjeib@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 May 2026 10:27:32 -0400
X-Gm-Features: AVHnY4JUyr9jBjd4nOGJThPTG4lkfyO1ro1Xu56XbuDVLh8xTZf2umYUmQ0I36Y
Message-ID: <CABBYNZLNrWP4-ZtqxL61UR8fxnp+6_Wfwdtfhq=bx2g=VeVLyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] adapter: Add configurable default LE PHYs
To: =?UTF-8?Q?Tarjei_Bitust=C3=B8yl?= <tarjeib@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tarjei,

On Sun, May 24, 2026 at 6:14=E2=80=AFPM Tarjei Bitust=C3=B8yl <tarjeib@gmai=
l.com> wrote:
>
> Some controllers mis-handle LE procedures on specific PHYs with
> certain peers. On an Intel AX210-class controller, connecting to a
> Frostbay BLE device can fail during early ATT/GATT setup unless the
> adapter is limited to LE 1M TX/RX.

Perhaps there should be a GitHub issue explaining exactly what the
problem is with btmon logs, etc, Then we can evaluate if this needs a
workaround like this or if we should detect that certain PHYs should
not be used.

> Add an opt-in [LE] DefaultPHYs setting to bluetoothd and apply it at
> adapter startup using MGMT_OP_GET/SET_PHY_CONFIGURATION while
> preserving non-configurable PHY bits.
>
> This provides a generic, adapter-wide workaround for controller-
> specific LE PHY interoperability problems affecting scanning and
> connection establishment, without adding device-specific quirks.

Well it is not really controller specific though, since it applies to
any controller on the system. Also, I believe this could be a device
specific problem so you might be taking away 2M support entirely when
it could actually be supported with another device.

> ---
>  src/adapter.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/btd.h     |  2 ++
>  src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++++
>  src/main.conf |  8 ++++++
>  4 files changed, 147 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 20f7c3e03..fcbb65e38 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4972,6 +4972,81 @@ done:
>         mgmt_tlv_list_free(list);
>  }
>
> +static void set_default_le_phys_complete(uint8_t status, uint16_t length=
,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +
> +       if (status !=3D MGMT_STATUS_SUCCESS)
> +               btd_error(adapter->dev_id,
> +                               "Failed to set default LE PHYs for hci%u:=
 %s (0x%02x)",
> +                               adapter->dev_id, mgmt_errstr(status), sta=
tus);
> +}
> +
> +static void get_default_le_phys_complete(uint8_t status, uint16_t length=
,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +       const struct mgmt_rp_get_phy_confguration *rp =3D param;
> +       struct mgmt_cp_set_phy_confguration cp;
> +       uint32_t configurable_phys;
> +       uint32_t selected_phys;
> +       uint32_t next_phys;
> +
> +       if (status !=3D MGMT_STATUS_SUCCESS) {
> +               btd_error(adapter->dev_id,
> +                               "Failed to read PHY configuration for hci=
%u: %s (0x%02x)",
> +                               adapter->dev_id, mgmt_errstr(status), sta=
tus);
> +               return;
> +       }
> +
> +       if (length < sizeof(*rp)) {
> +               btd_error(adapter->dev_id,
> +                               "Too small get PHY configuration response=
 for hci%u",
> +                               adapter->dev_id);
> +               return;
> +       }
> +
> +       configurable_phys =3D btohl(rp->configurable_phys);
> +       selected_phys =3D btohl(rp->selected_phys);
> +
> +       configurable_phys &=3D MGMT_PHY_LE_TX_MASK | MGMT_PHY_LE_RX_MASK;
> +       next_phys =3D selected_phys & ~configurable_phys;
> +       next_phys |=3D btd_opts.default_le_phys & configurable_phys;
> +
> +       if (next_phys =3D=3D selected_phys)
> +               return;
> +
> +       cp.selected_phys =3D cpu_to_le32(next_phys);
> +
> +       if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
> +                       adapter->dev_id, sizeof(cp), &cp,
> +                       set_default_le_phys_complete, adapter, NULL) > 0)
> +               return;
> +
> +       btd_error(adapter->dev_id,
> +                       "Failed to set default LE PHYs for hci%u",
> +                       adapter->dev_id);
> +}
> +
> +static void load_default_le_phys(struct btd_adapter *adapter)
> +{
> +       if (!btd_opts.default_le_phys_configured)
> +               return;
> +
> +       if (!(adapter->supported_settings & MGMT_SETTING_LE))
> +               return;
> +
> +       if (mgmt_send(adapter->mgmt, MGMT_OP_GET_PHY_CONFIGURATION,
> +                       adapter->dev_id, 0, NULL,
> +                       get_default_le_phys_complete, adapter, NULL) > 0)
> +               return;
> +
> +       btd_error(adapter->dev_id,
> +                       "Failed to read PHY configuration for hci%u",
> +                       adapter->dev_id);
> +}
> +
>  static void load_devices(struct btd_adapter *adapter)
>  {
>         char dirname[PATH_MAX];
> @@ -9455,6 +9530,7 @@ load:
>         btd_profile_foreach(probe_profile, adapter);
>         clear_blocked(adapter);
>         load_defaults(adapter);
> +       load_default_le_phys(adapter);
>         load_devices(adapter);
>
>         /* restore Service Changed CCC value for bonded devices */
> diff --git a/src/btd.h b/src/btd.h
> index db2e81239..59f44dc8c 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -140,6 +140,8 @@ struct btd_opts {
>         bool            device_privacy;
>         uint32_t        name_request_retry_delay;
>         uint8_t         secure_conn;
> +       uint32_t        default_le_phys;
> +       bool            default_le_phys_configured;
>
>         struct btd_defaults defaults;
>
> diff --git a/src/main.c b/src/main.c
> index 8aa19a3e3..97c64845b 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -32,6 +32,7 @@
>  #include <dbus/dbus.h>
>
>  #include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>  #include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
> @@ -132,6 +133,7 @@ static const char *le_options[] =3D {
>         "Autoconnecttimeout",
>         "AdvMonAllowlistScanDuration",
>         "AdvMonNoFilterScanDuration",
> +       "DefaultPHYs",
>         "EnableAdvMonInterleaveScan",
>         NULL
>  };
> @@ -145,6 +147,8 @@ static const char *policy_options[] =3D {
>         NULL
>  };
>
> +static void parse_default_le_phys(GKeyFile *config);
> +
>  static const char *gatt_options[] =3D {
>         "Cache",
>         "KeySize",
> @@ -751,6 +755,7 @@ static void parse_le_config(GKeyFile *config)
>                 return;
>
>         parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
> +       parse_default_le_phys(config);
>  }
>
>  static bool match_experimental(const void *data, const void *match_data)
> @@ -966,6 +971,62 @@ static void parse_repairing(GKeyFile *config)
>         g_free(str);
>  }
>
> +struct phy_config_entry {
> +       const char *name;
> +       uint32_t bit;
> +};
> +
> +static const struct phy_config_entry le_phy_configs[] =3D {
> +       { "LE1MTX", MGMT_PHY_LE_1M_TX },
> +       { "LE1MRX", MGMT_PHY_LE_1M_RX },
> +       { "LE2MTX", MGMT_PHY_LE_2M_TX },
> +       { "LE2MRX", MGMT_PHY_LE_2M_RX },
> +       { "LECODEDTX", MGMT_PHY_LE_CODED_TX },
> +       { "LECODEDRX", MGMT_PHY_LE_CODED_RX },
> +};
> +
> +static void parse_default_le_phys(GKeyFile *config)
> +{
> +       char *str =3D NULL;
> +       char **tokens;
> +       uint32_t phys =3D 0;
> +       bool valid =3D false;
> +       int i;
> +
> +       if (!parse_config_string(config, "LE", "DefaultPHYs", &str))
> +               return;
> +
> +       tokens =3D g_strsplit_set(str, ", \t", -1);
> +
> +       for (i =3D 0; tokens[i]; i++) {
> +               const char *token =3D tokens[i];
> +               size_t j;
> +
> +               if (!token[0])
> +                       continue;
> +
> +               for (j =3D 0; j < ARRAY_SIZE(le_phy_configs); j++) {
> +                       if (strcasecmp(le_phy_configs[j].name, token) !=
=3D 0)
> +                               continue;
> +
> +                       phys |=3D le_phy_configs[j].bit;
> +                       valid =3D true;
> +                       break;
> +               }
> +
> +               if (j =3D=3D ARRAY_SIZE(le_phy_configs))
> +                       warn("Invalid DefaultPHYs token: %s", token);
> +       }
> +
> +       if (valid) {
> +               btd_opts.default_le_phys =3D phys;
> +               btd_opts.default_le_phys_configured =3D true;
> +       }
> +
> +       g_strfreev(tokens);
> +       g_free(str);
> +}
> +
>  static bool parse_config_hex(GKeyFile *config, char *group,
>                                         const char *key, uint32_t *val)
>  {
> diff --git a/src/main.conf b/src/main.conf
> index 5846ef92d..ed955897e 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -247,6 +247,14 @@
>  # Default: 500
>  #AdvMonNoFilterScanDuration=3D
>
> +# Configure the controller's default LE PHY policy used for scanning and
> +# connection establishment. Only configurable LE PHYs are changed; manda=
tory
> +# PHYs remain selected automatically.
> +# Possible values: comma or space separated list of LE1MTX, LE1MRX, LE2M=
TX,
> +# LE2MRX, LECODEDTX, LECODEDRX.
> +# Example: keep LE on 1M only.
> +#DefaultPHYs =3D LE1MTX LE1MRX
> +
>  # Enable/Disable Advertisement Monitor interleave scan for power saving.
>  # 0: disable
>  # 1: enable
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
