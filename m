Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B83C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 17:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjEYRrr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjEYRro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 13:47:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479F1AC
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 10:47:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso2745737e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685036857; x=1687628857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYbUtxgBC3W1ldXyHAFEuoWK6PSW76AesRGeRgq0N2s=;
        b=ZP2CXN8AumPAJ/TduHCe4Mb8/usYa88giP/epQEYCpliy8PUJixEMUCibBIKhEoSjY
         R6WkpV329qEYmajb/OD1abVItCYK0CeGIX7fggCGCynSQj4umhouqMfEHPhxsSTGd16B
         BsHILm//7cG5uY5vEP9W1Xasdrd6jtXFeAtcku+O3UwveBawXCFH8tRf0rIcZkMFPNQF
         zuETCj/nPSjUpD8OWJ7DjHTFZJrR+//oAtI3B0E1EnTuPn2qkay3tRn7avicg9EN5sLs
         V3Gfe+8TxA7SjuwfoKKgaQzSKyyli3OmnK01VSp204JocMz+ez4FCZkIOQ+YWVVRMEY3
         7I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036857; x=1687628857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYbUtxgBC3W1ldXyHAFEuoWK6PSW76AesRGeRgq0N2s=;
        b=hgPaUtB9qS/zLwt8b9dfxJOVlzBT79/q3j3GAeUNzCo7Fx9zaVv8hL4oovvqGo7bko
         t1JOFvgJsEW4/ilsvdzPkgcLLdEiZrMx0sksLoH+X/A4c1mMjL3LkRAhGG6lqZyBsJxR
         TbXa0u69MM+lrxDgLL7KZ80VEMLqRuzACEXpY0pLT4ru5f6HX6WLRlKAKS0A8H+OocMQ
         tg4I8iuHTc1dIL4nHTl9Qdh6DmUzLn2bLXD2kcT0HZ5QsDecnI6CvwTyClhmBYPlisot
         KEO2aPe+iCoNkqfwuR1fXy1VuGKHX2TAab+oc6r43cAvVCMSPNrvCb7kCWNX1SW1gOOv
         /PCQ==
X-Gm-Message-State: AC+VfDxSBoqzWpZSTcRp4U7w8fn3aknrx5j11XS/oJBLZ4Z9Poi5FWVV
        0Riqk9hXQntOQes6pJnNrAU5sV0yYRtHT2zcUCs4Olz0
X-Google-Smtp-Source: ACHHUZ41lH7RWk56o3HR4m6KxrwlEemZcX5NfTg7qJPMrKzwTa1chDo3XrWmdc4NptqVQcFag+oTv0hDzE5D6yquvQE=
X-Received: by 2002:a2e:3c02:0:b0:2ac:840c:4cb2 with SMTP id
 j2-20020a2e3c02000000b002ac840c4cb2mr1344539lja.25.1685036857260; Thu, 25 May
 2023 10:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com> <20230525153452.125789-6-silviu.barbulescu@nxp.com>
In-Reply-To: <20230525153452.125789-6-silviu.barbulescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 25 May 2023 10:47:24 -0700
Message-ID: <CABBYNZ+GfYBT2L+E79eFQE7dot4t8UFzA7Ph18s5idE8dXJ0BQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Update bluetoothctl with support for broadcast source
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

On Thu, May 25, 2023 at 8:37=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> This adds bluetoothctl support for broadcast source.

You forgot to add an example of how these changes can be used in the
patch description, I know you have it in the cover letter but that
will not be committed.

> ---
>  client/player.c | 209 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 185 insertions(+), 24 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index a9f56fb94..408118fca 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -74,11 +74,13 @@ struct endpoint {
>         bool auto_accept;
>         bool acquiring;
>         uint8_t max_transports;
> -       uint8_t cig;
> -       uint8_t cis;
> +       uint8_t iso_group;
> +       uint8_t iso_stream;
>         char *transport;
>         DBusMessage *msg;
>         struct preset *preset;
> +       bool broadcast;
> +       struct iovec *bcode;
>  };
>
>  static DBusConnection *dbus_conn;
> @@ -104,6 +106,22 @@ struct transport {
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
> @@ -1154,6 +1172,16 @@ static const struct capabilities {
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
> +       CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
> +                                       LC3_DATA(LC3_FREQ_ANY, LC3_DURATI=
ON_ANY,
> +                                               3u, 30, 240)),
>  };
>
>  struct codec_qos {
> @@ -1435,6 +1463,7 @@ static struct preset {
>         PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
>         PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
>         PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
> +       PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
>  };
>
>  static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_=
t *cid)
> @@ -1707,6 +1736,27 @@ struct endpoint_config {
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
> @@ -1714,6 +1764,7 @@ static void append_properties(DBusMessageIter *iter=
,
>         struct codec_qos *qos =3D (void *)cfg->qos;
>         const char *key =3D "Capabilities";
>         const char *meta =3D "Metadata";
> +       const char *keyBCode =3D "BroadcastCode";
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &=
dict);
>
> @@ -1742,16 +1793,25 @@ static void append_properties(DBusMessageIter *it=
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
> @@ -1759,10 +1819,17 @@ static void append_properties(DBusMessageIter *it=
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
> @@ -1787,6 +1854,56 @@ static void append_properties(DBusMessageIter *ite=
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
> @@ -1826,8 +1943,15 @@ static DBusMessage *endpoint_select_properties_rep=
ly(struct endpoint *ep,
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
> @@ -2239,14 +2363,14 @@ fail:
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
> @@ -2255,20 +2379,20 @@ static void endpoint_cis(const char *input, void =
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
> @@ -2277,10 +2401,13 @@ static void endpoint_cig(const char *input, void =
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
>  static void endpoint_max_transports(const char *input, void *user_data)
> @@ -2302,13 +2429,22 @@ static void endpoint_max_transports(const char *i=
nput, void *user_data)
>                 ep->max_transports =3D value;
>         }
>
> -       bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig=
, ep);
> +       if (ep->broadcast)
> +               bt_shell_prompt_input(ep->path, "BIG (auto/value):", endp=
oint_iso_group, ep);
> +       else
> +               bt_shell_prompt_input(ep->path, "CIG (auto/value):", endp=
oint_iso_group, ep);
>  }
>
>  static void endpoint_auto_accept(const char *input, void *user_data)
>  {
>         struct endpoint *ep =3D user_data;
>
> +       if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
> +               ep->broadcast =3D true;
> +       } else {
> +               ep->broadcast =3D false;
> +       }
> +
>         if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
>                 ep->auto_accept =3D true;
>                 bt_shell_prompt_input(ep->path, "Max Transports (auto/val=
ue):",
> @@ -2321,7 +2457,10 @@ static void endpoint_auto_accept(const char *input=
, void *user_data)
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig=
, ep);
> +       if (ep->broadcast)
> +               bt_shell_prompt_input(ep->path, "BIG (auto/value):", endp=
oint_iso_group, ep);
> +       else
> +               bt_shell_prompt_input(ep->path, "CIG (auto/value):", endp=
oint_iso_group, ep);
>  }
>
>  static void endpoint_set_metadata(const char *input, void *user_data)
> @@ -3050,8 +3189,8 @@ static void register_endpoints(GDBusProxy *proxy)
>                                                                 ep->cid);
>                 ep->max_transports =3D UINT8_MAX;
>                 ep->auto_accept =3D true;
> -               ep->cig =3D BT_ISO_QOS_CIG_UNSET;
> -               ep->cis =3D BT_ISO_QOS_CIS_UNSET;
> +               ep->iso_group =3D BT_ISO_QOS_GROUP_UNSET;
> +               ep->iso_stream =3D BT_ISO_QOS_STREAM_UNSET;
>                 endpoint_register(ep);
>         }
>  }
> @@ -3595,6 +3734,7 @@ static void cmd_acquire_transport(int argc, char *a=
rgv[])
>  {
>         GDBusProxy *proxy;
>         int i;
> +       struct endpoint *ep, *link;
>
>         for (i =3D 1; i < argc; i++) {
>                 proxy =3D g_dbus_proxy_lookup(transports, NULL, argv[i],
> @@ -3610,6 +3750,27 @@ static void cmd_acquire_transport(int argc, char *=
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
