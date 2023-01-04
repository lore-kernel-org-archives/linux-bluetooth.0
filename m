Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E43C4708E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjADAcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbjADAcr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 19:32:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F017072
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 16:32:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so48190893lfz.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jan 2023 16:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ArK4tzKp9fD5ey/tvaFp+TIer1R17JMUH3inJioMqOU=;
        b=V/w/9qdrMIvbGYo2qGeLpE2ahI0SC/NkjkrkelbJIfWjMiC+K3Wq37rLmTXRly4idT
         4sl8Iw+MFUTrc21++UFqsPr/RkpJlhr74ySo/y6VpdCFIZGOpi9AGaIXLvRv3EH+f8yr
         1HdTpyi2v5ntn6bz/aVosTmj7Us+0uJzO4SdIcvqRq5YDHS7de7+ibZH3sYXStdywUWM
         sPgm68xDTzuZD/j4/C6kDoQKQ76750FNJYrN+KeQxA6MernPSnnNHMAnPDSxpoqT2D/H
         FhFdgSpfyEGrFd3d61jgxcY16GdwMPYmYRLkDOF4Rw1o1r8Yp7FEzg7ZZmc1TOhW5Wy3
         kPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArK4tzKp9fD5ey/tvaFp+TIer1R17JMUH3inJioMqOU=;
        b=ZEXtIUFB6SSBdTO2Av6uNmZORgEpaLWjp+eyK7xY762um22RhpKm1d15tK3muawerK
         K9UYVEvsWzxrnV4LwhJgt45uiJI1ULnyd84PLKoRFanWrxSNUDY6C7MGOI4MRqVU62Hp
         R6HlCAeM+mn0BuGxo9OFaDrXxsicFTgLY19WG/M+N9lMfIFsQ6qOWI1IRr2Pn/00TJt9
         TnVgTcMhjj7w9wkLCjjyTd3ptq1TYl5OCKbh3gvieQ2hfd+CPI9Hid50o3e39Dmpa/D7
         yfPnBrowRhtVTqrkYWl71S3TrfER2i7LGiJ79bRHGYsZQV3wfIm5b8/fipJw5FAKnOgJ
         NKNA==
X-Gm-Message-State: AFqh2krRALhOjHgWTQW6xAElO1eribtwLIloRISZ/NoYp4+T2BhYrvCO
        xEEB3PHOydCRUAwtDDqQ2L4R1RZiz3SIodh7nCY=
X-Google-Smtp-Source: AMrXdXv8prAN8/5cy6uuTCDSJXIXqMVX97sQ1NMhf41+ILRhUkNbLyZqvIJQR5FSJxMhKCGlj71ZmY6JTkk1jW24Awc=
X-Received: by 2002:ac2:5588:0:b0:4cb:33a:9386 with SMTP id
 v8-20020ac25588000000b004cb033a9386mr3086057lfg.198.1672792364368; Tue, 03
 Jan 2023 16:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com> <20221229155257.341327-7-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221229155257.341327-7-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Jan 2023 16:32:32 -0800
Message-ID: <CABBYNZKoaCC6D0FCF4y60BaSbKyzY6JD4xVsgztFjmY2G6P3-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 6/6] client/player: Add support for Metadata in
 BAP Profile
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, Abhay Maheta <mabhay125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Thu, Dec 29, 2022 at 7:58 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This adds support for Metadata in BAP profile.
> In order to register zero Metadata, 0 shall be
> entered when prompted.
>
> [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Enter Metadata: 0

Perhaps have a special one for empty Metadata e.g
[/local/endpoint/ep0] Enter Metadata (no/value): n

> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] CIG (auto/value): a
> [/local/endpoint/ep0] CIS (auto/value): a
> Capabilities:
>   03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
> Endpoint /local/endpoint/ep0 registered

Btw, we might need something as transport.metadata to be able to
update the metadata as well.

> ---
>  client/player.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index ff1ff209c..58a05ad13 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -69,6 +69,7 @@ struct endpoint {
>         uint16_t cid;
>         uint16_t vid;
>         struct iovec *caps;
> +       struct iovec *meta;
>         bool auto_accept;
>         bool acquiring;
>         uint8_t cig;
> @@ -1558,6 +1559,7 @@ struct endpoint_config {
>         GDBusProxy *proxy;
>         struct endpoint *ep;
>         struct iovec *caps;
> +       struct iovec *meta;
>         uint8_t target_latency;
>         const struct codec_qos *qos;
>  };
> @@ -1568,6 +1570,7 @@ static void append_properties(DBusMessageIter *iter,
>         DBusMessageIter dict;
>         struct codec_qos *qos = (void *)cfg->qos;
>         const char *key = "Capabilities";
> +       const char *meta = "Metadata";
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
>
> @@ -1578,6 +1581,15 @@ static void append_properties(DBusMessageIter *iter,
>                                         DBUS_TYPE_BYTE, &cfg->caps->iov_base,
>                                         cfg->caps->iov_len);
>
> +       if (cfg->meta->iov_len) {
> +               g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
> +                               DBUS_TYPE_BYTE, &cfg->meta->iov_base,
> +                               cfg->meta->iov_len);
> +
> +               bt_shell_printf("Metadata:\n");
> +               bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
> +       }
> +
>         if (!qos)
>                 goto done;
>
> @@ -1675,6 +1687,9 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
>         iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
>         cfg->target_latency = preset->target_latency;
>
> +       /* Copy metadata */
> +       iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
> +
>         if (preset->qos.phy)
>                 /* Set QoS parameters */
>                 cfg->qos = &preset->qos;
> @@ -1823,6 +1838,12 @@ static void endpoint_free(void *data)
>                 g_free(ep->caps);
>         }
>
> +       if (ep->meta) {
> +               if (ep->meta->iov_base)
> +                       g_free(ep->meta->iov_base);
> +               g_free(ep->meta);
> +       }
> +
>         if (ep->msg)
>                 dbus_message_unref(ep->msg);
>
> @@ -1869,6 +1890,24 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean endpoint_get_metadata(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct endpoint *ep = data;
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                               DBUS_TYPE_BYTE_AS_STRING, &array);
> +
> +       dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
> +                               &ep->meta->iov_base,
> +                               ep->meta->iov_len);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
>  static gboolean endpoint_get_cid(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -1893,6 +1932,7 @@ static const GDBusPropertyTable endpoint_properties[] = {
>         { "UUID", "s", endpoint_get_uuid, NULL, NULL },
>         { "Codec", "y", endpoint_get_codec, NULL, NULL },
>         { "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
> +       { "Metadata", "ay", endpoint_get_metadata, NULL, NULL },
>         { "CompanyID", "q", endpoint_get_cid, NULL, NULL },
>         { "VendorCodecID", "q", endpoint_get_vid, NULL, NULL },
>         { }
> @@ -1903,6 +1943,7 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
>         struct endpoint *ep = user_data;
>         DBusMessageIter dict;
>         const char *key = "Capabilities";
> +       const char *meta = "Metadata";
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
>
> @@ -1927,6 +1968,15 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
>                 bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
>         }
>
> +       if (ep->meta->iov_len) {
> +               bt_shell_printf("Metadata:\n");
> +               bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
> +
> +               g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
> +                               DBUS_TYPE_BYTE, &ep->meta->iov_base,
> +                               ep->meta->iov_len);
> +       }
> +
>         dbus_message_iter_close_container(iter, &dict);
>  }
>
> @@ -2059,6 +2109,30 @@ static void endpoint_auto_accept(const char *input, void *user_data)
>         bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
>  }
>
> +static void endpoint_set_metadata(const char *input, void *user_data)
> +{
> +       struct endpoint *ep = user_data;
> +
> +       if (ep->meta && ep->meta->iov_base) {
> +               g_free(ep->meta->iov_base);
> +               ep->meta->iov_base = NULL;
> +       } else
> +               ep->meta = g_new0(struct iovec, 1);
> +
> +       ep->meta->iov_base = str2bytearray((char *) input, &ep->meta->iov_len);
> +
> +       if (ep->meta->iov_len == 0x01 && (*(uint8_t *)(ep->meta->iov_base)) ==
> +                       0x00) {
> +               g_free(ep->meta->iov_base);
> +               ep->meta->iov_base = NULL;
> +               ep->meta->iov_len = 0x00;
> +       }
> +
> +       bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
> +                       endpoint_auto_accept, ep);
> +}
> +
> +
>  static void endpoint_set_id(const char *input, void *user_data)
>  {
>         struct endpoint *ep = user_data;
> @@ -2068,8 +2142,8 @@ static void endpoint_set_id(const char *input, void *user_data)
>         ep->cid = (uint16_t)(val & 0x0000ffff);
>         ep->vid = (uint16_t)((val & 0xffff0000) >> 16);
>
> -       bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
> -                       endpoint_auto_accept, ep);
> +       bt_shell_prompt_input(ep->path, "Enter Metadata:",
> +                        endpoint_set_metadata, ep);
>  }
>
>  static void endpoint_set_parameters(struct endpoint *ep)
> @@ -2081,8 +2155,8 @@ static void endpoint_set_parameters(struct endpoint *ep)
>                                 "Enter Company ID & Vendor ID:",
>                                 endpoint_set_id, ep);
>                 else
> -                       bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
> -                                       endpoint_auto_accept, ep);
> +                       bt_shell_prompt_input(ep->path, "Enter Metadata:",
> +                                       endpoint_set_metadata, ep);
>         } else
>                 bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
>                                 endpoint_auto_accept, ep);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
