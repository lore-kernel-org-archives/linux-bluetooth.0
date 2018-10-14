Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B6C6787C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14B020843
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14B020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gonzos.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeJNQOl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:14:41 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:23125 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeJNQOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 12:14:41 -0400
X-Greylist: delayed 1370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 12:14:41 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 212BAFDEF
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Oct 2018 03:11:40 -0500 (CDT)
Received: from gator3138.hostgator.com ([50.87.144.173])
        by cmsmtp with SMTP
        id BbUxgR6QERPojBbUygiTTj; Sun, 14 Oct 2018 03:11:40 -0500
X-Authority-Reason: nr=8
Received: from [58.173.224.242] (port=48456 helo=[192.168.34.11])
        by gator3138.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <brg@gonzos.net>)
        id 1gBbUx-002vKV-9w
        for linux-bluetooth@vger.kernel.org; Sun, 14 Oct 2018 03:11:39 -0500
To:     linux-bluetooth@vger.kernel.org
From:   Ben Gonzales <brg@gonzos.net>
Subject: Minimising latency in MIDI over BTLE
Message-ID: <13f2a56a-3d21-5f84-dc77-5d7cbc8c03a3@gonzos.net>
Date:   Sun, 14 Oct 2018 19:11:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3138.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gonzos.net
X-BWhitelist: no
X-Source-IP: 58.173.224.242
X-Source-L: No
X-Exim-ID: 1gBbUx-002vKV-9w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.34.11]) [58.173.224.242]:48456
X-Source-Auth: brg@gonzos.net
X-Email-Count: 1
X-Source-Cap: dHBvb2xhZG07dHBvb2xhZG07Z2F0b3IzMTM4Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi.

First post.

I have compiled Bluez 5.50 on a R-Pi for a synth using Fluidsynth. 
Project page here:

https://gonzos.net/projects/pi-synth/

I'm using a Yamaha UD-BT01 MIDI-over-BTLE (MOB) peripheral to send MIDI 
commands to the synth. Before the MOB functionality was implemented I 
was using BluePy to send/receive the MIDI. The new ability to create a 
MIDI port is excellent, but I find the latency higher than I would like. 
It is certainly higher than with BluePy (no measurements yet - just my 
subjective appraisal).

My question is: are there techniques for minimising latency over BTLE?

Ben
