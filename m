Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14BC636CA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400EE61380
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 09:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhGQJe7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 05:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQJe4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 05:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626514320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNjMbKlUTmYJdQu+Ev/zt678j19UGbU7yNLsopZLxow=;
        b=e5vFWQ7Qo3+8fiNhUZkn8oDR7AM68QMiT6H4shMqYyF/6mBsmURi5sd8azB0HMBF8Um0Qv
        weBo8j1fLeOZWbeAX1JCJRG7DnQwVNIPTSKO3VfPRPMdVIz6063k+19ImkraafLvAmFhY3
        qnJRD3miwmlLfJzjIvxBBikbRtD8A5g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-m5Xpqih9Pl6ixKRGhC4oyw-1; Sat, 17 Jul 2021 05:31:58 -0400
X-MC-Unique: m5Xpqih9Pl6ixKRGhC4oyw-1
Received: by mail-ed1-f70.google.com with SMTP id v14-20020a056402184eb029039994f9cab9so5359460edy.22
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 02:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sNjMbKlUTmYJdQu+Ev/zt678j19UGbU7yNLsopZLxow=;
        b=eyfWyXUXocA16ADH6Qk8JsEgcD5R0xX29o+9idJsCjtyiKXNb03OHTs8mucQQfHrCk
         KG7ZQWVvtuO0J0WHoq0o2q+2pZwj3Z5iTiEHBdECoT6KZb57j8wWDn9QGPvR+ZR6YdCG
         yyRBsfbtmvfG9vTMX9dYZ+AgTdZHx9+0amIxCAhcrc+glrAyQGj3RWG/H8rhUTj4dhVL
         igze1IVCxhZ5rxQdOkFLJl+v6REoBO4HheseK9Ad5D3BYDBISLwHZXDexW2b/Zi+RPDW
         4VwoEE4yD1DZsCNeOlGXOZDjhDH+a38jvD07XmxEw/c8w6v58ICwVXcpX0hSZVDoOQ4z
         OkBg==
X-Gm-Message-State: AOAM533MLMTB8asPXMkq9kYlK4Nf2H3UwLAD6cweSevICU5xC8C5obkX
        yRFgq8NHx24PUjCVHGYeGQ9krAzcPs1zb9QtFi0jMDq5xl6g5Dt+HODLUJXOCLuEXrM3R+WeyZw
        ftwEGM7l1MYeoHfg5el8sfVz4M/5/
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr5888536edc.124.1626514317763;
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0wFNzsifbnm9oOXfqizEIdZoHgseiGYXa2LzF61PqUhcViIaGZDb0G4ydtqzMHFwTI35Bzg==
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr5888520edc.124.1626514317601;
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u9sm3457973eje.31.2021.07.17.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btusb: Make the CSR clone chip force-suspend
 workaround more generic
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b238f666-9238-fb42-cd46-ad628e576218@redhat.com>
Date:   Sat, 17 Jul 2021 11:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 7/17/21 1:21 AM, Ismael Ferreras Morezuelas wrote:
> Turns out Hans de Goede completed the work I started last year trying to
> improve Chinese-clone detection of CSR controller chips. Quirk after quirk
> these Bluetooth dongles are more usable now.
> 
> Even after a few BlueZ regressions; these clones are so fickle that some
> days they stop working altogether. Except on Windows, they work fine.
> 
> 
> But this force-suspend initialization quirk seems to mostly do the trick,
> after a lot of testing Bluetooth now seems to work *all* the time.
> 
> The only problem is that the solution ended up being masked under a very
> stringent check; when there are probably hundreds of fake dongle
> models out there that benefit from a good reset. Make it so.
> 
> 
> Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
> Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
> Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
> Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>

FWIW I'm fine with making the force-suspend once quirk which
I added generic to all clones.

The new code looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> 
> I've changed the warning line to make it easy to grep and detect if this updated
> workaround is part of the driver. Should make it much more obvious to users in
> case their dongle doesn't work for other reasons. There's a clear then-now.
> 
> Easy to narrow other future issues down. Let me know what you think.
> 
>  drivers/bluetooth/btusb.c | 61 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd..197cafe75 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1890,7 +1890,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  		is_fake = true;
>  
>  	if (is_fake) {
> -		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
> +		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds and force-suspending once...");
>  
>  		/* Generally these clones have big discrepancies between
>  		 * advertised features and what's actually supported.
> @@ -1907,41 +1907,46 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>  
>  		/*
> -		 * Special workaround for clones with a Barrot 8041a02 chip,
> -		 * these clones are really messed-up:
> -		 * 1. Their bulk rx endpoint will never report any data unless
> -		 * the device was suspended at least once (yes really).
> +		 * Special workaround for these BT 4.0 chip clones, and potentially more:
> +		 *
> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
> +		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
> +		 *
> +		 * These controllers are really messed-up.
> +		 *
> +		 * 1. Their bulk RX endpoint will never report any data unless
> +		 * the device was suspended at least once (yes, really).
>  		 * 2. They will not wakeup when autosuspended and receiving data
> -		 * on their bulk rx endpoint from e.g. a keyboard or mouse
> +		 * on their bulk RX endpoint from e.g. a keyboard or mouse
>  		 * (IOW remote-wakeup support is broken for the bulk endpoint).
>  		 *
>  		 * To fix 1. enable runtime-suspend, force-suspend the
> -		 * hci and then wake-it up by disabling runtime-suspend.
> +		 * HCI and then wake-it up by disabling runtime-suspend.
>  		 *
> -		 * To fix 2. clear the hci's can_wake flag, this way the hci
> +		 * To fix 2. clear the HCI's can_wake flag, this way the HCI
>  		 * will still be autosuspended when it is not open.
> +		 *
> +		 * --
> +		 *
> +		 * Because these are widespread problems we prefer generic solutions; so
> +		 * apply this initialization quirk to every controller that gets here,
> +		 * it should be harmless. The alternative is to not work at all.
>  		 */
> -		if (bcdDevice == 0x8891 &&
> -		    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
> -		    le16_to_cpu(rp->hci_rev) == 0x0810 &&
> -		    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
> -			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues");
> -
> -			pm_runtime_allow(&data->udev->dev);
> +		pm_runtime_allow(&data->udev->dev);
>  
> -			ret = pm_runtime_suspend(&data->udev->dev);
> -			if (ret >= 0)
> -				msleep(200);
> -			else
> -				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround");
> -
> -			pm_runtime_forbid(&data->udev->dev);
> -
> -			device_set_wakeup_capable(&data->udev->dev, false);
> -			/* Re-enable autosuspend if this was requested */
> -			if (enable_autosuspend)
> -				usb_enable_autosuspend(data->udev);
> -		}
> +		ret = pm_runtime_suspend(&data->udev->dev);
> +		if (ret >= 0)
> +			msleep(200);
> +		else
> +			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
> +
> +		pm_runtime_forbid(&data->udev->dev);
> +
> +		device_set_wakeup_capable(&data->udev->dev, false);
> +
> +		/* Re-enable autosuspend if this was requested */
> +		if (enable_autosuspend)
> +			usb_enable_autosuspend(data->udev);
>  	}
>  
>  	kfree_skb(skb);
> 

