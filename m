Return-Path: <SRS0=8wDQ=AQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_HELO_IP_MISMATCH,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0518C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jul 2020 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BBA20724
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jul 2020 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJmZK4rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGEUzC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgGEUzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jul 2020 16:55:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A5C061794
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2020 13:55:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so39542454wmo.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2020 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfCRq0yAQSqEnZ+BJ++zg1D86ATDnpdb5dG2rsEII9g=;
        b=eJmZK4rBlU5HIpBkKO5zEVqFQW+IX37J3WSqVbasXODb2SptQ1LIvtpk+WxT2SJ4pC
         Q+dweqx6gDF8Tbtx0BR4jRFKveTFG/XqGU/FCG9bgO+vt2j1ISR6xEmSZMYXfMiG/roR
         hFpyRzcoahRD5dQVaYeuSbmBJ3U1xYH33jvHj9EOqM9YeTNYv91VO//6wQ3VgCZTkr/7
         kJZI/VXk7xHkoETVC6bIvVy4LHxQA2UXsZJwQHq+96GU1BDLXpa+RKGXciJayiUzaal9
         KN6Jx8IjIKkN4rW+PQ1Koa1/KGJUsGCMwecgBUSkU2+sYo+yM43vCQ1rxnrKdcNP7nGO
         HUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfCRq0yAQSqEnZ+BJ++zg1D86ATDnpdb5dG2rsEII9g=;
        b=Osvff5l3/j3vCfA4XTwrh5ZJ21so9Dz0hZfqyY/LshgoaQYKID71zNvnVzPLOOnRF3
         nj9UbjkD3B90cZj9CIyXGOcauaDEDIH4VryVIYW8qLKR3nDI0GONiR9xjXAdHX9UP/8S
         8Zb0ldttrMiS/3sCMfk2GFo9CmhFxO29q9wJKVHWj3tw9mnPwhpZxuWyyySLxnbR1RZm
         mKM1vkeyJORJDWAyT6hWhW+J1XVMKQNppZ3rHp3V3Duxq99cmec45qAIlQtt0rmuObgl
         EgrmQhBOSQORWh7URU4GbnFEOd2zFJbohfbV6pcqUQj/ULaBxDesx84A/77yv6LWgDeY
         eQiA==
X-Gm-Message-State: AOAM530trbmLGsmS1TYAWl6D7ICzB+2dtMpWTJZWjjf7LiH0JRBeuxHW
        dhWo9DEeRYnOmxayU5/S2HGT1xt0
X-Google-Smtp-Source: ABdhPJy9mccU/ZJxWwsD/PKwt2JFY/WBN1kA+AchaK3Hpb/mEW0crbqaJAiwGYmz9Yl92VSA59APvQ==
X-Received: by 2002:a1c:2982:: with SMTP id p124mr46107096wmp.26.1593982500319;
        Sun, 05 Jul 2020 13:55:00 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id 92sm22757522wrr.96.2020.07.05.13.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 13:54:59 -0700 (PDT)
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
From:   Swyter <swyterzone@gmail.com>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <6bce2c08-48f0-f49c-d70c-280475220550@gmail.com>
Message-ID: <1bff6e62-1815-ffe7-a06e-8e303b717e46@gmail.com>
Date:   Sun, 5 Jul 2020 22:54:57 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
In-Reply-To: <6bce2c08-48f0-f49c-d70c-280475220550@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 05/07/2020 21:21, Ismael Ferreras Morezuelas wrote:
> @@ -4001,11 +4053,13 @@ static int btusb_probe(struct usb_interface *intf,
>  		if (bcdDevice < 0x117)
>  			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>  
> +		/* This must be set first in case we disable it for fakes */
> +		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +
>  		/* Fake CSR devices with broken commands */
> -		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
> +		if (udev->descriptor.idVendor  == 0x0a12 &&
> +		    udev->descriptor.idProduct == 0x0001)
>  			hdev->setup = btusb_setup_csr;

Noticed that I'm probably missing a few le16_to_cpu() there,
from what I've seen in other places. I'll keep it in mind.

Self-review. :)
