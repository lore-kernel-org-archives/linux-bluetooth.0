Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01110C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A72611C2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 07:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhIJHaR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Sep 2021 03:30:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36830 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhIJHaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Sep 2021 03:30:16 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 714A2CED3D;
        Fri, 10 Sep 2021 09:29:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btintel: Fix incorrect out of memory check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210909123541.34779-1-colin.king@canonical.com>
Date:   Fri, 10 Sep 2021 09:29:04 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0826C6D5-F275-4E25-A3EE-D397C9BC9691@holtmann.org>
References: <20210909123541.34779-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> Currently *ven_data is being assigned the return from a kmalloc call but
> the out-of-memory check is checking ven_data and not *ven_data. Fix this
> by adding the missing dereference * operator,
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 70dd978952bc ("Bluetooth: btintel: Define a callback to fetch codec config data")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

