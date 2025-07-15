Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660E2620F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580344; cv=none; b=JLnb2DF9lxdMVYYTXHx9k1KWDZ1PrJxHOxQrfSZw8kkkvUoBV1O/KmuFA2w3oGI9mBDWZksM8fiOiPQRW6x5ZToAne7esprZPV/gA0I3r4LtdG5JpoRWSxwzL62FM/YS4TZ9a9hrY8YLjS8OoAYO4t+3fcc4NNXPSAGju7rEOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580344; c=relaxed/simple;
	bh=XXTbpEr2y9ihyx7FJF7oKVk9RnlkEXG/dIOnARgaH0Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PRJsE3FVDyZA30e8ubg8tJKsFFHRLa6nVqyTXG3RW6X+33Vt+h66wbpexIn/1U51lin0ylrD66efl9HKMcsSAVWXUbGFP2AwGc6AJUpRNmn96dI/LA0XfCEznvdJuFhoWVucfIjbgAxb0SbbMA5yVoq4poHDQm+rxf6sSIZ7kHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLrukL9h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLrukL9h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E571C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580344;
	bh=XXTbpEr2y9ihyx7FJF7oKVk9RnlkEXG/dIOnARgaH0Y=;
	h=From:To:Subject:Date:From;
	b=mLrukL9hr2EEoRHDhD8n/e6JUWujDPXmYB/MXNGqyl5MNl1ihEBHNkup1OTVKLOfh
	 PXOpCU1AyuUFCzgZysyDO8yF40LAPVHF2R3aKcfw0rdcjWUwsz4iwHWr45ZNvDuFcf
	 WfbfTCd1seTNiL+zFowwktd5ts0KE/72/0KzxDwSdQOMC3B4Gw7LRkUQRYL7dAT3Tw
	 jJ5V2aM5vBToJAv7btyrDYm8/j352hAalOk/TQARLAIkeWYAv6Z4WhWgnh1pWa7P24
	 kQ42jLUigb1fChRQQpCMI/baFHRR7x7vZxQHpFbO4Qdqnw+IUkBPF8ZhvDmG4ti/15
	 Cal3JiEcGM7vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4FBA8C433E1; Tue, 15 Jul 2025 11:52:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] New: Bluetooth crashes about 30-40 minutes after I
 connect my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Tue, 15 Jul 2025 11:52:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

            Bug ID: 220341
           Summary: Bluetooth crashes about 30-40 minutes after I connect
                    my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: martin@hignett.net
        Regression: No

Created attachment 308379
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308379&action=3Dedit
Kernel log

I have a recurring issue with the Bluetooth stack crashing.=20

What am I doing when it crashes?

This has happened 5-6 times in the last week since I got my new laptop. On
every occasion, I'm on a Google video call with my Bluetooth headset connec=
ted
(Sony WH-1000MX) in headset mode (mSBC). This happens whether I am using
Firefox or Chrome.

My Hardware

A brand new Lenovo X1 Gen Carbon 13

=E2=9E=9C  ~ lspci -nn=20
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:6400] (rev 04)
00:02.0 VGA compatible controller [0300]: Intel Corporation Lunar Lake [Int=
el
Arc Graphics 130V / 140V] [8086:64a0] (rev 04)
00:04.0 Signal processing controller [1180]: Intel Corporation Device
[8086:641d] (rev 04)
00:07.0 PCI bridge [0604]: Intel Corporation Lunar Lake-M Thunderbolt 4 PCI
Express Root Port #0 [8086:a84e] (rev 10)
00:07.2 PCI bridge [0604]: Intel Corporation Lunar Lake-M Thunderbolt 4 PCI
Express Root Port #2 [8086:a860] (rev 10)
00:0a.0 Signal processing controller [1180]: Intel Corporation Device
[8086:647d] (rev 04)
00:0b.0 Processing accelerators [1200]: Intel Corporation Lunar Lake NPU
[8086:643e] (rev 04)
00:0d.0 USB controller [0c03]: Intel Corporation Lunar Lake-M Thunderbolt 4=
 USB
Controller [8086:a831] (rev 10)
00:0d.2 USB controller [0c03]: Intel Corporation Lunar Lake-M Thunderbolt 4=
 NHI
#0 [8086:a833] (rev 10)
00:0d.3 USB controller [0c03]: Intel Corporation Lunar Lake-M Thunderbolt 4=
 NHI
#1 [8086:a834] (rev 10)
00:13.0 Communication controller [0780]: Intel Corporation Device [8086:a86=
2]
(rev 10)
00:14.0 USB controller [0c03]: Intel Corporation Lunar Lake-M USB 3.2 Gen 2=
x1
xHCI Host Controller [8086:a87d] (rev 10)
00:14.2 RAM memory [0500]: Intel Corporation Device [8086:a87f] (rev 10)
00:14.3 Network controller [0280]: Intel Corporation BE201 320MHz [8086:a84=
0]
(rev 10)
00:14.7 Bluetooth [0d11]: Intel Corporation Device [8086:a876] (rev 10)
00:15.0 Serial bus controller [0c80]: Intel Corporation Lunar Lake-M Serial=
 IO
I2C Controller #0 [8086:a878] (rev 10)
00:15.3 Serial bus controller [0c80]: Intel Corporation Lunar Lake-M Serial=
 IO
I2C Controller #3 [8086:a87b] (rev 10)
00:16.0 Communication controller [0780]: Intel Corporation Device [8086:a87=
0]
(rev 10)
00:1c.0 PCI bridge [0604]: Intel Corporation Lunar Lake-M PCI Express Root =
Port
#1 [8086:a838] (rev 10)
00:1c.4 PCI bridge [0604]: Intel Corporation Lunar Lake-M PCI Express Root =
Port
#5 [8086:a83c] (rev 10)
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:a807] (rev 10)
00:1f.3 Multimedia audio controller [0401]: Intel Corporation Lunar Lake-M =
HD
Audio Controller [8086:a828] (rev 10)
00:1f.4 SMBus [0c05]: Intel Corporation Lunar Lake-M SMbus Controller
[8086:a822] (rev 10)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Lunar Lake-M SPI
Controller [8086:a823] (rev 10)
04:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd
Device [144d:a810]

My Software

Clean install of OpenSuSE Tumbleweed (up to date as of 14th July 2025). I'm=
 not
sure it is relevant, but I'm using systemd-boot instead of Grub.

=E2=9E=9C  ~ uname -a=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
Linux martin-work 6.15.5-1-default #1 SMP PREEMPT_DYNAMIC Sun Jul  6 18:09:=
53
UTC 2025 (478c062) x86_64 x86_64 x86_64 GNU/Linux

What have I tried?

* `sudo systemctl restart bluetooth.service`
* `sudo systemctl restart bluetooth.target`

Neither worked - it seems that the Bluetooth module is hard crashed until I
reboot.


Kernel Logs

Is it possible that this is a hardware error (see the first line in the ker=
nel
log attached)? This is a brand new laptop, so if so, I should return it!

Output of `sudo journalctl --since "11:53" --until "12:00" >
/home/martin/bluetooth-error2.log` attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
