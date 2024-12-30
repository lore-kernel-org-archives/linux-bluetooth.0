Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E41A9B48
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568506; cv=none; b=L7CEkUpijqb/u1SW2tBB3quNhb/G1o/6KSGK8r26+BHN1JR1XgL6x8eA0et2aka5LHMJa63u301uoFncarM7vC0104s5IQAeVxz5/VUZzlKkK862hHLXX03qA3DoL4VbgBE0x/4hNd6+cP/n+qy85soe53GKvW9Kzshmm1QdXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568506; c=relaxed/simple;
	bh=1b6F0jNsU7pn6XKviURLQlXJyvLrMQh9Lnz18ycSxew=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bHakHWf6/y5VHebUhT/rvmwUDZF38ongyiLlc+Zb0vFzcVmeXbGtO0gIV1q41AKAqYJ1E4mxlezj8g5kcHS4/C4iWz/XarbqmjNG5JKb38L4EFSV6lIfJXdvutIVPhxxdi+ABGHF1pWPTHA7Yogs/Nzf9gxG2bbJwfmiusihcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZlBcPQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZlBcPQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 285A7C4CED0
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2024 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735568506;
	bh=1b6F0jNsU7pn6XKviURLQlXJyvLrMQh9Lnz18ycSxew=;
	h=From:To:Subject:Date:From;
	b=AZlBcPQ6n1rdnERrCJ0CQ8Mx7GiaPHPHgsZCMlT97rrFnJ+3sYnHm96qsF/ph9qRW
	 JM9TPO+yk0GKUVbFmgkIzLQK0W0EJbFIE5S8nJQkkfy78U8Yx0WVLjQYtReoxfXNfz
	 EbLRMPPjGXkbA/65XGUlb9cWC3UPkOjlHraJSssy1uMRQgpvWz66SzQfdJGaTw+ZC+
	 4vlMJJd3gctLa/ZNdyQilQ6PWfQfTd2BH2Z6fDir4qjNB+Lvmp2BzM4Cy0ciUO4SJy
	 Xq3kV8MbuIvJIDO4dUpTfU8Z85Go6L3Bj+MOQNh96h7UbqHNzcGO9h+//j7uVvYCsH
	 Spfsl9NTx0qwA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 124F8C3279F; Mon, 30 Dec 2024 14:21:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219642] New: graph xrun not-triggered
Date: Mon, 30 Dec 2024 14:21:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: francois5537@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219642-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219642

            Bug ID: 219642
           Summary: graph xrun not-triggered
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: francois5537@gmail.com
        Regression: No

dec 30 15:15:53 fedora wireplumber[1803]: pw.node:
(bluez_output.F8_4E_17_A3_5F_01.1-99) graph xrun not-triggered (0 suppresse=
d)
dec 30 15:15:53 fedora wireplumber[1803]: pw.node: (-99) xrun
state:0x7f67c9f99008 pending:1/2 s:9372234501939 a:9372234564499
f:9372234623413 waiting:62560 process:58914 status:triggered
dec 30 15:15:53 fedora wireplumber[1803]: pw.node: (-93) xrun
state:0x7f67c9f98008 pending:0/1 s:9372328286234 a:9372328361058
f:9372234547036 waiting:74824 process:18446744073615737594 status:awake


This causes interrupts in my Bluetooth audio, which isn't great when listin=
g to
music. It's on a Lenovo Yoga Pro 7 14AHP9.

The following warnings(?) also popup:

dec 30 15:17:33 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-52 noise=3D9999 txrate=3D1921500
dec 30 15:17:57 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-47 noise=3D9999 txrate=3D1729600
dec 30 15:18:16 fedora systemd-resolved[1397]: Using degraded feature set U=
DP
instead of UDP+EDNS0 for DNS server 192.168.50.1.
dec 30 15:18:17 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-51 noise=3D9999 txrate=3D1921500
dec 30 15:18:45 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-51 noise=3D9999 txrate=3D1729600
dec 30 15:19:05 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-49 noise=3D9999 txrate=3D1729600
dec 30 15:19:29 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-48 noise=3D9999 txrate=3D1225100
dec 30 15:19:51 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-49 noise=3D9999 txrate=3D1470200
dec 30 15:20:11 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-54 noise=3D9999 txrate=3D1470200
dec 30 15:20:33 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-50 noise=3D9999 txrate=3D1633500
dec 30 15:20:57 fedora wpa_supplicant[1625]: wlp2s0: CTRL-EVENT-SIGNAL-CHAN=
GE
above=3D1 signal=3D-45 noise=3D9999 txrate=3D1814800

For some reason it keeps logging this, or re-connecting to my AP for a reas=
on?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
