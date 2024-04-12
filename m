Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D8139D0F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936251; cv=none; b=TUe/a1Grj4k777LZ4JIfHbbAWIokDIkmENeXFRjI9DPHF6+wupUo7XWchF5hVzKGGxP3ukTJC175VaYSfDfmekHUOFhB8tfjExEUwR0VZ1LOLeYOXPUu9N2uANQe2vGNf/3dK3iybDtSs/QJaq+hqYeE8XV6hyxBFive+pLTnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936251; c=relaxed/simple;
	bh=uPhtGRLKjd7gk74v12X9Utpl+NSn8lYPFn2j2nU4guE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF68pUvSnGoPgZ+fV8ZNlNZj3+L4HsGhdHgGeODTkzxhtltWx+oLYsT2KKVA002rxK+AQUbRZPJKSy48HmBjwUrRE1h7clE4MMeSrLgyespWmFWONZoc87QL7+XhIWM0eSr5azbnBdMxSttaYAZwAUAwVzEfhC1+e+xkQzSbcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6w4WdMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6w4WdMU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EAA3C3277B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712936250;
	bh=uPhtGRLKjd7gk74v12X9Utpl+NSn8lYPFn2j2nU4guE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V6w4WdMUTDp2rN1sL/NFIug0yBqbWWRLVTRtuMOI1sZlVPjEk+Tob6sQNUv6/N+Sh
	 oHjYvMSFZQHOfFpP9nwhjJLEMv5QCN6y0ihQRgbesnC6aO0bPrCGn3x8weD0jX0b5h
	 U2baTcAtNaAb0z5noPg5EnuEZOzDH3VAf1WZNXoweAQ1nzQjUClUPtsazVK9d3Zi+s
	 ESGR0MibGfyHIvYoBMebOHARGhQeyo6+r7Td8rKzqTYjW2Zo0YKpWmoSh6CpOM5s5U
	 0HW/+/vTzhh+KrxAG8g0Rn5KdU0bD0sm+ubZkCgNg8eUWfUfocTsgAdoSknAXcDnaG
	 5axCPw6Gkggcw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 21084C433E5; Fri, 12 Apr 2024 15:37:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 12 Apr 2024 15:37:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-on7439OWmw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #20 from Artem S. Tashkinov (aros@gmx.com) ---
This is still reproducible in 6.8.5:

dmesg -t | grep -i blue
Bluetooth: Core ver 2.22
NET: Registered PF_BLUETOOTH protocol family
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 173-5.24
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP socket layer initialized
Bluetooth: hci0: FW download error recovery failed (-19)
Bluetooth: hci0: sending frame failed (-19)
Bluetooth: hci0: Reading supported features failed (-19)
Bluetooth: hci0: Error reading debug features
Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not
supported.
Bluetooth: hci0: sending frame failed (-19)
Bluetooth: hci0: Failed to read MSFT supported features (-19)
Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
Bluetooth: hci0: Device revision is 2
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 173-5.24
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1129749 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 14839 usecs
Bluetooth: hci0: Malformed MSFT vendor event: 0x02
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware revision 0.1 build 173 week 5 2024
Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not
supported.
Bluetooth: MGMT ver 1.22
Bluetooth: ISO socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11

No timings, btintel just tries to load the firmware when it's already there=
 (if
you're rebooting from Windows).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
