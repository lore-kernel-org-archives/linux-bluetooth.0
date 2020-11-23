Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5AC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E4206FB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgKWLzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:55:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33125 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgKWLzQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:55:16 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id A86B7CECD0;
        Mon, 23 Nov 2020 13:02:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [Patch v3] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201116155626.GA27472@jimmy-ryzen-home>
Date:   Mon, 23 Nov 2020 12:55:13 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CB6C0CB2-89E2-451B-9EC1-1DA6978DC945@holtmann.org>
References: <20201116155626.GA27472@jimmy-ryzen-home>
To:     Jimmy Wahlberg <jimmywa@spotify.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jimmy,

> This test case is meant to verify that multiple
> unknown options is included in the response.
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part A
> page 1057
> 
> 'On an unknown option failure (Result=0x0003),
> the option(s) that contain anoption type field that is not
> understood by the recipient of the L2CAP_CONFIGURATION_REQ
> packet shall be included in the L2CAP_CONFIGURATION_RSP
> packet unless they are hints.'
> 
> Before this patch:
> 
>> ACL Data RX: Handle 11 flags 0x02 dlen 24
>      L2CAP: Configure Request (0x04) ident 18 len 16
>        Destination CID: 64
>        Flags: 0x0000
>        Option: Unknown (0x10) [mandatory]
>        10 00 11 02 11 00 12 02 12 00
> < ACL Data TX: Handle 11 flags 0x00 dlen 17
>      L2CAP: Configure Response (0x05) ident 18 len 9
>        Source CID: 64
>        Flags: 0x0000
>        Result: Failure - unknown options (0x0003)
>        Option: Unknown (0x10) [mandatory]
>        12
> 
> After this patch:
> 
>> ACL Data RX: Handle 11 flags 0x02 dlen 24
>      L2CAP: Configure Request (0x04) ident 5 len 16
>        Destination CID: 64
>        Flags: 0x0000
>        Option: Unknown (0x10) [mandatory]
>        10 00 11 02 11 00 12 02 12 00
> < ACL Data TX: Handle 11 flags 0x00 dlen 23
>      L2CAP: Configure Response (0x05) ident 5 len 15
>        Source CID: 64
>        Flags: 0x0000
>        Result: Failure - unknown options (0x0003)
>        Option: Unknown (0x10) [mandatory]
>        10 11 01 11 12 01 12
> 
> Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

