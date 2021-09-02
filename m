Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E0FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 13:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A356610CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhIBN5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhIBN5M (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 09:57:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3C981610CC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630590974;
        bh=RNmLfk2X5uP4bEN75RC4NTisRB4/pJwy0kptaYLQhps=;
        h=From:To:Subject:Date:From;
        b=jfQLb6F4pkfbpWxZHqPLxcF/HW10KdbTpAIV8qCRUPN7ouxmJqgv1hk5JSUG0LNgK
         83/lCEJVB6jzpcR8T6nAR3TFMbwKQW/Ltdq4VwkwlkZkl5CaI6+ps2sf+lzNZZFDDe
         Q7jnnL7ZfElZAd5Jrp7CnameeVqMZDJGTLFcKO4UQcRcu2IbAbIWD9DyA2O5cB7vx4
         hpwUpOUlgBALF38lnFK2coauk79RV6yXGGrlGKX9xNwr6FHBQq9NbEhGwY7KeCBRO9
         AT7B26nfOMCJ8UnbSSweS6js5Qv7QyMSIkZivgS3S4KTh7X+ex7Ve5KPDWiJLBc9It
         WRITWLZnaAy0Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214287] New: Bluetooth firmware rtl8671bu_fw.bin fails to load
Date:   Thu, 02 Sep 2021 13:56:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: tadej.obrstar@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214287-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214287

            Bug ID: 214287
           Summary: Bluetooth firmware rtl8671bu_fw.bin fails to load
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.14
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tadej.obrstar@gmail.com
        Regression: No

After upgrading to newest kernel, firmware for the usb bluetooth fails to l=
oad.

dmesg:
[    3.457128] usb 1-5.4: Product: Bluetooth Radio
[    3.467018] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000b
lmp_ver=3D0a lmp_subver=3D8761
[    3.467995] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[    3.467997] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[    3.468355] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761bu_fw=
.bin
failed with error -2
[    3.468356] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761bu_fw.bin =
not
found

lsusb:
Bus 001 Device 009: ID 0bda:2550 Realtek Semiconductor Corp. Bluetooth Radi=
o.

The firmware is built into the kernel (with a few others). It loaded
successfuly in kernel 5.13. The other firmware files (intel microcode, amd
poalris) still loads fine. Config file and firmware path hasn't changed from
previous version.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
