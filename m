Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0F7262E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749140; cv=none; b=lnHk6HF0g/SGAEOiNqxhG/R2XmK6qlSV0TrAOHZZ2x+pPFFNvMAzgUbl/z/t0rBUfaaHrS4+h6Okam72BoUKh42+TMwiC7kt6T0b2icyPGBY8n7TQBXs5iNUPVyx+AezffuKMXHsye4EYSS6QdO79e53rADDQ+kELMU2NKNj2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749140; c=relaxed/simple;
	bh=bcMN6VpF0Vnjv7TNqxnH9px4A82fDOLja7XJOi9yNVQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ABMIP3dKqoNgrGv+qbcxcZAkEbyNefuKsiUsOQ6ZfT3kHK/YzbLUZX2McvK/a2XPUq8B3N1uIPjlS9BFBmp1c4pH7SEvrVQdrOodkvaJ6M+LBpggYbiom4GiEa75VeyEKn0VdINaO9UReOlY8aog0xxNzRp830lkYzG3CiqUEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHQ3CPGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHQ3CPGX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA880C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749139;
	bh=bcMN6VpF0Vnjv7TNqxnH9px4A82fDOLja7XJOi9yNVQ=;
	h=From:To:Subject:Date:From;
	b=eHQ3CPGX+rYIWcHGHtEuiEhiAqD6qR6Xap5ljfOh1kna2EW31u/zSzP9udBxFaqec
	 Lo5q9Rj1RMh18dhudG0VNu8lxAvCJ6wCetFgK/02HBVOucdON4IMSWviaGKKz4BNS9
	 DTPyKfyMgBOe8r0v7QsYDZtxjmbbz0RM1IGIY8L1GH5cA7G9Xo/iKZI0iWfYQGjpGI
	 4jrVtpRy9/SQBb52BRaQ3jQZz0pdGDa6Zl3Jkf5UKzXeHxEM76HdCozcRNCUqK+CzP
	 zj2Dgh/wgQqEnM940ff6qGXW/jOYnkE6HnJ/d55wrYVsNfUdR3yL7SRuFJ006fBGHR
	 tHa6gJlbbAG3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D6F0DC433E1; Thu, 17 Jul 2025 10:45:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] New: Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Thu, 17 Jul 2025 10:45:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tal.lich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

            Bug ID: 220344
           Summary: Intel AX211 bluetooth randomly disconnects and
                    reconnects, started after kernel update
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tal.lich@gmail.com
        Regression: No

Bluetooth devices disconnect every few minutes. Tried same devices with ano=
ther
laptop with same hardware but Windows OS - works fine. So this is not the
devices or the Bluetooth hardware.

Every time the disconnect happens, dmesg shows:

Jul 16 13:47:24 licht-t14s kernel: Bluetooth: hci0: Retrieving Intel except=
ion
info failed (-16)
Jul 16 13:47:24 licht-t14s kernel: Bluetooth: hci0: Hardware error 0x0c

I have tried:
- Downloading the newest firmware file from linux-firmware (file
ibt-0040-0041.{sfi/ddc}

- Setting the following options in /etc/modprobe.d

# Disable power saving in both iwlmvm and iwlwifi
options iwlmvm power_scheme=3D1
options iwlwifi power_save=3D0

# Disable bluetooth coexistence to avoid BT issues
options iwlwifi bt_coex_active=3D0

I have read on Ubuntu's forum (here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051720) that this may=
 be
a regression in kernel 6.5 but I'm on a newer kernel

Hardware info:
System  : Lenovo Thinkpad T14s Gen4 model 21F60051IV
BIOS    : N3PET23W (1.14)
Adapter : Intel AX211
Firmware: 133-20.25

OS info:
Kernel  : Linux licht-t14s 6.8.0-60-generic #63~22.04.1-Ubuntu SMP
PREEMPT_DYNAMIC Tue Apr 22 19:00:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
Distro  : Ubuntu 22.04.05

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
