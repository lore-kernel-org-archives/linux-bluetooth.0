Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42829C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1424B20716
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRM/vWqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgHQRfR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbgHQRfK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 13:35:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47936C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:35:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k12so14091992otr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7F2WR7ZiKtgV6Hbdw4w6WH+wyjdFEO/gsngLlaXW4JY=;
        b=XRM/vWqpqTA4CCDPEqZlyxy7z/PUa113phRqL8bExZI7c32oenN0l/kRzs6Hn74QV/
         Mze98FZsPg6js7Lmq2BLCLmuuG9kFk7jmoYRNQGKon3ZfPt85pxIR4D2uQ32SBDhRiWH
         kxFYzcw9Q+LZRwbI1sUnLO4wUoIHkv5cJrBUY31DB4FyCPK8GAFBQE/6fDAFy8bRE38J
         2rN4+yljrR11nzSKmLT3frdOLKqQuoTCQv/Pbce66Z+dbrCIKG477dcwn8lH4106OEK5
         wdyNeSU+XADxKdsxOc/5F4xfxMmig8dvCSnn1ytV2rX6uHIQPwLSN1SHTAf2StIcZCHI
         9ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F2WR7ZiKtgV6Hbdw4w6WH+wyjdFEO/gsngLlaXW4JY=;
        b=cJoVIeZYaY44OOxJRmqjSKy4xmd6zBjuoijlkCvXls3KhI7+hSDDo0tY9KuJ825hDF
         Jppp6s9DQ5NjREIppup3SkyxrOBpcGUq5TGCnFKpPbyFFGp8bK806m0upRMySlgWb0UN
         58SJ2PbueF9syOR/DQVWFTM5MrTL79CjXYm8uIU44pIGVhvUrdxCEVdcEGQWivoFF1rx
         Zg+buJBfvM9+j7DU9b4j+lIQALQjtDHV5RuMK05MWP5ElCfc6QFi5jWIKrLrboE13qvl
         7YxUPAfoZ590Da01S/X/TVMrcI9fukGnTdUuhzCXYse8ES3/DTUAgMc1Jw/buBkgxAm9
         Rh2A==
X-Gm-Message-State: AOAM53104TNpSRjZiWuYQp/9OnG5vxwwu0AUf1MTCt3VZRxfQ4ocYuzp
        TP+Lk0ieQ7aZ0SmJPww/RPBre/XHn/92RgwjkFFUYnW1
X-Google-Smtp-Source: ABdhPJyH87GTs0wMxjHNRuNL4f+DnLdAfUPCtnPvlHj5Yy7TdESEPz3r4kScO8M/8MNS+MtMwMYkLgb+4lx6IwTn+tc=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr11582739otj.362.1597685708584;
 Mon, 17 Aug 2020 10:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200814155807.Bluez.1.Ia90c97ad9ec0b51b7aaae1216864e8379c1470d5@changeid>
In-Reply-To: <20200814155807.Bluez.1.Ia90c97ad9ec0b51b7aaae1216864e8379c1470d5@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 10:34:58 -0700
Message-ID: <CABBYNZKrRGb7FkCVOix8jmNwr94BQNXrS8U+a8VRBNxHoQ2ArA@mail.gmail.com>
Subject: Re: [Bluez PATCH] advertising: Fix dbus response for over-advertising
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Fri, Aug 14, 2020 at 4:09 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> client_free would always send a dbus method_return to fix the case where
> a request to Unregister occurred before the MGMT call returned. However,
> in the code path where too many advertisements are registered, this
> method_return prevents the failure from being sent properly. This patch
> makes sure the reference to the register_advertisement DBusMessage is
> not stored in the client structure until the end of
> register_advertisement. This ensures that we only respond once, either
> in register_advertisement or in client_free, not both.
>
> It also changes the dbus response in the fast unregister_advertisement
> case from a method_return to a btd_error_failed, since the registration
> was never allowed to complete, and thus was not successful.
>
> The patch was tested in the following ways:
>
> To verify it did not break the segfault fix in
> caff2b48ca54bbc57b5da3f63317767489aa5b48, I repro'd the failure by
> quickly unregistering after registering, and verified that the segfault
> is still fixed with this change.
>
> Ran through our automated tests that register too many advertisements
> and verify that the registration fails with the intended "Maximum
> Advertisements Reached" error response.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>
>  src/advertising.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 076d591b6..e5f25948d 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -119,9 +119,13 @@ static void client_free(void *data)
>         }
>
>         if (client->reg) {
> -               g_dbus_send_message(btd_get_dbus_connection(),
> -                               dbus_message_new_method_return(client->reg));
> +               DBusMessage *reply;
> +
> +               reply = btd_error_failed(client->reg,
> +                                       "Failed to complete registration");
> +               g_dbus_send_message(btd_get_dbus_connection(), reply);
>                 dbus_message_unref(client->reg);
> +               client->reg = NULL;
>         }
>
>         if (client->add_adv_id)
> @@ -1152,8 +1156,6 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
>         g_dbus_client_set_proxy_handlers(client->client, client_proxy_added,
>                                                         NULL, NULL, client);
>
> -       client->reg = dbus_message_ref(msg);
> -
>         client->data = bt_ad_new();
>         if (!client->data)
>                 goto fail;
> @@ -1216,6 +1218,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
>
>         DBG("Registered advertisement at path %s", match.path);
>
> +       client->reg = dbus_message_ref(msg);
> +
>         queue_push_tail(manager->clients, client);
>
>         return NULL;
> --
> 2.28.0.220.ged08abb693-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
