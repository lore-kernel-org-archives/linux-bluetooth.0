Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5C2441A6
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809831; cv=none; b=l804CasaiA6LdY/AA/kB0h5Vy5Je4VLZ/hkuu5j2AMs3LMiLR+5UukCPKh9c0twiUMPBrDwaPVThsCbXG+auFfiYMorv+KWK//r2gsix3X+mWZta8DBlv5iTZCBByV5tThe3OUDYOG5MupBKvejUipYPG96CFsHNYd8Ch6TwK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809831; c=relaxed/simple;
	bh=huZ9PaiocCxLxlWEY+9fdeDg5X2Re31G98yCzWJabaA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S/Pt9nxGGVy3e0LmhLiUTrezIyVJQjZE61LZ5Nw13ihcmxw1mzpmrMMW91M9P5kxFS9X03ft0Lz/VrmfumsXGGpxYPQZa1jkpEOsJF648Z8EZwjbTaRyQAvY/x4+U37SRRcvQDTx9RH0046ivXtTW57R82GMCR0ZrvYjMSeAHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1x5u4tP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1x5u4tP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F65BC4CEF8
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760809831;
	bh=huZ9PaiocCxLxlWEY+9fdeDg5X2Re31G98yCzWJabaA=;
	h=From:To:Subject:Date:From;
	b=e1x5u4tPO419UylU3XRuOBExLP7ijgMd7K1l72w0kTwn8NRJEUgLItXttG4jadQ+2
	 TS2UOOQEl5OWUxqhRv6d0jPPmMFaQsgkFqkzb/+4/KOSwvec55wWsEAScq0nniQLY4
	 nMz6Qn9HyGJhfHNGIi/coFnbdFaasoLQ1n8j6ksOZazoicXFyhhOBrP0MqVD7eRftN
	 V64enUMl8WNM7+banYf573rApTo7HTswRgoKx17hy6tgYUgjnaM+A/lzQfVSxJu8FD
	 Wz4tfeAvG9o+SyQoIUIkPdEV+H7o+ps134in9ON9umC0etwXyTaIWwaBUSqmVrL/PZ
	 8pwvuT7EniDyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E932C3279F; Sat, 18 Oct 2025 17:50:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] New: Bluetooth adapter (MediaTek MT7925, USB ID
 0489:e111) stops working after user logs in to the GNOME
Date: Sat, 18 Oct 2025 17:50:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alex.jakimov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220682-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220682

            Bug ID: 220682
           Summary: Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
                    stops working after user logs in to the GNOME
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alex.jakimov@gmail.com
        Regression: No

Created attachment 308826
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308826&action=3Dedit
Logs

Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111) stops working after u=
ser
logs in to the GNOME desktop on a Lenovo Yoga Pro 7 running Fedora 42. The
problem is timing-sensitive and appears to be caused by a software-level
conflict, as the hardware works correctly on Windows 11. Attempts to resolve
the issue with standard workarounds, including kernel module reloading via
systemd and udev, adjusting kernel parameters with GRUB
(btusb.enable_autosuspend=3D0), and configuring power management with TLP, =
have
failed. Logs show the bluetooth.target being stopped post-login and reveal
potential communication errors (ACL packet for unknown connection handle).
Relevant log entries
1. Hardware identification via lsusb:
text
Bus 003 Device 002: ID 0489:e111 Foxconn / Hon Hai Wireless_Device
Use code with caution.

2. Kernel and boot environment:
text
uname -r
6.14.0-63.fc42.x86_6
GRUB_CMDLINE_LINUX=3D"rhgb quiet btusb.enable_autosuspend=3D0"
Use code with caution.

3. Initial successful bluetoothd startup (post-login failure):
text
Oct 18 20:31:29 fedora kernel: Bluetooth: MGMT ver 1.23
Oct 18 20:31:29 fedora bluetoothd[2491]: Battery Provider Manager created
Oct 18 20:31:29 fedora kernel: hid-generic 0005:046D:B035.0002: input,hidra=
w1:
BLUETOOTH HID v0.06 Mouse [MX Master 3S B] on 84:9e:56:33:6b:2a
Oct 18 20:31:34 fedora kernel: hid-generic 0005:046D:B369.0003: input,hidra=
w2:
BLUETOOTH HID v0.16 Keyboard [MX Keys Mini] on 84:9e:56:33:6b:2a
Oct 18 20:31:45 2a01-5a8-301-815b--1009.v6.vivacom.bg kernel: Bluetooth: RF=
COMM
TTY layer initialized
Oct 18 20:31:54 2a01-5a8-301-815b--1009.v6.vivacom.bg systemd[1]: Stopped
target bluetooth.target - Bluetooth Support.
Use code with caution.

4. ACL packet error showing low-level communication issue:
text
Oct 18 20:31:30 fedora kernel: Bluetooth: hci0: ACL packet for unknown
connection handle 3837
Use code with caution.

5. Corrected module reload fails, showing btmtk is not the right module for
this device:
text
Oct 18 20:23:29 2a01-5a8-301-815b--1009.v6.vivacom.bg kernel: usbcore:
deregistering interface driver btusb
Oct 18 20:23:29 2a01-5a8-301-815b--1009.v6.vivacom.bg kernel: btusb: unknown
parameter 'btmtk' ignored
Oct 18 20:23:29 2a01-5a8-301-815b--1009.v6.vivacom.bg kernel: usbcore:
registered new interface driver btusb
Use code with caution.

Steps to reproduce
Boot Fedora 42 on the Lenovo Yoga Pro 7.
Log in to the GNOME desktop.
Observe that the Bluetooth adapter disappears shortly after login.
Run journalctl -b | grep -i "bluetooth" to confirm the bluetooth.target was
stopped and the ACL packet for unknown connection handle error is present.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
