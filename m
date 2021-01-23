Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8AFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jan 2021 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87DD229C5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jan 2021 17:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAWRz5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Jan 2021 12:55:57 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:56688 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbhAWRz4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Jan 2021 12:55:56 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 12:55:56 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru D63CB233DF53
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
 <c7579df5-a69b-d9e7-ccb6-6a7b2fc23d4a@omprussia.ru>
 <69CEE0E0-E71B-480E-B009-5B5E9475B510@holtmann.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <42fe0bc9-441f-1eda-4ebc-ee3fe47227cb@omprussia.ru>
Date:   Sat, 23 Jan 2021 20:47:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <69CEE0E0-E71B-480E-B009-5B5E9475B510@holtmann.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/23/20 2:58 PM, Marcel Holtmann wrote:

>>>> hci_phy_link_complete_evt() has several duplicate error paths -- consolidate
>>>> them, using the *goto* statements.
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
>>>>
>>>> ---
>>>> net/bluetooth/hci_event.c |   16 ++++++----------
>>>> 1 file changed, 6 insertions(+), 10 deletions(-)
>>> patch has been applied to bluetooth-next tree.
>>
>>   What about the 2nd patch?
> 
> must have been slipping somehow. Can you please re-send against bluetooth-next.

   I have but to no avail -- the patch has been silently ignored...

> Regards
> 
> Marcel

MBR, Sergei
