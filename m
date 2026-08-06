Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386378F2F
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998913; cv=none; b=Hxn4uhrtdTaOMjHAvNHSY6k9PM6uaquDRU2+NFflvTrCMD/kosi6S31IqEtwWOVvzzXXHcLWFZSqPtJt3yvChSl0Tv+nanD31K8qmNjUrpJWPnVxN7LA3ZSBEV8KjORCFl/8vgBdYMWuiY2BkZC8XTyypn3oL4y5Qi02FuyT+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998913; c=relaxed/simple;
	bh=4XzGinvVm9lsOLwW/Djqr/sLriv1bnYOMJc0BEXVhmw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H9g3tRjhTGr9i/eKlSXEA1FDx/sQbZ5F3PKrj0cDfSAlbWrWSzW6xSxppjUv+dP0KC/aK3F9HYZ4jkVw8Z1+EiYcJgXKcQXC1MOnPiZMboV816pl/itraqeFgkBOa/gds731J662Zj7JKsvjumdtwDiM7nfSz2USx2n9HsiiiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PltZdOlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PltZdOlh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD3ABC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 06:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785998912;
	bh=4XzGinvVm9lsOLwW/Djqr/sLriv1bnYOMJc0BEXVhmw=;
	h=From:To:Subject:Date:From;
	b=PltZdOlhI0PVEZgnZpH0g75U37LPX+uB72T52zaelA1NnRAKKDCctS0A16nKdKcKJ
	 OiSceq3eqObFJfJsMPcK9RUE66362/jHxjUjJSYehr4jScFo0EYZsumnDtj6d9ZDJs
	 /152s2QZ++2fLi0RpzixkHrn3qiQTCqzoKndWzThvGaj9pvwgseS4uDdY3/guWKiFl
	 26gUOFp8xKSaoKNI93wghN22YwjkP0uaRQhjNLxW03OquqtqhoIX0HsgeqmEbeCTrN
	 JAyajd/A0p3cSQNUsbdVXE0vBsb/gCY1kFNXx+jq591E2f9hQs+gL7PSnfJvWHswLK
	 YFEegPyGzeVMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80416C3279F; Thu,  6 Aug 2026 06:48:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221840] New: Regression: Intel Bluetooth (btintel/hci0) fails
 firmware boot on 7.0.12, works on 6.17.10 (Dell Inspiron 3501, AX201)
Date: Thu, 06 Aug 2026 06:48:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rohitanand9418@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221840-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221840

            Bug ID: 221840
           Summary: Regression: Intel Bluetooth (btintel/hci0) fails
                    firmware boot on 7.0.12, works on 6.17.10 (Dell
                    Inspiron 3501, AX201)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: rohitanand9418@gmail.com
        Regression: No

Created attachment 310581
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310581&action=3Dedit
dmesg comparison: working kernel 6.17.10 vs broken kernel 7.0.12

Overview:

Intel Bluetooth AX201 CNVi companion radio ("Jefferson Peak", USB ID 8087:0=
aaa)
fails to complete firmware boot handshake on kernel 7.0.12.

After firmware download completes, hci0 fails during "Waiting for device to
boot", enters a USB reset loop, and never recovers until rebooting into ker=
nel
6.17.10.

The same hardware, firmware, and BlueZ userspace work correctly on kernel
6.17.10. The regression appears to be kernel-related.


Steps to Reproduce:

(1) Boot the machine into kernel 7.0.12+kali-amd64.

(2) Wait for boot to complete. No user action is needed -- Bluetooth
initializes automatically at boot.

(3) Check dmesg for hci0 messages, or run `bluetoothctl show`.


Expected Results:

hci0 completes firmware boot (~15ms) and the controller powers on normally.


Actual Results:

hci0 times out during "Waiting for device to boot", enters a permanent USB
reset loop, and the controller disappears from lsusb/rfkill entirely. Recov=
ery
requires rebooting into a different (working) kernel.


System:

Machine: Dell Inspiron 3501

CPU: Intel Core i5-1135G7 (Tiger Lake-UP3)

BIOS: 1.44.0

Wireless: Intel Wi-Fi 6 AX201 (CNVio2), PCI ID 00:14.3, driver iwlwifi

Bluetooth: Intel Bluetooth 9460/9560 "Jefferson Peak", USB ID 8087:0aaa, dr=
iver
btusb/btintel

Firmware: intel/ibt-19-0-0.sfi, firmware revision 83-7.26

Distribution: Kali Linux rolling

BlueZ: tested with BlueZ 5.85-4 and 5.87-1. Issue reproduces identically on
both versions.


Kernel versions tested:

GOOD -- 6.17.10+kali-amd64 (6.17.10-1kali1): Bluetooth initializes correctly
("Device booted in 14813 usecs"), controller works normally. Full dmesg exc=
erpt
attached as dmesg-working-6.17.10.txt.

BAD -- 7.0.12+kali-amd64 (7.0.12-2kali1): firmware download completes, but
device boot fails and the controller enters a permanent reset loop. Full dm=
esg
excerpt attached as dmesg-broken-7.0.12.txt.


Timing:

Firmware loading time is essentially identical between the two kernels (183=
9645
usecs on 6.17.10 vs 1847614 usecs on 7.0.12). The regression happens after
firmware loading, specifically during the device boot phase that follows it.


Possible affected areas (speculation, not confirmed):

btusb driver changes, or btintel firmware boot handling, or USB interrupt
handling, or USB endpoint timing, or timeout handling changes between these
kernel versions.


Ruled out -- not a BlueZ/userspace issue:

Tested with BlueZ 5.85-4 and 5.87-1, same result on both, so this is not a
userspace regression.

Ruled out -- not a firmware issue:

The exact same firmware file works correctly on kernel 6.17.10, so the firm=
ware
itself is not at fault.

Ruled out -- not USB power management:

Tested with USB autosuspend fully disabled (btusb module parameter, a udev
rule, and a TLP USB_DENYLIST entry). No change in behaviour.

Ruled out -- not rfkill:

The controller is confirmed unblocked (rfkill list shows soft/hard blocked:=
 no)
both before and during the failure.

Ruled out -- not hardware failure:

The same laptop, same physical adapter, works correctly every time on kernel
6.17.10 and fails every time on kernel 7.0.12.

Ruled out -- not a USB topology issue:

Unbinding and rebinding the xHCI PCI controller while running the broken ke=
rnel
does not recover the device; it re-enters the same boot-timeout loop.


Additional Information:

Kernel 6.19.14+kali-amd64 is also installed on this system but has not yet =
been
tested; will update this report once tested, to narrow the regression range
further. Two dmesg excerpts are attached separately (dmesg-working-6.17.10.=
txt
and dmesg-broken-7.0.12.txt) rather than pasted inline, since multi-line log
output gets reflowed/collapsed by the comment box otherwise. Happy to test
intermediate kernel versions or apply candidate patches -- both a working a=
nd a
broken kernel are readily available on this exact hardware right now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
