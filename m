Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22DDECE599
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CD020854
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbfJPTR5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:17:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41098 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJPTR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:17:57 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id E0E71CECDE;
        Wed, 16 Oct 2019 21:26:53 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Bluetooth: Workaround hd directed advertising bug in
 Broadcom controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191002122243.31519-1-szymon.janc@codecoup.pl>
Date:   Wed, 16 Oct 2019 21:17:54 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        =?utf-8?Q?S=C3=B6ren_Beye?= <linux@hypfer.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <6C0D0A41-21F4-45CF-B21C-ED9A46A989C6@holtmann.org>
References: <20191002122243.31519-1-szymon.janc@codecoup.pl>
To:     Szymon Janc <szymon.janc@codecoup.pl>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

> It appears that some Broadcom controllers (eg BCM20702A0) reject LE Set
> Advertising Parameters command if advertising intervals provided are not
> within range for undirected and low duty directed advertising.
> 
> Workaround this bug by populating min and max intervals with 'valid'
> values.
> 
> < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15                                                                                                                                                                                                                                      #75 [hci0] 29.155775
>        Min advertising interval: 0.000 msec (0x0000)
>        Max advertising interval: 0.000 msec (0x0000)
>        Type: Connectable directed - ADV_DIRECT_IND (high duty cycle) (0x01)
>        Own address type: Public (0x00)
>        Direct address type: Random (0x01)
>        Direct address: E2:F0:7B:9F:DC:F4 (Static)
>        Channel map: 37, 38, 39 (0x07)
>        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                                                                                                                                                                                                                                             #76 [hci0] 29.156745
>      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>        Status: Invalid HCI Command Parameters (0x12)
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> Tested-by: Sören Beye <linux@hypfer.de>
> ---
> net/bluetooth/hci_conn.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

