Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF8C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7D420756
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 11:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKKLFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:05:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59507 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKLFN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 06:05:13 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 011FCCECFD;
        Wed, 11 Nov 2020 12:12:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Add compatible string for BCM4389
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201014054325.2407-1-amitesh.chandra@gmail.com>
Date:   Wed, 11 Nov 2020 12:05:11 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        amitesh.chandra@broadcom.com, ravi.nagarajan@broadcom.com,
        cheneyni@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <1559685E-4A1D-4D64-AF52-42D9E99BD4AB@holtmann.org>
References: <20201014054325.2407-1-amitesh.chandra@gmail.com>
To:     Amitesh Chandra <amitesh.chandra@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amitesh,

> Add compatible string match to the serdev driver for the
> BCM4389 Bluetooth controller
> 
> Signed-off-by: Amitesh Chandra <amitesh.chandra@broadcom.com>
> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)

The series no longer applies cleanly to bluetooth-next tree. Please resend.

Regards

Marcel

