Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57411A3028
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760950; cv=none; b=ryHje4fngXfOBlctEkvI6JAZw7div2qjuCn6I5yCX7dsrFYxw9Bae+LXFghmYjQ8wyW2cTBIPDJvwuB4uYmywrsi4/PPIy06ERWOn8UKcT/NbMvxMRMqRmg/mXopy+Tus8KKWKAfK7PBTyKpZEDHKAvbg4ruEC3qaludSMdYTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760950; c=relaxed/simple;
	bh=OwQqwE+EtQyUV00Q50qWrZVvwF1lh3dVBVgrwvx82Wc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/5y1P4yVR0kH1JRdIA9kxqBC1RkWQjr0I3WYbGmCakydf6RXKCmFQmt6DQBsqgc3To48dESbwLnCjsGcsO7KpKIP7vb2dFLVAwTRInb5Bfg2mRAawEhBG77lgk7yJxExlul21rnNIHjMmkK0xM9xTQC+Uub8r8WasRrxyMBSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AflKeOw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AflKeOw5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B603C4CEE6
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729760950;
	bh=OwQqwE+EtQyUV00Q50qWrZVvwF1lh3dVBVgrwvx82Wc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AflKeOw5kinEWzwt9lmY/dKlV2nqBXbuQfjpGyW3YNA/GOdREP1NydASw6pLsrCjl
	 kymuGhJhNFKGRsnXIkMF8+/Ixq9rfzEnZ8ljF9oA4Ett+oU3Fp3ovNSnB9XvTeGThv
	 B3g1xcRas5xO/rRp93Bpj6pIpuK/C9Qrt6fO+93ltp4xjxha5qutTTPXPrY3yJvHvo
	 MDHlS5S6i/AajZwMtec/XY6ziugsa6ENl5FJn1iCc6xbrhq2jKFXLWvBtesv2rDp/s
	 RKMyhEZ0JgktToly/ppnO09/PuLpFoOU7y8TdU6FxvrIXb8VEIPEeifpQvuT2f/nzW
	 bdrpVY3CUL1Vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 01BDCC53BBF; Thu, 24 Oct 2024 09:09:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Thu, 24 Oct 2024 09:09:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219385-62941-wXaECoc00X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
