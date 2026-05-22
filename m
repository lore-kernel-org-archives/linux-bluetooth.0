Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0393AE1A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440698; cv=none; b=RrZgVB+8gtXBMUjI/94keqr/a3H219WpkszbfEc635X5gAx+THBcC1PJ38uhZz2KYd8mNrIzrWwZ2wHaJiTZW/azpnDirC1xieMorCUUWf6I5A71um7AXhft9HJwtm8czV9jQTV1FFWvo1m2CjLHsqoURof3g+PHIKwjG0Rz6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440698; c=relaxed/simple;
	bh=hGMzxG0EZZWKS07ExRBD73CB8lBOgZU/frrStcJ8BVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rglpcVlmIRaxf41PDXeO3LhV17vUIPSrctldqNl7hjvZjOdVdi+EGiR95dkOFzxn6XgA6NQdhzdk1sIxRjHIuXXoIuZlAMcVoXv1Yimw0q+erhRDzT81qzpHiNMNuUgOCGFhsemEOBYiGyA5nyHPdTUYhUODsPBjIP0mWxBls3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9XTiWD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9XTiWD1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D83A3C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779440697;
	bh=hGMzxG0EZZWKS07ExRBD73CB8lBOgZU/frrStcJ8BVs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r9XTiWD1F9l++T8vF/h48xUpFWGDboGsRsTbe5W4FGuyN0JEc8Cm3vVH9bjhU46e6
	 gjii0Yf2/ZnvsOjt1tjckXBP+gs1q97Rl9ddeUsEJxab3QGkDtUtokZOl/x1dUO98t
	 uslNnl+++/CpU56ARfB94O6OuWEk3Su6XYl/5vcjkKBRo4xHecCvDiF5WdR7N+VNaa
	 KsPlcK9RiANEiXAzgvMNL08091b2pMRpdexfld2Rcorlajl3y9EjyqoDjG1E+6WRUv
	 DwitIRc9SwGG55M2Vj16Vtrwf969UfK4riLuMMo/UQlMJmIWDMg4+rZ/q/T5rwKrs3
	 MziurUERmmKeA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CF7D7C53BC5; Fri, 22 May 2026 09:04:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221481] btintel_pcie: suspend fails with -EBUSY on Intel Lunar
 Lake (s2idle)
Date: Fri, 22 May 2026 09:04:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221481-62941-JZaOX4GXEV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221481-62941@https.bugzilla.kernel.org/>
References: <bug-221481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221481

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Is this a regression? If it is, could you bisect?

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
