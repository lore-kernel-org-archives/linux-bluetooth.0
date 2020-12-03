Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E088C433C1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15140206F6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgLCNyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:54:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38589 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLCNyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:54:06 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id AEA32CECFC;
        Thu,  3 Dec 2020 15:00:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v8 2/5] Bluetooth: btusb: Add *setup* function for new
 generation Intel controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201119113943.13839-2-kiran.k@intel.com>
Date:   Thu, 3 Dec 2020 14:53:21 +0100
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A7B88502-F46D-4CC0-B95B-966BA6AB7864@holtmann.org>
References: <20201119113943.13839-1-kiran.k@intel.com>
 <20201119113943.13839-2-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Define a new  *setup* function for new generation Intel controllers
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> Changes in v8:
> * fix review comments
> * create a separate patch to fix issue reported for endianness
> 
> Changes in v7:
> * split code in to multiple patches
> 
> Changes in v6:
> * Revert to v4
> * Move TyphoonPeak controller mapping to BTUSB_INTEL_NEWGEN to
>  a separte patch
> 
> Changes in v5:
> * Remove BTUSB_INTEL_NEWGEN and use usb vid/pid combination to
>  identify controller type
> 
> Changes in v4:
> * Rebase patchset
> * Fix indentation issues
> * make btusb_setup_intel_new_get_fw_name to return void as return value is
>  not getting used
> 
> Changes in v3:
> * Combine the two patches in v2 series to one to avoid compiler warnings
>   reported by kernel bot (lkp)
> 
> Changed in v2:
> * Fix typo in commit message
> drivers/bluetooth/btusb.c | 141 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 141 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

