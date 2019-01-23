Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B084C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E88D21855
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAWSvg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:51:36 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.80]:15071 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfAWSvf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 13:51:35 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 13:51:35 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E1D5418373B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 12:05:00 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mMtYgEWtM90onmMtYgfq4x; Wed, 23 Jan 2019 12:05:00 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=49980 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmMtU-000fnS-3L; Wed, 23 Jan 2019 12:05:00 -0600
Subject: Re: [PATCH net-next] Bluetooth: Mark expected switch fall-throughs
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190123072031.GA9678@embeddedor>
 <1AA1243F-A0CD-4124-A2D8-DB3648E4C922@holtmann.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <9a5ff3f2-5157-0e07-5085-f9ef41070e1d@embeddedor.com>
Date:   Wed, 23 Jan 2019 12:04:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1AA1243F-A0CD-4124-A2D8-DB3648E4C922@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmMtU-000fnS-3L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:49980
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 1/23/19 11:46 AM, Marcel Holtmann wrote:
> Hi Gustavo,
> 
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> net/bluetooth/rfcomm/core.c:479:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> net/bluetooth/l2cap_core.c:4223:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> net/bluetooth/l2cap_core.c  | 1 +
>> net/bluetooth/rfcomm/core.c | 1 +
>> 2 files changed, 2 insertions(+)
> 
> patch has been applied to bluetooth-next tree.
> 

Thank you, Marcel.

--
Gustavo
