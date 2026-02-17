Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268436B068
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336613; cv=none; b=gIGxQbRymsNvfpGSj+T9K6pwdVGBZfflBWZPX9gfH315MEkuZ04I4uyLtjHB3xVCswCrnMxk4ay627zhXyMfssFH2NTNRcg4qJRE68iIddc95U7fUf0ZZptM30FCylTVjrWliaea6dfycJ+wxdFD8xwMZJNSimevMxdx7esbeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336613; c=relaxed/simple;
	bh=5DU5EAVXpjZRoGLUJtdN34c1AqUpJlbANbZ6UNOseYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdhowS5iQlf57qbjH3LngXGzLdtsvxlH98VqWlkxy8Llj7jZdJgYkrnuO4i9mBfzNV/XMC2X/XFZMSPLnEm2pDmZzvUM/KWdvX9ul7CIt/1RVCtqWFDosN4Y5SJajY/xK1FPhxaAfALVRhSxnojzziwUz0juofeo22oBSuGXbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4gtEGkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4gtEGkh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 293F5C2BCB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771336613;
	bh=5DU5EAVXpjZRoGLUJtdN34c1AqUpJlbANbZ6UNOseYg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k4gtEGkhcOcVMNp32vTWG76rVz+YUoUGLu7TB0q4vxWakxiqS8zxyAwWES2O/9K9v
	 hysUdII3mWfmVbCAaB6jAHDiW0BWzJwu7uvbDdlWAVjv0yUcGpRwC1POhjDTv+qyD3
	 OUuHmUu9gil5kR/0uqLkAO46n1uYEKDRk13ltuDTOyy5kBJIFkr7ZTSUDlyoegGaaO
	 nis2ey7X0S/Gx1TC03uJOupUOXwnVKSJZ4+1vHyW0lOXZyJT2R3XpGi9hlHsq2gI3w
	 I7t8gyV+cSd+CwdHW18bv0vqzfZwKPa3Pk+1ASkP7fAMakpNIplOXxPn7BJWdxlUag
	 4wFtMt70Uq/VQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C931CAB781; Tue, 17 Feb 2026 13:56:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221096] [PATCH AVAILABLE]Please add MediaTek MT7927 (MT6639)
 Bluetooth support to mainline
Date: Tue, 17 Feb 2026 13:56:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221096-62941-s84tpObGh1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221096-62941@https.bugzilla.kernel.org/>
References: <bug-221096-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221096

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Jean-Fran=C3=A7ois=E2=80=99 patch message:
https://lore.kernel.org/all/496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@=
marliere.fr/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
