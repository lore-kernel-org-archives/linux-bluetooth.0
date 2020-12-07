Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A80C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE6C23750
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLGQAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGQAN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 11:00:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C1C06179C
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 07:59:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p22so2201561edu.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 07:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uhasselt.be; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=UZH9E25yPj7aqS7+JVAZVZviJ+aDYZFEygt0FJaanx4=;
        b=d2bvqtz837oRSL5J8h1PwhUAfkaC+o+qRDiRgYprdL8wW6jUIJftWAbA8U4cmHl6vi
         +cbs8H/jhnIHSKnuq6mvXXJ2jBOAGbRWldxY9FtV5c2oAUMPQa/tiSBIkRkmLb161xeB
         gmitOjycISZIhj5mJHClS2SAoMFr0Wkupo24s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UZH9E25yPj7aqS7+JVAZVZviJ+aDYZFEygt0FJaanx4=;
        b=h2YUqsZuxUTtihg4NteZf8U3Ry8NVL4Vu01YSUG5fCjY4jI9lACZ9bzWyPBhE+H37F
         8VMS6BYbl4Lk0oHcddWBNZ1kN0R31gcZyRbAQQCE2VLnChfUyu0gbS1mVUUa4SHkDLNa
         zlKCVj/ZtK/sKELs6LcRAhrGqgPOl++0f2gOLYGBOa53ez94NhLh5PSOvbkMuQghPdqP
         TSMWimQFGcgBd9WwOIb8Qp/9E8csZKCSIpZYH55y8+KBShTffvqYoOX4LTOLDD949t7g
         k1jy3nV3xGgs6lEdlkPoiKaSX5C6ZzRjaiVQKkZUqWRQS9FoAEXQIaLCZtmutVIYAbgv
         pBTw==
X-Gm-Message-State: AOAM533W99Kk7J9WzDW7M0cmR5Q6qg/PAPQ9cojWPIOstFPOaBwPv6A5
        GaovUgox0nYc+I9n545JrdqKkLI+Zuu/3HCVEt8ZWyeKU00a4uNIzoph+574rBFcKd70cYFy5Zf
        MDByzYE8WmdJfvo7vDH3mJJFFyJajBC5phyRXHZZbsPlMdl2q4rD+pDq2iEqY9XoF/hNt5q+qsN
        MlajrcgwmTg5/N6oC9PGg=
X-Google-Smtp-Source: ABdhPJw1c6RV8vwyNRzClZ04L2ZD/D1Q1IhhbAA5woYosTUSiCMPwtoAVpFfnMSWUAs1TnWYP/kLSQ==
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr20592414edr.341.1607356771696;
        Mon, 07 Dec 2020 07:59:31 -0800 (PST)
Received: from ?IPv6:2a02:1810:9506:e300:9b2:cc6c:58c0:e889? (ptr-4gz57ep9i94wldhvpmx.18120a2.ip6.access.telenet.be. [2a02:1810:9506:e300:9b2:cc6c:58c0:e889])
        by smtp.gmail.com with ESMTPSA id d22sm13093960eja.72.2020.12.07.07.59.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:59:31 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   Michel Van den Bergh <michel.vandenbergh@uhasselt.be>
Subject: Bluetooth headset no longer working after upgrade to Ubuntu 20.04
Message-ID: <f16ac221-6281-6725-6680-284d0a221a1d@uhasselt.be>
Date:   Mon, 7 Dec 2020 16:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My apologies. I posted this to the pulseaudio mailing list but now I 
think it may be a bluetooth issue.

I have a bluetooth headset JBC LIVE650BT. It worked perfectly with Ubuntu
16.04. It currently works perfectly with an ipad.

On Ubuntu 20.04 I can pair with the device but then pulseaudio does not 
see it.

The output of

$ bluetoothctl info <MAC>

is

Device 45:63:61:53:08:39 (public)
Name: JBL LIVE650BTNC-LE
Alias: JBL LIVE650BTNC-LE
Paired: yes
Trusted: yes
Blocked: no
Connected: no
LegacyPairing: no
UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Unknown (0000fe03-0000-1000-8000-00805f9b34fb)
UUID: Google Inc. (0000fe2c-0000-1000-8000-00805f9b34fb)
UUID: Vendor specific (55f80aef-d89f-41a4-9e36-0ffc88dc81ce)
UUID: Vendor specific (65786365-6c70-6f69-6e74-2e636f6d0000)
UUID: Vendor specific (66666666-6666-6666-6666-666666666666)
UUID: Vendor specific (67a846ad-de3e-451b-a6d8-7b2899ca2370)
UUID: Vendor specific (91c10d9c-aaef-42bd-b6d6-8a648c19213d)
UUID: Vendor specific (fe59bfa8-7fe3-4a05-9d94-99fadc69faff)
ManufacturerData Key: 0x0ecb
ManufacturerData Value:
   15 1f 00 43 d3                                   ...C.
ServiceData Key: 0000fe2c-0000-1000-8000-00805f9b34fb
ServiceData Value:
   00 00                                            ..
ServiceData Key: 0000fe03-0000-1000-8000-00805f9b34fb
ServiceData Key: 0000fe26-0000-1000-8000-00805f9b34fb
ServiceData Value:
   13 02 f0

AFAICT there is nothing in this output that suggests this is an audio
device. Is this normal?
