Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Oct 2021 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F7B60C4C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Oct 2021 18:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbhJQSHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Oct 2021 14:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhJQSHP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Oct 2021 14:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3498460F70
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Oct 2021 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634493905;
        bh=yrc2xT02W9cFRAjZRjvHFyXhlWGFvhSS/5f6fixmeLg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LTndkZS1QnE6LxKS0SGiGmox2A4eDXGJlFhXy/sSmvmDvKmJidayGUu8aiolgkQFg
         zNuPcFW2TIZxXuzkqK+eWdIMjAwr9TrWCkWF3Zvbjjl5+mDnfoBHnuCPCWCDydxRLa
         e5p80r6hpnjRHWtSuX2JCC+H+niJCRI2fV749zeJRxsGs8qlQPAjw/PGO2BBkXxVom
         aOyFN3Qo50FpftAZsQsADAMndhSCkD/M9DMSHTr6pDxpdGSqLwpJJGiXiQPTsa8Vts
         +qvWJAdTBTDnAHOlygHpn4whNnTtN1gOl/U+UAIzYD0QO9TMTWdmJi5UW89R2/kdF7
         WARAyhonVc09A==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sun, 17 Oct 2021 18:05:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gbin@gootz.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-EqhONenYdh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #13 from Guillaume Binet (gbin@gootz.net) ---
I continued to investigate. The major difference between a cold boot and a =
warm
boot is the driver trying to load a firmware.

For the science, I just disabled this behavior and it looks like the device=
 and
driver recover on a warm boot. Consider this a workaround and not a fix but=
 at
least it works for me, bluetooth is available on a warm boot.

```
pal =E2=9E=9C  linux-5.14.12  diff -u drivers/bluetooth/btintel.c.old
drivers/bluetooth/btintel.c=20
--- drivers/bluetooth/btintel.c.old     2021-10-17 13:56:23.583338189 -0400
+++ drivers/bluetooth/btintel.c 2021-10-17 14:01:16.113344330 -0400
@@ -1034,17 +1034,6 @@
                /* Skip reading firmware file version in bootloader mode */
                if (ver->fw_variant =3D=3D 0x06)
                        break;
-
-               /* Skip download if firmware has the same version */
-               if (btintel_firmware_version(hdev, ver->fw_build_num,
-                                            ver->fw_build_ww,
ver->fw_build_yy,
-                                            fw, boot_param)) {
-                       bt_dev_info(hdev, "Firmware already loaded");
-                       /* Return -EALREADY to indicate that the firmware h=
as
-                        * already been loaded.
-                        */
-                       return -EALREADY;
-               }
        }

        /* The firmware variant determines if the device is in bootloader
@@ -1074,21 +1063,6 @@
        int err;
        u32 css_header_ver;

-       /* Skip reading firmware file version in bootloader mode */
-       if (ver->img_type !=3D 0x01) {
-               /* Skip download if firmware has the same version */
-               if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
-                                            ver->min_fw_build_cw,
-                                            ver->min_fw_build_yy,
-                                            fw, boot_param)) {
-                       bt_dev_info(hdev, "Firmware already loaded");
-                       /* Return -EALREADY to indicate that firmware has
-                        * already been loaded.
-                        */
-                       return -EALREADY;
-               }
-       }
-
        /* The firmware variant determines if the device is in bootloader
         * mode or is running operational firmware. The value 0x01 identifi=
es
         * the bootloader and the value 0x03 identifies the operational
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
