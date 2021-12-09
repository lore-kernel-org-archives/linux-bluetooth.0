Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 10:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhLIK6x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:58:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42399 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhLIK6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 05:58:53 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 357F5CECD4;
        Thu,  9 Dec 2021 11:55:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_sync: Fix not always pausing
 advertising when necessary
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211208234325.521207-1-luiz.dentz@gmail.com>
Date:   Thu, 9 Dec 2021 11:55:18 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E1C65891-BE5E-46B0-893D-05069855D0C6@holtmann.org>
References: <20211208234325.521207-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> hci_pause_advertising_sync shall always pause advertising until
> hci_resume_advertising_sync but instance 0x00 doesn't count
> in adv_instance_cnt so it was causing it to be skipped.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Add fix for l2cap-tester direct advertising test cases which was caused
> by hci_pause_advertising_sync not pausing advertising when instance 0x00 is
> used.
> v3: Fix CI findings.
> 
> net/bluetooth/hci_sync.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

