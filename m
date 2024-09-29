Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A738F6D
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727619923; cv=none; b=ifyycSPsFc34h4PmhAI3pgQP2+fhbNtrdZiJlrdL1MN4eJgTQSEvM/79rRpLaLuznfR3s0n4y/LxBX/plfK9G2g/sV3uefUbriUI3pO1rBkRWIO6c6NFdRyqj5ooX8JzceMFp969GIyCKEtwoTEVdSguTjuFoqis9MxLNegWx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727619923; c=relaxed/simple;
	bh=od7GWESD9UjUP8+r4IT91FQiu2xMGcOSFRhiTMLAsgk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HFz7zzAPMzwLOza5ms5c3jWOynca0n0WhjpiSp0nHlhW0NfQlwh9xnFFtgmK3nthEot6WGYuusTBzZsO/gRu+tXKwF0a2tXFkuzCTBzNkxS+Z1O6pAc9a/7WtW6PhQl+XXio8CsxAvvFlo4C/1VsNn9Uf7GDe23GA/CicRVSkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbD5ZSDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbD5ZSDN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C687BC4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727619922;
	bh=od7GWESD9UjUP8+r4IT91FQiu2xMGcOSFRhiTMLAsgk=;
	h=From:To:Subject:Date:From;
	b=fbD5ZSDNq6oMsWLLdXAWip8ZatNVMhnOsz5gTaX8x9mPW4TTW/QBGWoZ1wH+42dQj
	 CilKBXvSQHgwvtHYmJtnGO3G8U3d0RvZcEC29HPMDNqUQ3KTVruoG2LMleLEG9aGJf
	 0A7OA8z3eL3fh3AVT+fXVtEF3P2gPV5ogtMLbSJ1TTF1dYlLG8c47CtwHdYPVDRNof
	 ple9eBNo+nQBybHxWD+nY5rvafkz2Yq7GfdfZ+pwzNFX5J30/It6K5OkRZ1KLoKBuM
	 C6OuNCBQOUxck19rG0LW1oKdCPFHTH5gyWQ14G7TCk7gZbeUdrM6fpfcl3kakTb6C6
	 f4+ow1+NmJFkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A74F8C53BC1; Sun, 29 Sep 2024 14:25:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] New: Bluetooth: hci0: Failed to claim iso interface
Date: Sun, 29 Sep 2024 14:25:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

            Bug ID: 219333
           Summary: Bluetooth: hci0: Failed to claim iso interface
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hi Kernel Team,

I notice this today:

[    4.905762] Bluetooth: hci0: Failed to claim iso interface


sudo dmesg | grep -E "hci0|Bluetooth|mt7921"
[    4.885029] Bluetooth: Core ver 2.22
[    4.885155] Bluetooth: HCI device and connection manager initialized
[    4.885163] Bluetooth: HCI socket layer initialized
[    4.885167] Bluetooth: L2CAP socket layer initialized
[    4.885173] Bluetooth: SCO socket layer initialized
[    4.905762] Bluetooth: hci0: Failed to claim iso interface
[    4.974335] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20240826151221
[    5.254490] mt7921e 0000:02:00.0: enabling device (0000 -> 0002)
[    5.358338] mt7921e 0000:02:00.0: HW/SW Version: 0x8a108a10, Build Time:
20240826150948a
[    5.386732] mt7921e 0000:02:00.0: WM Firmware Version: ____010000, Build
Time: 20240826151030
[    6.227084] mt7921e 0000:02:00.0 wlp2s0: renamed from wlan0
[    6.778672] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.778675] Bluetooth: BNEP filters: protocol multicast
[    6.778679] Bluetooth: BNEP socket layer initialized
[    7.884984] Bluetooth: hci0: Device setup in 2909392 usecs
[    7.884989] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[    7.957660] Bluetooth: hci0: AOSP extensions version v1.00
[    7.957666] Bluetooth: hci0: AOSP quality report is supported
[    7.957820] Bluetooth: MGMT ver 1.23
[   15.301241] Bluetooth: RFCOMM TTY layer initialized
[   15.301252] Bluetooth: RFCOMM socket layer initialized
[   15.301258] Bluetooth: RFCOMM ver 1.11


Kernel: 6.11.0 stable.
OS: openSUSE Tumbleweed - 20240927

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
