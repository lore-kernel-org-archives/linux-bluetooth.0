Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC612D75C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589505; cv=none; b=d3kEOKFJGqlZLTSI+bcVO822Z3J21Fnqqz/hBT0KeoLTknRFUlWl3lc5TPi23QlwrjaR0MCFF1hx46iePDEKs3l1PLNF2dB2zkmnmjdgHHYbrQCd3qvAIMfz4zSwZgwB0Db30TRd9OtT2hTOQG57Ya0K2HPQHMKeYCwuAd0ExgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589505; c=relaxed/simple;
	bh=HT2MEVafKFKjtrX/jgyKIGXlCP4yWjOdHgetybEAOtA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qA+hqX9eVJ0OVb2wY+mtgOyPVNHe41zjA+a7JCPc0C5R7iC2BeM/VR5ILkAxbunnGndkXXag6tw8on32yKkqkWg4Z6FrM3xV7/WoC/zEQIUMp8fJc1jccyyusUQGB/6QZyVpDeQqlQCsX6bB0dT9Fut64T6LaqBWELPzZ0CJo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXCFkb8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXCFkb8R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00E83C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729589505;
	bh=HT2MEVafKFKjtrX/jgyKIGXlCP4yWjOdHgetybEAOtA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DXCFkb8RQHL0QcvmXqkzu71RY/X3/lHz7V4/bkppBX0c/mNETLpw03XAgXLrb1LVZ
	 Kk1/FwDDSjRR3AYN9zglxDaPGZx3Ml8rEUvPNAhaKEIp31UR/D/t4tYqAsgXTntYSb
	 9LxM48OK9Tuexpauk+M8yoV9xUr+J/4yboT2HY2nMXj5ujAljOZjG3KA2/owEWTc/L
	 VG8EvxIf7VmXN9txxqYf6Rd7HYgzYXG1vqmSSygsReWbK/NShrTvILZsuOd/MZ+KWc
	 3YkzrQKJY4QlMRhiIyHEZPaaZAGK0utzRdDQ/5RwBd+w3aLw+68u9pYRkixcC6Rw4Z
	 6T57lSxbSiQVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6BF5C53BCA; Tue, 22 Oct 2024 09:31:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219398] 6.11.4 cannot connect DualSense controller via
 bluetooth
Date: Tue, 22 Oct 2024 09:31:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219398-62941-6DVUuD2Bvs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219398-62941@https.bugzilla.kernel.org/>
References: <bug-219398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219398

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to velemas from comment #2)
> Resolved downstream, see
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/=
86

fixes should be in the next set of stable releases, too.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
