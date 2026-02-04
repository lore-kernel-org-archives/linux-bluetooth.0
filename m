Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC11684B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182390; cv=none; b=RUuuhFcpIxojiryTURMPSSmz9E7xt9RPSFbTK0L7mn/yPybizKdTr3iBLGcqqE5J4TtKFByJ81N1dZ2p4oyOgwCjn4fl5NdAIjwQHkz3Wn4q7zJYtl0A/VVw9Du/fksixTRdjk/+lAHnqe81/yXftHY+k6/xcVhxQUJgPnJmVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182390; c=relaxed/simple;
	bh=87oSIjFZMA9NNBpEJH6BvUV4d/Fku5vRnhEC7gIG3dk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uwallenlAalnctwqlxtjQuEShS1zgRhVF7IU3kSZ+h1bJc4AHh3mmgWZxBb3K48cnAda/31nwd8rsHpQdyForheJ8XCRkBh8jrzjvbVQHwEN9bO4vLGWpUbwTi8Ah+JuT6x9MqyuXuUuQUZcYkSmQMEL+vY90MfPURfShEHmOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfRCXhmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfRCXhmD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAC7DC4CEF7
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770182389;
	bh=87oSIjFZMA9NNBpEJH6BvUV4d/Fku5vRnhEC7gIG3dk=;
	h=From:To:Subject:Date:From;
	b=qfRCXhmD08yo/bnnI5UCUHIAARJskzXsHOMSNFTUYVY5vZTCYQrCeT6vJE/+cbzWp
	 outzvtwYQmCdaq+nq6Ind/bmE2SEWFSu5MWQcfeymGyGXlQrPSb0MESluMvwrO3QNG
	 B5oArAYoO3FLuVmcw/d1ZsW0t9d7DnS00AggMIiZUJvwLMBn6iXaQ3cG+2ll8s1vr2
	 X/xCYwZINXhIxJQN019kN9GKVM/zf77LsHYcpQMz8pshgBvYEYllYj4ri1ySmzGJdN
	 Z5KdqLjBdlX5K7Qz7RLVv0PsuMvUDH1tNlp0XuZgF0SeLI3gahLdX9WXVM/D9nLQZc
	 ehm1/t/u8o7KQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C938EC3279F; Wed,  4 Feb 2026 05:19:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221045] New: Intel AX201 wireless driver not working
Date: Wed, 04 Feb 2026 05:19:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mnwhisperer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221045-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221045

            Bug ID: 221045
           Summary: Intel AX201 wireless driver not working
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mnwhisperer@gmail.com
        Regression: No

Device: Dell Precision 3561
Operating Systems Tested:
Windows 11 (Installed) =E2=80=93 Working normally
Fedora Linux (Installed) =E2=80=93 Wi-Fi not functional
Fedora Linux (Live USB) =E2=80=93 Wi-Fi not functional
=F0=9F=94=A7 Hardware Details
Wireless Adapter:
Intel Tiger Lake PCH CNVi WiFi
(PCI ID: 8086:43f0, likely Intel AX201)
Ethernet:
Intel I219-LM =E2=80=93 working normally
=E2=9D=97 Problem Description
The internal Intel CNVi Wi-Fi adapter works correctly under Windows 11, but
fails completely under Linux, including:
Fedora installed system
Fedora Live USB (clean environment)
This confirms the issue is not related to user configuration, drivers
installation, or OS corruption.
=F0=9F=93=9C Linux Diagnostics
Kernel module detected: iwlwifi
Firmware present: linux-firmware (latest)
rfkill status: not blocked
Secure Boot: disabled / not relevant
Driver loads but fails during initialization
Kernel log error:
Copy code

iwlwifi 0000:00:14.3: probe with driver iwlwifi failed with error -110
This error indicates a hardware timeout during device initialization, meani=
ng
the Wi-Fi device does not respond to the Linux driver.
=F0=9F=A7=AA Troubleshooting Already Performed
Tested multiple Linux environments (installed + live)
Disabled Windows Fast Startup and Hibernate
Full power drain (cold boot)
Kernel parameters tuning (iwlwifi.power_save=3D0)
Driver reload (modprobe)
BIOS checked (Wi-Fi enabled)
=E2=9D=8C None of the above resolved the issue.
=F0=9F=A7=A0 Technical Analysis
Intel CNVi adapters depend heavily on platform firmware (BIOS/ME).
This behavior strongly suggests a firmware-level incompatibility or defect,
where:
Windows proprietary driver initializes the CNVi device correctly
Linux iwlwifi driver fails due to incomplete or faulty firmware response
This issue is documented across multiple Dell Precision models and is not
fixable from the OS side.
=E2=9C=85 Conclusion
Wi-Fi hardware is not reliably Linux-compatible in current firmware state
The issue is hardware/firmware related, not software
Requires BIOS firmware fix, hardware replacement, or external Wi-Fi solution

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
