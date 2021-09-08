Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E51A60F5E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 22:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhIHWlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241339AbhIHWlo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 18:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A29C0611BF
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631140835;
        bh=TCKkYWmWlBJLtAmfVWkFF3ngmGfn94S1O+K8lNZxJYY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=K59oEaw62j7J2OoW7+nQrbxMAaaNlUNHEpCmxR+y1HUebKHzvsZuhFGvRZXUXWajG
         VSBEO/YHWNM6Fe6RBzt5s2CHlW8RIkdMZjgxfN+CxgiZE+dQT5W4PX7KT7HEoMRgmN
         nWGWwVyGS94MHcMZObX7B0IxmfEadG6kNlG6lUlDG3ODe6uB2JtXsLrioEuhLt326P
         toj4Hfa6orvYCm9RQwEkA1hZbHlvTsBhca5H+eWpSLr+3W6f96N7wm4kfFCWJUMw3k
         ZG6F3g7po7OuaZ0+fZPpPVI5KAnKDcHpnZpb4iI58ATi8baDj93uPXBfDF+F9m+Jqr
         7G3hwaNglk92Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 08 Sep 2021 22:40:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-hllkETSSDH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

guimarcalsilva@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |guimarcalsilva@gmail.com

--- Comment #198 from guimarcalsilva@gmail.com ---
I tested it using a live image of Fedora Rawride from September 8 2021 with=
 the
development version of Kernel 5.15. The dongle is detected but I can't turn=
 it
on in the settings or in blueman:

[1125.221008] usb 1-4: USB disconnect, device number 14
[1130.356918] usb 1-4: new full-speed USB device number 15 using xhci_hcd
[1130.486202] usb 1-4: New USB device found, idVendor=3D0a12, idProduct-000=
1,
bcdDevice=3D25.20
[1130.486219] usb 1-4: New USB device strings: Mfr=3D0, Product=3D2, Serial=
Number=3D0
[1130.486227] usb 1-4: Product: CSR8510 A10
[1130.496424] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...=20
[1135.982384] Bluetooth: hci0: CSR: Failed to suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[1141.099165] Bluetooth: hci0: setting interface failed (110)

My dongle is packaged as a Bluetooth 5 device. Unfortunately I couldn't run
hciconfig because for some reason dnf refused to work on the live image. I'=
ll
try bringing more logs later.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
