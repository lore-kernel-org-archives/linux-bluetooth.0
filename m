Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D6C4708E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 May 2021 00:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CD3610A6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 May 2021 00:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhE2AxX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 May 2021 20:53:23 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:50771 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhE2AxX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 May 2021 20:53:23 -0400
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 20:53:23 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4FsN0G4hLLzDRZ
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 May 2021 20:36:30 -0400 (EDT)
Received: from xps-7390 (ip70-164-222-119.oc.oc.cox.net [70.164.222.119])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FsN0F186HzQ5C;
        Fri, 28 May 2021 20:36:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1622248589; bh=JxdsPoOCRZs6f++m4Uh0jQn1jfP+LVG6TVWbtOFL3oM=;
        h=Date:From:Reply-To:To:cc:Subject;
        b=bzKaMsj6FzV2cowVEABgOuxggSLrvDwh5QDrGq2TjZgLLCXl2bqDpQfgo92WJmTDC
         rvDJFWDSus6S3hFUu8CpoRagcIB6+RH6SbjDlYXiKvNi5zpLKEnwQux14ZVgCthXj1
         RMdAzgLX8vE4mNqzDECLpcEGYHVKkkQoqV84baUU=
Date:   Fri, 28 May 2021 17:36:28 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     luiz.von.dentz@intel.com
cc:     tedd.an@intel.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Subject: Commit 9b16bfbf41 ("Bluetooth: btintel: Move operational checks
 after version check") causing BT FW loading problems
Message-ID: <42d9c52a-bcc9-13e6-9b1d-d9a94ff2889f@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


My BT device is (apparently a Jefferson Peak device):

>> Bus 003 Device 003: ID 8087:0026 Intel Corp.

With this commit in place, loading the BT firmware after a cold start fails
attempting to load the wrong(?) firmware:

----
Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
bluetooth hci0: Direct firmware load for intel/ibt-19-16-0.sfi failed with error -2
Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-16-0.sfi (-2)
----

... and a "git log" in the linux-firmware repo shows this file "ibt-19-16-0.sfi"
never existed. Before this commit it was trying to load:

----
Bluetooth: hci0: Bootloader revision 0.4 build 0 week 11 2017
Bluetooth: hci0: Device revision is 2
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1642369 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 17881 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-32-4.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
Bluetooth: hci0: MSFT filter_enable is already on
----

Let me know if anyone needs more info.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
