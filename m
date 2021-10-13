Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35592C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B58D610E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhJMMbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:31:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51356 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhJMMbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:04 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8BFAACECF6;
        Wed, 13 Oct 2021 14:29:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: Fix debugfs entry leak in hci_register_dev()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013085546.101615-1-weiyongjun1@huawei.com>
Date:   Wed, 13 Oct 2021 14:29:00 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A80515D1-03BE-46F5-8522-20DD6A4A8E04@holtmann.org>
References: <20211013085546.101615-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wei,

> Fault injection test report debugfs entry leak as follows:
> 
> debugfs: Directory 'hci0' with parent 'bluetooth' already present!
> 
> When register_pm_notifier() failed in hci_register_dev(), the debugfs
> create by debugfs_create_dir() do not removed in the error handing path.
> 
> Add the remove debugfs code to fix it.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

