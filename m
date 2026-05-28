Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF92475F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985178; cv=none; b=KdilWRjnOIpC7P5B8PqAJ4tJIjLLjrVFbA5bb3QdZgjktOxH6iIrVO6AmzE/y9roQmr41W7L9GTyuH4AAyQyXT0bNYcG6CFwoBepcWiihBmnUNQ/qcEnzM+fXCDaTKN9rfQDbav7BZWC1FB5KO2DV3EjU/Po7+62ZDEW5OHjn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985178; c=relaxed/simple;
	bh=BPdrQ/37E8TIzU4txhu0P5umINbW9n02lUcGhkgFMd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVdQv+fUDQPF3kVnZZSk4Qi6nSPQGdjC1xlE5oHwDk3P1T3IGXt+dWQQhKltqfqcRx49Ui1z1I3kHO9+UMmDztOkB+DV+K511wTpmpmt6V9vd5Ue9pcEAoHd+XlgQaCHNZTG/adyAaWCr+h+n7iwH5RxOsdANPL19y+EXAXN5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmtgfA4A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmtgfA4A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4117C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779985177;
	bh=BPdrQ/37E8TIzU4txhu0P5umINbW9n02lUcGhkgFMd8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HmtgfA4A8vOkYsY0p1IZbio96tI+OVMWK/MBT4uKW8J48fRYpMCY4wfDCxUuRG/hi
	 bUKngFL2HmrPQZrLxhz0/7aSZXl9HNkKyVuahT15P9VMLzgqvhQm+4w+FXtnwVGKqU
	 QtQEj/+AogNASY+gYVii4kHaipgODgC1DjmuZDmXUAENMNjqI6BR7R/x1bMj2rND8K
	 3aLQAWbD7G+5OxS58/qfc1UrTIj0wWmdhJHwVBgNPscTEznj5Hz8ywoSDhabMyuMW6
	 OTJdkqbu8Sobyp39FE6IPxqanaXi5cF3jXyPNvaSdbVRxJuNkkrnawTn5EPXnHE9Ac
	 YrOafm8ilZAdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CBC4EC433E1; Thu, 28 May 2026 16:19:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Thu, 28 May 2026 16:19:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: are.mehus@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220237-62941-5fCLXqzSSV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220237-62941@https.bugzilla.kernel.org/>
References: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

--- Comment #7 from Are Mehus (are.mehus@protonmail.com) ---
Also fixed for me on 7.0.10.

Thank you!




Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 05/28/26 at 18:14 bugzilla-daemon@kernel.org wrote:
https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

--- Comment #6 from Cameron VanHouzen (cameron@vanhouzen.me) ---
Note that this issue is now fixed for me in kernel version 7.0.10

=3D=3DINITIAL DEVICE DETECTION=3D=3D
May 27 20:57:29 kernel: usb 1-12: new high-speed USB device number 10 using
xhci_hcd
May 27 20:57:29 kernel: usb 1-12: New USB device found, idVendor=3D0e8d,
idProduct=3D0717, bcdDevice=3D 1.00
May 27 20:57:29 kernel: usb 1-12: Product: Wireless_Device
May 27 20:57:29 kernel: usb 1-12: Manufacturer: MediaTek Inc.
May 27 20:57:29 kernel: usb 1-12: SerialNumber: 000000000

=3D=3DFIRMWARE LOAD=3D=3D
May 27 20:57:33 kernel: Bluetooth: Core ver 2.22
May 27 20:57:33 kernel: Bluetooth: HCI device and connection manager
initialized
May 27 20:57:33 kernel: Bluetooth: HCI socket layer initialized
May 27 20:57:33 kernel: Bluetooth: L2CAP socket layer initialized
May 27 20:57:33 kernel: Bluetooth: SCO socket layer initialized
May 27 20:57:33 kernel: usbcore: registered new interface driver btusb
May 27 20:57:33 kernel: Bluetooth: hci0: HW/SW Version: 0x00000000, Build T=
ime:
20260414153243
May 27 20:57:35 kernel: Bluetooth: hci0: Device setup in 1835871 usecs
May 27 20:57:35 kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous
Connection command is advertised, but not supported.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
