Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29822FA3741
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 21:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaVaI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 17:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaVaG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 17:30:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B26B10556
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:30:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so21259836lfk.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRVzFBXsUl1W5fZ9OWs2A6phHL4mlO5E6La9a67pow=;
        b=NqYFRCvTAshyQAWe2epn/rBp6i88m16Hbtq+vi0uRjnJDTJCAAcsu6/PfrDi6St2N1
         QVhlytVOdW+wNG68VO26f8MoJSq+xvVysndeuauSSEM3pFfzkxs7ZQSkFaQkgweomZGc
         LhDWkh7ZQ/v/O4ni7NFamhI7VTMib1zJxB8i+a3iKCdShOszuThYbtGRCq4etdLIV8Zs
         sfHBD6fvFJ3jpXEk6mTUHuT2tXbEKB/aQiia9lC2oUcmqjg1BF6cBOww1STTEGEdqMot
         dQlz5bIc59+vNnAcFucP22qwUO5gG1kfpA313ggfvwVRu9bA9Yt/bBsYQ0uWHxgsDYQ9
         j0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lRVzFBXsUl1W5fZ9OWs2A6phHL4mlO5E6La9a67pow=;
        b=RKS5ChGF6j5FPrROjyhhzHa8JlSKD74oRRVQB1rTT48TRxeiu0jgXMHNvVWBWIgYYL
         ZOx6FushzTXR916usGL7dhTk7qb9d7rxdoZrUFNfpD7p61jcR9uauFHmyygaWtqu1qkR
         ITzWykIYTi9fN5sgZc9rR8DDF2LgZJN1goFhNgBfoFWev+h0ooCV5iCAApMjisIOnVeR
         UYR5JRHsF8DXUayDBeRd2A/ze08lYobCPKTt+EHu2LI9JA6znHzfUWE34hj1WRgS7thH
         VDEsMK7iycJROSRMoJR6RzgonlwgvBfMvC7iIgOCME1H/JvHUIpWt6cx7HqVGiuBCZ0j
         bLbA==
X-Gm-Message-State: ACrzQf1lJ/RqvQhHKYnYkJrx5z1zfM8XCeJHqRCvak8brLfKtEZvfU/p
        MjTUC3J8h352bnnwu4JI864ayhIjgAuLFFOEZ1U2jcjdiqc=
X-Google-Smtp-Source: AMsMyM5rpQwAsUJHbn/7RVBfAqV5p+p+M/p2bm//0+TRE2ol28/hyVjVALn+VhoJPLwJanasfD/krDMBwXTnO3nNHfY=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr6434687lfq.57.1667251803427; Mon, 31 Oct
 2022 14:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com> <20221029170408.175533-6-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221029170408.175533-6-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 14:29:51 -0700
Message-ID: <CABBYNZKBCQO9jnBc=4EyXKUgJXS8CPZDv99xWLNHtAmwuCu=5A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] client/player: Add support for Metadata, CID, VID
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Sat, Oct 29, 2022 at 10:21 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
>
> This adds support for Metadata, Company ID and Vendor Codec ID.
> This also adds handling of Vendor Specific Coding format.
> Now it allows to enter zero codec capabilities.
> It allows to enter zero metadata as well.
> In order to register zero codec capabilities and metadata
> 0 shall be entered when prompted.

It's probably easier to understand if you split the handling of
metadata and vendor codec in different commits and add a sample output
to show how it looks in practice.

> ---
>  client/player.c | 185 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 175 insertions(+), 10 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 432408934..f4338416b 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -63,7 +63,10 @@ struct endpoint {
>         char *path;
>         char *uuid;
>         uint8_t codec;
> +       uint16_t cid;
> +       uint16_t vid;
>         struct iovec *caps;
> +       struct iovec *meta;
>         bool auto_accept;
>         bool acquiring;
>         uint8_t cig;
> @@ -1643,6 +1646,7 @@ struct endpoint_config {
>         GDBusProxy *proxy;
>         struct endpoint *ep;
>         struct iovec *caps;
> +       struct iovec *meta;
>         uint8_t target_latency;
>         const struct codec_qos *qos;
>  };
> @@ -1653,6 +1657,7 @@ static void append_properties(DBusMessageIter *iter,
>         DBusMessageIter dict;
>         struct codec_qos *qos = (void *)cfg->qos;
>         const char *key = "Capabilities";
> +       const char *meta = "Metadata";
>
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
>
> @@ -1663,6 +1668,15 @@ static void append_properties(DBusMessageIter *iter,
>                                         DBUS_TYPE_BYTE, &cfg->caps->iov_base,
>                                         cfg->caps->iov_len);
>
> +       if (cfg->meta->iov_len) {
> +               g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
> +                                       DBUS_TYPE_BYTE, &cfg->meta->iov_base,
> +                                       cfg->meta->iov_len);
> +
> +               bt_shell_printf("Metadata:\n");
> +               bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
> +       }
> +
>         if (!qos)
>                 goto done;
>
> @@ -1756,6 +1770,9 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
>         iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
>         cfg->target_latency = preset->latency;
>
> +       /* Copy metadata */
> +       iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
> +
>         if (preset->qos.phy)
>                 /* Set QoS parameters */
>                 cfg->qos = &preset->qos;
> @@ -1899,10 +1916,17 @@ static void endpoint_free(void *data)
>         struct endpoint *ep = data;
>
>         if (ep->caps) {
> -               g_free(ep->caps->iov_base);
> +               if (ep->caps->iov_base)
> +                       g_free(ep->caps->iov_base);
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
> @@ -1949,10 +1973,52 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
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
> +static gboolean endpoint_get_cid(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct endpoint *ep = data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->cid);
> +
> +       return TRUE;
> +}
> +
> +static gboolean endpoint_get_vid(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct endpoint *ep = data;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->vid);
> +
> +       return TRUE;
> +}
> +
> +
>  static const GDBusPropertyTable endpoint_properties[] = {
>         { "UUID", "s", endpoint_get_uuid, NULL, NULL },
>         { "Codec", "y", endpoint_get_codec, NULL, NULL },
>         { "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
> +       { "Metadata", "ay", endpoint_get_metadata, NULL, NULL },
> +       { "CompanyID", "q", endpoint_get_cid, NULL, NULL },
> +       { "VendorCodecID", "q", endpoint_get_vid, NULL, NULL },

You should probably add a .exists callback so when these values are
not set their property is omitted, if we follow my suggestion to use
the presence of CompanyID (e.g. ep.cid != 0xffff) to determine the use
of Codec as vendor codec id.

>         { }
>  };
>
> @@ -1961,6 +2027,7 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
>         struct endpoint *ep = user_data;
>         DBusMessageIter dict;
>         const char *key = "Capabilities";
> +       const char *meta = "Metadata";
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
>
> @@ -1970,12 +2037,29 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
>
>         g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
>
> -       g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
> +       g_dbus_dict_append_entry(&dict, "CompanyID", DBUS_TYPE_UINT16,
> +                                                       &ep->cid);
> +
> +       g_dbus_dict_append_entry(&dict, "VendorCodecID", DBUS_TYPE_UINT16,
> +                                                       &ep->vid);
> +
> +       if (ep->caps->iov_len) {
> +               g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
>                                         DBUS_TYPE_BYTE, &ep->caps->iov_base,
>                                         ep->caps->iov_len);
>
> -       bt_shell_printf("Capabilities:\n");
> -       bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
> +               bt_shell_printf("Capabilities:\n");
> +               bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
> +       }
> +
> +       if (ep->meta->iov_len) {
> +               bt_shell_printf("Metadata:\n");
> +               bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
> +
> +               g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
> +                                       DBUS_TYPE_BYTE, &ep->meta->iov_base,
> +                                       ep->meta->iov_len);
> +       }
>
>         dbus_message_iter_close_container(iter, &dict);
>  }
> @@ -2094,19 +2178,93 @@ static void endpoint_auto_accept(const char *input, void *user_data)
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
> +                                       endpoint_auto_accept, ep);
> +}
> +
> +static void endpoint_set_vid(const char *input, void *user_data)
> +{
> +       struct endpoint *ep = user_data;
> +       char *endptr = NULL;
> +       int value;
> +
> +       value = strtol(input, &endptr, 0);
> +
> +       if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", input);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       ep->vid = value;
> +
> +       bt_shell_prompt_input(ep->path, "Enter Metadata:",
> +                                       endpoint_set_metadata, ep);
> +}
> +
> +static void endpoint_set_cid(const char *input, void *user_data)
> +{
> +       struct endpoint *ep = user_data;
> +       char *endptr = NULL;
> +       int value;
> +
> +       value = strtol(input, &endptr, 0);
> +
> +       if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", input);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       ep->cid = value;
> +
> +       bt_shell_prompt_input(ep->path, "Vendor Codec ID:",
> +                                       endpoint_set_vid, ep);
> +}
> +
>  static void endpoint_set_capabilities(const char *input, void *user_data)
>  {
>         struct endpoint *ep = user_data;
>
> -       if (ep->caps)
> +       if (ep->caps && ep->caps->iov_base) {
>                 g_free(ep->caps->iov_base);
> -       else
> +               ep->caps->iov_base = NULL;
> +       } else
>                 ep->caps = g_new0(struct iovec, 1);
>
>         ep->caps->iov_base = str2bytearray((char *) input, &ep->caps->iov_len);
>
> -       bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
> -                                               endpoint_auto_accept, ep);
> +       if (ep->caps->iov_len == 0x01 &&
> +                       (*(uint8_t *)(ep->caps->iov_base)) == 0x00) {
> +               g_free(ep->caps->iov_base);
> +               ep->caps->iov_base = NULL;
> +               ep->caps->iov_len = 0x00;
> +       }
> +
> +       if (ep->codec == 0xff) {
> +               bt_shell_prompt_input(ep->path, "Enter Company ID:",
> +                                               endpoint_set_cid, ep);
> +       } else {
> +               bt_shell_prompt_input(ep->path, "Enter Metadata:",
> +                                               endpoint_set_metadata, ep);
> +       }
>  }
>
>  static char *uuid_generator(const char *text, int state)
> @@ -2175,8 +2333,15 @@ static void cmd_register_endpoint(int argc, char *argv[])
>                         iov_append(&ep->caps, cap->data.iov_base,
>                                                         cap->data.iov_len);
>
> -                       bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
> -                                               endpoint_auto_accept, ep);
> +                       if (ep->codec == 0xff) {
> +                               bt_shell_prompt_input(ep->path,
> +                                               "Enter Company ID:",
> +                                               endpoint_set_cid, ep);
> +                       } else {
> +                               bt_shell_prompt_input(ep->path,
> +                                               "Enter Metadata:",
> +                                               endpoint_set_metadata, ep);
> +                       }
>                 } else
>                         bt_shell_prompt_input(ep->path, "Enter capabilities:",
>                                                 endpoint_set_capabilities, ep);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
