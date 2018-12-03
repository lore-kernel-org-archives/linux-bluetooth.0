Return-Path: <SRS0=1Mik=OM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E913C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232ED206B7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcBie7r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232ED206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeLCN5f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:57:35 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51382 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCN5e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Dec 2018 08:57:34 -0500
Received: by mail-wm1-f45.google.com with SMTP id s14so5943747wmh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Dec 2018 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=cMnpUBeldWanMuyvVwns3+W/TQAOEbo3HqriJiuxswE=;
        b=fcBie7r+GpZaVqxZCXFGlQWPfxtMGiy9QwgIxX29ZBY+mWOd3BKeHst8kYmVM9T1y6
         s5B0+WFvW7fBoEaWqQ2klUc4Pf0n0+sbW3faXYisCQepwnFa/bYwO1YpBp7oPLLwE+be
         YLrCBNe41IHa0zZd0kcW3xjBAsseLOMy7uH2gDISq03DJZZSKqPU/ji+cI5tD5izx36x
         l1co17G+P4fy89oL05SBskqxjO7xciooLH5++Zh1kItvw1GHjw6S8LLPjPbbNcVY81MT
         qbCU6/ufFJWkD5lQbHkPWlS1FkxAA1/GTK4Q1O0X9uA/eUkL7kRBaOlfJfjvoMPuTES/
         n6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=cMnpUBeldWanMuyvVwns3+W/TQAOEbo3HqriJiuxswE=;
        b=P0NvQ+UYHSvZxOgudfabvdaPYq34ID2LOStWxnWeBpoUGkc7nuXUo4P/Td6NEOojJz
         60Fo4gH1+Dl1+Qa2pfiqrNXShr2RraPeSCZ6Jf/qSW6mdJ2UW9v9Sc68o7ajXNtHTxmx
         ZFstHjp/vTFmGxxuKWlssjosHM5dml6KIKv+FKDgjDGBTl8ITluI2LHRqF6g14JCUdEB
         ksI5bQdBT8Wo+S9aPJVrPnI2B/Vm9KOoVb8GaO+NTYX7cvzaLSACb5Dp95aZ+rrAKX43
         n8uEpo/7sU8TN953gai+M4JTQ7I3382H4Ggm8eg8KINeJrkrcp4G2Ynmpg4qUEsxm4P/
         NRvw==
X-Gm-Message-State: AA+aEWagzuDS41i0GXREoOz/hdjGtpG16GYqcmL7K74QBAXDu3O2rRgI
        G/2zVXUhF35bTXaKx2v6ZeWFcKmv
X-Google-Smtp-Source: AFSGD/U7HgOqmPTu7RvOTj+WoDg/LtkvHhhq5L4a+H3QcPcwd1DyTfWoEpxadziAJcDdJEX0R3sWTQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr8074184wmd.63.1543845385684;
        Mon, 03 Dec 2018 05:56:25 -0800 (PST)
Received: from [192.168.0.1] (cpc149624-rdng29-2-0-cust819.15-3.cable.virginm.net. [82.15.3.52])
        by smtp.googlemail.com with ESMTPSA id j8sm10862829wrt.40.2018.12.03.05.56.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 05:56:24 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   Matt <mwtaylor@gmail.com>
Subject: Error setting UUIDs discovery filter on big endian systems
Message-ID: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
Date:   Mon, 3 Dec 2018 13:56:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

When setting a UUIDs discovery filter I am receiving 
"org.bluez.Error.InProgress" on starting a scan (which isn't in progress 
and will not start unless the discovery filter is cleared).

I am using bluez 5.50 (on openWRT). The problem seems to only appear on 
big endian hardware (tested a couple of recent kernel and bluez 
versions), the same software compiled for and tested on little endian 
hardware works as expected. The issue can be reproduced in the following 
way using bluetoothctl:

# /etc/init.d/bluetoothd restart
# bluetoothctl
[bluetooth]# power on
Changing power on succeeded
[CHG] Controller 00:1A:7D:DA:71:13 Powered: yes
[bluetooth]# menu scan
[bluetooth]# uuids 0000180f-0000-1000-8000-00805f9b34fb
[bluetooth]# back
[bluetooth]# scan on
SetDiscoveryFilter success
Failed to start discovery: org.bluez.Error.InProgress

Setting an rssi filter does work as expected on my big endian hardware, 
it is only the uuids filter that appears to show this problem. The issue 
appears whether set using bluetoothctl or directly using DBus.

Thank you for your help and attention,
Matt
