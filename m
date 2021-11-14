Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6305C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57F161073
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhKNLXo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Nov 2021 06:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233469AbhKNLXj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Nov 2021 06:23:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 066BC61167
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636888841;
        bh=RdeQEh5chgrYnHTQQ5X14j2fgrB8EifCgk4E2CPRDMA=;
        h=From:To:Subject:Date:From;
        b=A0OoPBWclWF+ofLducaBtV4qqDSmtJYqNiJH5eEkWGzd8yG/amD0fMykChQ6pYOMX
         b7jLYI2iyUXsFJB2y3LLFRjgimsbB+TPEqPVQ5e1oTVTeV/enCdgqaCDOV3O9v/nGi
         MBayvyMnjG1rfeT0lz2mKbK75kTxuDpKaMsII6dpR7kVDZD5TKINz5Ro50Oww/9FpV
         7cC57fv/nwggpR2mN82jIRGctU6X8y7FR0GqxChuT812zlCRIIAB/wL6GNK8wXQdS/
         DEWraSn03/BkmXpcUtkqSL47SnlQxyZyUgEG4/aDXQ4x0trVkZomCoqqtdL24vrMm5
         nPLW97qt+xzHQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215015] New: rtl8723bs restarting loop
Date:   Sun, 14 Nov 2021 11:20:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: serg@podtynnyi.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215015

            Bug ID: 215015
           Summary: rtl8723bs restarting loop
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.2
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: serg@podtynnyi.com
        Regression: No

Using tablet on Intel Atom platform cherry trail with rtl8723bs, Arch Linux
distro. After kernel update to the 5.15.2 Bluetooth constantly turning on a=
nd
off as seen in logs switching back to 5.14.16 solves the issue.

```
Nov 13 10:44:41 talos systemd[1]: systemd-rfkill.service: Deactivated
successfully.
Nov 13 10:44:43 talos systemd[1]: Starting Load/Save RF Kill Switch Status.=
..
Nov 13 10:44:43 talos systemd[1]: Stopped target Bluetooth Support.
Nov 13 10:44:43 talos systemd[1]: Started Load/Save RF Kill Switch Status.
Nov 13 10:44:44 talos kernel: Bluetooth: hci0: RTL: examining hci_ver=3D06
hci_rev=3D000b lmp_ver=3D06 lmp_subver=3D8723
Nov 13 10:44:44 talos kernel: Bluetooth: hci0: RTL: rom_version status=3D0
version=3D1
Nov 13 10:44:44 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_fw.bin
Nov 13 10:44:44 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_config-OBDA8723.bin
Nov 13 10:44:44 talos systemd[1]: Reached target Bluetooth Support.
Nov 13 10:44:44 talos systemd[460]: Reached target Bluetooth.
Nov 13 10:44:44 talos kernel: Bluetooth: hci0: RTL: cfg_sz 64, total sz 245=
08
Nov 13 10:44:45 talos kernel: Bluetooth: hci0: RTL: fw version 0x365d462e
Nov 13 10:44:49 talos systemd[1]: systemd-rfkill.service: Deactivated
successfully.
Nov 13 10:44:49 talos systemd[1]: systemd-hostnamed.service: Deactivated
successfully.
Nov 13 10:44:52 talos systemd[460]: Stopped target Bluetooth.
Nov 13 10:44:52 talos systemd[1]: Starting Load/Save RF Kill Switch Status.=
..
Nov 13 10:44:52 talos systemd[1]: Stopped target Bluetooth Support.
Nov 13 10:44:52 talos systemd[1]: Started Load/Save RF Kill Switch Status.
Nov 13 10:44:53 talos kernel: Bluetooth: hci0: RTL: examining hci_ver=3D06
hci_rev=3D000b lmp_ver=3D06 lmp_subver=3D8723
Nov 13 10:44:53 talos kernel: Bluetooth: hci0: RTL: rom_version status=3D0
version=3D1
Nov 13 10:44:53 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_fw.bin
Nov 13 10:44:53 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_config-OBDA8723.bin
Nov 13 10:44:53 talos systemd[1]: Reached target Bluetooth Support.
Nov 13 10:44:53 talos systemd[460]: Reached target Bluetooth.
Nov 13 10:44:53 talos kernel: Bluetooth: hci0: RTL: cfg_sz 64, total sz 245=
08
Nov 13 10:44:54 talos kernel: Bluetooth: hci0: RTL: fw version 0x365d462e
Nov 13 10:44:58 talos systemd[1]: systemd-rfkill.service: Deactivated
successfully.
Nov 13 10:45:01 talos systemd[460]: Stopped target Bluetooth.
Nov 13 10:45:01 talos systemd[1]: Starting Load/Save RF Kill Switch Status.=
..
Nov 13 10:45:01 talos systemd[1]: Stopped target Bluetooth Support.
Nov 13 10:45:01 talos systemd[1]: Started Load/Save RF Kill Switch Status.
Nov 13 10:45:01 talos kernel: Bluetooth: hci0: RTL: examining hci_ver=3D06
hci_rev=3D000b lmp_ver=3D06 lmp_subver=3D8723
Nov 13 10:45:01 talos kernel: Bluetooth: hci0: RTL: rom_version status=3D0
version=3D1
Nov 13 10:45:01 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_fw.bin
Nov 13 10:45:01 talos kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8723bs_config-OBDA8723.bin
Nov 13 10:45:01 talos systemd[460]: Reached target Bluetooth.
Nov 13 10:45:01 talos systemd[1]: Reached target Bluetooth Support.
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
