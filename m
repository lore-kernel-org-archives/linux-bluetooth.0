Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9615A4BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431468; cv=none; b=NqYz9pQS7jeAiY4KZWpKbd5lu3f/PpzwBll49c4UcTopLWJfSPPr0U/lcGAG5qgs3yVLtP5yvNbJKE58UeQEsC+MFUXCitJlWxBSNEeTL2eKizbdFgqrZNdG8JkWBkxB+JVmHs+/rPTi/O660ghyyRaicQNbUDFZwR4nyJjrvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431468; c=relaxed/simple;
	bh=u0u7A5oXeR7bEkGJROSl0tf3byPyl1NUWNfKhfDvwFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1RbZTa+hcPY0TjzyF99GRNHfJM/uM221C9cfwyDxtLuOWmCdyCRbtRa6bOXB+Z+ba12lHLvakYd5TPH4+48zbxPMm58r0Ls+/EZ1PHhekva9biAcKaAKuXk8biupDXP8TLGHQyG/cauxA7nox5qJhFcSKU8fxA2C/cWJ3D527Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKv6s2XA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKv6s2XA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75EA8C3277B
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713431467;
	bh=u0u7A5oXeR7bEkGJROSl0tf3byPyl1NUWNfKhfDvwFQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EKv6s2XA6OT/NGRwWjwNBe8/AGoqTskzsFF4sfMfnz5woDMaSBRdyTXK3rINwKH+2
	 irNr9z8x3E0CyaGer78AKElKDtmZvmPu1XlwzNib3NQueHbnTdESrVymrKrasmrvzC
	 oRNWMoX1lgJRLtrhxSGw3e6+hx9vU2xe76y2yw1IEjuo+wvBQd2nAVLjwqj2omBX58
	 QtkjF1ZviKIRgGUxkGaa1OruUfQFPLRJOLmFJ+eNjVIo3SoquGYdEHP1qGfTEh5QPQ
	 mREIWlo+bQMGIiTQ1oaPH2QYZkp9cZEfaxq6Oers+BGBiMc3AEheMqRJwpBIAQ6fwv
	 JdaCPJt9EG9Gg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5C22FC433E2; Thu, 18 Apr 2024 09:11:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 09:11:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-5R0ROQs1I5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #45 from Wren Turkal (wt@penguintechs.org) ---
BTW, I ported the revert patch to Linus' latest. I can confirm that it works
there as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
