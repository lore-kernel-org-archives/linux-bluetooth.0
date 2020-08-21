Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C6C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5709820702
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRSUkdbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHURyi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHURyh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:54:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB8C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:54:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l84so2212922oig.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNQFwJoi1mS8yo9UsU4ab+XF9HC8xWBiEbryZG9ORqs=;
        b=iRSUkdbklz8z2Py0ri2l9eZzqU3NNI7cYqntpEHUSiQiZJryrD09mDi+fCdzy6koz+
         81w+ZXnVk4TtVOMNEWv4SwsvmcFgDpQw34y64oHSDBSJM0rXXqeABEDVMEFnaPDJd0wL
         unJYmBIAWYIhhJiQr+lgrNXT20faMrefeOMBAjdEPw2N1iUEL8PL11pvG5UEb4Okbg3H
         r7pgkNXq9XLGXZK/rQTv/t4GOtqSUtmzP5vmTOfLy8jMM8i6atVOzAaGp52UT6BZMjA0
         wbZ4K1Rr+RUsFUVT+1oifdYAgRwiIb9MGDcctRseUEDA47hn+sN0hs+NXGCJcn1nSxWU
         2tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNQFwJoi1mS8yo9UsU4ab+XF9HC8xWBiEbryZG9ORqs=;
        b=eDakLXHVo/hg4vnSRg+/0hhE73VuRwFGoGvz7MX4WDfgV1mhgtoS5QE5i46uEY6CyI
         h+H3dTfBG71tKaolA1+9rUpCq7S8HPF2JYPrGNp1w1l+pkI6i4sWTkAOTzgKFvmyB1dj
         3UFdqnjdkgbmWdiRGHgzD9TynW/dzW8rPH/PdbCh+lVKYNm+GKcHP7wlBvBCIrlL+sGO
         z5ELkQY7fQsopKtLdu3DAFfZCnjVKgMtWR6MEON4NdA1wsSEIeiUl64JI2pmiMeQ5lVw
         vFSTo68kjQtvRCaj5AU+LepLXjTmeETdnRjDaRtbC9gRrt2lfjiHzdeUCtMuzgJekQh3
         48wQ==
X-Gm-Message-State: AOAM530e9xsthOY0SuICjtkkPe/A8iWOVOesVisMCfWzothozDzk5jlq
        PUiHMWWpcvDHjrOdSaD30RV1ic8tbWruEsSmGRczeSRx
X-Google-Smtp-Source: ABdhPJx9GGnYGUiOE4L862SAo9fM3aFS5Q+qLQF2HNYN6kxGFwkOPI2HHctjeGy0wCJdj/4EvFcuy8J7h71Dz9Y+7V4=
X-Received: by 2002:aca:5703:: with SMTP id l3mr2378460oib.48.1598032476208;
 Fri, 21 Aug 2020 10:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200821072812.19131-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821072812.19131-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:54:25 -0700
Message-ID: <CABBYNZLqJS6XW-XZ+094sx0zm7sGyTHqqvdbpAA3wHRsjZwNwQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Add cancel-pairing command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 12:30 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This adds cancel-pairing command which can be used to cancel the ongoing
> pairing.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>  client/main.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 9abada69f..da877b546 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1742,6 +1742,39 @@ static void cmd_pair(int argc, char *argv[])
>         bt_shell_printf("Attempting to pair with %s\n", proxy_address(proxy));
>  }
>
> +static void cancel_pairing_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
> +               bt_shell_printf("Failed to cancel pairing: %s\n", error.name);
> +               dbus_error_free(&error);
> +               return;
> +       }
> +
> +       bt_shell_printf("Cancel pairing successful\n");
> +}
> +
> +static void cmd_cancel_pairing(int argc, char *argv[])
> +{
> +       GDBusProxy *proxy;
> +
> +       proxy = find_device(argc, argv);
> +       if (!proxy)
> +               return;
> +
> +       if (g_dbus_proxy_method_call(proxy, "CancelPairing", NULL,
> +                               cancel_pairing_reply, NULL, NULL) == FALSE) {
> +               bt_shell_printf("Failed to cancel pairing\n");
> +               return;
> +       }
> +
> +       bt_shell_printf("Attempting to cancel pairing with %s\n",
> +                                                       proxy_address(proxy));
> +}
> +
>  static void cmd_trust(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -2816,6 +2849,8 @@ static const struct bt_shell_menu main_menu = {
>                                                         dev_generator },
>         { "pair",         "[dev]",    cmd_pair, "Pair with device",
>                                                         dev_generator },
> +       { "cancel-pairing",  "[dev]",    cmd_cancel_pairing,
> +                               "Cancel pairing with device", dev_generator },
>         { "trust",        "[dev]",    cmd_trust, "Trust device",
>                                                         dev_generator },
>         { "untrust",      "[dev]",    cmd_untrust, "Untrust device",
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
