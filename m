Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94301C8605
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949976; cv=none; b=GomfXbIeQj99lTQZXn4FOMWpNQmiKSHpRhQCy5sUsSOU6a5ks5ZCtJ6dn1w97x8faRmwL3jFpg7pgvQgj+vEQxyO5zXpOBO9koCp457YZbMJ5VzUxPDNVODXKCCHh/LZbVGx5X5JO19gbPJI0oOC5qGXIsnAub7UyvUpYSgTERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949976; c=relaxed/simple;
	bh=Y3hPNA4gbEOMqjnWMMrDyHkTcEufO7vd9CoybOK9T/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMKNLSG12Q2YuHjHtugB3B7Oo2OlPo9hX3iEUhY97K9lHeKAJabFlEmK3ISpvJonfYsMWyEIJIk8Gx3vZ1mhKpsnATPXBJqDD2DleTcwb7qE0seDdVUVrrt+T6LoZEj64rS4glXnX0Z4pdXGDA+ex2YjAYP2+KIrBR7XAfGJaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTIZf9hG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTIZf9hG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7025CC4CEF8
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 04:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751949974;
	bh=Y3hPNA4gbEOMqjnWMMrDyHkTcEufO7vd9CoybOK9T/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GTIZf9hG1DQL8gBHJvrz55e4mmDhN6zHLT/D5dvyhXjAigoqCWUxqaLcT6r/OeJT9
	 atUhX/07ghoQr9yam7sFv1+tgIxkNLy65uV2FBED4TvYmrc9lUIKzFyUwiMo1/mIV2
	 4SngcFWP9GSiFb119YSLHJEv3uoWhMu5FEziWeujnet6NLkwoJjteZu+2WyNCz8YVe
	 tHEHpMaCD0eV3qCIoviOLW81djt7GA3X+HSvd4p0/AukHJNyBMxRMo1DgE9MJlq5h5
	 IXefDhYRoREx8Z+zmkU6jmmw8DD4Mf7JskdZALpe9zvKeLCRoeVfrYgZwvxupLd/TL
	 c03yz6otlE5Dg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6920DC53BBF; Tue,  8 Jul 2025 04:46:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Tue, 08 Jul 2025 04:46:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tynsareatger@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219387-62941-ajVT3sIayl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

potefa (tynsareatger@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tynsareatger@gmail.com

--- Comment #12 from potefa (tynsareatger@gmail.com) ---
We found some USB devices (keyboard, storage) will fail to be detected on
kernel 5.13 during boot, but it's working OK after re-plug the device. After
looking into the dmesg during boot, there's an error message as down below
[   39.350435] hub 1-0:1.0: USB hub found
[   39.398835] hub 1-0:1.0: 12 ports detected
[   39.622744] usb usb1-port3: couldn't allocate usb_device

Then we try to reproduce it on older kernel (5.4 and 5.8), there's no such
problem. After bisecting, we found the commit
https://github.com/torvalds/linux/commit/90d28fb53d4a51299ff324dede015d5cb1=
1b88a2
https://speedstars-unblocked.github.io makes the difference. It seems that
hub_power_on_good_delay is not long enough for this hub. The bPwrOn2PwrGood=
 in
the Hub Descriptor (please refer to the attached lsusb-v.txt) is 20ms, which
seems pretty normal when I check the same thing on other hubs. Can we total=
ly
trust this? Please suggest what we should do for this kind of hub. Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
