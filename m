Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC21EC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEDB20789
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKIMlM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:41:12 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37019 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIMlM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 07:41:12 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20CDBCECC5;
        Mon,  9 Nov 2020 13:48:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201029074821.29950-1-sathish.narasimman@intel.com>
Date:   Mon, 9 Nov 2020 13:41:10 +0100
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <4DB44FB6-A6F3-4FBE-A16D-EE3FCB1A6F65@holtmann.org>
References: <20201029074821.29950-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> When adding device to white list the device is added to resolving list
> also. It has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
> HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
> to resolving list. use_ll_privacy macro is used only to check if controller
> supports LL_Privacy.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209745
> 
> Fixes: 0eee35bdfa3b ("Bluetooth: Update resolving list when updating whitelist")
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
> net/bluetooth/hci_request.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

