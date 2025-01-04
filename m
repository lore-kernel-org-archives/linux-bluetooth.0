Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165D17C69
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735969005; cv=none; b=bk3PEodiy0ZNxMTiF3qPIwR/G3bXwPP5AfQD7bezRk4LsDSVgtsVMBIvLre9dTaeEHgHptHBmCprC/5sW4uzIgvUyVRj4cFPiVSUyECM+/wJrnygHisjpRxEYXj41W7r+e+J87V/bvbQL8MtyVg1KiV9fTe64KppbGo3Xr0URgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735969005; c=relaxed/simple;
	bh=Nby9mWQg1fzE31y/PwepoNQmYNDHj16Y95Q0OWmB9js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8I8eY/RWvlNQsqcsCT76kBCUmUMtk1tud6ZjvTThD8eLvmRf5CyLhAhRZnJ49lXQJGKZvH0/t4T8Rkx7HODxD1tRolaUID8TeFa1t9/Jet6HM7//sLwoszyDO+R4toI2XDdttKtQqI6COTTggZFdkdk2/1+XDOy4yZ3SoRX/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCxX2j84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCxX2j84"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C3EC4CEDE
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jan 2025 05:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735969005;
	bh=Nby9mWQg1fzE31y/PwepoNQmYNDHj16Y95Q0OWmB9js=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tCxX2j84EsTTMXbV7EC5Xn9DHpB6ItzdMJ5jiabxyL0V4G2I+Dl8UxYkry99asuk5
	 Afko5G92mNWLi1qJdaH0X04TLeuraNzz+uYPOHSimeHslN4jOTpYGNYLgpIh8Dq8KU
	 rTOyS37iJi4zBsX0j18zxzN3HrhD3r8/FrrtllKqtuEGVaHXxR12JLxJkK+9lm1S23
	 g4qcGkXXEBEi+Avy6VNmsHO2OGFS5nhroEVfukyin6xvmRESW2Wac/cVs17Jl53oEw
	 xZaUiPo9b0JK13D3Jytt00nZI2WlC/CpfHLTtfl4ZBiYH+HHE7JxdjbG5ZxN5XZboa
	 37X3EWSWZoDhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 40031C41614; Sat,  4 Jan 2025 05:36:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Sat, 04 Jan 2025 05:36:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-BYoT3yYIfX@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |2802131438@qq.com

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 219290 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
