Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE9C47254
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 05:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BF320857
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 05:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgEAFLh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 01:11:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47186 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgEAFLh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 01:11:37 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8562CCED1B;
        Fri,  1 May 2020 07:21:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Fix advertising handle is set to 0
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <35e52a8c25411e799a5ffece3e51c290c7dfb967.camel@linux.intel.com>
Date:   Fri, 1 May 2020 07:11:35 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A8F5EA6F-A3AC-4F4B-955E-3F6A74DC3CF4@holtmann.org>
References: <35e52a8c25411e799a5ffece3e51c290c7dfb967.camel@linux.intel.com>
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch fix the advertising handle is set to 0 regardless of actual
> instance value. The affected commands are LE Set Advertising Set Random
> Address, LE Set Extended Advertising Data, and LE Set Extended Scan
> Response Data commands.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> ---
> net/bluetooth/hci_request.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

seems the patch does not cleanly apply to bluetooth-next. Please update as needed.

Regards

Marcel

