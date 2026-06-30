Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247273C108A
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848173; cv=none; b=ID6ctIdEk7F/rvHjBC7OcLpPTG4e0REcM8Vzhb6JrMvr9KtZZnRvsIodNYKyqa0je93qZxlusw3+aOfuBuF5Q6TVJ+5JQn73TnJtx/5Xdd+yy3pMwm6J5IxOpm8/NKqkIJgKJvZkjzUmURoWQ+3kFe8jLmUxIKJZMsks8uVtrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848173; c=relaxed/simple;
	bh=Mg0q3O8+E+xEqYDLQuBbkdOGVb9IJ57JrlWGnraZ9V8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a8JcOIRzvcJPRYwdMM4InVIJcjTjPIfhdDUsNk/4sbwfOp0KfF8a1Tsoq164k/CnlpMNPwr5dN/iDn8mcdVYW2fTsbNPA2xpF1iqkwiLI7Y5he53IBUl8HwHzokoG0XidicfwhCO8MZlUs5vVeQP4Yn+miqr+/Y9jYBMExx81z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asMQ1Sc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asMQ1Sc6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECA5FC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782848173;
	bh=Mg0q3O8+E+xEqYDLQuBbkdOGVb9IJ57JrlWGnraZ9V8=;
	h=From:To:Subject:Date:From;
	b=asMQ1Sc63c77E6QsvGjhtLaYuh+3cWktwVHn7dFFh+bpsirhsRLL/xMtTijPfpMNc
	 cb7t8H0G2D25yp7fUliyR99TLBXjM8AgUwVAzGcLYrVdDliqGDnR5FN36f06WdxAJm
	 BtNQ7pYznLAyMsx/9nm06tXVZqGzLRS/vKBwyk8nAPcya22MmFRStkfSaVuuNQ8fV1
	 t4QtuPe+E8swhLGUihwyW+we2nv9ueyJmIOF1/0odVBw9yMv8UlutZRz2/YH0JkiSa
	 zeZ78Jq2qHNH/U9t3lOKK5z4zjWmJpkJdKxEZuc+TQNTW9DgYZxKBsYVUcSW2uVmqs
	 qSOcD4ivb0ztw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA96DC41612; Tue, 30 Jun 2026 19:36:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MDddIE5ldzogYnR1c2IvYnRtdGs6IE1UNzkyMSBC?=
 =?UTF-8?B?VCBhdWRpbyBmYWlscyBhZnRlciBzdXNwZW5kL3Jlc3VtZSDigJQgc3RhbGUg?=
 =?UTF-8?B?QUNMIGNvbm5lY3Rpb24gaGFuZGxlIHJlcXVpcmVzIG1vZHVsZSByZWxvYWQg?=
 =?UTF-8?B?dG8gY2xlYXI=?=
Date: Tue, 30 Jun 2026 19:36:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sandeepmahendrakar11@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221707-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221707

            Bug ID: 221707
           Summary: btusb/btmtk: MT7921 BT audio fails after
                    suspend/resume =E2=80=94 stale ACL connection handle re=
quires
                    module reload to clear
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sandeepmahendrakar11@gmail.com
        Regression: No

Created attachment 310397
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310397&action=3Dedit
Attached: dmesg output (bt-dmesg.log) and lsusb -v + uname -a (bt-lsusb.log=
).=20
dmesg confirms the reported issue and shows additional detail: alongside the
recurring "ACL packet for unknown connection

System:
- Fedora 44, kernel 6.19.x
- BlueZ 5.86, PipeWire 1.6.7, WirePlumber 0.5.15
- Adapter: MediaTek MT7921, USB bus path 3-2
- Headset tested: Zebronics ZEB-THUNDER PRO (A2DP), MAC 41:42:09:03:43:EB

Symptom:
After suspend/resume, Bluetooth audio reconnects successfully but disconnec=
ts
again within 2-3 seconds, every time, on every resume.

Root cause found:
The kernel log shows a recurring stale connection handle that survives every
userspace-level recovery attempt:

    kernel: Bluetooth: hci0: ACL packet for unknown connection handle 3837

This handle number persisted across all of the following recovery attempts,
none of which fixed it:
- bluetoothctl disconnect / connect
- bluetoothctl remove + re-pair from scratch
- Power-cycling the headset itself
- rfkill block / unblock
- Full USB-level device de-authorize / re-authorize cycle
(/sys/bus/usb/devices/3-2/authorized set to 0 then 1)

The only thing that cleared it was a full kernel module reload:

    sudo systemctl stop bluetooth
    sudo modprobe -r btusb btmtk
    sleep 2
    sudo modprobe btmtk
    sudo modprobe btusb
    sleep 5
    sudo systemctl start bluetooth

After this, the headset reconnected and held the connection stably (verified
over 2+ minutes of continuous audio playback, and across repeated
suspend/resume cycles since).

Why this looks like a driver-level state bug rather than a BlueZ/userspace
issue:
A full USB re-authorization cycle re-enumerates the device at the USB level,
yet did not clear the stale handle. Only unloading and reloading the
btusb/btmtk kernel modules did. This suggests the stale ACL connection hand=
le
is held in the driver's own internal HCI connection table state, surviving =
USB
re-enumeration, and is only cleared on full module teardown/init.

Reproduction steps:
1. Pair an A2DP headset on a MediaTek MT7921 adapter.
2. Confirm a stable connection.
3. Suspend the system (systemctl suspend), then resume.
4. Observe: reconnect succeeds, then drops within ~2-3 seconds.
5. Run: dmesg | grep "unknown connection handle" =E2=80=94 the same stale h=
andle number
reappears.
6. Confirm that only modprobe -r/modprobe of btusb and btmtk clears it; not=
hing
else does.

I'm happy to test patches, provide additional dmesg/btmon captures, or run
further diagnostics.

GitHub: https://github.com/sandeep11mahendrakar

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
