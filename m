Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052F2E7380
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984872; cv=none; b=Tk5Wvl2WwuXg2P+mpT8CxwBLPRx4JB2+gcJshHlJR7pqn15I30SGrxpbRMGCq63XJaoIOM8sSvgajkFqjVHkjrg6Xqa0j27FyjIBSoJ4iNuXXP7atxqm0Al1wNFGqkUbRPp3E+mYd7KDpk+p+7IdaQofT+d3d8Nrz7XD70OSK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984872; c=relaxed/simple;
	bh=BPYm7o34TZsjvEz7Oay7myNOIQ20ka2ot6Y0nCMQytA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXQ+DzHtvDx0Nvf0t1Urg/gb47YEmmWPdPY92b+H22cDPqpaCl0y9ozyfuH3H0QqDJH5/bJo1xYsuu4lXrj/N3FBhWCbBVITqtbdRvRn0s8Uy7q4j6gwTZjjdtnTX3VXLe+imAuhHbLmrYkc7LVoFsj6Z8fm+ieMx1nBWoGpQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwjJhdA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwjJhdA8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5740EC2BCC4
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779984872;
	bh=BPYm7o34TZsjvEz7Oay7myNOIQ20ka2ot6Y0nCMQytA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mwjJhdA8i7IBPpC6KtEZLE3TI5zMI/R3RY8eFmSLln5PQ1Zd13QoaVce0W7ebg+VH
	 7FnaUP9cJTgKGdnIYZOlXplXJv5Ne4IPp+wfHrq8WRFWH0utRQ9kF383cMj7HVQjbi
	 2rD44MYZYib4xIGr89h5d9kjfQCtAzGF3HI1uDZM+hzCnak6K+eIJBE2iBM/p3mhVB
	 ZkwuYi2zcHoObrQy6STfKwZprpg62V9SU0zHoV3afsr8/qIxJjtmNFLvd0ZB33e+TA
	 In3bOOIbdeefHD5fn0AhW0URENkkDqB0c6o11xlQ4cZEItHrzV9WKacEZAroF1Atkp
	 uyBpXbC+L07sQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E4C8C3279F; Thu, 28 May 2026 16:14:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Thu, 28 May 2026 16:14:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameron@vanhouzen.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220237-62941-XJtrgAMAlu@https.bugzilla.kernel.org/>
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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
