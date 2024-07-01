Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F8381CC
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858828; cv=none; b=A9UMTZZtbZyNaDCzQhL+bEt959C7YwE9f01Xpa5iL5s+abdvD+UCEPeaeIx5wG+h3HEFnV4mxcizsIq/dm/6MMRbRWYU1/A/6eSjlQFkBGXdgnEYzjxvGEe2NKHsDLIELBmnPl6YYVsE4n7Banb0Uyu1qeD+kYd/z8YXtmGd5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858828; c=relaxed/simple;
	bh=2aB+qkkglFM+L+jOIBdSVM+pvHuBvoKxXdAOtsEyyas=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h22W4lN1ja3mjqoe7LLJ+NepzEJa2A5RWlsEjt075K5ZW/MKFe1AKEd1rPqpD93hdonhJcUUlZbF6+eeJUtSbUO5afAJaflDjcTxY3vQ5oDi6IlOsswZoK+hqyRe0rj0y89/Bz78awnMTsuG79G34jE1SzCOLP1mIPip/jULyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA/0KGZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA/0KGZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F164FC116B1
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858828;
	bh=2aB+qkkglFM+L+jOIBdSVM+pvHuBvoKxXdAOtsEyyas=;
	h=From:To:Subject:Date:From;
	b=aA/0KGZ4utJVBKDp0FwaI1jrJPcu9tpZpNR+6T+6rkfwvpgpLKP3iGNklYYl/z19U
	 tPIIFkC7sQszAFzmZwhZLmrPZo2yCSbsuHGA1C8yJ6l+HH/USgCxXWSGyAqIUgsPzk
	 R1jbD2epn0b755LK78w8oEGp+j10O8bkD/AXwa3+6cjpgJTAXtpmOPTqmozXT8GTTb
	 apv96Rl2G9UC2Q3QF1IWodT1rYHs5gLkoC9vqavAev7NKjtkKXn0UV0p3X8dQWkGer
	 zdcsEfPdK/9OcCjuKGvlyuwjdwLhWooKZVStQ9WxgOkfLysKNi6q18O8O+6pIrBBw/
	 meMqprZ6S6Gsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DED11C53B73; Mon,  1 Jul 2024 18:33:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219001] New: mt7921e: hibernate/resume not working | Bluetooth:
 hci0: Failed to get fw version (-108)
Date: Mon, 01 Jul 2024 18:33:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219001-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219001

            Bug ID: 219001
           Summary: mt7921e: hibernate/resume not working | Bluetooth:
                    hci0: Failed to get fw version (-108)
           Product: Drivers
           Version: 2.5
          Hardware: Other
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: g.wenzel@gmail.com
        Regression: No

uname -a:
Linux WorkStation 6.10.0-rc6-x86_64 #3 SMP PREEMPT_DYNAMIC Mon Jul  1 18:43=
:43
CEST 2024 x86_64 GNU/Linux

Before hibernate:
dmesg | grep Bluetooth
[    0.270447] Bluetooth: Core ver 2.22
[    0.270451] Bluetooth: HCI device and connection manager initialized
[    0.270452] Bluetooth: HCI socket layer initialized
[    0.270454] Bluetooth: L2CAP socket layer initialized
[    0.270456] Bluetooth: SCO socket layer initialized
[    1.471456] Bluetooth: RFCOMM TTY layer initialized
[    1.471458] Bluetooth: RFCOMM socket layer initialized
[    1.471461] Bluetooth: RFCOMM ver 1.11
[    1.471463] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    1.471464] Bluetooth: BNEP filters: protocol multicast
[    1.471466] Bluetooth: BNEP socket layer initialized
[    1.471467] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    1.471469] Bluetooth: HIDP socket layer initialized
[    2.732306] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20240409163648
[    2.856373] Bluetooth: hci0: Device setup in 122972 usecs
[    2.856387] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[    2.918594] Bluetooth: hci0: AOSP extensions version v1.00
[    2.918600] Bluetooth: hci0: AOSP quality report is supported
[    3.172736] Bluetooth: MGMT ver 1.22


After hibernate:
[   62.612499] Bluetooth: hci0: Failed to get fw version (-108)
[   62.612507] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.


sudo hciconfig hci0 up
Can't init device hci0: Cannot send after transport endpoint shutdown (108)

[  163.699941] Bluetooth: hci0: Failed to get fw version (-108)
[  163.699961] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.

Unload and load modules btusb btmtk btintel gives the same result.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
