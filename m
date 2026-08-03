Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9C3ACEFE
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787871; cv=none; b=ncbNNTugWxiI0E519EIdnwuMV7cBWvgy034kvK9Wh54Wr2lRzdnraxmHEKVulepmt7dwdkElutijl9M6v+11PqReBQsz1g+jCA56RLbiFKoMRuUu7+/cg3sO7U+sU4Ul+TgW5JP9/mlEHD3mjqqhwVP+S0Q8DGm6CsL+Y/hXjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787871; c=relaxed/simple;
	bh=NHpd7oFlUvnfyAAlJ4XIC8kt8eGF5T7MQDd+3WW1Xn8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Et1osVkHIug8tWjhr3sXGk2wuf1/5RgYf7rlMWLCYEl7A2NQZoJQjiOdgbVZy72jtVTKd5TQlfn43pj1j7mta+vAH4h4MCbk1YddRJ7ZW/j3KeLiGj9tI4XNBIagFBtLEwB2ulQy+wNco+Mm7hAzkk3pyvAgCnvcJ0+2uF6MXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRkTPBfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRkTPBfP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22864C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785787871;
	bh=NHpd7oFlUvnfyAAlJ4XIC8kt8eGF5T7MQDd+3WW1Xn8=;
	h=From:To:Subject:Date:From;
	b=nRkTPBfPpdW+plZx0Jdbt2q3ttQNtwuokLOe9C0swphvt7QlzlLhJtMW04sV6dd5l
	 hqe91DyD9tqAc7e7Jju8FcpS6WKoHSUeumhjZ2mu7Ozud4AGAx3avYOxWFKInuK8fX
	 9q2lG9Eaz8tMfIl2K0CNnglVEG+zwWvGpqHLnbBDaf+d/DJWAxKmZtS7+zUo3Spmmx
	 QhOIYXaefKirYlRDFOlMpcptC9Wie4ShQEF80FNDSPx//xfmin95a3KTabqFYQxtoG
	 3VuksBKmQHAQ2nQFIVlPosnNwchHQA8eG4ymbo4Jq1pdIki2PGn6QLv4XSJHOOX8LE
	 qdVh4Tha52eRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07B37C4160E; Mon,  3 Aug 2026 20:11:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] New: MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Mon, 03 Aug 2026 20:11:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

            Bug ID: 221832
           Summary: MT7925 (Foxcon T99H493.03) BT missing in lsusb on
                    Vivobook S16
           Product: Drivers
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: lnxps@bbtex.net
        Regression: No

Hi

I installed the Foxcon T99H493.03 2230/E card, Wifi shows up in lspci, howe=
ver
nothing shows in lsusb. It is a Snapdragon X1P26100 laptop. Wifi works
correctly
(after disabling power management which was giving delays).

Previously it used QCNFA765 2230/E card (Wifi did not work on the stock ker=
nel.

Linux A16 6.14-rc1-1-qcom-x1e #1 SMP PREEMPT_DYNAMIC Sat Feb  8 15:28:53 CET
2025 aarch64 aarch64 aarch64 GNU/Linux

The mt76 driver was updated from git to latest version, still same issue (n=
o BT
usb).

Ideas?

0004:01:00.0 Network controller: MEDIATEK Corp. Device 0717
Subsystem: MEDIATEK Corp. Device 0717
Device tree node: /sys/firmware/devicetree/base/soc@0/pci@1c08000/pcie@0/wi=
fi@0
Flags: bus master, fast devsel, latency 0, IRQ 224
Memory at 7c400000 (64-bit, non-prefetchable) [size=3D2M]
Memory at 7c300000 (64-bit, non-prefetchable) [size=3D32K]
Capabilities: [80] Express Endpoint, IntMsgNum 0
Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
Capabilities: [f8] Power Management version 3
Capabilities: [100] Vendor Specific Information: ID=3D1556 Rev=3D1 Len=3D00=
8 <?>
Capabilities: [108] Latency Tolerance Reporting
Capabilities: [110] L1 PM Substates
Capabilities: [200] Advanced Error Reporting
Kernel driver in use: mt7925e_git
Kernel modules: mt7925e, mt7925e_git

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 006 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
