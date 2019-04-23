Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5433C10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CD6208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDWRLn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:11:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48066 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfDWRLm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 13:11:42 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 39026CF2F8;
        Tue, 23 Apr 2019 19:19:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Add entry for BCM2076B1 UART
 Bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190305130901.56660-1-stephan@gerhold.net>
Date:   Tue, 23 Apr 2019 19:11:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C5A84ED0-70EE-4A4C-8167-CCBD411E4764@holtmann.org>
References: <20190305130901.56660-1-stephan@gerhold.net>
To:     Stephan Gerhold <stephan@gerhold.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stephan,

> Add the device ID for the BT/FM/GPS combo chip BCM2076 (rev B1)
> used in the AMPAK AP6476 WiFi/BT/FM/GPS module.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

