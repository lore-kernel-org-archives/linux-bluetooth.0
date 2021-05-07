Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C356113E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhEGIez convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 04:34:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40441 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhEGIey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 04:34:54 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4AFB1CECDB;
        Fri,  7 May 2021 10:41:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH v1] Bluetooth: Fix alt settings for incoming SCO with
 transparent coding format
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210408170159.19510-1-kiran.k@intel.com>
Date:   Fri, 7 May 2021 10:33:54 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        chethan.tumkur.narayan@intel.com,
        Lokendra Singh <lokendra.singh@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E7873127-F9ED-4836-8404-CC12FD890DAB@holtmann.org>
References: <20210408170159.19510-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> For incoming SCO connection with transparent coding format, alt setting
> of CVSD is getting applied instead of Transparent.
> 
> Before fix:
> < HCI Command: Accept Synchron.. (0x01|0x0029) plen 21  #2196 [hci0] 321.342548
>        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 13
>        Setting: 0x0003
>          Input Coding: Linear
>          Input Data Format: 1's complement
>          Input Sample Size: 8-bit
>          # of bits padding at MSB: 0
>          Air Coding Format: Transparent Data
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x003f
>          HV1 may be used
>          HV2 may be used
>          HV3 may be used
>          EV3 may be used
>          EV4 may be used
>          EV5 may be used
>> HCI Event: Command Status (0x0f) plen 4               #2197 [hci0] 321.343585
>      Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Synchronous Connect Comp.. (0x2c) plen 17  #2198 [hci0] 321.351666
>        Status: Success (0x00)
>        Handle: 257
>        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x0c
>        Retransmission window: 0x04
>        RX packet length: 60
>        TX packet length: 60
>        Air mode: Transparent (0x03)
> ........
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2336 [hci0] 321.383655
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2337 [hci0] 321.389558
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2338 [hci0] 321.393615
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2339 [hci0] 321.393618
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2340 [hci0] 321.393618
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2341 [hci0] 321.397070
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2342 [hci0] 321.403622
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2343 [hci0] 321.403625
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2344 [hci0] 321.403625
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2345 [hci0] 321.403625
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2346 [hci0] 321.404569
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2347 [hci0] 321.412091
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2348 [hci0] 321.413626
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2349 [hci0] 321.413630
>> SCO Data RX: Handle 257 flags 0x00 dlen 48            #2350 [hci0] 321.413630
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2351 [hci0] 321.419674
> 
> After fix:
> 
> < HCI Command: Accept Synchronou.. (0x01|0x0029) plen 21  #309 [hci0] 49.439693
>        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 13
>        Setting: 0x0003
>          Input Coding: Linear
>          Input Data Format: 1's complement
>          Input Sample Size: 8-bit
>          # of bits padding at MSB: 0
>          Air Coding Format: Transparent Data
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x003f
>          HV1 may be used
>          HV2 may be used
>          HV3 may be used
>          EV3 may be used
>          EV4 may be used
>          EV5 may be used
>> HCI Event: Command Status (0x0f) plen 4                 #310 [hci0] 49.440308
>      Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17  #311 [hci0] 49.449308
>        Status: Success (0x00)
>        Handle: 257
>        Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x0c
>        Retransmission window: 0x04
>        RX packet length: 60
>        TX packet length: 60
>        Air mode: Transparent (0x03)
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #312 [hci0] 49.450421
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #313 [hci0] 49.457927
>> HCI Event: Max Slots Change (0x1b) plen 3               #314 [hci0] 49.460345
>        Handle: 256
>        Max slots: 5
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #315 [hci0] 49.465453
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #316 [hci0] 49.470502
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #317 [hci0] 49.470519
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #318 [hci0] 49.472996
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #319 [hci0] 49.480412
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #320 [hci0] 49.480492
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #321 [hci0] 49.487989
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #322 [hci0] 49.490303
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #323 [hci0] 49.495496
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #324 [hci0] 49.500304
>> SCO Data RX: Handle 257 flags 0x00 dlen 60              #325 [hci0] 49.500311
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

