Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB42BB13
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685038; cv=none; b=Xib6xWQKuHSgRlIaAFSdqQAzN0dMs2JkD8REMvkk0v1faqnQk2AbhcM2FCUjcVVBLbpTvfUqbw9M3mAd5EdoZGvK2iGK8qXJRVLEz0pVDuJ9Bsm6sn/A+0iQg7qF5iiKHm6crRT7uYpjoJENv/7sMOleUtUNPwbV/mFQDGyBks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685038; c=relaxed/simple;
	bh=HagPh+ezF+sFGOobXqxn2VeNb4yl6eFydwsgdBl5/pk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUU7Wz5LbRzXpleCMFaiuePqrO9vVrFPWmDaGsK5JcUyLcHNkyqVlVg7PUgoRPFZLa8cAqCWO3oAZdhz6a/7xxxRmK8vYG/38vs0pt8yavmhotq+nGHgpOzby5vxkdsi6pX/KUt6UAovLMxxwJkhgqikDNt7RPhvTSrVKLaXhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEW97fuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEW97fuk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E579DC2BCB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776685037;
	bh=HagPh+ezF+sFGOobXqxn2VeNb4yl6eFydwsgdBl5/pk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XEW97fukr1SLw63lcMD9Aj7ZDL2H8xlDCBU7a3Ftph8aLt4vSGDMUjy7yKnbOcFBO
	 xl6REdrSAr7QmhGZFs4QGYr9XLUuTxEWSAwzyONDYauqgpHs0AQbYJX+cZZLXONAzr
	 azztXz5WywcvGdQF8ExrSD5KDRSBAUnfBwBvKn5k7g22ryLiRys3uuwPdMl9D4+kB1
	 qw+vvc1V95tHOINa8JJ7z7NHl71SeOzXcv7yVEvt0VuxkFfq63dOEcTldFsCyK2mh4
	 Oxjzp7ChLqC32QkQr8I1i19aClffJKPrvxAhpx0ZyB7xav9Cp/KrobdG1frvwW0X60
	 CzqF0GDwpUbGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DF383C3279F; Mon, 20 Apr 2026 11:37:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Mon, 20 Apr 2026 11:37:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-9LG9UTfIG6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #10 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #9)

> Yes, confirm that is was the commit Paul identified by reverting to the o=
ld
> file -- as then I can ask for a revert. Could you do that please?

Forget about that, you did already do so in comment 4 (I remembered it, but
missed it when looking through this earlier and thought I had misremembered,
sorry)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
