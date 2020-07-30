Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C775C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 04:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6822B48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 04:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgG3EPB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:15:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3EPB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 00:15:01 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k0zy6-0003Uj-Lc
        for linux-bluetooth@vger.kernel.org; Thu, 30 Jul 2020 04:14:58 +0000
Received: by mail-pl1-f198.google.com with SMTP id y9so15784080plr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 21:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5cMoLJ8ubMqndVw9m4PPR4lyGXii7QUn7MzeOw06kcg=;
        b=UW74EcVtzB0UgGt5ZxqpwFj2ake7kOCfFKQvgIqtF7H+MAR/qoEg8oW8UE2/1yfL3H
         wrsCddMR2XPuVOSF0iZWwBIz13hJrRG/hYt4WOUeK1M4V2gv5lWQF8oNQpPrtd19Pca9
         U5mXWXst05rB3t0YT1HuBWD4w+1euIS+uSGTzEIJ7rIlCHd6+wjVSdpLXzd106taAkQY
         5rnNQjdWY4ctuZDvVmItOOoSJtojWbVNqucG5BF5wfXOrcPnb9HWPhMThgOz7EMt+AxY
         Y2FPXcgiQA76PzuZ5BwH2o7lNQmS1CeRUxOoQNL0YBuG9xX9Y9fPzcLPT8aSFsVf4x5k
         3Puw==
X-Gm-Message-State: AOAM533FBTUtzAfDGTlEuKVEKzStMOgRnWNxxK4Ai4j5Wg6yAVu1vPSv
        ROHIr++w6eGFGVDlSD0zmCJKYY6PRPhFMP7WHsJLCdUkgSyQbULV5TLm3uwNK/5K/fwk9PIavor
        klT/6THKdig1npgY3O9efmrs2EOXn/x1OIeRdp49NrUQhCg==
X-Received: by 2002:a17:90b:1b08:: with SMTP id nu8mr1251782pjb.190.1596082497057;
        Wed, 29 Jul 2020 21:14:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHqxgRcJVzZxTqIEzl11Z+pJEA4N4b+XBeqOzZNX+oq5PUFsnaJHeYA005ToKEdz5KDXYSDA==
X-Received: by 2002:a17:90b:1b08:: with SMTP id nu8mr1251748pjb.190.1596082496693;
        Wed, 29 Jul 2020 21:14:56 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b12sm4257122pga.87.2020.07.29.21.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 21:14:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Disable runtime suspend on
 Realtek devices"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
Date:   Thu, 30 Jul 2020 12:14:42 +0800
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org, Alex Lu <alex_lu@realsil.com.cn>,
        linux-pm@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8DFB5D1A-AA7E-4960-9937-4FD00827937B@canonical.com>
References: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> On Jul 30, 2020, at 07:17, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
> 
> This reverts commit 7ecacafc240638148567742cca41aa7144b4fe1e.
> 
> Testing this change on a board with RTL8822CE, I found that enabling
> autosuspend has no effect on the stability of the system. The board
> continued working after autosuspend, suspend and reboot.

The original issue was found on 8723DE. Do you have one to test with?
The rtw88 codebase has changed a lot and maybe it's already fixed in mainline.
Let me do some test and I'll report back.

> 
> The original commit makes it impossible to enable autosuspend on working
> systems so it should be reverted. Disabling autosuspend should be done
> via module param or udev in userspace instead.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> We have a few Chromebooks using the RTL 8822CE part over USB and they
> are running without problems with autosuspend enabled. While bringing up
> a new board, I found some power regressions that I was able to narrow
> down to this change so I'm requesting a revert.
> 
> I tested this on Hp Chromebook 14a (running 4.14 kernel and 5.4 kernel)
> with this revert:
> * Enabled autosuspend, used it normally with a HID device
> * Suspended the Chromebook and verified it worked normally on resume
> * Rebooted the Chromebook and verified Bluetooth was working on next
>  boot
> 
> I didn't see the issue that was originally reported with this fix. For
> the original reporter, if you're still seeing this issue, there are
> other ways to disable autosuspend for your device:
> * set module param: enable_autosuspend=0
> * change your kconfig so BT_HCIBTUSB_AUTOSUSPEND=n
> * use a udev rule to disable autosuspend for specific vid:pid
> 
> Keeping this change in the kernel makes it impossible to enable
> autosuspend so it should be reverted.

It's apparently a driver/firmware/hardware issue, so the fix should keep inside the kernel.
However, the fix can be more precise and target only 8723DE.

Kai-Heng

> 
> drivers/bluetooth/btusb.c | 4 ----
> 1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1f51494f581812..8d2608ddfd0875 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4086,10 +4086,6 @@ static int btusb_probe(struct usb_interface *intf,
> 			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
> 		else
> 			bt_dev_err(hdev, "Device does not support ALT setting 1");
> -
> -		err = usb_autopm_get_interface(intf);
> -		if (err < 0)
> -			goto out_free_dev;
> 	}
> 
> 	if (!reset)
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 

