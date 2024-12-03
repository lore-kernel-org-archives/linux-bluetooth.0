Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E911FCFD3
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247887; cv=none; b=RkL02VzCbYt51WVjk0ny1YBdtMk4MZ+Xh6fR3o6+cbZtK99e7hnHxsknIcXCDzPCUSTG4BlH0od31s3KNd1xmg+5y1VBGZghAalALuHeXhdp4b1/NxsPtRvI1hiZRnJs4TEoRHLocZn3oD/8pclyJlRCsSkfnqnOo63qEK+8ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247887; c=relaxed/simple;
	bh=FUutbdCG0C2PL4Xp24zici+BXMDldxMFLgRKlhm6tXw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jbBHQ7+GOU1ATzFC/NnbEK3YQ7R4i+F23vHGB6TJNSXgoC0w1Rc/4PHM2CNmoyL1yT1ust14bbZEqnI7pGmumRQ9IaeR8MtMayPpyu8uhTPRoNqu1MzFAj1UbUmprHjokdFM46yBe0ZO5PMrxj1wxIgfOtFpN0TFfKFIbQqxecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tepWXfgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tepWXfgk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72137C4CECF
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733247885;
	bh=FUutbdCG0C2PL4Xp24zici+BXMDldxMFLgRKlhm6tXw=;
	h=From:To:Subject:Date:From;
	b=tepWXfgkSHTchbw87RAXjBu1X4Wl9R/gGGDqX4ZMcFGNy3ERM1evyqztogQCRJhvC
	 p1n0OQcYx5NUnJ0EiPOrolz2Ra83dCwCDB2O8ftk2oTIHSMH6mpkscjtUBnrp7K0xl
	 /PLYlhJINtIboyC65VPz+vyvjqEQe1lWbIHDvfciBqaZ5FRtRZ3gsP3njjKRqNa3Ti
	 EJ3Ymdj/0ObckF/J4DdzdKVgvQ+lp98Foi7PmHl1a+e/ouOslnaK3UCsj2a6NYFWHk
	 zlER0UQcrBBTIRkMp397BSA9qWO2pry/7924DNQg0iPbBT384qc97OEfIOd5J/EqxD
	 MJTMEXI68FL9g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E3A3C53BC2; Tue,  3 Dec 2024 17:44:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219553] New: Intel Corp. Bluetooth 9460/9560 Jefferson Peak
 (JfP) not able to connnect to Logitech MX Master 3S
Date: Tue, 03 Dec 2024 17:44:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: joachim@falaba.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219553-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219553

            Bug ID: 219553
           Summary: Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP)
                    not able to connnect to Logitech MX Master 3S
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: joachim@falaba.de
        Regression: No

On OpenSUSE Tumbleweed with kernel 6.11.8-1 and firmware version from 20241=
125
it is not possible to pair the device with a Logitech Master MX 3S mice. Ot=
her
bluetooth devices are working.


Pairing the same hardware commbination works with Ubuntu 24.04 (noble) runn=
ing
kernel 6.8.0.


The maintainer from OpenSUSE suggested to file a bug report here, since he =
has
the opinion, it is an upstream problem. The bug report for opensuse is here:
https://bugzilla.opensuse.org/show_bug.cgi?id=3D1233733

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
