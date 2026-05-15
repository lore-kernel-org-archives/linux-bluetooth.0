Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C538758B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839993; cv=none; b=apt11+wtj8DuxoaEp7XJkuUyRwfrx6i78lXPLwjAIiZZDwlmu7Xnxya/OLxAjn7Lx3UdoKHoO9W4TqxcJeWvLAA897qrfAcILhDo8PhZX0laZ8VkX8PuI5+a59LmUBYsadFPmARlKl54osxCi3/xnnGjRBlV2QytnIVNbpFpepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839993; c=relaxed/simple;
	bh=zpRDN3PcTH3iVsK/U82mFqbKALV5F3wqL0OWRz6C3KE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J16qqpAxzNziW76wYjpsfP6UsffPo73e2Acj8BYYWCPTsIdiPrI7tQw4fsgp1VGWxX1W/TeMXNT8goy6d22lUDRrMGMdWFsY3Bq0mQ51hRcBLgb+X8tnacC58QHcPblKtUKQOrt5FdJKLb0+MOtNLkcis1UAfNAdtlcJayYr25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdQgPZE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdQgPZE7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47B2CC2BCB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778839993;
	bh=zpRDN3PcTH3iVsK/U82mFqbKALV5F3wqL0OWRz6C3KE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HdQgPZE7uTaGNyUg2m1hWBu/cJY+lKKFiXo+AOaezvOlHo8TgmxcpujlOTHMiAtOy
	 TL/jrc8ICRnseblYV7qeVX3R1uxocNBJTGoLLJnS9wTKVP0jvzg8V1T/8B18ZsPodB
	 xOvvn3NZ0/BPbTjnRwk3TUC4TfJUvnaTTDOo1zTc37FJMLZWxF34webYgZFJ+ho9Ry
	 zu8DNOkc6UQrFdQpexKF5/Qbi3DOVULx+k9qPXaSqlXbDY8mhfspbSvseWMYiK+leA
	 a+PPFokr/RUVx5vaJWjYxXFIwtCmXd2apo6HQzEd69L8W9TJV8qWvhEWhVPKM9AsrQ
	 gdZCNPD9kgQFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BAB7C4160E; Fri, 15 May 2026 10:13:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] MT7925  7.1 rc does not work, but it works in kernel
 7.0
Date: Fri, 15 May 2026 10:13:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221511-62941-PRBMd6Max6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221511-62941@https.bugzilla.kernel.org/>
References: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
