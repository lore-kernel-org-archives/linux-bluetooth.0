Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C41DAC9C
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158706; cv=none; b=VrSggdP5nwFR7RDSnCFzDKppCnppIVNkaDBAFa3nKWqEOMv7+kpEBKOj6skMrzBc1yoYd5qBzbTIdE/fr1Z0ZmBa0xXLnWIHUgv1862n/0wI3s/UWnxeNEHLc+jghJIONHcpnusF8xokt6scb8CV97uziaUJFaikyxcBRQ4Ak5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158706; c=relaxed/simple;
	bh=NjlixOidwYQNbE975zyXd5hDBNVu5eapa7pl3BDw2H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0sTwrplenzV/ygM6IWRAzoyXIsTaj0R8yBKMqDaJOLPnjkStbJUUXDcw05LRLQy4Unv8la7SIu5jHel8Z5s0BWaijXwby+25QYhcLlh76enwf37XJiuXc9IIs7fXkymTh5jkilcD4n1tOZ/JQaPUpzwjRU72VLwe8aouP5ni4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWiA+5HB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWiA+5HB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 723DDC4CEEB
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736158705;
	bh=NjlixOidwYQNbE975zyXd5hDBNVu5eapa7pl3BDw2H0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mWiA+5HBmOtJF7YD13lWUSbJB0LEvd2+YJtah7dJHNtdjJ5L05VdG5OsW2gC2BqYr
	 +XiM5lLsEc615NTnPU/1wu6a7RbccMSNLNu/FM70isrCj5hhS8D1wXN/CPsvQbQzY/
	 DPr5Y+X0YKKebt+fj2ySXnfKfch2Cx/CngHpIsiW7BsIvFFRC+vACxW8vRdi3sGPtw
	 RGHzYayYu1Fri0tUN21mfoZRWTBHUrwxHXH/AXlRRqmB38wrMGO4u0EEw6SROlmOqd
	 tHyqckjkwuHTPoNNmih4uqMHp5tst3ifE3gK54IdFev7PKzQit0bIm3CvBUquJNkxX
	 QhbRp6crgybDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5CBC3C41616; Mon,  6 Jan 2025 10:18:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 06 Jan 2025 10:18:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olivier@croquette.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-JwLtmJQCbq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #9 from Olivier Croquette (olivier@croquette.de) ---
Thank you Bojan. I now do this to suspend:

sudo rfkill block all && /usr/bin/systemctl suspend

And after waking up:

sudo rfkill unblock all

So far, it worked twice in a row. Let=E2=80=99s see!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
