Return-Path: <SRS0=Xed5=37=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067CC35242
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D222086A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixo0D9Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgBKT2A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:28:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45844 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgBKT2A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Feb 2020 14:28:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so13900836oic.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2020 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYZT81OlGTWcN0jtwAOfQIAD9I9KBu+11E308lphCzs=;
        b=ixo0D9XgaWnTDk8qIeRPXzE2qDTVTbdWeTw9MbTkIzO/BC62pJ1aXWIfMPHroCLW2m
         ZLm/BpC1q3eUHsLkNo0qM3JvA2D9tjOFMtAqLd1HA6Q1g2rUU5BjacGmJ3V2vZhJsyKO
         rOnPxrgjRYYEFEdONkzA2nuYYMnPZwpvMyw4gu9GOq49iHIMll8fdjJmfCwkxWEJwNEt
         67GD+4uk8OJ6AxO6wsW3wkTcedxBT6cAfThXzqgyJk65hioXSy3doLqviYQSbCGal5AK
         RC5Riku5sLNRUUxZRyISfoDjyd7jJVjLHBDvb+8BzSKKTFiFEczDUM0YYnNRdgFbY2di
         Gcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYZT81OlGTWcN0jtwAOfQIAD9I9KBu+11E308lphCzs=;
        b=WItYxLVJywkf26g3QyB8LEsTn8+RmjZrKtYr1u5KSFDizsYoKfkO1M4Q5EIlifoMn4
         4ZIZZO1J1zdbWukPTjBuSsMTxwglUD/HFedD0zMVEZlEAL1DP4kHty92mffpcOCyrr8k
         J8qg4LAAaeLAMHibf9WyqQ9+wJT/GjLEe88zR4MIN7uN/N+vJhAEr3TbQWOsCRsgF55h
         GOdaowXgVuBKB5cAHz5YsSENVznPq+Xb6aissktZgjgEyqrZNexd0AxtjaWitkmk4iiU
         jHKmIc98Rw72+lZrynIacQ0g6+CRTn8HDy5g3nPSkLMxBg8cKRyWKOjG+seoEgvYZfPc
         vi1g==
X-Gm-Message-State: APjAAAUcxz5EihT6vqKG6x/5P3lyXLxy3abcCLTeaACY1I/o/I5NUNhO
        96wYio1Gvqu1F0je6na/1KndSCkOC5a88r9JBK8=
X-Google-Smtp-Source: APXvYqwXuqSbj5ohzeukl1xBHuo/YrbZyVjev+GucoEfhjDqyOSr523wsTmXEiyU2wVYlSy/dtYcApSWxjb6W7C4Kyk=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr3817251oif.82.1581449279487;
 Tue, 11 Feb 2020 11:27:59 -0800 (PST)
MIME-Version: 1.0
References: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
In-Reply-To: <1581402970-1781-1-git-send-email-ajay.kishore@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Feb 2020 11:27:47 -0800
Message-ID: <CABBYNZ+Fr629sA17x5wG-C=bGxVGyh=5OMgxp9gjCfkQKPEDqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] obexd: Add initial support for MAP conversations
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Mon, Feb 10, 2020 at 11:32 PM Ajay Kishore <ajay.kishore@intel.com> wrote:
>
> Changes made to add a new method for MAP conversation listing i.e
> "ListConversations" to handle conversation listing object
> "x-bt/MAP-convo-listing".
> ---
>  obexd/client/map.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 550c5af..adf62d9 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -1560,6 +1560,69 @@ static DBusMessage *map_list_messages(DBusConnection *connection,
>         return get_message_listing(map, message, folder, apparam);
>  }
>
> +static GObexApparam *parse_conversation_filters(GObexApparam *apparam,
> +                                                       DBusMessageIter *iter)
> +{
> +       DBusMessageIter array;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
> +               DBG("Not of type array");
> +               return NULL;
> +       }
> +
> +       dbus_message_iter_recurse(iter, &array);
> +
> +       while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
> +               const char *key;
> +               DBusMessageIter value, entry;
> +
> +               dbus_message_iter_recurse(&array, &entry);
> +               dbus_message_iter_get_basic(&entry, &key);
> +
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_recurse(&entry, &value);
> +
> +               /* TODO: Parse conversation filters */
> +
> +               dbus_message_iter_next(&array);
> +       }
> +       return apparam;
> +}
> +
> +static DBusMessage *map_list_conversations(DBusConnection *connection,
> +                                               DBusMessage *message,
> +                                               void *user_data)
> +{
> +       struct map_data *map = user_data;
> +       const char *folder;
> +       GObexApparam *apparam;
> +       DBusMessageIter args;
> +
> +       dbus_message_iter_init(message, &args);
> +
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
> +               return g_dbus_create_error(message,
> +                       ERROR_INTERFACE ".InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&args, &folder);
> +
> +       apparam = g_obex_apparam_set_uint16(NULL, MAP_AP_MAXLISTCOUNT,
> +                                                       DEFAULT_COUNT);
> +       apparam = g_obex_apparam_set_uint16(apparam, MAP_AP_STARTOFFSET,
> +                                                       DEFAULT_OFFSET);
> +
> +       dbus_message_iter_next(&args);
> +
> +       if (parse_conversation_filters(apparam, &args) == NULL) {
> +               g_obex_apparam_free(apparam);
> +               return g_dbus_create_error(message,
> +                       ERROR_INTERFACE ".InvalidArguments", NULL);
> +       }
> +
> +       /*TODO: Return conversation listing */
> +       return NULL;
> +}
> +
>  static char **get_filter_strs(uint64_t filter, int *size)
>  {
>         char **list, **item;
> @@ -1817,6 +1880,10 @@ static const GDBusMethodTable map_methods[] = {
>                         GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
>                         GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
>                         map_list_messages) },
> +       { GDBUS_ASYNC_METHOD("ListConversations",
> +                       GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
> +                       GDBUS_ARGS({ "conversations", "a{oa{sv}}" }),
> +                       map_list_conversations) },
>         { GDBUS_METHOD("ListFilterFields",
>                         NULL,
>                         GDBUS_ARGS({ "fields", "as" }),
> --
> 2.7.4

I see some mix of v2 and v3 patches, I recommend updating the whole
set to v3 to make easier to review.


-- 
Luiz Augusto von Dentz
