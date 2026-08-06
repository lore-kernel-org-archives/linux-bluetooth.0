Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22E3FE644
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007617; cv=none; b=J3z03uT0edOyPRWOampjGfgdBLEI2HviXlOoG8Qy9x1DdDbz67IinmnTJ36/r4TumXz+C1zOUJoP08o/kJCEDG7g/e77gnacn1CVc7eTynZUwKl3QAl5Pz5AeWfk8Id7T2Is9D6qASpKWreEtkorhbCRyXwTQgm4NvaNe2zK9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007617; c=relaxed/simple;
	bh=tQPbDMPMbS120plOlbQ0aq5QzPpa637+FhG14fLDWr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGlKUsPBZRL6hCIhr74C4/CHYRuG9VjREOJ9yoMSSWpNP6P/adKhrDR9Py1dRNcod/CVynHfRXIlTT2rvB6xyPgFSyLU5ur1LHUgrGbgSLnk++6wh2rvRkiP5UAaO4ORJF4zGJ2YPuNvTGXVorB9/YMxFNMbBGkQLtJqMolGapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNM8UfB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNM8UfB9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE5E1C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786007616;
	bh=tQPbDMPMbS120plOlbQ0aq5QzPpa637+FhG14fLDWr8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eNM8UfB9LvYQXuMNrLjmsULDkINBzeVNuNP7miMAzvss5adc9dH8s/sKwSIwSJNW/
	 4OpSdWd5w2vvNMcjt6yp1kD//HPs0zE+Q/QOh1qRggme3/vCfDbYdfxJaQWAUvGEy6
	 U8qvbkVp8MP2lpFxFda5AkajoepqeeAdQocii9T0xyW/w9APTvgC4XaU5DigS+gsN4
	 k3nfkYWsHfh2ZqxuqY9bVpiEqvlB4QaKpUs9gmd9fSDd9L7wxu5V9OZxF/yhWWpI/1
	 kKbYeHLY/hXURn4VseIhTACxjxMTVuQVFxkvvjhIHtP6L88o3ATY5R8u0sEoF6hQVs
	 kTvod8K27g/DA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACFDFC41613; Thu,  6 Aug 2026 09:13:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221840] Regression: Intel Bluetooth (btintel/hci0) fails
 firmware boot on 7.0.12, works on 6.17.10 (Dell Inspiron 3501, AX201)
Date: Thu, 06 Aug 2026 09:13:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-221840-62941-zh2RRcyubc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221840-62941@https.bugzilla.kernel.org/>
References: <bug-221840-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221840

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This kernel release is not supported.

Can you reproduce the issue using 7.1.6 or 7.2-rc6 **with** the latest
firmware?

Also, are you dual-booting with Windows?

If you do, make sure you have disabled hybrid shutdown off in Windows.

To disable hybrid shutdown (Fast Startup) in Windows, open the Control Pane=
l,
go to Power Options, click "Choose what the power buttons do," unlock the
settings, and uncheck "Turn on fast startup." Alternatively, disable
hibernation via admin command prompt using powercfg /hibernate off

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
