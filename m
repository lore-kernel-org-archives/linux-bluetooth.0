Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A29AC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E55214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfA2PR2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:17:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34985 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2PR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 10:17:28 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9936ECF2C3;
        Tue, 29 Jan 2019 16:25:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [Patch v1] btusb: Add shutdown routine for BTUSB_INTEL_NEW
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1548764688-5429-1-git-send-email-raghuram.hegde@intel.com>
Date:   Tue, 29 Jan 2019 16:17:26 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <C15CC489-9116-4FAB-868E-17DE935345AC@holtmann.org>
References: <1548764688-5429-1-git-send-email-raghuram.hegde@intel.com>
To:     Raghuram Hegde <raghuram.hegde@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raghuram,

> Observation:
> If BT operations (Eg:BREDR inquiry/LE scan) were triggered
> through the stack, followed by BT turn off through
> 'hciconfig hci0 down', the controller would still be active
> and consume power.
> Also, there is a possibility that a race condition/
> synchronization issue might arise on the subsequent BT turn
> on, as the controller might try to push the
> events that were queued up before processing the HCI Reset
> command.
> 
> btusb_shutdown_intel_new routine shall reset the controller
> and stop all BT operation.
> Advantages:
> 	1. Power save on the platform
> 	2. Host and controller will be in Sync.
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

