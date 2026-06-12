Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675137C918
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266613; cv=none; b=WotnKc0o3rYLVrCo3nDg38P0wnyz5r2FSKlFaLPpsNQvFTvM7VcZuQXoXHhQAne9bREq6fZyDGdFgszFb/CvEZs7oF5LBSGIOFRBLTeJqlBVyCHe1hap6UoAmxWXEkHP7NusIohqpoQXzIFkBF4NWx6eKhmuu/Xb8b93RB0SGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266613; c=relaxed/simple;
	bh=ajb+q/87vkpR/572i2ZQujgYoR5U33yrcA76Fi3CjLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZHbsuhwFgWZugsSM9P7Ae2IcPh8brNe7yGG0Q7MAWWYUZKy5GYp+PXU0bG4sYEsbXNojhBETxBQl0P5YOgq/W2poLAhv+GFzs8BNrnNjIzPyZaUkGSg38RlbDALYjy6syD3Wbo0Uew34SHsRmCu3O6xJI+OA7WkwYBDp8gLQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye9NnUeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye9NnUeO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B0F9C4AF0F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 12:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781266613;
	bh=ajb+q/87vkpR/572i2ZQujgYoR5U33yrcA76Fi3CjLc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ye9NnUeOl5O792RbloM8whaKyydkrqzCViaJpygU5IKUzkct045n2a1oXdWvUVCt0
	 n2yU+iuoODIfUqTsaxVwSPOeReg+drGxR/zprYNijexoEkmmgwd7ZWisglaB/Bqjae
	 oBlpy1QhhuSINLqIYTmvFt6ar8UPEMNX8T2xaodfSrXIQ/ZhraxpxL/rPbgr4/apY/
	 ELL3nzt1BmUnDjBh+WntKEn/StKwoPrxQCuc2HxUMVF9R9gbyZ4kbXM+bYwYU6iUrH
	 /ue7tVni4Gi+wkppRr0w5FPkrlqyetNYthl+R4Fq8ThtarNf+Ur4B+yCh6R/7SXKZJ
	 k32zycT2ayURQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 01575C433E1; Fri, 12 Jun 2026 12:16:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Fri, 12 Jun 2026 12:16:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hytham@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-73081-62941-FWJjfokQ0O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

Hytham (hytham@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hytham@gmail.com

--- Comment #4 from Hytham (hytham@gmail.com) ---
Has anyone been able to resolve this issue? I installed Ubuntu 2022 LTR but=
 I
yet have the same issue with both WiFi and Bluetooth.

I would be okay with WiFi not working if I could at least get Bluetooth wor=
king
without using a dongle. That way I could attach my tablet to a Keyboard case
and use it for notes etc.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
