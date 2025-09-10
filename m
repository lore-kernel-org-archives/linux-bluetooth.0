Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF5522F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547057; cv=none; b=mIjwIX/HnoxId6X6lz3LwYCHb8PT+DnSa6tuG/lH695FX+AxIxvMpanZS3v772cdGuJrrUt+sgBZBugvmMGwKKYIQBoeQmADUBNoFhobyaqJ1ZNoSOvaVm1w95nc6Cg4bNTC0lwibMsk9kAXYcL1HfngTdcPRQdR9+sdFPoYeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547057; c=relaxed/simple;
	bh=J0nvga6PiNOGipU03S5+02xfwJqtNWLUIOuFOvH/zMo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BTH5C3/C4LUxGfz6vdvEfTe2TB8S/DasrPzDpBkUfbZNtpaDfDjOC3/eAeIcgoQrizkHOXngejWVEcUniCZt6FhHeiezo/EllMqyiCJyEa5HdLNJD6G02jcpJprTDiHtydvpz9TX6xK1FW8fUNb6OO5h4sNU4eJwumFdXTr6c+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpislYvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpislYvA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE18C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757547057;
	bh=J0nvga6PiNOGipU03S5+02xfwJqtNWLUIOuFOvH/zMo=;
	h=From:To:Subject:Date:From;
	b=PpislYvA1tLINVkfVqdBtIhV53xQ3pAyvCQjWPdRaWAAksjuQa3A4qavLX/6jTZjz
	 Iv2ffAXCMPQFCEysco0TAUcR1Bvw9RfubZ1uuR1B/Thx6+Hu1w7Cz/04hJNQNMuEAI
	 M7JYQ/kuLc1p2gxGiIzOH/e7SxzmkJZwm+FlnEd261d+JgAE6BCnii079CQgY9KiVF
	 rD+eBY3O4/DgN0K/uBNS0w3leBpWFxi85OVS8Ik1CVkM7WF5O/6y0e7J8SwETSBte2
	 DdVHYeJkeH9OClqYz/XqlQAmpkaMxsD48XDtd06OqrA9nZoVkrX4ITWzj9Kyrf1c6V
	 gFEOQUMz0hEnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D37EC3279F; Wed, 10 Sep 2025 23:30:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] New: Wrong indentification of Bluetooth in Lenovo
 Legion Pro 5 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Wed, 10 Sep 2025 23:30:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

            Bug ID: 220564
           Summary: Wrong indentification of Bluetooth in Lenovo Legion
                    Pro 5 and 0489:e111 Foxconn / Hon Hai Wireless_Device
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jcubic@onet.pl
        Regression: No

I commented on https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

But I think that this is something unrelated, since the error message:

hci0: ACL packet for unknown connection handle 3837

in my case it may be an error in the driver, I have a flood of errors in lo=
gs.
I have a new laptop from 2025 (Lenovo Legion Pro 5 16IAX10 Ultra 7 255HX) a=
nd
the system I have (fedora 42 xfce) with kernel 6.16.5-200.fc42.x86_64 detec=
ts
something as MTP Wireless Device. There is an icon on the desktop. I think =
that
this is because of wrong detected Bluetooth device in the Bluetooth driver.=
 The
laptop don't have any MTP device.

gio mount -l shows:

Volume(0): Wireless Device
  Type: GProxyVolume (GProxyVolumeMonitorMTP)


mtp-detect returns:

libmtp version: 1.1.19
Listing raw device(s)
Device 0 (VID=3D0489 and PID=3De111) is a Vizio (for Lenovo) LIFETAB S9714.
   Found 1 device(s):
   Vizio (for Lenovo): LIFETAB S9714 (0489:e111) @ bus 3, dev 6
Attempting to connect device(s)
PTP_ERROR_IO: failed to open session, trying again after resetting USB
interface
LIBMTP libusb: Attempt to reset device
LIBMTP PANIC: failed to open session on second attempt
Unable to open raw device 0
OK.

lsusb:
Bus 003 Device 006: ID 0489:e111 Foxconn / Hon Hai Wireless_Device


I've enabled debugging with /sys/kernel/debug/dynamic_debug/control

This is part of the logs from btmon:

> ACL Data RX: Handle 3837 flags 0x02 dlen 143         #26475 [hci0] 238.82=
1952
      Channel: 259 len 139 [PSM 0 mode Basic (0x00)] {chan 65535}
        32 00 9f d2 95 00 01 00 e6 0a 03 00 00 00 00 00  2...............
        00 dd 9a 00 00 00 00 00 00 08 0a 00 00 00 00 00  ................
        00 d7 04 00 00 71 cc 00 00 e9 11 00 00 00 00 00  .....q..........
        00 fe 0e 01 00 00 00 00 00 9e d2 95 00 6a d2 95  .............j..
        00 07 d6 50 00 fc 07 00 00 00 00 c0 df ff 3f 00  ...P..........?.
        00 02 00 20 00 02 00 00 00 02 00 20 00 02 00 00  ... ....... ....
        00 02 00 20 00 02 00 00 00 02 00 20 00 02 00 09  ... ....... ....
        00 5c 01 00 00 02 00 09 00 00 00 00 00 02 00 20  .\.............=20
        00 02 00 00 00 02 00 20 00 02 00                 ....... ...=20=20=
=20=20=20
> HCI Event: Number of Completed Pack.. (0x13) plen 5  #26476 [hci0] 238.85=
4712
        Num handles: 1
        Handle: 50
        Count: 1
bluetoothd[1539]: < ACL Data TX.. flags 0x02 dlen 850  #26477 [hci0] 238.85=
4861
      Channel: 3778 len 846 [PSM 0 mode Basic (0x00)] {chan 65535}

This is output of journalctl -k

wrz 11 00:38:50 jcubic kernel: hdev 0000000021bf8090 len 147
wrz 11 00:38:50 jcubic kernel: hci0 ACL data packet
wrz 11 00:38:50 jcubic kernel: hci0: len 143 handle 0x0efd flags 0x0002
wrz 11 00:38:50 jcubic kernel: Bluetooth: hci0: ACL packet for unknown
connection handle 3837
wrz 11 00:38:50 jcubic kernel: hci0 Event packet
wrz 11 00:38:50 jcubic kernel: hci0: event 0x13
wrz 11 00:38:50 jcubic kernel: hci0: num 1

I listen to music almost non-stop with Bluetooth speakers, and the error ha=
ppen
during short music interruption. I think that it started to happen after I'=
ve
upgraded to testing kernel in Fedora.

This is a related bug in Fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2392938

I hope that the provided info is enough, I used Grok (LLM) to help with
debugging.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
