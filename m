Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FC260F13
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhHDOt1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:49:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38938 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDOt1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:49:27 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id AB38CCECD6;
        Wed,  4 Aug 2021 16:49:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 2/2] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip(MT7921)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210804090316.12080-2-mark-yw.chen@mediatek.com>
Date:   Wed, 4 Aug 2021 16:49:13 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com,
        apusaka@google.com, mcchou@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <F013475B-3F26-453F-A3C5-EFDD94703AEF@holtmann.org>
References: <20210804090316.12080-1-mark-yw.chen@mediatek.com>
 <20210804090316.12080-2-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> When the firmware hang or command no response, driver can reset the
> bluetooth mcu via USB to recovery it. The reset steps as follows.
> 
> 1. Cancel USB transfer requests before reset.
> 2. It use speicific USB HW Register to reset Bluetooth MCU, at the
>   same time, the USB Endpoint0 still keep alive.
> 3. Poll the USB HW register until reset is completed by Endpoint0.
> 4. To recovery unexpected USB state and behavior during resetting the
>   Bluetooth MCU, the driver need to reset the USB device for MT7921.
> 5. After the reset is completed, the Bluetooth MCU need to re-setup,
>   such as download patch, power-on sequence and etc.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> Reviewed-by: Michael Sun <michaelfsun@google.com>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> drivers/bluetooth/btusb.c | 129 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 129 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

