Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC93C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D90229C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbhAZFcX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:32:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43684 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbhAYSaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:30:23 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE790CECCB;
        Mon, 25 Jan 2021 19:37:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not knowing
 options
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201208172912.4352-1-hadess@hadess.net>
Date:   Mon, 25 Jan 2021 19:29:37 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <F18A5D4E-E940-476A-A1AE-233D4114C3F1@holtmann.org>
References: <20201208172912.4352-1-hadess@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

> The current implementation of L2CAP options negotiation will continue
> the negotiation when a device responds with L2CAP_CONF_UNACCEPT ("unaccepted
> options"), but not when the device replies with L2CAP_CONF_UNKNOWN ("unknown
> options").
> 
> Trying to continue the negotiation without ERTM support will allow
> Bluetooth-capable XBox One controllers (notably models 1708 and 1797)
> to connect.
> 
> btmon before patch:
>> ACL Data RX: Handle 256 flags 0x02 dlen 16                            #64 [hci0] 59.182702
>      L2CAP: Connection Response (0x03) ident 2 len 8
>        Destination CID: 64
>        Source CID: 64
>        Result: Connection successful (0x0000)
>        Status: No further information available (0x0000)
> < ACL Data TX: Handle 256 flags 0x00 dlen 23                            #65 [hci0] 59.182744
>      L2CAP: Configure Request (0x04) ident 3 len 15
>        Destination CID: 64
>        Flags: 0x0000
>        Option: Retransmission and Flow Control (0x04) [mandatory]
>          Mode: Basic (0x00)
>          TX window size: 0
>          Max transmit: 0
>          Retransmission timeout: 0
>          Monitor timeout: 0
>          Maximum PDU size: 0
>> ACL Data RX: Handle 256 flags 0x02 dlen 16                            #66 [hci0] 59.183948
>      L2CAP: Configure Request (0x04) ident 1 len 8
>        Destination CID: 64
>        Flags: 0x0000
>        Option: Maximum Transmission Unit (0x01) [mandatory]
>          MTU: 1480
> < ACL Data TX: Handle 256 flags 0x00 dlen 18                            #67 [hci0] 59.183994
>      L2CAP: Configure Response (0x05) ident 1 len 10
>        Source CID: 64
>        Flags: 0x0000
>        Result: Success (0x0000)
>        Option: Maximum Transmission Unit (0x01) [mandatory]
>          MTU: 1480
>> ACL Data RX: Handle 256 flags 0x02 dlen 15                            #69 [hci0] 59.187676
>      L2CAP: Configure Response (0x05) ident 3 len 7
>        Source CID: 64
>        Flags: 0x0000
>        Result: Failure - unknown options (0x0003)
>        04                                               .
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                            #70 [hci0] 59.187722
>      L2CAP: Disconnection Request (0x06) ident 4 len 4
>        Destination CID: 64
>        Source CID: 64
>> ACL Data RX: Handle 256 flags 0x02 dlen 12                            #73 [hci0] 59.192714
>      L2CAP: Disconnection Response (0x07) ident 4 len 4
>        Destination CID: 64
>        Source CID: 64
> 
> btmon after patch:
>> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #248 [hci0] 103.502970
>      L2CAP: Connection Response (0x03) ident 5 len 8
>        Destination CID: 65
>        Source CID: 65
>        Result: Connection pending (0x0001)
>        Status: No further information available (0x0000)
>> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #249 [hci0] 103.504184
>      L2CAP: Connection Response (0x03) ident 5 len 8
>        Destination CID: 65
>        Source CID: 65
>        Result: Connection successful (0x0000)
>        Status: No further information available (0x0000)
> < ACL Data TX: Handle 256 flags 0x00 dlen 23                          #250 [hci0] 103.504398
>      L2CAP: Configure Request (0x04) ident 6 len 15
>        Destination CID: 65
>        Flags: 0x0000
>        Option: Retransmission and Flow Control (0x04) [mandatory]
>          Mode: Basic (0x00)
>          TX window size: 0
>          Max transmit: 0
>          Retransmission timeout: 0
>          Monitor timeout: 0
>          Maximum PDU size: 0
>> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #251 [hci0] 103.505472
>      L2CAP: Configure Request (0x04) ident 3 len 8
>        Destination CID: 65
>        Flags: 0x0000
>        Option: Maximum Transmission Unit (0x01) [mandatory]
>          MTU: 1480
> < ACL Data TX: Handle 256 flags 0x00 dlen 18                          #252 [hci0] 103.505689
>      L2CAP: Configure Response (0x05) ident 3 len 10
>        Source CID: 65
>        Flags: 0x0000
>        Result: Success (0x0000)
>        Option: Maximum Transmission Unit (0x01) [mandatory]
>          MTU: 1480
>> ACL Data RX: Handle 256 flags 0x02 dlen 15                          #254 [hci0] 103.509165
>      L2CAP: Configure Response (0x05) ident 6 len 7
>        Source CID: 65
>        Flags: 0x0000
>        Result: Failure - unknown options (0x0003)
>        04                                               .
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                          #255 [hci0] 103.509426
>      L2CAP: Configure Request (0x04) ident 7 len 4
>        Destination CID: 65
>        Flags: 0x0000
> < ACL Data TX: Handle 256 flags 0x00 dlen 12                          #257 [hci0] 103.511870
>      L2CAP: Connection Request (0x02) ident 8 len 4
>        PSM: 1 (0x0001)
>        Source CID: 66
>> ACL Data RX: Handle 256 flags 0x02 dlen 14                          #259 [hci0] 103.514121
>      L2CAP: Configure Response (0x05) ident 7 len 6
>        Source CID: 65
>        Flags: 0x0000
>        Result: Success (0x0000)
> 
> Signed-off-by: Florian Dollinger <dollinger.florian@gmx.de>
> Co-developed-by: Florian Dollinger <dollinger.florian@gmx.de>
> ---
> net/bluetooth/l2cap_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

