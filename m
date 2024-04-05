Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BF14F129
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305847; cv=none; b=MsV8vkrOhwvosAYdxPsXWDI65cSLtKybvEyk5bwbopsq8ryo6scSc2LEJPQslwRb8SRlYaacijP6uKlDMah4F/n6NYKA1FrelXgi68KL8l8g71hvKkdGjRyz4d7CZxKeO81PIHGy56kO4CeP9M/91BrMfzgA6dgwXULoUGNJWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305847; c=relaxed/simple;
	bh=FnqoDgD1L/SN/SWYgRHarX93XiZyp3ulELrbHfBG6hM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kojLrc6qjP8M4e1I9OAyXKpZiyUCS6Gdgcf5xXjllwGLFCv2+LDs5aINpDrQVO9QZDjk1uvcnai2ydSfYM46C33xc1OgvLj40TfxgfX/JAUfO5T1muCXH6AlrIqUz8v/dxWdNo4pwCVh3EqRxEhAdS9gAaLRlh+k0qcol+V5upQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwRNBczQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwRNBczQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FA0BC43399
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712305846;
	bh=FnqoDgD1L/SN/SWYgRHarX93XiZyp3ulELrbHfBG6hM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PwRNBczQOB1DCBljvlGTZSkBocuYpNguc5lYad5YLFeUnV0lb2i1WIUl/4NxswpJb
	 1aEmamtzqsBk/04nTiU9sswyoWxrTwrE+2S7zPXhL2Br9bdSE4dfbQLARuUVEeso8c
	 7kod9EyNqPuNgl0CzeVkPwV9aFyfLWWxYammso7dWJjHeG678F5L1Yxy6SoIaVnuho
	 1jQ2AJRM/ZOCX6AWMyWfFLNL/G7LdE2drTmkL8FAbXaJlvihLVkjW9UcgNoToc1qB4
	 +6vUzkskq7gozVV1AwKjQre1kITYfyyIzLp5SyBdc7fqGE34ZRylOphP8iy6SSgxAo
	 MSUy1CKlRFNDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8DC21C53BD3; Fri,  5 Apr 2024 08:30:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Fri, 05 Apr 2024 08:30:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218680-62941-FMXGglHUTi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #2 from Bagas Sanjaya (bagasdotme@gmail.com) ---
Please test the proposed fix [1].

[1]:
https://lore.kernel.org/all/20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08c=
dfc862a4622@changeid/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
