Return-Path: <SRS0=ezyT=XK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA6C4CEC7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE34521479
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbcVbScO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfIOROp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:14:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35000 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIOROo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Sep 2019 13:14:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so6500298oii.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Sep 2019 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlOxh+iZWPayhPtXxPZHYW0CqrTbluK9B5Fdd7jugpM=;
        b=lbcVbScOM8059uaYF1SvUGgXmua/vrmrWUnSmXDkh0PU23ms1o+0UCP0uAL4E9Tu+2
         R9U9PmQRedn40zSduARDau5khq7CXpP1fSfmd2L4+D1WuBHY3Xu2RU4Azb5CnLjaBQ+4
         kAloHr4jHhZ8Y7IvHTZhjDjLKldhNi1PccuyP+D1jB2kO77kUaHo5yd/0ENF5s7Kq1L+
         YdWPboy676GCUZKS3Dya47jGUHbPVtXHlABeHy0gky6L7XUhoCldIEcT7fEaFvHHwCgU
         74o1XpoGX287ocmxGXESM3sprLKpenwPOkCwafU9glCI3sYjjsJFC6zTgBg37JYo7tLh
         FJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlOxh+iZWPayhPtXxPZHYW0CqrTbluK9B5Fdd7jugpM=;
        b=SadOh8Ky3+urb0qNxjhVxLcfD8hA2ZQbYdlB7PX98ZMPJuDAEtuO+b6TR+oANkjSgv
         D5CEi/yE3N6XHJEgC1Nl5kZPRuFcQB5raIqIMpMjB8hn6z7fzfX9s0AtiYbXKcOtr20N
         0c3CBL5HlkO+sTV/OFW9IOx5jKCAUIoqDvPw3U+ORzoAePv9o0reuRBN33cUFYju09VV
         T0sxWnje6epSHZMrW9LkLHTp0yuhtNFnzHSs0UppmwSmU60SPpoyPpOwNFt9e57bbPry
         GQXxpYhT9SpS1rKcmTekqSq5MO/8sNdNdSoandw/oOkUWdQA1+8r5DsKXSikS4vhmPBS
         tiGQ==
X-Gm-Message-State: APjAAAVX82Y/pbh3wK3mT3rsiqBthHA9AdnsSTckxdrBt4+yisgLdE29
        3YitC+nqvF+E2fkE9e7scoCuXso9tkrCoblcAfE=
X-Google-Smtp-Source: APXvYqz6TWKcIyJrCv0UftWQpxB81rLmKSOka5qnLMoAihBYzetPa0l5abdIlHuMCzc/5y1qD09EboEiw8ihRHSSUxQ=
X-Received: by 2002:a05:6808:2d5:: with SMTP id a21mr10442720oid.8.1568567683709;
 Sun, 15 Sep 2019 10:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
In-Reply-To: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 15 Sep 2019 20:14:30 +0300
Message-ID: <CABBYNZJ1k7vXEgyTwMPa_M_5Kpc_J9rFkR81JTz07vapf5aefA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Properly set owner of filter data at start
 of client creation
To:     Sonny Sasaka <sonnysasaka@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Sat, Sep 14, 2019 at 5:57 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
>
> Currently at the start of client creation (g_dbus_client_new), the
> |owner| in |filter_data| is not set until the |name| is resolved. This
> creates a time window where the filter doesn't work properly, i.e. it
> filters in more than it should. To solve this issue, this patch does the
> following:
> 1. At the start of client creation, set the |owner| in |filter_data|
> based on the current resolved |name| if any, or set it explicitly to
> unknown (empty string) as opposed to NULL otherwise. The unknown |owner|
> lets the filter reject any message, unlike NULL |owner| which accepts
> any message.
> 2. Step 1 above reveals another bug: message_filter fails to accept
> messages which have |sender| set directly to D-Bus service name rather
> than D-Bus address. Therefore this patch relaxes the filter requirement
> in message_filter to accept a message if its |sender| is equal directly
> to our filter's |name|.
> 3. After the initial service name resolution (after GetNameOwner)
> returns, immediately update our name cache with the result, otherwise
> the filters' |owner| would be stuck to unknown (empty string) until
> "NameOwnerChanged" signal arrives.
>
> ---
>  gdbus/watch.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 447e48671..2ae0fd5a7 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -78,6 +78,8 @@ struct filter_data {
>         gboolean registered;
>  };
>
> +static const char *check_name_cache(const char *name);
> +
>  static struct filter_data *filter_data_find_match(DBusConnection *connection,
>                                                         const char *name,
>                                                         const char *owner,
> @@ -265,7 +267,10 @@ proceed:
>
>         data->connection = dbus_connection_ref(connection);
>         data->name = g_strdup(name);
> -       data->owner = g_strdup(owner);
> +       if (name)
> +               data->owner = g_strdup(check_name_cache(name) ? : "");

I follow this it would ignore the owner address and use the cache name
or set "" to be resolved shouldn't that use the owner instead? If the
called don't have it resolved then it should optionally set the owner
resolution.

> +       else
> +               data->owner = g_strdup(owner);
>         data->path = g_strdup(path);
>         data->interface = g_strdup(interface);
>         data->member = g_strdup(member);
> @@ -534,8 +539,12 @@ static DBusHandlerResult
> message_filter(DBusConnection *connection,
>                 if (!sender && data->owner)
>                         continue;
>
> -               if (data->owner && g_str_equal(sender, data->owner) == FALSE)
> +               if (data->owner &&
> +                               g_str_equal(sender, data->owner) == FALSE &&
> +                               data->name &&
> +                               g_str_equal(sender, data->name) == FALSE) {

iirc messages never use the friendly name only the bus connection as
sender so I wonder if this really does make any difference, are there
any example of this not working? Perhaps it would be worth creating a
test case in unit/test-gdbus.c to capture this case.

>                         continue;
> +               }
>
>                 if (data->path && g_str_equal(path, data->path) == FALSE)
>                         continue;
> @@ -627,6 +636,7 @@ static void service_reply(DBusPendingCall *call,
> void *user_data)
>                                                 DBUS_TYPE_INVALID) == FALSE)
>                 goto fail;
>
> +       update_name_cache(data->name, data->owner);
>         update_service(data);
>
>         goto done;
> --
> 2.21.0



-- 
Luiz Augusto von Dentz
