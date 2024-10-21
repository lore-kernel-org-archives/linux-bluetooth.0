Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9A1FAF0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536144; cv=none; b=I8OWIH67AmAxLfZJOGSITQ5CQcAep0KTl21r0QmtJ8PZ9+xMLSEGeTNyVDEAEiWmDIuZQH0xW1KcuCXI0xzDsy2DeanxoBmBXh2Z9sL2AieRAlC7xSuZNCeRi0Oc6pFxpbIHII/iSHv8k5Z21v42QOC4R5axFCeRBRsVD5DpYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536144; c=relaxed/simple;
	bh=27SwHX0iwAC1qUoU3dl6bANpUwNJ0kKySn1ZOUuhypE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NtIy46czScCl1fFwO+byItdw+I4We4kPoVathPzOTV/4bwrfF/Gwktph8PzoRf+xeRWHKYE3zRxVuD1CzAYTnlsV/knQE0Tk7IlMKp3pw7jibiHLvpGmp7EPqWfqvhpXPDYEpEmMnBcRsRs+a20DsJ3sKbYX7VSZzM3JPM5t1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWjhbFQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWjhbFQf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24982C4CEE5
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729536144;
	bh=27SwHX0iwAC1qUoU3dl6bANpUwNJ0kKySn1ZOUuhypE=;
	h=From:To:Subject:Date:From;
	b=FWjhbFQfmCJBa5yw2Jspp/xYlgBmD1TT289h1KJ5IkEjAo6vDCC8hrdEE0JI1/WYh
	 SaDeCF9QWvTexrc4inEX6tpZxtLw3BUwpQM8j+RRM57jrB4WD0/29naNXeCWa/sdTu
	 /8Hv0HxKhB7Twnv5uRw7l1VESbp4s7K3S3c5HPpNF5M9g7AZUKlJaiNvFq/2GA2CQE
	 YdWhwY3kHtpS4TYSyjpQUk+8jzEgVdkHS/QLtkKi/i5bK5F2HWjQAbY3kMjQWm2sOt
	 3QnYdJNuxO9iY6mgTze6+c1SFhM2gQOtqgTZ0c7GieAJ/tu/aV9XzT7IFnyuImTkg/
	 Bge9tCBmpEt+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E5D9C53BC2; Mon, 21 Oct 2024 18:42:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219410] New: Need help with Product: CSR8510 A10
Date: Mon, 21 Oct 2024 18:42:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hhsnakeg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219410-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219410

            Bug ID: 219410
           Summary: Need help with Product: CSR8510 A10
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: hhsnakeg@gmail.com
        Regression: No

Help please, who can tell me what changes to the code need to be made to ma=
ke
the bluetooth device work
I can provide any data, command output/dumps of device operation

At the moment the output of the dmesg command:

[41142.022157] usb 5-2.1: new full-speed USB device number 17 using xhci_hcd
[41142.229393] usb 5-2.1: New USB device found, idVendor=3D0a12, idProduct=
=3D0001,
bcdDevice=3D25.20
[41142.229405] usb 5-2.1: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[41142.229410] usb 5-2.1: Product: CSR8510 A10
[41142.241228] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D3120
[41142.241244] Bluetooth: hci0: LMP ver=3D9 subver=3D22bb; manufacturer=3D10
[41142.241249] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[41152.439058] usb 5-2.1: Failed to suspend device, error -110
[41152.439073] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[41152.439149] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[41152.439153] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[41152.439156] Bluetooth: hci0: HCI Set Event Filter command not supported.
[41154.453944] Bluetooth: hci0: Opcode 0x0c03 failed: -110

I tried changing the flags in the btusb.c file that are in the Barrot 8041a=
02
block.
but obviously my knowledge is not enough, if anyone is willing to help, I w=
ould
be grateful.

the device comes with a disk for windows7 and works well, also under window=
s10
install the drivers without the disk, the device works as well

If it is possible to customize the device, these fixes can be put into
bluetooth drivers for all users who have this device

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
