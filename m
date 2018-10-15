Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17783C04AA5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FA208B3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83FA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gonzos.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPEm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:42:26 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:18927 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbeJPEmZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Oct 2018 00:42:25 -0400
X-Greylist: delayed 1292 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 00:42:25 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2C3E77968BF
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 15:33:58 -0500 (CDT)
Received: from gator3138.hostgator.com ([50.87.144.173])
        by cmsmtp with SMTP
        id C9YigLV2zkBj6C9YngQEzs; Mon, 15 Oct 2018 15:33:57 -0500
X-Authority-Reason: nr=8
Received: from [58.173.224.242] (port=53578 helo=[192.168.34.11])
        by gator3138.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <brg@gonzos.net>)
        id 1gC9Yi-001XFO-Cx
        for linux-bluetooth@vger.kernel.org; Mon, 15 Oct 2018 15:33:48 -0500
Subject: Re: Minimising latency in MIDI over BTLE
From:   Ben Gonzales <brg@gonzos.net>
To:     linux-bluetooth@vger.kernel.org
References: <13f2a56a-3d21-5f84-dc77-5d7cbc8c03a3@gonzos.net>
Message-ID: <9d400627-ea18-9d82-c0e4-d78128910c5e@gonzos.net>
Date:   Tue, 16 Oct 2018 07:33:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <13f2a56a-3d21-5f84-dc77-5d7cbc8c03a3@gonzos.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3138.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gonzos.net
X-BWhitelist: no
X-Source-IP: 58.173.224.242
X-Source-L: No
X-Exim-ID: 1gC9Yi-001XFO-Cx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.34.11]) [58.173.224.242]:53578
X-Source-Auth: brg@gonzos.net
X-Email-Count: 1
X-Source-Cap: dHBvb2xhZG07dHBvb2xhZG07Z2F0b3IzMTM4Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 14/10/18 19:11, Ben Gonzales wrote:
> Hi.
>
> First post.
>
> I have compiled Bluez 5.50 on a R-Pi for a synth using Fluidsynth. 
> Project page here:
>
> https://gonzos.net/projects/pi-synth/
>
> I'm using a Yamaha UD-BT01 MIDI-over-BTLE (MOB) peripheral to send 
> MIDI commands to the synth. Before the MOB functionality was 
> implemented I was using BluePy to send/receive the MIDI. The new 
> ability to create a MIDI port is excellent, but I find the latency 
> higher than I would like. It is certainly higher than with BluePy (no 
> measurements yet - just my subjective appraisal).
>
> My question is: are there techniques for minimising latency over BTLE?
>
> Ben

Further information:

I have set up a test rig on my RPi so I can measure the time difference 
between the trigger (the air pressure pulse) on my wind controller and 
the arrival of the MIDI command at the OS MIDI port. The sensor 
by-passes the wind controller and connects directly to the RPi.

My wind controller is an Akai EWI-USB, the BTLE peripheral is a Yamaha 
UD-BT01, and I did 20 tests of each of the following scenarios measuring 
time difference in msec:

A) With the EWI wired to the  USB port
Average:  34 , Max:  41.568 , Min:  30.496 , No.:  20

B) with the EWI connected via the Bluez 5.50 BTLE connection
Average:  76 , Max:  112.246 , Min:  35.877 , No.:  20

C) with the EWI connected via an "optimised" Bluez 5.50 BTLE connection
Average:  53 , Max:  61.032 , Min:  45.739 , No.:  20

"Optimising" the BTLE connection is done by running:
sudo hcitool lecup --handle $HANDLE --min 6 --max 7 --latency 0 
--timeout 500

So, the optimised BTLE connection is 20ms slower than the wired one, and 
the unoptimised BTLE connection is really bad at 40ms slower than the 
wired one.

Any suggestions?

Ben
