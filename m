Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278A40DFBD
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776486858; cv=none; b=O09tGROUH7/qnoXFSBcGGwDXsa5WC3PVLXuowbxQL8l4f/rtiMGraAxSq97betY/u26s+GJ+mP/05GomHKSKOc66LKh7cszDMaejpZyTE7ZH3pDxONoFRQGNJcesLfbFYdjVN8tB0K5Z/FSgidzgB8fMMKkhscunlXgsCoPjUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776486858; c=relaxed/simple;
	bh=+PTzVhhekA9MSFlVXS7swc42Q2aSWI0+jjubsuG08/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hT3FkQzJ2vJgtBKccNiov3ekcxay9ZFIGQ6FGgJzE60cvx0INg7NexXCQQdQuR/p3SMvPtZuzrEWXgA/ZwsDGZCU+SOnV/lRbbTrKiPisUCEryeid0D9GAS74OibciJ2OC+UGxJfD5A2T1hzN5k9VrxA7+90PXjAn4Fh44YO64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUGApyfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUGApyfK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A1B8C2BCB6
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 04:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776486858;
	bh=+PTzVhhekA9MSFlVXS7swc42Q2aSWI0+jjubsuG08/k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oUGApyfKoHi1SJGxFH8EhoZFPCD2/4v9mDv1dXBRrfRE2c7xRc2Afq77a8H14o/St
	 /t7vHojyqcX1gzuqa6WDy/zv4LB1hhaGVOilk9E7m1n/PlzLBGZ3NEEdSx3UuS4TNg
	 J4v2GD70dARR+LADZFmNzoHgfPSH6yCOtEnQyeXA//h86J6to7vlBOVFSVo43xRZto
	 mU/YO8jf0sH6my+D8VI1b32DcAYsv9LMAdnWrm4mKtkkA3yoVvYTqFf5mDddBCgn5f
	 QLAU0P+D2a6ZldPaL4iCBVm00K4+Dh3DLUok4L58Il+CTvQ3xboQvoi2s5x2KqIbEd
	 Me9Va5W8J0vGw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A605C53BBF; Sat, 18 Apr 2026 04:34:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Sat, 18 Apr 2026 04:34:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pallaswept@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-OhYuRGKIBH@https.bugzilla.kernel.org/>
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

--- Comment #8 from pallaswept@proton.me ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #5)
> Can I forward this report by mail? This would expose your email address to
> the public

That sounds like I might get spammed a lot (more). Is there some other acti=
on I
could take as a normie end-user here?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
