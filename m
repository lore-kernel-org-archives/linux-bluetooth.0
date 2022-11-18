Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 16:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiKRQOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 11:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiKRQOd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 11:14:33 -0500
X-Greylist: delayed 261 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 08:14:30 PST
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [IPv6:2001:638:208:120::220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44491922E6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 08:14:29 -0800 (PST)
Received: from [192.168.2.118] (dslb-088-068-027-038.088.068.pools.vodafone-ip.de [88.68.27.38])
        (authenticated bits=0)
        by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id 2AIG9xTU065171
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 17:10:03 +0100
Message-ID: <f9213307-e4c3-902a-e0b6-aed53f3a1e02@rhrk.uni-kl.de>
Date:   Fri, 18 Nov 2022 17:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: de-DE, en-GB
To:     linux-bluetooth@vger.kernel.org
From:   Marvin Sinnwell <msinnwel@rhrk.uni-kl.de>
Subject: LE Advertisement on data channels/ btvirt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

TL;DR: Seeking advice on advertising on arbitrary channels + usage of 
btvirt specifically function "send_adv_pkt".

I am currently working on my bachelor thesis and have the following 
problem with I would like to request some advice:

I want to test several algorithms that try to improve the time it takes 
to find an advertisement packet of another device. For this I not only 
want to change the method of advertising, on channels 37-39 in 
sequential order, to something else, but also send advertisement packets 
on other channels.

My main difficulty currently is composed of trying to find out where the 
actual advertisement packets are sent. Currently my best guess is, that 
is is controlled by the firmware of my raspberry pi that I am using 
(specific model below), because I could not find anything within the 
bluez stack. Maybe one of you has more knowledge on where I have to search.

What I was able to find was the btvirt tool, which could help with my 
problem. There I found in the file "le.c" in function 
"adv_timeout_callback" another function called "send_adv_pkt". Sadly 
while trying out btvirt and clever usage of some print statements I 
could not see the function be executed. Maybe someone can give me some 
advice on that, because this function should do exactly what I am 
looking for. It could be that I was just using the tool incorrectly in 
which case it would be great if somebody could tell me how to use it. My 
methodology was: 1. "sudo ./btvirt -L -l2 -d" to create 2 new local LE 
controller. 2. Start advertisement using hcitool "sudo hcitool -i hci2 
cmd 0x08 0x000a 01". The advertisement is correct and the other local 
controller can connect to the first one.

My current equipment is:

Device:                Raspberry Pi 3 Model B+

Kernel + OS:       Linux raspberrypi 5.15.61-v7+ #1579 SMP Fri Aug 26 
11:10:59 BST 2022 armv7l GNU/Linux

Bluez version:     5.65


Kind regards

Marvin Sinnwell



