Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C92C4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 15:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCD6610FB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 15:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhHBPFq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:05:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34244 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhHBPFq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 11:05:46 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id B92E9CED0B;
        Mon,  2 Aug 2021 17:05:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Enable MSFT extension for Mediatek
 Chip (MT7921)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210802125941.29078-1-mark-yw.chen@mediatek.com>
Date:   Mon, 2 Aug 2021 17:05:33 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com,
        apusaka@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <838E84AB-1F38-45A3-A5B7-27CE134FFD49@holtmann.org>
References: <20210802125941.29078-1-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> The Mdiatek MT7921(7961) support MSFT HCI extensions, we are using
> 0xFD30 for VsMsftOpCode.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

