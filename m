Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85F02065C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbhAZW6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391238AbhAZSj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 13:39:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50ECC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 10:37:27 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id w8so19575417oie.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6euC258dhm6HMOOKStz6cLB6MW85J7zfU0xTcQNIhO8=;
        b=luPr0pxGVJCbhHiKkxz5ZuqnDxb4HA/XdksarcMLktec6TMo02bTx+7Od7cq+K9HFz
         sTLSW6s5ehOdlS1wpJQwOLyoy2IH2YF4VH8xQLKxYOdfZY7D4qDzdGGmPex5E/ChPFr0
         Mi740agRDa/SR6qW2Y4wmnqXhRx+6eZnYXY5+L1+lf90BLnXsYaD1Yo+2KofQSvk869k
         lwgvaUpmx/nWrSH4He6qucxKB5lFpzaevkzwmS7UlVQQxjNIM0M1ocRjkUewKBTnszxs
         ThsLxgS5bQtintjjLzxtaP0EWXK+iUQQKlvO8lbmOc7YLsLX4iiChvdGyAcMIJe9K+oa
         eM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6euC258dhm6HMOOKStz6cLB6MW85J7zfU0xTcQNIhO8=;
        b=T+Z9YM4U5b6AztvbElcmal/+kTm59dUEnHsOhqTe1j/h3lOQGaK6qq4v3q8B+RSQVv
         1wTp+IioClwVMm0m7DBjDujF8cYUedTUTg+uG4QxtvxKNihhkJZIYsrP0A9JFTuEyOL4
         0okKklWD9F7VVLqjcK+pq6GTRwxqGVaG/N3eZ/7Zsa9Llgbrvck2RIImK4GMweGM9+1d
         JWIY/Qh/c6Mfpj2Ssiy00b+euCNrfbdbp+/F28Ks8L++l9NktZABCMALv5fDNxc5p7nG
         wZ3hbSD7wpcxnYIxvccgV7ez7GnMyHSQ/EtPT5iVBNw7WeIXm2/4EoE6v7LjnpyN+Hec
         IgQw==
X-Gm-Message-State: AOAM5326Gsbl0Hy4HyJEfoxGJrzozbfv3SXAkmrLdgIUgUGpkMxXrHYY
        zk8YYshrFgSkL3FUpPRtwxLMqST4TmaY7cncD6fS0zzDYk4=
X-Google-Smtp-Source: ABdhPJzHJ8XHluIQYDb4a/BgCQvRK9L13ziT+BCRYKjob8dWdWa9NZGXYo9T+gIJB5L8Pp1uhLbQlU+/6pyJ8rBwDd4=
X-Received: by 2002:aca:c693:: with SMTP id w141mr667891oif.58.1611686247076;
 Tue, 26 Jan 2021 10:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20210113232858.1181251-1-luiz.dentz@gmail.com>
 <52613EEA-D992-4BDB-BA8A-E91DC4125F70@holtmann.org> <CABBYNZLu7nqgp8x6AWYfQOCXG4_Z6Da8PF=v=XAK9mj7Vg5FjQ@mail.gmail.com>
 <341754CA-5C47-4FA7-BC34-210229FBC5CB@holtmann.org>
In-Reply-To: <341754CA-5C47-4FA7-BC34-210229FBC5CB@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Jan 2021 10:37:15 -0800
Message-ID: <CABBYNZJ-m3AArO33KbCJtOeyeFN+CeG6Wc0EQeBfXPNOxv8OFA@mail.gmail.com>
Subject: Re: [RESEND 1/2] Bluetooth: btusb: Add support for queuing during
 polling interval
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jan 26, 2021 at 1:16 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This makes btusb to queue ACL and events during a polling interval
> >>> by using of a delayed work, with the interval working as a time window
> >>> where frames received from different endpoints are considered to be
> >>> arrived at same time and then attempt to resolve potential conflics by
> >>> processing the events ahead of ACL packets.
> >>>
> >>> It worth noting though that priorizing events over ACL data may result
> >>> in inverting the order compared to how they appeared over the air, for
> >>> instance there may be packets received before a disconnect event that
> >>> will be discarded and unencrypted packets received before encryption
> >>> change which would considered encrypted, because of these potential
> >>> changes on the order the support for queuing during the polling
> >>> interval is not enabled by default so platforms have the following
> >>> means to enable it:
> >>>
> >>> At build-time:
> >>>
> >>>   CONFIG_BT_HCIBTUSB_INTERVAL=y
> >>>
> >>> At runtime with use of module option:
> >>>
> >>>   enable_interval
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> drivers/bluetooth/Kconfig |  7 ++++
> >>> drivers/bluetooth/btusb.c | 88 ++++++++++++++++++++++++++++++++++-----
> >>> 2 files changed, 84 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> >>> index 4e73a531b377..2f20a853d946 100644
> >>> --- a/drivers/bluetooth/Kconfig
> >>> +++ b/drivers/bluetooth/Kconfig
> >>> @@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
> >>>        This can be overridden by passing btusb.enable_autosuspend=[y|n]
> >>>        on the kernel commandline.
> >>>
> >>> +config BT_HCIBTUSB_INTERVAL
> >>> +     bool "Enable notification of USB polling interval"
> >>> +     depends on BT_HCIBTUSB
> >>> +     help
> >>> +       Say Y here to enable notification of USB polling interval for
> >>> +       Bluetooth USB devices by default.
> >>> +
> >>> config BT_HCIBTUSB_BCM
> >>>      bool "Broadcom protocol support"
> >>>      depends on BT_HCIBTUSB
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index b14102fba601..38cb5448fc69 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -30,7 +30,7 @@
> >>> static bool disable_scofix;
> >>> static bool force_scofix;
> >>> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> >>> -
> >>> +static bool enable_interval = IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL);
> >>> static bool reset = true;
> >>>
> >>> static struct usb_driver btusb_driver;
> >>> @@ -519,8 +519,12 @@ struct btusb_data {
> >>>
> >>>      unsigned long flags;
> >>>
> >>> -     struct work_struct work;
> >>> -     struct work_struct waker;
> >>> +     struct work_struct  work;
> >>> +     struct work_struct  waker;
> >>> +     struct delayed_work rx_work;
> >>> +
> >>> +     struct sk_buff_head acl_q;
> >>> +     struct sk_buff_head evt_q;
> >>
> >> so does it make sense to keep them separate if we delay processing anyway.
> >
> >
> > We need them to reorder in case they are received at the same time
> > (within the same polling interval), we could reorder in place but then
> > will need to iterate into the queue to find where to insert events,
> > using 2 queues is a lot simpler to understand and probably perform
> > better.
>
> do we actually have to queue the HCI event as well. Or just make sure that the bulk endpoints are processed at the same interval as the interrupt endpoint?

Perhaps you are suggesting to just maintain one queue for ACL data and
then dequeue it if an event is received?

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
