Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A00FA3735
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 11:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1952082C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 11:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502174AbfJQLvs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:51:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58072 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfJQLvs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 07:51:48 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id A519ACECE6;
        Thu, 17 Oct 2019 14:00:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v6] Bluetooth: btusb: Trigger Intel FW download error
 recovery
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1571300549-27306-1-git-send-email-amit.k.bag@intel.com>
Date:   Thu, 17 Oct 2019 13:51:46 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <113CA53A-9FB7-4793-B2C4-828B185C4853@holtmann.org>
References: <1571300549-27306-1-git-send-email-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> Sometimes during FW data download stage, in case of an error is
> encountered the controller device could not be recovered. To recover
> from such failures send Intel hard Reset to re-trigger FW download in
> following error scenarios:
> 
> 1. Intel Read version command error
> 2. Firmware download timeout
> 3. Failure in Intel Soft Reset for switching to operational FW
> 4. Boot timeout for switching to operaional FW
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btintel.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h |  6 ++++++
> drivers/bluetooth/btusb.c   | 20 ++++++++++++++++----
> 3 files changed, 68 insertions(+), 4 deletions(-)

So this patch has a bunch of errors

Applying: Bluetooth: btusb: Trigger Intel FW download error recovery
.git/rebase-apply/patch:97: trailing whitespace.
		btintel_reset_to_bootloader(hdev);	
warning: 1 line adds whitespace errors.

  CC      drivers/bluetooth/btintel.o
drivers/bluetooth/btintel.c: In function ‘btintel_reset_to_bootloader’:
drivers/bluetooth/btintel.c:733:20: error: assignment of member ‘reset_type’ in read-only object
  733 |  params.reset_type = 0x01;
      |                    ^
drivers/bluetooth/btintel.c:734:22: error: assignment of member ‘patch_enable’ in read-only object
  734 |  params.patch_enable = 0x01;
      |                      ^
drivers/bluetooth/btintel.c:735:20: error: assignment of member ‘ddc_reload’ in read-only object
  735 |  params.ddc_reload = 0x01;
      |                    ^
drivers/bluetooth/btintel.c:736:21: error: assignment of member ‘boot_option’ in read-only object
  736 |  params.boot_option = 0x00;
      |                     ^
drivers/bluetooth/btintel.c:737:20: error: assignment of member ‘boot_param’ in read-only object
  737 |  params.boot_param = cpu_to_le32(0x00000000);
      |                    ^
drivers/bluetooth/btintel.c:716:6: warning: unused variable ‘boot_param’ [-Wunused-variable]
  716 |  u32 boot_param;
      |      ^~~~~~~~~~

I would really encourage to test the patch with git am and compile test it at least since these are obvious bugs.

Anyway, I manually fixed this up and applied to patch to bluetooth-next tree.

Regards

Marcel

