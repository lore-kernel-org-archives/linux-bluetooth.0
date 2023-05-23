Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D7C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbjEWQbd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjEWQbc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 12:31:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150FDD
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 09:31:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2958db45so972921fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684859488; x=1687451488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ2XrKoz8KcHnlQmZSomFyrCLaevxoFMKuZeupXnqpA=;
        b=Zu2n3VEQwPm8XnXQz2AQYtjHd2WsGx0PiV3CDyqqgC9xv4c7kblJMzteydvuyBN1N+
         hNYz5Dkr3Qn8BdPEVd7VBnezs/AEIsGDmIOh4bQ/TPWtMz74i0uOPTCCAFQ8+I32Z6sr
         cgIVuX6h6swg2hOiikwyhLyftYSXZU995ePXbxeezGCYory+uN9VkjjAPGqANIsTNxla
         unMJ8CC8vZqRyU7BnzSpkct0PAoVf5DXkS+NKSa45g9M8VlzejLlIarpGruO8EiaHdPU
         FPdFxf/bH3pVeeD6whrZjMuAGFRtCfN2BOOKFxwWtdZTwxNrhxZAYuzrPM2dQoLZwGPL
         d1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859488; x=1687451488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ2XrKoz8KcHnlQmZSomFyrCLaevxoFMKuZeupXnqpA=;
        b=Z+OQoGLHOtR6Gbd4cVDJUSM/Kjf41jeUzsaGp4mLt+oPDC3vu+ufVw9DDCHkPSGrLu
         f7JRKme1JHPtM7z/jM8CPdHQKULwgOLU830rHC3kYZol6bT7HGLM7OzEkFeghM6dVELA
         WRFWO9XkmrPJZOuna0Db+wjaPPGAAB1RCh6Na/uJafAVaHjOlbIZF13tzKDnLJq9evn5
         Vd26XhO746GSTWtSRE65kmdwEED1S6H3Diy49ErifI9HpBDgjYvrKyfGsoBlAXsP3ulQ
         mSlCC52wW/flmD4fz1XEWcDz28QRl0Grbsy6TeGPwOhgqknii9ibKOS9WRJZZxTGrMGc
         rU/w==
X-Gm-Message-State: AC+VfDzfYXBR3f3pxoqg1rRLIK3mqDsZAuhgnPjzCqDn5LrqFiVra3vy
        qeydb/WNqs/w6FGX4gFOSwNUzfOkXQeI5lBwzJY=
X-Google-Smtp-Source: ACHHUZ6pKQQdWG0AAqynUk1pIV40wJTg5AYghQCpjcBiqA0DFwAogR93xliO6xDH/KFFL6IfKn+7w1uzKJd+9jgWSOw=
X-Received: by 2002:a2e:960a:0:b0:2ac:7ffb:6bda with SMTP id
 v10-20020a2e960a000000b002ac7ffb6bdamr5088152ljh.2.1684859487717; Tue, 23 May
 2023 09:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com> <20230523143504.3319-6-iulia.tanasescu@nxp.com>
In-Reply-To: <20230523143504.3319-6-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 May 2023 09:31:15 -0700
Message-ID: <CABBYNZJ9wtSUh-k0HAikoyz4nxWBG6+3d4D-Q3feeUwSNhgfyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/6] client/player: Update bluetoothctl with support
 for broadcast source
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Tue, May 23, 2023 at 7:45=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
>
> This adds bluetoothctl support for broadcast source.

Can we have an example of how the commands look?

> ---
>  client/player.c | 207 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 182 insertions(+), 25 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 7719076c8..1ba722150 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -73,10 +73,12 @@ struct endpoint {
>         struct iovec *meta;
>         bool auto_accept;
>         bool acquiring;
> -       uint8_t cig;
> -       uint8_t cis;
> +       uint8_t iso_group;
> +       uint8_t iso_stream;
>         char *transport;
>         DBusMessage *msg;
> +       bool broadcast;
> +       struct iovec *bcode;
>  };
>
>  static DBusConnection *dbus_conn;
> @@ -102,6 +104,22 @@ struct transport {
>         struct io *timer_io;
>  };
>
> +static const uint8_t base_lc3_16_2_1[] =3D {
> +       0x28, 0x00, 0x00, /* Presentation Delay */
> +       0x01, /* Number of Subgroups */
> +       0x01, /* Number of BIS */
> +       0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID =3D LC3 (0x06) */
> +       0x11, /* Codec Specific Configuration */
> +       0x02, 0x01, 0x03, /* 16 KHZ */
> +       0x02, 0x02, 0x01, /* 10 ms */
> +       0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
> +       0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
> +       0x04, /* Metadata */
> +       0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
> +       0x01, /* BIS */
> +       0x00, /* Codec Specific Configuration */
> +};
> +
>  static void endpoint_unregister(void *data)
>  {
>         struct endpoint *ep =3D data;
> @@ -1142,6 +1160,16 @@ static const struct capabilities {
>         CODEC_CAPABILITIES(PAC_SOURCE_UUID, LC3_ID,
>                                         LC3_DATA(LC3_FREQ_ANY, LC3_DURATI=
ON_ANY,
>                                                 3u, 30, 240)),
> +       /* Broadcast LC3 Source:
> +        *
> +        * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
> +        * Duration: 7.5 ms 10 ms
> +        * Channel count: 3
> +        * Frame length: 30-240
> +        */
> +       CODEC_CAPABILITIES(BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID, LC3=
_ID,
> +                                       LC3_DATA(LC3_FREQ_ANY, LC3_DURATI=
ON_ANY,
> +                                               3u, 30, 240)),
>  };
>
>  struct codec_qos {
> @@ -1419,6 +1447,7 @@ static struct preset {
>         PRESET(A2DP_SINK_UUID, sbc_presets, 6),
>         PRESET(PAC_SINK_UUID, lc3_presets, 3),
>         PRESET(PAC_SOURCE_UUID, lc3_presets, 3),
> +       PRESET(BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID, lc3_presets, 3)=
,
>  };
>
>  static struct codec_preset *find_preset(const char *uuid, const char *na=
me)
> @@ -1588,6 +1617,27 @@ struct endpoint_config {
>         const struct codec_qos *qos;
>  };
>
> +#define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
> +                               0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03,=
 0xb8}
> +
> +static struct bt_iso_qos bcast_qos =3D {
> +               .bcast =3D {
> +                       .big =3D BT_ISO_QOS_BIG_UNSET,
> +                       .bis =3D BT_ISO_QOS_BIS_UNSET,
> +                       .sync_interval =3D 0x07,
> +                       .packing =3D 0x00,
> +                       .framing =3D 0x00,
> +                       .encryption =3D 0x00,
> +                       .bcode =3D BCODE,
> +                       .options =3D 0x00,
> +                       .skip =3D 0x0000,
> +                       .sync_timeout =3D 0x4000,
> +                       .sync_cte_type =3D 0x00,
> +                       .mse =3D 0x00,
> +                       .timeout =3D 0x4000,
> +               }
> +       };
> +
>  static void append_properties(DBusMessageIter *iter,
>                                                 struct endpoint_config *c=
fg)
>  {
> @@ -1595,6 +1645,7 @@ static void append_properties(DBusMessageIter *iter=
,
>         struct codec_qos *qos =3D (void *)cfg->qos;
>         const char *key =3D "Capabilities";
>         const char *meta =3D "Metadata";
> +       const char *keyBCode =3D "BroadcastCode";
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &=
dict);
>
> @@ -1605,7 +1656,7 @@ static void append_properties(DBusMessageIter *iter=
,
>                                         DBUS_TYPE_BYTE, &cfg->caps->iov_b=
ase,
>                                         cfg->caps->iov_len);
>
> -       if (cfg->meta->iov_len) {
> +       if ((cfg->ep->meta) && (cfg->meta->iov_len)) {
>                 g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &=
meta,
>                                 DBUS_TYPE_BYTE, &cfg->meta->iov_base,
>                                 cfg->meta->iov_len);
> @@ -1623,16 +1674,25 @@ static void append_properties(DBusMessageIter *it=
er,
>                                         DBUS_TYPE_BYTE, &cfg->target_late=
ncy);
>         }
>
> -       if (cfg->ep->cig !=3D BT_ISO_QOS_CIG_UNSET) {
> -               bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->cig);
> +       if ((!cfg->ep->broadcast) && (cfg->ep->iso_group !=3D BT_ISO_QOS_=
GROUP_UNSET)) {
> +               bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
>                 g_dbus_dict_append_entry(&dict, "CIG", DBUS_TYPE_BYTE,
> -                                                       &cfg->ep->cig);
> +                                                       &cfg->ep->iso_gro=
up);
> +       } else {
> +               bt_shell_printf("BIG 0x%2.2x\n", bcast_qos.bcast.big);
> +               g_dbus_dict_append_entry(&dict, "BIG", DBUS_TYPE_BYTE,
> +                                                       &bcast_qos.bcast.=
big);
>         }
>
> -       if (cfg->ep->cis !=3D BT_ISO_QOS_CIS_UNSET) {
> -               bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->cis);
> +       if ((!cfg->ep->broadcast) && (cfg->ep->iso_stream !=3D BT_ISO_QOS=
_STREAM_UNSET)) {
> +               bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->iso_stream);
>                 g_dbus_dict_append_entry(&dict, "CIS", DBUS_TYPE_BYTE,
> -                                                       &cfg->ep->cis);
> +                                                       &cfg->ep->iso_str=
eam);
> +
> +       } else {
> +               bt_shell_printf("BIS 0x%2.2x\n", bcast_qos.bcast.bis);
> +               g_dbus_dict_append_entry(&dict, "BIS", DBUS_TYPE_BYTE,
> +                                                       &bcast_qos.bcast.=
bis);
>         }
>
>         bt_shell_printf("Interval %u\n", qos->interval);
> @@ -1640,10 +1700,17 @@ static void append_properties(DBusMessageIter *it=
er,
>         g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
>                                                 &qos->interval);
>
> -       bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");
> +       if (!cfg->ep->broadcast) {
> +               bt_shell_printf("Framing %s\n", qos->framing ? "true" : "=
false");
>
> -       g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
> -                                               &qos->framing);
> +               g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOL=
EAN,
> +                                                       &qos->framing);
> +       } else {
> +               bt_shell_printf("Framing %s\n", bcast_qos.bcast.framing ?=
 "true" : "false");
> +
> +               g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOL=
EAN,
> +                                                       &bcast_qos.bcast.=
framing);
> +       }
>
>         bt_shell_printf("PHY %s\n", qos->phy);
>
> @@ -1668,6 +1735,56 @@ static void append_properties(DBusMessageIter *ite=
r,
>         g_dbus_dict_append_entry(&dict, "Delay", DBUS_TYPE_UINT32,
>                                                 &qos->delay);
>
> +       if (!cfg->ep->broadcast)
> +               goto done;
> +
> +       bt_shell_printf("SyncInterval %u\n", bcast_qos.bcast.sync_interva=
l);
> +
> +       g_dbus_dict_append_entry(&dict, "SyncInterval", DBUS_TYPE_BYTE,
> +                                               &bcast_qos.bcast.sync_int=
erval);
> +
> +       bt_shell_printf("Encryption %u\n", bcast_qos.bcast.encryption);
> +
> +       g_dbus_dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
> +                                               &bcast_qos.bcast.encrypti=
on);
> +
> +       bt_shell_printf("Options %u\n", bcast_qos.bcast.options);
> +
> +       g_dbus_dict_append_entry(&dict, "Options", DBUS_TYPE_BYTE,
> +                                               &bcast_qos.bcast.options)=
;
> +
> +       bt_shell_printf("Skip %u\n", bcast_qos.bcast.skip);
> +
> +       g_dbus_dict_append_entry(&dict, "Skip", DBUS_TYPE_UINT16,
> +                                               &bcast_qos.bcast.skip);
> +
> +       bt_shell_printf("SyncTimeout %u\n", bcast_qos.bcast.sync_timeout)=
;
> +
> +       g_dbus_dict_append_entry(&dict, "SyncTimeout", DBUS_TYPE_UINT16,
> +                                               &bcast_qos.bcast.sync_tim=
eout);
> +
> +       bt_shell_printf("SyncCteType %u\n", bcast_qos.bcast.sync_cte_type=
);
> +
> +       g_dbus_dict_append_entry(&dict, "SyncCteType", DBUS_TYPE_BYTE,
> +                                               &bcast_qos.bcast.sync_cte=
_type);
> +
> +       bt_shell_printf("MSE %u\n", bcast_qos.bcast.mse);
> +
> +       g_dbus_dict_append_entry(&dict, "MSE", DBUS_TYPE_BYTE,
> +                                               &bcast_qos.bcast.mse);
> +
> +       bt_shell_printf("Timeout %u\n", bcast_qos.bcast.timeout);
> +
> +       g_dbus_dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
> +                                               &bcast_qos.bcast.timeout)=
;
> +
> +       bt_shell_printf("BroadcastCode:\n");
> +       bt_shell_hexdump(cfg->ep->bcode->iov_base, cfg->ep->bcode->iov_le=
n);
> +
> +       g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &keyBCode=
,
> +                                                               DBUS_TYPE=
_BYTE, &cfg->ep->bcode->iov_base,
> +                                                               cfg->ep->=
bcode->iov_len);
> +
>  done:
>         dbus_message_iter_close_container(iter, &dict);
>  }
> @@ -1707,12 +1824,20 @@ static DBusMessage *endpoint_select_properties_re=
ply(struct endpoint *ep,
>         cfg =3D new0(struct endpoint_config, 1);
>         cfg->ep =3D ep;
>
> -       /* Copy capabilities */
> -       iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_le=
n);
> +       if (ep->broadcast) {
> +               iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode, sizeof=
(bcast_qos.bcast.bcode));
> +               /* Copy capabilities for broadcast*/
> +               iov_append(&cfg->caps, base_lc3_16_2_1, sizeof(base_lc3_1=
6_2_1));
> +       } else {
> +               /* Copy capabilities */
> +               iov_append(&cfg->caps, preset->data.iov_base, preset->dat=
a.iov_len);
> +       }
> +
>         cfg->target_latency =3D preset->target_latency;
>
>         /* Copy metadata */
> -       iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->io=
v_len);
> +       if (cfg->ep->meta)
> +               iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->=
meta->iov_len);
>
>         if (preset->qos.phy)
>                 /* Set QoS parameters */
> @@ -2073,14 +2198,14 @@ fail:
>
>  }
>
> -static void endpoint_cis(const char *input, void *user_data)
> +static void endpoint_iso_stream(const char *input, void *user_data)
>  {
>         struct endpoint *ep =3D user_data;
>         char *endptr =3D NULL;
>         int value;
>
>         if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
> -               ep->cis =3D BT_ISO_QOS_CIS_UNSET;
> +               ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
>         } else {
>                 value =3D strtol(input, &endptr, 0);
>
> @@ -2089,20 +2214,20 @@ static void endpoint_cis(const char *input, void =
*user_data)
>                         return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>
> -               ep->cis =3D value;
> +               ep->iso_stream =3D value;
>         }
>
>         endpoint_register(ep);
>  }
>
> -static void endpoint_cig(const char *input, void *user_data)
> +static void endpoint_iso_group(const char *input, void *user_data)
>  {
>         struct endpoint *ep =3D user_data;
>         char *endptr =3D NULL;
>         int value;
>
>         if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
> -               ep->cig =3D BT_ISO_QOS_CIG_UNSET;
> +               ep->iso_group =3D BT_ISO_QOS_GROUP_UNSET;
>         } else {
>                 value =3D strtol(input, &endptr, 0);
>
> @@ -2111,10 +2236,13 @@ static void endpoint_cig(const char *input, void =
*user_data)
>                         return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>
> -               ep->cig =3D value;
> +               ep->iso_group =3D value;
>         }
>
> -       bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_cis=
, ep);
> +       if (!ep->broadcast)
> +               bt_shell_prompt_input(ep->path, "CIS (auto/value):", endp=
oint_iso_stream, ep);
> +       else
> +               bt_shell_prompt_input(ep->path, "BIS (auto/value):", endp=
oint_iso_stream, ep);
>  }
>
>  static void endpoint_auto_accept(const char *input, void *user_data)
> @@ -2130,7 +2258,13 @@ static void endpoint_auto_accept(const char *input=
, void *user_data)
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig=
, ep);
> +       if (!strcmp(ep->uuid, BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID))=
 {
> +               bt_shell_prompt_input(ep->path, "BIG (auto/value):", endp=
oint_iso_group, ep);
> +               ep->broadcast =3D true;
> +       } else {
> +               bt_shell_prompt_input(ep->path, "CIG (auto/value):", endp=
oint_iso_group, ep);
> +               ep->broadcast =3D false;
> +       }
>  }
>
>  static void endpoint_set_metadata(const char *input, void *user_data)
> @@ -2227,6 +2361,7 @@ static void cmd_register_endpoint(int argc, char *a=
rgv[])
>         char **list;
>
>         ep =3D g_new0(struct endpoint, 1);
> +       ep->meta =3D NULL;
>         ep->uuid =3D g_strdup(argv[1]);
>         ep->codec =3D strtol(argv[2], &endptr, 0);
>         ep->cid =3D 0x0000;
> @@ -2861,8 +2996,8 @@ static void register_endpoints(GDBusProxy *proxy)
>
>                         ep =3D endpoint_new(cap);
>                         ep->auto_accept =3D true;
> -                       ep->cig =3D BT_ISO_QOS_CIG_UNSET;
> -                       ep->cis =3D BT_ISO_QOS_CIS_UNSET;
> +                       ep->iso_group =3D BT_ISO_QOS_GROUP_UNSET;
> +                       ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
>                         endpoint_register(ep);
>                 }
>
> @@ -3409,6 +3544,7 @@ static void cmd_acquire_transport(int argc, char *a=
rgv[])
>  {
>         GDBusProxy *proxy;
>         int i;
> +       struct endpoint *ep, *link;
>
>         for (i =3D 1; i < argc; i++) {
>                 proxy =3D g_dbus_proxy_lookup(transports, NULL, argv[i],
> @@ -3424,6 +3560,27 @@ static void cmd_acquire_transport(int argc, char *=
argv[])
>                         return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>
> +               ep =3D find_ep_by_transport(g_dbus_proxy_get_path(proxy))=
;
> +               if (!ep || ep->acquiring) {
> +                       bt_shell_printf("Transport %s already in acquirin=
g process\n",
> +                                       argv[i]);
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
> +               }
> +
> +               ep->acquiring =3D true;
> +
> +               link =3D find_link_by_proxy(proxy);
> +               if (link) {
> +                       bt_shell_printf("Link %s found\n", link->transpor=
t);
> +                       /* If link already acquiring wait it to be comple=
te */
> +                       if (link->acquiring) {
> +                               bt_shell_printf("Link %s already in acqui=
ring process\n",
> +                                       argv[i]);
> +                               return bt_shell_noninteractive_quit(EXIT_=
FAILURE);
> +                       }
> +                       link->acquiring =3D true;
> +               }
> +
>                 if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
>                                                 acquire_reply, proxy, NUL=
L)) {
>                         bt_shell_printf("Failed acquire transport\n");
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
