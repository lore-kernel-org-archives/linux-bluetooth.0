Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3851EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5DF20787
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgERH7s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 03:59:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43617 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERH7s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 03:59:48 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 256C1CECE2;
        Mon, 18 May 2020 10:09:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] bluetooth/smp: Fix for GAP/SEC/SEM/BI-10-C
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200513081853.362-1-lukasz.rymanowski@codecoup.pl>
Date:   Mon, 18 May 2020 09:59:47 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <86292E0B-2816-414C-82FD-7ACFFD4C9587@holtmann.org>
References: <20200513081853.362-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lukasz,

> Security Mode 1 level 4, force us to use have key size 16 octects long.
> This patch adds check for that.
> 
> This is required for the qualification test GAP/SEC/SEM/BI-10-C
> 
> Logs from test when ATT is configured with sec level BT_SECURITY_FIPS
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11                                                                       #28 [hci0] 3.785965
>      SMP: Pairing Request (0x01) len 6
>        IO capability: DisplayYesNo (0x01)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey Sign (0x05)
>        Responder key distribution: EncKey IdKey Sign (0x07)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11                                                                       #35 [hci0] 3.883020
>      SMP: Pairing Response (0x02) len 6
>        IO capability: DisplayYesNo (0x01)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
>        Max encryption key size: 7
>        Initiator key distribution: EncKey Sign (0x05)
>        Responder key distribution: EncKey IdKey Sign (0x07)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6                                                                        #36 [hci0] 3.883136
>      SMP: Pairing Failed (0x05) len 1
>        Reason: Encryption key size (0x06)
> 
> Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
> ---
> net/bluetooth/smp.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

