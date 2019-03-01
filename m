Return-Path: <SRS0=mQGV=RE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F43EC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 20:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F0320857
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Mar 2019 20:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kXPB0719"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfCAUPf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:15:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUPf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Mar 2019 15:15:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so27211884wrg.1;
        Fri, 01 Mar 2019 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWJym2v96IK6dnzWOixk+4fN/BIWMSM1tG3qdh2C1A0=;
        b=kXPB0719YM6N5FS57LnaS8hNpGKaSOiyRNeRogzcPbWjOzEMVROveyzZPr4BnpPjxX
         MFCexEgK8p87l6nYf4kmmFXu4rJesF2eEvoQ8Y0xCHb58Uqeo9OO8FqfjbBpQOLWq4sT
         X1YHjYeubxjGSTj6Arp3KdkOnSUzpMv0qw/G/EWVGDjglV93CdaDqno/2D3TiObMwWF+
         d+tEO233HobrQZH3cZ75G58zHX/NUFK2I2KqsQ4cZ1C43sXKgffWyAyoEJJVTYE6hVV2
         7XtS6HSMWMKei4BVn9HEKWY7b94R56Xh0gjicd5ljj1vemUMjjIzFj65zIgTDntKM+DX
         5pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWJym2v96IK6dnzWOixk+4fN/BIWMSM1tG3qdh2C1A0=;
        b=h4Y38hQbDHH2yeeh+gUxqv9FFI0dh9rO/1YmtHHeEmYOC30looqVYG1KMALq3BzcZk
         zya6aSLCnYCzPZBZQJtSGvTh52F5DrcVhNdqdWo7VuxOEf51bXEL4nnl99RM/5kz/kJe
         SPhrL6PQBcejeZGS1ZMlVXiYowLW/PajGP4P3it7JUZkCEFxHhn13lUwsAv+9SgTSlZ1
         oJXDoBoCR4mwQ0bXSppD1NcvTIIgx50/7Szks6+cpaCKKaFA+4EiCdf0CG16S33Brz/i
         di4kQMq9VUuMZYSI6/RGhIcJdcoYmks7MWBFF7yeI90QZEwWSAG7BDkZtH9t7yPuMaPO
         ZCFQ==
X-Gm-Message-State: APjAAAUXSkP9LH81p8S2VFAjgC7q0v6PL5I26uKv4aT4HQ2GM8B3Cux3
        AuH6n/ZXRfwOqU8dewyz3KE=
X-Google-Smtp-Source: APXvYqyUQcxYSz0DkkajW+CZgxOr/ANK2ptX+nKAP1TyXZelWSXGjVX9mYrSrdhbw0vVgJ9A0GwCgQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr4529351wrx.134.1551471332597;
        Fri, 01 Mar 2019 12:15:32 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7109200428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d710:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v10sm22899389wrn.26.2019.03.01.12.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 12:15:31 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     anarsoul@gmail.com, alex_lu@realsil.com.cn
Cc:     beagleboard@davidjohnsummers.uk, davem@davemloft.net,
        devicetree@vger.kernel.org, johan.hedberg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        netdev@vger.kernel.org, robh@kernel.org, stefan.wahren@i2se.com,
        wens@csie.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Date:   Fri,  1 Mar 2019 21:15:19 +0100
Message-Id: <20190301201519.21953-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>
References: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vasily, Hi Alex,

On 22/02/2019 11:21, Vasily Khoruzhick wrote:
> I agree with Rob that we should probably use firmware-name here instead.
Have you considered skipping this property for v1 of this series?
We can still add that property (as optional one) later on if we really
see the need for it. (The btrtl code should already support the case
where NULL is passed as "postfix")

I checked the public rtl8723bs_bt [0] and rtl8723ds_bt [1] git repos and
they each contain only one config blob. The blob from the rtl8723bs_bt
repo worked on my two Amlogic boards (data only, sound input/output not
tested), even though Amlogic seems to ship different blobs: [2]

>> Is there a need to have the board name?
>
> As far as I understand firmware config depends on board, so I think
> it's a good idea to use board name here.
I also added Alex Lu from Realtek / Realsil to this email.
Alex, I hope that you can help us with the "Bluetooth config" format for
the Realtek WiFi and Bluetooth combo chips - mainly the ones which
connect to the host using SDIO.

This is important for us because the question came up whether we can
describe everything that's part of the "config blob" as device-tree
properties. If we knew the format we could generate the "config blob"
on-the-fly (either by fully generating it, taking a blob - maybe with
only the smallest set of config data - as "template" and update values
on-the-fly, etc.)

Marcel wrote a tool [3] which handles the basic config format. However,
we're still missing a lot of details (only 3 offsets are known,
"UART_CONFIG" contains 16 bytes but we only know the purpose of 4 of
these, ...).
I would highly appreciate if you give us enough details so we can extend
Marcel's tool to display the human-readable representation of the config
blobs from rtl8723bs_bt [0] and rtl8723ds_bt [1].

Vasily, thank you for your effort on this topic so far!
If you keep me CC'ed on v2 of your series then I can test it on two of
my Amlogic boards (which come with a RTL8723BS).


[0] https://github.com/lwfinger/rtl8723bs_bt/tree/09eb91f52a639ec5e4c5c4c98dc2afede046cf20
[1] https://github.com/ayufan-pine64/rtl8723ds_bt/tree/fab21b52250d67857b694f961e1ff8618e678d89/8723D
[2] https://github.com/khadas/android_hardware_realtek/tree/bd3b113266c353aafcbf528a0334d28090ff249b/rtkbt/system/etc/firmware
[3] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/rtlfw.c?id=261948090e9073514ac4b5f64c8715cf0a71eafa
