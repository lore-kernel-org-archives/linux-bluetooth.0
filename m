Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE788C54E4A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB05208E4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589063089;
	bh=csKn5pMKKsdGBHIVzMfqtPPgiYL/8jOEUMPz2JD7aRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dFdBaeJooxWdyEdJDCX6E+yi2kOrw3NhXy6Eq/eHDCT60laqvRHH0sAxM8mCHjT/m
	 nLxMHKV1K3VzbNecSNv2iReu32hxjLloSuhLIJDapZCfMfkEFQYyDRMMO/YwEjw21+
	 KjV4o+uoEnNB1dDvfvRVOvAqvwwPPOsHewshQz78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEIWYr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 May 2020 18:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgEIWYr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 May 2020 18:24:47 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9E7208E4;
        Sat,  9 May 2020 22:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589063086;
        bh=csKn5pMKKsdGBHIVzMfqtPPgiYL/8jOEUMPz2JD7aRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TuGkSwZylT3EKdr1L+6NwqpHm++78h0kk9137PycrCbWFTXQTb4D66NvFcxePrYJ2
         BYSHt4MrwtoJ2C08e4aAZB19uYBd1VI4WDb4PdSo8eTBClG3qhDfIRbCgfhPzyq4tf
         0xrCouFyJ+cmSf+u3udqfttYTABLW5AYVT7fDPSU=
Date:   Sat, 9 May 2020 15:24:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2020-05-09
Message-ID: <20200509152445.262a84f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200509184928.GA26120@jhedberg-mac01.local>
References: <20200509184928.GA26120@jhedberg-mac01.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 9 May 2020 21:49:28 +0300 Johan Hedberg wrote:
> Hi Dave,
> 
> Here's another set of Bluetooth patches for the 5.8 kernel:
> 
>  - Add support for Intel Typhoon Peak device (8087:0032)
>  - Add device tree bindings for Realtek RTL8723BS device
>  - Add device tree bindings for Qualcomm QCA9377 device
>  - Add support for experimental features configuration through mgmt
>  - Multiple fixes & cleanups to the btbcm driver
>  - Add support for LE scatternet topology for selected devices
>  - A few other smaller fixes & cleanups
> 
> Please let me know if there are any issues pulling. Thanks.

Is your tree immutable, is there a chance you could still get the missing sign-off?

Commit bf1f79470a62 ("Bluetooth: btusb: Add support for Intel Bluetooth Device Typhoon Peak (8087:0032)")
	author Signed-off-by missing
	author email:    raghuram.hegde@intel.com
	committer email: marcel@holtmann.org
	Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
	Signed-off-by: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>
	Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Also, in the same patch:

---------------------------------------------------------------
0015-Bluetooth-btusb-Add-support-for-Intel-Bluetooth-Devi.patch
---------------------------------------------------------------
ERROR: code indent should use tabs where possible
#55: FILE: drivers/bluetooth/btusb.c:346:
+                                                     BTUSB_WIDEBAND_SPEECH},$

WARNING: please, no spaces at the start of a line
#55: FILE: drivers/bluetooth/btusb.c:346:
+                                                     BTUSB_WIDEBAND_SPEECH},$

WARNING: Missing Signed-off-by: line by nominal patch author '"Hegde, Raghuram" <raghuram.hegde@intel.com>'

total: 1 errors, 2 warnings, 0 checks, 8 lines checked


And:

------------------------------------------------------------
0016-dt-bindings-net-bluetooth-Add-rtl8723bs-bluetooth.patch
------------------------------------------------------------
WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
#23: FILE: Documentation/devicetree/bindings/net/realtek-bluetooth.yaml:1:
+# SPDX-License-Identifier: GPL-2.0

total: 0 errors, 2 warnings, 0 checks, 54 lines checked

---------------------------------------------------------------
0026-Bluetooth-Introduce-debug-feature-when-dynamic-debug.patch
---------------------------------------------------------------
WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
#99: FILE: net/bluetooth/lib.c:212:
+	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);

WARNING: Missing a blank line after declarations
#135: FILE: net/bluetooth/mgmt.c:3740:
+		u32 flags = bt_dbg_get() ? BIT(0) : 0;
+		memcpy(rp->features[idx].uuid, debug_uuid, 16);

WARNING: Missing a blank line after declarations
#173: FILE: net/bluetooth/mgmt.c:3788:
+			bool changed = bt_dbg_get();
+			bt_dbg_set(false);

WARNING: 'Paramters' may be misspelled - perhaps 'Parameters'?
#197: FILE: net/bluetooth/mgmt.c:3812:
+		/* Paramters are limited to a single octet */

total: 0 errors, 5 warnings, 0 checks, 188 lines checked
