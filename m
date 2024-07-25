Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE24199386
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915051; cv=none; b=P3SbIYFTFs9pYvobSUu6M78ziKHXL58vRm6pr1BGxIc4J3RwHEOCjIVief+rWjU09EiI11te86VPyX+7E9ej7hl5gQs7fP/zDcpixc8DMrgzSgRhfWWpUMUKy5QBE8kz9KbMasUSl/Ex2PJ2oqoAeO6oxjAV5+btSG3AWo5s7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915051; c=relaxed/simple;
	bh=69SIKbiOekgShx1kHFtL9KxKQ078kgEGm5ZPO0oJg/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9owqGQrjCr/CoT/VuSyyEUE5rmpkW+n5Ux97kcTaPuy2BZehuqhM5XgS0rIkJcmd3EaZc8J3Q2lFtzfMl984TqKPvuz9IufiRrcrXpcOk/eqA31uS2Bw56xGDXillzXYCw4181OjfUm3FZDUuQKAvFG0L1AdbSIEekcSPEyl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZFL8OVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZFL8OVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CF1FC32782
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721915051;
	bh=69SIKbiOekgShx1kHFtL9KxKQ078kgEGm5ZPO0oJg/4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UZFL8OVQmdcxVK71gBV0pOUHMRQQ/nLtUlFGsficL+OosT13vhjHXZ/C/ds4wOwb2
	 Gq6VS7C8kP6cjQxiJ/YpCBdO39S23gzIdQC4Pu+gs03N7coHvludjkNLB69z6hQ/5W
	 L0BHHNpzCJY/b2i7zSZybevEj9s2QYnb7qJSpAWBbQ5IMaVvR7DN1PxuvqrK8DKYPk
	 rMa3eV4cp4XtLperxBy2jZ2hYAULR/68cSvOrluhFW3tIdc5dZM7yCV8DTPx3hh3HN
	 CxlGdoEzy8GSO91ab9PKYL2BD2/L3hyysqTagZciUXqhr7DUWE0aywI3qqdLDt+u4F
	 midqNhgTlFHdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3F269C53B7F; Thu, 25 Jul 2024 13:44:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 13:44:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219088-62941-pnYk3C4RhO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
I wasn't able to reproduce with current bluetooth-next:

https://gist.github.com/Vudentz/da22fb40ad55091b4a1e67f14a8ad033

@Eugene please collect the btmon traces.

That change should actually help to detect scanning had started so it would=
 be
quite surprising if it caused events to not be submitted to userspace.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
