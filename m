Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09933E35B
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522207; cv=none; b=Jseza7WsNVUZucjyUOY85joboaXuw8LOzaPjLUo1SDnM9cDJ8loR4li3e5rSR3/q55tLYhfPRfm1uB3A79TRP1/wFwMznMhvgb/1dFevomL9RQHanOMzgKkiUVsm+PLMBkxYpdwBraLy6x5yZGVMH5HMhxh54ge+vjhkbvwplHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522207; c=relaxed/simple;
	bh=7Uf2Eh9+owsC5IBIHP78gpuCdU3Xy+RcBvKzpLvzI0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Km40hOwDMXV819HIw4rIoUn0xcv3X745Q7GIBIYQxMs1BVRUQnyAa+FfmMl+Bn5Z6G7JGUECF9W1tqueoaFFcsC4+ppTFBPmAi9dof9no0zNLaVKjiWpoZO5qTjiyT3k4MOSs79nR55cVyeUqaC43dTAzKs6wnfkT2rIuBsVAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqg5c8Kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqg5c8Kr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F9CEC2BCFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786522207;
	bh=7Uf2Eh9+owsC5IBIHP78gpuCdU3Xy+RcBvKzpLvzI0U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nqg5c8Kry8u0BkxqR+8/JTiatZoZUrTIovwiDTbxrBQYheN/TsYX472cmrzCiOwnS
	 /DvekdKe2EHjrmrPrD9Fp+i4k2kivoU/bPoJuEz5krnYTJi9GI+aQrCySfP4KYir5Q
	 GsKG1l8oRQ2lw9E8EeRHP/crajYB4N8xT9goqq0qnEfHdFHpArvsKZgzexp4X2uZaI
	 Si2YsaF7fjOXUGLSyadhC7MtcyKUAzsO/bJ+LTjRazzqxdV/mQMBWC6Vffu2SHZnci
	 +deiKAr1pYT6NEt4EHnVDa0nvK8u4FG1s4kFReEKvLtKdlxQyAEIH0LBG//xvywLG5
	 YRJ3JdWIimLfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07964C53BC5; Wed, 12 Aug 2026 08:10:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Wed, 12 Aug 2026 08:10:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-iM5jKxmQU7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #9 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Is
https://lore.kernel.org/all/jy7Oxm13JtZE-cHnVc2A83BwwJcviMvaLSDfdHqIlEysqO8=
8jvDwRkqAOqSNaNc66DJdPgQBoWanzce8h-_Mz4kYCe5SYfIafU1tyxN2_dg=3D@protonmail.=
ch/
related to your issue?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
