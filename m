Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DE38DD3
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449455; cv=none; b=bdcareXITDRiFYrpKt/TkE278aQ+hxuffvLsGKubx2aDRdi05AobJHkCzT4Fz0Bcudf9MytiiJio0w05sm0i0Atde8XO2Vyo2owKHWj58wfB+q+AA7NXqD82XmU5Dg7Pc9HgrGhyemet87sL0RofaQhqgA0Sf1oGSlEoPquMWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449455; c=relaxed/simple;
	bh=dbNfqyCnb6tyMcUk8RFGr4oNVmPaqT6/sRxSiNTbfoM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HDFlMOctxDobRUtiwL1xZ0oJ+iqKzEtN8hDwttqS7ChUPPCOFemp9iRVZPnA4IfYQeihMpoxqvPliJAqjtprARJFMTjLx3T3EJ2MhTGR70GTLScTEKdKiHFTMVYW1Cu9IIG6eGF8GPNURY5L/O3znyzK1mFXd/iDXw76HGxF7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDHHLP0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDHHLP0c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A307C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 04:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728449454;
	bh=dbNfqyCnb6tyMcUk8RFGr4oNVmPaqT6/sRxSiNTbfoM=;
	h=From:To:Subject:Date:From;
	b=aDHHLP0cSYW0dlm67f2tMjHc2jBpgOIsHAEgRh5/QhnihIAxtY1r+TpOvoHBJe1ib
	 K2jtni+DyEgQ1pBrLMEfdsQWCb9PH6yiaVvzuAuaf8rk1clfuYnqIpWzgCWmYMw4J7
	 Zt8FWvmYJuqYc5BU9DCSeD2d8XC0VaE4WKAP9Jj4CLjs6FND8zdfx5ac1FS0G1QDdi
	 8evglRiQjVRfRFsO5RnHDwgKB7xqwm5S7JJ3Q+KP6cSU+JQAmS1OQi6/9HNcWe44oB
	 H2ScPiOFRyVTFvdQsVRAiPMYb9v7Ax5cQYk/BGEpmQq+3VjlYtituW0JBi5M2O/AbN
	 s1OuCvCyYhoJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 65127C53BBF; Wed,  9 Oct 2024 04:50:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] New: USB bluetooth dongle stop working after upgrade
 from 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 04:50:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-219365-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

            Bug ID: 219365
           Summary: USB bluetooth dongle stop working after upgrade from
                    6.11.1 to 6.11.2
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.11.2
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: adilson@adilson.net.br
        Regression: Yes

After upgrading from 6.11.1 to 6.11.2, my bluetooth dongle stop working with
the following errors below:


2024-10-09T01:29:45.564367-03:00 r2d2 kernel: usb 1-1: new full-speed USB
device number 19 using xhci_hcd
2024-10-09T01:29:45.695468-03:00 r2d2 kernel: usb 1-1: New USB device found,
idVendor=3D0a12, idProduct=3D0001, bcdDevice=3D88.91
2024-10-09T01:29:45.695539-03:00 r2d2 kernel: usb 1-1: New USB device strin=
gs:
Mfr=3D0, Product=3D2, SerialNumber=3D0
2024-10-09T01:29:45.695557-03:00 r2d2 kernel: usb 1-1: Product: BT DONGLE10
2024-10-09T01:29:45.705487-03:00 r2d2 kernel: Bluetooth: hci1: CSR: Setting=
 up
dongle with HCI ver=3D6 rev=3D3120
2024-10-09T01:29:45.705563-03:00 r2d2 kernel: Bluetooth: hci1: LMP ver=3D6
subver=3D22bb; manufacturer=3D10
2024-10-09T01:29:45.705573-03:00 r2d2 kernel: Bluetooth: hci1: CSR: Unbrand=
ed
CSR clone detected; adding workarounds and force-suspending once...
2024-10-09T01:29:45.705581-03:00 r2d2 kernel: Bluetooth: hci1: CSR: Couldn't
suspend the device for our Barrot 8041a02 receive-issue workaround
2024-10-09T01:29:45.705588-03:00 r2d2 kernel: Bluetooth: hci1: HCI Delete
Stored Link Key command is advertised, but not supported.
2024-10-09T01:29:45.705594-03:00 r2d2 kernel: Bluetooth: hci1: HCI Read Def=
ault
Erroneous Data Reporting command is advertised, but not supported.
2024-10-09T01:29:45.705602-03:00 r2d2 kernel: Bluetooth: hci1: HCI Set Event
Filter command not supported.
2024-10-09T01:29:45.716675-03:00 r2d2 systemd[1]: Starting
systemd-rfkill.service - Load/Save RF Kill Switch Status...
2024-10-09T01:29:45.793744-03:00 r2d2 systemd[1]: Started
systemd-rfkill.service - Load/Save RF Kill Switch Status.
2024-10-09T01:29:47.774485-03:00 r2d2 kernel: Bluetooth: hci1: Opcode 0x1004
failed: -110
2024-10-09T01:29:47.774559-03:00 r2d2 kernel: Bluetooth: hci1: command 0x10=
04
tx timeout
2024-10-09T01:29:50.804490-03:00 r2d2 systemd[1]: systemd-rfkill.service:
Deactivated successfully.



The dongle used: Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, =
Ltd
Bluetooth Dongle (HCI mode)


It works fine under Windows and kernel 6.11.1



I have to copy the following files from 6.11.1 and rebuild the kernel to ma=
ke
the dongle work with 6.11.2

drivers/bluetooth/btusb.c
include/net/bluetooth/hci_core.h
net/bluetooth/hci_conn.c
net/bluetooth/hci_sync.c
net/bluetooth/mgmt.c

Theses files were changed from the following commits between 6.11.1 and 6.1=
1.2



5 days  Bluetooth: btusb: Fix not handling ZPL/short-transfer   Luiz Augusto
von Dentz  1       -1/+4

[ Upstream commit 7b05933340f4490ef5b09e84d644d12484b05fdf ]

Requesting transfers of the exact same size of wMaxPacketSize may result
in ZPL/short-transfer since the USB stack cannot handle it as we are
limiting the buffer size to be the same as wMaxPacketSize.

Also, in terms of throughput this change has the same effect to
interrupt endpoint as 290ba200815f "Bluetooth: Improve USB driver throughput
by increasing the frame size" had for the bulk endpoint, so users of the
advertisement bearer (e.g. BT Mesh) may benefit from this change.

Fixes: 5e23b923da03 ("[Bluetooth] Add generic driver for Bluetooth USB
devices")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>


5 days  Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANC=
EL=20=20
Luiz Augusto von Dentz  1       -1/+4

[ Upstream commit cfbfeee61582e638770a1a10deef866c9adb38f5 ]

This ignores errors from HCI_OP_REMOTE_NAME_REQ_CANCEL since it
shouldn't interfere with the stopping of discovery and in certain
conditions it seems to be failing.

Link: https://github.com/bluez/bluez/issues/575
Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>


5 days  Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED Luiz Augusto
von Dentz  3       -10/+13

[ Upstream commit d47da6bd4cfa982fe903f33423b9e2ec541e9496 ]

If HCI_CONN_MGMT_CONNECTED has been set then the event shall be
HCI_CONN_MGMT_DISCONNECTED.

Fixes: b644ba336997 ("Bluetooth: Update device_connected and device_found
events to latest API")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>


Maybe is one or all commits has caused the regression on my BT dongle

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
