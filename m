Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E24688
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718153885; cv=none; b=kYHlbX047p3cDBW0/xVamMJa240m4kQt2E8G0vSq68g3nl5dbPULoDVMhn29ovFQNTifoUC4PXLNwCjcJwLFmjeRx3HLKrTAUsJrND7yIkrg7/A2g7QEhzNm5+6Eb+q85p/yyiNZiywUsBKxqqyutvcj4VUekT57xuUz/HyuqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718153885; c=relaxed/simple;
	bh=/Num1f912EzY2UUdE+if5vqJSQR2/DoR6alYgaf4T6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6K8lCNXgX6GIm0VwYk3MDuqy5nHF31uJWnYSAQ1yaNxa9nVePjrpEonH7U/ksP+hjfS9Ir1fLeQhLvorNl+xTTaxIabXl32Y3qCR4gn2Ses9xOC78uYCjuXQeSKnidmLo9AzTmRYBTEt2UDw6W43aXbx/TYdDkR+POqeeZrcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE83yZIE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE83yZIE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7892FC4AF49
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 00:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718153885;
	bh=/Num1f912EzY2UUdE+if5vqJSQR2/DoR6alYgaf4T6o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HE83yZIEzhNHNLQ5WxZ6glrnT8WCkNqYB8pO3b8RVbP2OXeoHfdTsbZmPklQzEJ1a
	 4zlL1O7oRoLj3gu+QYMb5p3IYKDnkTzov1OMcIOSpE3N37dHcL3PJb3gY79L4tVuSa
	 3T0E/L3hhYI8p0EPYBiB8mfNesS5tf3cGG0A0/E1UCqg6GI/nv3RlNDBG6Sns/pjEe
	 2H/ci4/l2sXxzDDo827Tqkgcs9e31yAo5dmh/Op6T5vNa7KiBBHyvFgNRQ11+Us+Yw
	 a6jlcb2p01kNvWSWy6+BglM+V2NZH/1pzbf2omuBG3ypEI9DGOhJAOJo9AT95iJrCE
	 LnZPqEXFPmkLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6EEDEC53B50; Wed, 12 Jun 2024 00:58:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 12 Jun 2024 00:58:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: priit@ww.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-gVwO572gva@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Priit O. (priit@ww.ee) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |priit@ww.ee

--- Comment #34 from Priit O. (priit@ww.ee) ---
still present in kernel 6.9.3

dmesg | grep -i bluetooth
[    4.466394] Bluetooth: Core ver 2.22
[    4.466410] NET: Registered PF_BLUETOOTH protocol family
[    4.466411] Bluetooth: HCI device and connection manager initialized
[    4.466417] Bluetooth: HCI socket layer initialized
[    4.466419] Bluetooth: L2CAP socket layer initialized
[    4.466422] Bluetooth: SCO socket layer initialized
[    5.405005] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.405007] Bluetooth: BNEP filters: protocol multicast
[    5.405010] Bluetooth: BNEP socket layer initialized
[    6.696883] Bluetooth: hci0: command 0xfc05 tx timeout
[    6.696966] Bluetooth: hci0: Reading Intel version command failed (-110)

what's even more troublesome is that previously I was able to make it work =
with
(sometimes with couple of tries):
sudo rmmod btusb && sudo modprobe btusb

now with this kernel I get only this over and over:
[   74.101494] usbcore: deregistering interface driver btusb
[   74.279683] usbcore: registered new interface driver btusb
[   76.457250] Bluetooth: hci0: command 0xfc05 tx timeout
[   76.457268] Bluetooth: hci0: Reading Intel version command failed (-110)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
