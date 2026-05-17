Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2B2E414
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004061; cv=none; b=hwRKYmxxmv9uyH1zYEHmLOFbXjqVJ43lrmv6ARD/JrcUTNCGlV8E8lFZ5EEBIVwb6iDea6wEo2X9M0dsgl/DcADER/hyibRBQRXgYCaWTqEtbL+WVOwscLwMewEotEwuSetPghfqJsTpGmT/25080BSkfe/5y65xHmLdgVPYc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004061; c=relaxed/simple;
	bh=DN7ucSDUEWzquC8mS4c/mlrvfLrZLMniw3SVGNR17oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRfLVAVjaKWmn9D1k471mGNgoXwdJ94Eeppn5yHj3txBs5nQ+DWNAc/mDRl4NU/dj27kOaTAzmm04EADjbRWMmMJwcuBaOUPlv4+MPqVOlZjtGDlz16U4ysi8vpZwUwr4UBjMyWvxiGdepwOb2uOTXzeSnqqNNGgQGj2MRTY+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLReOpBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLReOpBn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F859C2BCC9
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779004061;
	bh=DN7ucSDUEWzquC8mS4c/mlrvfLrZLMniw3SVGNR17oY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HLReOpBnYnkQ4syyTLP6Htb8USMCtb7yrKD5HByMEj6tq4tBawjQBPRutI6aQaLt2
	 S1ICZnQ3l5I3Fxiua3KcDQStkXzHNZoWlLqT85QdY3TzLNFrXx0Nq8axqxqZYu1V5y
	 vCBe43Cq989RZS53ESSaqA0oVL6M5oXqfQtSKXDbPpJbLaYVx01oDMAUCHMpXkcT4Z
	 6OSaXJRA+ZxtJINS7ab53aMUPQX1/ZQBXQ368KeJQ+gJH+B7MnOkCL6YivciV+wkyq
	 +wAbH5A/clsYo8CR10vmhyC/9csCJ6658wNwfkyP4W/8TpF3gyxTGi6oYFYWpk6n4g
	 rJib2GdNTIk3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75ED7C4160E; Sun, 17 May 2026 07:47:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221524] Intel 8265 Bluetooth regression (BLE hearing aid
 unusable) in kernel 6.12 vs 6.1
Date: Sun, 17 May 2026 07:47:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-221524-62941-CB1DzOFTam@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221524-62941@https.bugzilla.kernel.org/>
References: <bug-221524-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221524

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
