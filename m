Return-Path: <SRS0=K0Cw=M5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EFC5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 00:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED6214C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 00:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED6214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gonzos.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJQInF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:43:05 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:37518 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbeJQInE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 04:43:04 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 04:43:04 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E24FB400C6156
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 18:32:28 -0500 (CDT)
Received: from gator3138.hostgator.com ([50.87.144.173])
        by cmsmtp with SMTP
        id CZeEgo1MTtz4jCZeLgvgpy; Tue, 16 Oct 2018 19:25:27 -0500
X-Authority-Reason: nr=8
Received: from [58.173.224.242] (port=57268 helo=[192.168.34.11])
        by gator3138.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <brg@gonzos.net>)
        id 1gCX9B-0030Zz-Jx
        for linux-bluetooth@vger.kernel.org; Tue, 16 Oct 2018 16:45:01 -0500
Subject: Re: Minimising latency in MIDI over BTLE
From:   Ben Gonzales <brg@gonzos.net>
To:     linux-bluetooth@vger.kernel.org
References: <13f2a56a-3d21-5f84-dc77-5d7cbc8c03a3@gonzos.net>
 <9d400627-ea18-9d82-c0e4-d78128910c5e@gonzos.net>
Message-ID: <6f30b9d4-711a-7e1b-9d41-b313c9a6e579@gonzos.net>
Date:   Wed, 17 Oct 2018 08:44:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9d400627-ea18-9d82-c0e4-d78128910c5e@gonzos.net>
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
X-Exim-ID: 1gCX9B-0030Zz-Jx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.34.11]) [58.173.224.242]:57268
X-Source-Auth: brg@gonzos.net
X-Email-Count: 0
X-Source-Cap: dHBvb2xhZG07dHBvb2xhZG07Z2F0b3IzMTM4Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

<snip>
>
> Any suggestions?
>
> Ben

OK, so no responses....

Does this mean

a) This is the wrong forum for this discussion

b) No-one can help
or
c) something else

??

Ben
