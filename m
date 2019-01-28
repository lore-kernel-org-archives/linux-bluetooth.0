Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0898CC282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD2D214DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA1MFD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:05:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39627 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfA1MFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 07:05:03 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 75D2ACF2B4;
        Mon, 28 Jan 2019 13:12:50 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] btusb: Add shutdown routine for BTUSB_INTEL_NEW devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1548665625-23742-1-git-send-email-raghuram.hegde@intel.com>
Date:   Mon, 28 Jan 2019 13:05:01 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <91F174CE-3CBE-4D3B-B0C9-E350C01F3DDF@holtmann.org>
References: <1548665625-23742-1-git-send-email-raghuram.hegde@intel.com>
To:     Raghuram Hegde <raghuram.hegde@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raghuram,

> btusb_shutdown_intel routine shall reset the controller
> and stop all BT operation.
> Advantages:
> 	1. Power save on the platform
> 	2. Host and controller will be in Sync.
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5de0c2e59b97..66483ca3d870 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3139,6 +3139,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->manufacturer = 2;
> 		hdev->send = btusb_send_frame_intel;
> 		hdev->setup = btusb_setup_intel_new;
> +		hdev->shutdown = btusb_shutdown_intel;
> 		hdev->hw_error = btintel_hw_error;
> 		hdev->set_diag = btintel_set_diag;
> 		hdev->set_bdaddr = btintel_set_bdaddr;

I assumed that this was only needed for the older ROM versions of the Intel controllers and not the newer RAM versions. I have been told they don’t inherit the LED issue that we tried to fix with this. Please read the comments in btusb_shutdown_intel and amend comments if needed and provide a detailed commit message.

Regards

Marcel

