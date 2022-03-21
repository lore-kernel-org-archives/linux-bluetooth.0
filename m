Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48839C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 12:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347554AbiCUM4r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCUM4q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 08:56:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67394ECE7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 05:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFFDB815DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 12:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37ACCC340E8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647867317;
        bh=IJ98coHESuTd4va8gcEA/zAGXwn+ymd1hJvAwmfPkVM=;
        h=From:To:Subject:Date:From;
        b=UtILfUFF+COxk5aHPTNnBXGDJm+v4iFVtACXD59INrN6gr+AXcuiMrKxOuXfPIo/3
         6ZNaHQOw5b6vy0tXwyBFZW3oOZjZErVh1F7fSWCVAA/0ALODriIOixYiBhjymqNL9S
         TaNaePV1L9eT/bXUTzXMpvM5YwdIvcQPyyFhktauLmODTOYLNBxpKcSK0+VO+IbJXc
         YQ9aTjTlMBASbOy6qgkRhX4xjre77TyN/VA13JkhuCn7mOPKVD+5xCHZedZZr/qT8t
         jtlh5Ql6ZndK3XRp4osXSIE7A24v6AvYfFxGvbU+zlbJbt+FAIFWtiuCvn+KdUIPKQ
         3N0rvrU6bF/og==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A990C05F98; Mon, 21 Mar 2022 12:55:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New: New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Mon, 21 Mar 2022 12:55:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215713-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215713

            Bug ID: 215713
           Summary: New (useless?) warning messages from BlueTooth in
                    kernel 5.17
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

I've just upgraded from 5.15.30 to 5.17 and now upon pairing my BT headphon=
es I
see brand new warning messages I've never seen before:

Bluetooth: hci0: unexpected event 0xff length: 25 > 0
Bluetooth: hci0: unexpected event 0xff length: 4 > 0

I wonder if it's a kernel bug or it's a valid message.=20

The BT headphones work without any issues though.

The device is 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter.

# lsmod | grep bt
btusb                  40960  0
btbcm                  20480  1 btusb
btintel                32768  1 btusb
bluetooth             471040  52 btintel,btbcm,bnep,btusb,rfcomm

# dmesg -t | egrep -i "bt|blue"=20
Bluetooth: Core ver 2.22
NET: Registered PF_BLUETOOTH protocol family
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
usbcore: registered new interface driver btusb
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 86-46.21
Bluetooth: hci0: Firmware already loaded
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: hci0: unexpected event 0xff length: 25 > 0
Bluetooth: hci0: unexpected event 0xff length: 4 > 0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
