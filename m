Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14B1A2C04
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436010; cv=none; b=Bej+bTtJlFBMpWG6QvUpjmwHDNSr1EuxHaGTbB5r3Zpyt/4uOKEZmnV7bbLllZj3Dq8G1fghf6Ky7MTxbhkLIIeJ1gGzGwiSPnQK0pWJRt8yBnInoGx7E9HKBBzrGVnR7WVPyylHaheKYuLvbDzPKs4ouTEQW5rR7L69A5vPyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436010; c=relaxed/simple;
	bh=JQo8bujBtT/HfHZcBxoTMXXSMNvqzjSOKtpmgRsb6ms=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cCRqnghwMXEhjWol0qxjPpZD7/45RVRQ9ZZ7zDO2ZNW4Rnun2r0nN0T7rSG8Rg2eGD2mhX6Cz2xpAAkp1ugYQndLv8R2Ic9Dj1Yw7XLjTTjwqn2hmci69Anw6edbfTbKCNg31ApzbWftOm4O1LXziTam5nyTYfRH18/yPb5HAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgfjbT+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgfjbT+s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FE44C4CEEE
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751436009;
	bh=JQo8bujBtT/HfHZcBxoTMXXSMNvqzjSOKtpmgRsb6ms=;
	h=From:To:Subject:Date:From;
	b=EgfjbT+soC9QxklUisu//sDRnmOcYp5dxy9doBDV1DjtznSEmtxX0Y4DszqEi4QWW
	 q/9AdgBCy7oBisEaZRlryMD8hRkV8QiCmBGf+9dBw6EknUEH1KRwI8RGlevWgz+1cb
	 7KofURQXji3NecHZTTifVflXgaoAj7vrTpwxTIMazdCh6omKR+0ED9kLzB1ReRz7Ec
	 2AE97nBN8pMcoAnVPPwRsbUAeEha8mIXsTofad15uO3Wg2izDqLzgdWflrV3AWexvx
	 JCbGIWrCBdAe8pkQ+czRIAfxK9trgY7be/8sA4+JJNJQAVzhxmlM30gGqYIsc2O3SE
	 LEkTcmWKIcDzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3BE6C3279F; Wed,  2 Jul 2025 06:00:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] New: Updated ibt-18-16-1.sfi is bugged, "Invalid
 exception type 03" kernel spam
Date: Wed, 02 Jul 2025 06:00:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

            Bug ID: 220306
           Summary: Updated ibt-18-16-1.sfi is bugged, "Invalid exception
                    type 03" kernel spam
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

I've updated this file to=20

sha256sum ibt-18-16-1.sfi=20
3d83c90093885eb110ed1827226297bf5ccf9b0c4aa16de712919081a834c970=20
ibt-18-16-1.sfi

and now my dmesg is full of:

[   10.704037] Bluetooth: hci0: Invalid exception type 03
[   13.613626] Bluetooth: RFCOMM TTY layer initialized
[   13.613631] Bluetooth: RFCOMM socket layer initialized
[   13.613656] Bluetooth: RFCOMM ver 1.11
[   18.818070] Bluetooth: hci0: Invalid exception type 03
[   78.989481] Bluetooth: hci0: Invalid exception type 03
[  138.998240] Bluetooth: hci0: Invalid exception type 03
[  198.988335] Bluetooth: hci0: Invalid exception type 03
[  259.008424] Bluetooth: hci0: Invalid exception type 03
[  319.022512] Bluetooth: hci0: Invalid exception type 03
[  379.032608] Bluetooth: hci0: Invalid exception type 03
[  439.032710] Bluetooth: hci0: Invalid exception type 03
[  499.031808] Bluetooth: hci0: Invalid exception type 03
[  559.040907] Bluetooth: hci0: Invalid exception type 03
[  619.035006] Bluetooth: hci0: Invalid exception type 03
[  679.036094] Bluetooth: hci0: Invalid exception type 03
[  739.051204] Bluetooth: hci0: Invalid exception type 03
[  799.042305] Bluetooth: hci0: Invalid exception type 03
[  859.040404] Bluetooth: hci0: Invalid exception type 03
[  919.052508] Bluetooth: hci0: Invalid exception type 03
[  979.052623] Bluetooth: hci0: Invalid exception type 03
[ 1039.059698] Bluetooth: hci0: Invalid exception type 03
[ 1099.078826] Bluetooth: hci0: Invalid exception type 03
[ 1159.096913] Bluetooth: hci0: Invalid exception type 03

My hardware is:

Bus 003 Device 002: ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Ada=
pter

I've also updated from 6.14 to 6.15 but I feel like this is down to firmwar=
e.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
