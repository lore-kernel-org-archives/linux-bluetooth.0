Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1118FC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2178206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAHUsL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:48:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41466 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgAHUsL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 15:48:11 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B425ACECFA;
        Wed,  8 Jan 2020 21:57:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] Bluetooth: hci_qca: Remove set but not used
 variable 'opcode'
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200108015431.51996-1-yuehaibing@huawei.com>
Date:   Wed, 8 Jan 2020 21:48:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Transfer-Encoding: 7bit
Message-Id: <ED15472A-FD5F-4D10-90F3-E6932CA28BA7@holtmann.org>
References: <20200108015431.51996-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yue,

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/bluetooth/hci_qca.c: In function 'qca_controller_memdump':
> drivers/bluetooth/hci_qca.c:980:6: warning:
> variable 'opcode' set but not used [-Wunused-but-set-variable]
> 
> It is never used since commit d841502c79e3 ("Bluetooth: hci_qca: Collect
> controller memory dump during SSR"), so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> drivers/bluetooth/hci_qca.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

