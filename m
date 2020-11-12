Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8769FC55ABD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E129D216FD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKLJJL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 04:09:11 -0500
Received: from mxout03.lancloud.ru ([89.108.73.187]:50230 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLJJK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 04:09:10 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 04:09:09 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 87EA520A0AAF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/2] bluetooth: hci_event: consolidate error paths in
 hci_phy_link_complete_evt()
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
References: <bbdd9cbe-b65e-b309-1188-71a3a4ca6fdc@omprussia.ru>
 <b508265e-f08f-ea24-2815-bc2a5ec10d8d@omprussia.ru>
 <EA8EC09F-6AB5-45DD-9889-C05D1FC9AAE6@holtmann.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform
Message-ID: <c7579df5-a69b-d9e7-ccb6-6a7b2fc23d4a@omprussia.ru>
Date:   Thu, 12 Nov 2020 12:02:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <EA8EC09F-6AB5-45DD-9889-C05D1FC9AAE6@holtmann.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.163.193]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

On 11.11.2020 14:12, Marcel Holtmann wrote:

>> hci_phy_link_complete_evt() has several duplicate error paths -- consolidate
>> them, using the *goto* statements.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
>>
>> ---
>> net/bluetooth/hci_event.c |   16 ++++++----------
>> 1 file changed, 6 insertions(+), 10 deletions(-)
> 
> patch has been applied to bluetooth-next tree.

    What about the 2nd patch?

> Regards
> 
> Marcel

MBR, Sergey
