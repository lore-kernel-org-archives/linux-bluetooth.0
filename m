Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B193C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354044AbhLCVgq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:36:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46797 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354019AbhLCVgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:36:45 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 326BBCED20;
        Fri,  3 Dec 2021 22:33:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4 1/4] Bluetooth: MGMT: Use
 hci_dev_test_and_{set,clear}_flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201194952.1537811-1-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:33:20 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <63F3E6B9-5674-49F3-A795-710BF91CB1DC@holtmann.org>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This make use of hci_dev_test_and_{set,clear}_flag instead of doing 2
> operations in a row.
> 
> Fixes: cbbdfa6f33198 ("Bluetooth: Enable controller RPA resolution using Experimental feature")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fix marking Device Privacy Flag even when adapter is not capable of
> handling Set Privacy Mode.
> v3: Add patch for using hci_dev_test_and_{set,clear}_flag and split
> changes reworking how HCI_CONN_FLAG_REMOTE_WAKEUP is set and make use of
> bitmap to store the supported flags.
> v4: Add Fixes to 1/4, address comments of 2/4 removing changes to
> hci_dev_*_flags and moving privacy_mode_capable to 3/4 which makes use of it.
> 
> net/bluetooth/mgmt.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

