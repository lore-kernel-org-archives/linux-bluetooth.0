Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F61C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30312084C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlnqHRPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfA3Tpq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:45:46 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37184 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfA3Tpp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 14:45:45 -0500
Received: by mail-lf1-f47.google.com with SMTP id y11so567319lfj.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=51m4kXDZSJdKzOKrZzIuUW4RbPIv6fO4yu9gTUnrdUw=;
        b=KlnqHRPL6DkVnCI0GC+AD7sMVBytwbsdXC0rvOhaeLPexS+myZ4WV8QFKJYLzRUdkr
         R4odjNPq4A1LZaPA9qj5ryt4nyAeViRSBRT+6/nSVr3s/PxkvcD2LOwvC8YAEgwAz56q
         6/o/xgwxQmJTwyIsA/rEKtAAywmWjD/QmnhD8a0gKaX7XULdMsDwLLETlxVzik70KB/c
         CFqa0AFUhZnf5Z5ofi8JA8Lr+Qb/b8Vv5a3Xhw0PrhymtinC4/JugLC+dBduAj0fhEDY
         LPnY3S5mzsUsY/MQ/LvX2/fyR4JqavJb5bfeXd3yxlYJIwdmtBJVdZuf4scxd9YI5F/k
         akQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=51m4kXDZSJdKzOKrZzIuUW4RbPIv6fO4yu9gTUnrdUw=;
        b=OPV6C5ZVsZdhrH6YDXYHJL1hcpL4cJA1oTBCIWpmG6Ut6cI5MiK3UoRuyKEQe5qOIf
         IbMIchhePkg0S8bX0R9qOLxa9Kn1WogC8QHkLJywqkFKc5fpG6tDvPKrGN9Oo582FBau
         C7XwPq2BWvNS8FVd3NXSq1YJ4iIKu88uLsNeOOetpolRktYBj0ToRZ3Wbck2PF8tlBtb
         elDVSm3yiH10s/XcT2HnKlzzvqGGpBAakrBIq9yCNOf0buT251TpoHs1Z0459V8rFvNN
         jsQk77/hcFDss5TaNMXmnLweAZW+8oVdyrJ4uaRemlw8s0K9Ra4PjjEaVSgeZmi5GLpG
         QnxA==
X-Gm-Message-State: AJcUukdRMJl+0zuCNppG6r9yFYQg+DR+YKVmh8mgLl7nFMVpOf332e4s
        I0j60W+UZH1oTILvSvnMbf/Eo4Oqnc8=
X-Google-Smtp-Source: ALg8bN4QRiHtiQDp42JgM02i2gxjbbWLY4fl+Cca7ccUUOQc68i6vHgrmMP9RefmyRSd95qhrEhWaA==
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr25897520lfc.27.1548877543322;
        Wed, 30 Jan 2019 11:45:43 -0800 (PST)
Received: from [192.168.1.116] (broadband-46-188-21-20.2com.net. [46.188.21.20])
        by smtp.gmail.com with ESMTPSA id f1sm444580lfm.22.2019.01.30.11.45.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:45:42 -0800 (PST)
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: first keystroke of BT-keyboards is missed
To:     linux-bluetooth@vger.kernel.org
Message-ID: <c256c23d-5710-0872-21be-a2beaa3c67c1@gmail.com>
Date:   Wed, 30 Jan 2019 22:45:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 21 Jan 2014 12:32:45 +0100, Alexander Holler 
<holler@xxxxxxxxxxxxx <mailto:holler@DOMAIN.HIDDEN>> wrote:
> Hello,
>
> I can't remember since when I'm seeing the kernel message "unknown 
> main item tag 0x0" for many Bluetooth input devices, but it is since 
> quiet some time.
> Has someone already tried to find out where that does come from?
>
> My first guess would be that bluez misses one or more bytes a 
> connection startup, which is based on the fact that, since ever, it 
> misses the first keystroke of BT-keyboards too (the keystroke which 
> wakes up the keyboard and initiates the connection). And I'm pretty 
> sure my keyboard does transmit that initiating keystroke, because 
> Windows receives it. ;) Besides that, that guess isn't based on 
> anything. I neither have tried to search through the source nor did I 
> run some tests. But because I'm curious I can't completely ignore that 
> kernel message, even if I haven't experienced any obvious problems. So 
> here is the question if someone else has a pointer or has already 
> searched what the reason for that message is. I don't think it's a 
> fault of the used device(s), as I see this message for multiple 
> bt-input-devices. 

Hi, I have the same described problem - after BT-keyboard idle(10 min), 
the first keystroke is missed, with "unknown main item tag 0x0" message 
in log.
On the same system, Windows 10 doesn't have the problem - the keystroke 
shows up successfully after reconnect.

Also, the same BT keyboard doesn't miss the keystroke with my Android 
phone (it re-connects still).

This bug is very annoying, as I can't use my keyboard properly.

Any suggestion on problem resolving? I'm ready to assist in debug it 
further.
Thanks.

