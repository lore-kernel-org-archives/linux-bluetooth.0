Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961E128385
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106569; cv=none; b=aTy7fmy26Oj02LsycMyMGmKbyhXYIQ26r9yzms7Sf+NY0dmXFvNAaG1w176yB4FdTFdEOCzj4tpUJkFAMn0WsDCT/DKlgGfwrKcGezbZ7bY9PiKGpikv8m1Fl3E73+pVjU0gp4XOLRQfF8jK708bA6v779BiyEFV6sMh5exfkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106569; c=relaxed/simple;
	bh=tqp9J7GOMGaTufFoUfg8JugUWD3/Kf85AUkjG5qUPm4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LaAbkRbvKEsZ2nV/27OnKIKStQLOHasPtA+E0anKHERvBG9AXJOh/OC1pShBdSjeUp9e99KqQlP1iFJjERCZ/kS6Wccwf/q0sz6os964x2jZUvOKcuqSQ/2dzAqKB2vaVRhBdeSiGHOmrncTCOz24setGlWIJHJwAkEXcD/+164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3KWQ1mh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3KWQ1mh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51874C43141
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106569;
	bh=tqp9J7GOMGaTufFoUfg8JugUWD3/Kf85AUkjG5qUPm4=;
	h=From:To:Subject:Date:From;
	b=b3KWQ1mhu1rzbIrFPPRsaiVSd4JitLhGw3Kts53QAeIblmUT/WzeQGVCfrGt+4gqS
	 uaoqRRVXamMWTtfm4hzUNjNXM/F+ElXS1X5p6dZ/BCjqlvFRHbYFN6mx2q/enHvDsL
	 HgInSTHmYPWnWcLyJ/oupPRUsJqicZasItSQH2qKFQn3pX9T6BeA+LpdjDDHPByEzN
	 CVGEiP7sDaMxWtmc9dwIcGNtLH0ZkjmIxMa+klp8QCYekaW+PUiuwvHGbxB5nTap3T
	 FJpZDOZeYqjTFNDJRWygztKobdxmQ/D8z4+4bB0zJlSf1BGVLXE2UEQnP2WiDov3Hu
	 P6Q1EjTis86Jg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2EB98C4332E; Wed, 24 Jan 2024 14:29:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] New: hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Wed, 24 Jan 2024 14:29:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218416-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 218416
           Summary: hci0: command 0xfc05 tx timeout in kernel 6.7.1
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nickolas@gupton.xyz
        Regression: No

This issue is still present on kernel 6.7.1 and firmware 20240115.=20
Opening a new bug for this as directed in this old bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

$ uname -a
Linux andromeda 6.7.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 21 Jan 2024 22:14=
:10
+0000 x86_64 GNU/Linux

$ lsusb | grep -i bluetooth
Bus 001 Device 006: ID 8087:0029 Intel Corp. AX200 Bluetooth

$ journalctl -b | egrep -i bluetooth
egrep: warning: egrep is obsolescent; using grep -E
Jan 24 00:20:24 andromeda kernel: Bluetooth: Core ver 2.22
Jan 24 00:20:24 andromeda kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
Jan 24 00:20:24 andromeda kernel: Bluetooth: HCI device and connection mana=
ger
initialized
Jan 24 00:20:24 andromeda kernel: Bluetooth: HCI socket layer initialized
Jan 24 00:20:24 andromeda kernel: Bluetooth: L2CAP socket layer initialized
Jan 24 00:20:24 andromeda kernel: Bluetooth: SCO socket layer initialized
Jan 24 00:20:25 andromeda systemd[1]: Reached target Bluetooth Support.
Jan 24 00:20:25 andromeda NetworkManager[790]: <info>  [1706077225.3441] Lo=
aded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.44.2-3/libnm-device-plugin-bluetooth.so)
Jan 24 00:20:27 andromeda kernel: Bluetooth: hci0: command 0xfc05 tx timeout
Jan 24 00:20:27 andromeda kernel: Bluetooth: hci0: Reading Intel version
command failed (-110)

Not sure what other logs or info you need, but just let me know if it would
help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
