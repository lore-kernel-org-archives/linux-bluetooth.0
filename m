Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFDC0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 11:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B32214AF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGFLBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 07:01:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42138 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGFLBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 07:01:39 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA9BFCEFAE;
        Sat,  6 Jul 2019 13:10:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth:: btrtl: Add support for RTL8723DU
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190529181234.12744-1-Larry.Finger@lwfinger.net>
Date:   Sat, 6 Jul 2019 13:01:37 +0200
Cc:     "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D352CD85-84BE-4B4C-A051-F9C9FA297907@holtmann.org>
References: <20190529181234.12744-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Larry,

> This device is functionally equivalent to the BT part of the RTL8723DE,
> uses the same firmware, but the LMP subversion and HCI revision are unique.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/btrtl.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

