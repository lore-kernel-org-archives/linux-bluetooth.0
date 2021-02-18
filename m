Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52634C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0561160C3D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBROAI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 09:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232558AbhBRMjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 07:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613651853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Uj3d7AX4kCZzCan+7I9KfL3//X8k0tnB3epM9LTHA88=;
        b=SZrp2QIIfN7Cz+AXcEVC72Q9xEdIVa2SaxPnetYzWT8Ha/LHgi35QN91FVY/OxEMTdunb8
        KcSIy1xkCEIrW1WxUglFNTVEskrgmcX14/Y/oDkAI+2fRWfXg2rVyNStFF/NDlcgKDHWhF
        zYEhSvDrVqty+X6dLL/J2zgzW58I03k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-IQiO_pQXP1CxR5FbF86N1A-1; Thu, 18 Feb 2021 07:37:31 -0500
X-MC-Unique: IQiO_pQXP1CxR5FbF86N1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8219E108C312;
        Thu, 18 Feb 2021 12:37:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6181060917;
        Thu, 18 Feb 2021 12:37:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.12 regression fix 0/1] Bluetooth: btusb: Revert "Fix the autosuspend enable and disable"
Date:   Thu, 18 Feb 2021 13:37:27 +0100
Message-Id: <20210218123728.17067-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

From the commit msg:

"""
drivers/usb/core/hub.c: usb_new_device() contains the following:

        /* By default, forbid autosuspend for all devices.  It will be
         * allowed for hubs during binding.
         */
        usb_disable_autosuspend(udev);

So for anything which is not a hub, such as btusb devices, autosuspend is
disabled by default and we MUST call usb_enable_autosuspend(udev) to
enable it.

This means that the "Fix the autosuspend enable and disable" commit,
which drops the usb_enable_autosuspend() call when the enable_autosuspend
module option is true, is completely wrong, revert it.
"""

Hui, I guess that what you were seeing is caused by:
/lib/udev/hwdb.d/60-autosuspend-chromiumos.hwdb

Which enables autosuspend on a bunch of USB devices based on VID:PID,
overruling the kernel defaults. This is done to get better power-consumption
with devices where it is known that it is safe to do this.
 
I guess that that the device you were testing this with is on that list.
So the proper fix would be to edit that file and remove your VID:PID from it.

Hui, also next time please try to Cc the original author of the code you
are modifying. A simple "git blame drivers/bluetooth/btusb.c" would have
found you commit eff2d68ca738 ("Bluetooth: btusb: Add a Kconfig option to
enable USB autosuspend by default") and then you could have added me to
the Cc and I could have nacked the patch before it got merged.

I happen to spot this this time since I was looking into some other
btusb issue. But if I had not spotted this, this would have caused
a significant power-consumption regression on many laptops.

Btusb might not look like a big consumer, but if it does not autosuspend
it often is the only USB device not autosuspending, keeping the XHCI
controller awake, which in turn is keeping a whole power-plane awake on
what once used to be the southbridge. At least on Skylake era hw this
could lead to an extra idle powerconsumption of 1W. So a small change
can cause a big impact.

Regards,

Hans
   

