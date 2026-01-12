Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BE2C028B
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212920; cv=none; b=HaWE1GMXTiJYYxVK8v8FwXLzz8OjNzdTuLc6v8EINkYk8ewnz6nCl+CK0S0HcA/WqEjTr+puc0SHxxGsGXSzkHXjsChgXkjcLbPFLLGlYxLohTeGT7EFO3+4E9dkICbQNN+TaLz8DaeN8PRjHjR4f1rm77YM/2jxIxtDljmnM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212920; c=relaxed/simple;
	bh=/JNVV1keZG7AzhICMUwAABvyOdquHyAG1/aTGJcjggM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILwLbztapcbeyNwJH3+WgyT6hE2ziZwrS1AASE9g1ea8QEFULSNA8jP8vwGy3e7aONjN/j5j54NfaBoo7DqSTYunv0kr+QDiOQKTvCLoCzQRIj/HZo5B+I1rn9Q4g5zAIEBRQb+4QjbAzAwUR+29flNAuXnOwzcVdBDQ1GVsTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRMClkuu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRMClkuu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D49C19422
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212919;
	bh=/JNVV1keZG7AzhICMUwAABvyOdquHyAG1/aTGJcjggM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FRMClkuuS7GMFoyhhYAgm+0wau+2ibibofIVnSLGFSnfVQYrCJD5+eTkxLmwdOGCs
	 yZIVJ/I5d99oywJL+HoFXKO87qgyQqloLMSvX+I0HqG3SY6WYWJyAMadC07Qg0ASvs
	 EUFGBsP+En50wvtnvosNhuZozQ1ETpTm90GaNoxNG0mtqGa3tFusmiHO5uR+ojaRnb
	 YqlWf+eb/clHUvmPA1boCHfWbg4XWS9qA/+qklOOBElxgntGvjES8Epzli1B2DORx6
	 k/z+7tfrnUOzz+6HM6mSMnaesYRmy34+07uu0Wfni35Ky1nGR0xJTUS2p6K/zB1Xku
	 D8NSZnNqAe77Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CD777C41612; Mon, 12 Jan 2026 10:15:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Mon, 12 Jan 2026 10:15:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc
Message-ID: <bug-86931-62941-JF4ywN4Rcx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |bugzilla@hadess.net

--- Comment #14 from Bastien Nocera (bugzilla@hadess.net) ---
This should have been fixed by:
https://github.com/bluez/bluez/commit/2645d3f662ebe8e601df628432886d3712b42=
1b3
which will be in the next bluez release after 5.85.

You might need to re-pair your device, would appreciate a test from someone
who's seen the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
