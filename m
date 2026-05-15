Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC547F2C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847149; cv=none; b=RmN5jR0IvjII+s9LHnXVYIIkd0td4YdBzC3R9v8hAmaibcZPBoR6lBw421azawYASyIkhsN5jRotn6VyGkvPwzwvwMUN6kTs0FCKGwcZXZkR0eSfRc3lq68oi9ldelh1+2OtNHB2SiZhg0PI7fFWkkxMa4LwOXq3ntLaor+BPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847149; c=relaxed/simple;
	bh=K0Wzt5PsOlJBEFKjqLEBH2yTKRAGGxjrZ4Sj7zNz5+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YF4Def43speFQ0Gdr1XkY9nvfv6clx3+GWU/f80pxu7wyS/Z1NFUlhudgXQyU7yHsaRUv1B0z0UhnqfPouKiFP2AjWqbrwSiPyBfGYfqG0cZFbTPAHRlJTiYjZ3QXsZwXhfLKs7aLpHRx7/nVc2cfgx/VkuNwtNJTzudkCbZ3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAtPVcEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAtPVcEP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF82BC2BCB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847148;
	bh=K0Wzt5PsOlJBEFKjqLEBH2yTKRAGGxjrZ4Sj7zNz5+Q=;
	h=From:To:Subject:Date:From;
	b=AAtPVcEPHMHyYTsjKcwxWZtCPKursTceG5u7mCI1MKzh7MbwJ81e5JC/+bHgtnsJZ
	 lWFbyzJiuAZrQ4pP3uVgcT+EjUGUogHK7V/97CGjqZpndw9Z+3z2OqLxbPafnuUKa7
	 AG4qcQnhmWvBV0HMs3XLGagDh7as/TunglqfImvZzlL2FbtJ5/xx074z3QugG1ozvv
	 ZIqjigybXqLs9laR694n8jHYfUlBZAUBGUondgtWeKmhRC/KpMBn55zuRJj0L6QzbO
	 VkzjvE0P/qyR3f+SUDPKWuYVxN0LZXAW1OrEM+4WWjpU2VJ7AKiS2R8bVn3fBfkPOs
	 YockVEyplQQ2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AD300C433E1; Fri, 15 May 2026 12:12:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221524] New: Intel 8265 Bluetooth (8087:0a2b) BLE connectivity
 regression observed after kernel upgrade.
Date: Fri, 15 May 2026 12:12:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: t.darcin10@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221524-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221524

            Bug ID: 221524
           Summary: Intel 8265 Bluetooth (8087:0a2b) BLE connectivity
                    regression observed after kernel upgrade.
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: t.darcin10@gmail.com
        Regression: No

Regression report:

Intel 8265 Bluetooth (8087:0a2b) BLE connectivity regression observed after
kernel upgrade.

Environment:
- Debian 13 (trixie)
- Kernel: 6.12.86+deb13-amd64
- Previous working kernel: 6.1 (Debian 12)
- Bluetooth driver: btusb
- Device: Intel Dual Band Wireless-AC 8265

Problem:
BLE hearing aid device becomes unusable at normal distance (~0.5=E2=80=931m=
).
Device only works when placed directly on top of the computer.

Classic Bluetooth devices (mouse, keyboard, phone audio) work normally.

This indicates BLE-specific regression rather than general Bluetooth failur=
e.

Kernel logs:
----------------
iwlwifi 0000:3a:00.0: missed beacons exceeds threshold, but receiving data
Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not
supported
----------------

Observations:
- Wi-Fi and Bluetooth share Intel 8265 module
- Wi-Fi shows occasional missed beacon warnings
- Bluetooth firmware loads correctly
- No general HCI failure or device reset observed
- Issue is reproducible and consistent

Expected behavior:
BLE devices (hearing aid) should operate normally as in kernel 6.1.

Actual behavior:
Severe BLE range degradation only affecting hearing aid device.

Reproducibility:
100%

Regression:
Yes (worked on kernel 6.1, broken on 6.12)

Likely affected area:
btusb / Intel Bluetooth LE / PHY handling in kernel 6.12

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
