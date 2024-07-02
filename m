Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE115ADA6
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963304; cv=none; b=PkxnKzxtZHFUHJYZRAoEp4p5IAqyFyaFV3+wjOAqfexNUGv8arirdHNfGP0E341dk3hsQAFqKKsQ0Cyie8xzIzzG8xda7X/vmr3q1P49X2hxZlvwgHX+O1W59opYz4NaLiF4+mjlz3Hoztg8oHrXPInMcEBHViocHlLHkT/Wxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963304; c=relaxed/simple;
	bh=UBEwx1pTBTIPD4cniIxI42gNFOPYVThMm+EBLv7u1jg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kYoVs56+LNpl8Kzd7lsT8tB1E68q0k9nEKVjASntUNdLGV3iJicbygusRHWt9n3bN+pDPQ5p1w/QX5NovPbFqVZKNJvlUjz0QI2RcfvG/Eu2RYEoS1EpTHJvjaN4bBHin1QvIczDAzueBHcEZEwXO6QllmWp/i7Ti13qxm/R5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbyr3jQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbyr3jQl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93874C116B1
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719963302;
	bh=UBEwx1pTBTIPD4cniIxI42gNFOPYVThMm+EBLv7u1jg=;
	h=From:To:Subject:Date:From;
	b=Jbyr3jQlgIrQH4AcIVehTtZF/OYjisVsCNquaqQJws18ls55x4+LWBuzL3q1yDP/a
	 lrLI5zgP/T1fKJ6qd7Y+7OCdgyvWKnkp9zEEX5nYp/t+vqJirJUeBSU1Xxi/X2al2c
	 ikQHHmtTCiR9c4ajumov3Ba4Pt7W4mxhKp7cpdDFnd/gir8VnZEzxLMT6pHd3b0gLC
	 fWCEXo1oZlTRAedOAXT+q2WJiQ/jEuzUv+4VSGvjjW2QpwcKHb9tq1C9LLE+EkmpoU
	 4WZuXWHqovT08mEi3zvAoqlBxzRiCCf45c5m784qlHIchSlPpKBBQgCpluXYYwFYQ0
	 dLAnONFWPk1/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8166AC53B73; Tue,  2 Jul 2024 23:35:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219003] New: "Bluetooth: hci0: corrupted SCO packet" on W800BT
 on kernel 6.9.7
Date: Tue, 02 Jul 2024 23:35:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brauliobo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219003-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219003

            Bug ID: 219003
           Summary: "Bluetooth: hci0: corrupted SCO packet" on W800BT on
                    kernel 6.9.7
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: brauliobo@gmail.com
        Regression: No

On kernel 6.9.7, I get several errors "Bluetooth: hci0: corrupted SCO packe=
t"
on dmesg while playing audio.

On the user side, the Edifier W800BT audio is interrupted by several seconds
and gets back by itself. It happens at least once every minute.

Reverting to 6.6.36 LTS solves the issue.

The dongle used is Baseus BA04 Bluetooth 5.1 Usb.

Below is the messages on linux 6.6.36:
braulio @ phoenix =E2=9E=9C  ~  sudo dmesg | grep -i bluetooth
[  131.956823] Bluetooth: Core ver 2.22
[  131.956851] NET: Registered PF_BLUETOOTH protocol family
[  131.956852] Bluetooth: HCI device and connection manager initialized
[  131.956855] Bluetooth: HCI socket layer initialized
[  131.956857] Bluetooth: L2CAP socket layer initialized
[  131.956860] Bluetooth: SCO socket layer initialized
[  131.981550] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D0001
[  131.981554] Bluetooth: hci0: LMP ver=3D9 subver=3D0001; manufacturer=3D2=
279
[  131.981555] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[  131.981556] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[  131.981558] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[  131.981558] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[  131.981559] Bluetooth: hci0: HCI Set Event Filter command not supported.
[  132.050598] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  132.050603] Bluetooth: BNEP filters: protocol multicast
[  132.050607] Bluetooth: BNEP socket layer initialized
[  132.631669] Bluetooth: MGMT ver 1.22
[  132.677355] Bluetooth: RFCOMM TTY layer initialized
[  132.677364] Bluetooth: RFCOMM socket layer initialized
[  132.677367] Bluetooth: RFCOMM ver 1.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
