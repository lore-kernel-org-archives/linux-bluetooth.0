Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEB7D413
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428775; cv=none; b=eodM0+eJyOeQP7ZaeDBj/aYEYuIIm6qt1rdl3LDU8P6Us8EYUvRZ9bStLRPkGQD4TwHSxD9AtiJQuWenWp13Z4M5NXLE+tSWet+FWNEz/7KYN11VDAwkdn+uDPhoQLpql5hiE4wtKxoG7S7i07gnbRY73Y67STetuP1MKGXclFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428775; c=relaxed/simple;
	bh=3pWfaJjgSL20TYs8o9X3otUS1jSrqlFGn2PAdIF0xvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWYn1F6A3PXYGT/snoXqS4WXCNVRGpjftMDPJ3fvJWuFlubqWx7oCfCVpxrMAbTvjwzv+zk5u+LjPcaOj4IMWtO/Ppcs5vMURnaFmZxdso4V4HIBMDB6jdhLw+IJ0LHe7P8VwLx6Hl1GOEYYyOPQEIBwpwMrmwQEMocIxDkgYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6R5VeL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6R5VeL2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1A11C116B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713428774;
	bh=3pWfaJjgSL20TYs8o9X3otUS1jSrqlFGn2PAdIF0xvo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R6R5VeL2Q9welzQmvT8kHgQbJhpkNulPUSD8b1ulzRuSXwunmEiNDRYu385SrLrtm
	 1z94bSfBTb6W4EuEIW3qJSiLTQ689VqDKLyRhPu+TX8eqBYlw0rtuPoA+3Ql7b2eXG
	 HGwe0ZAyJJdcbppHhx1/7Kh55LkpMDKFqHlqsj7wJ+i2U/GOZJqhyDXmExmEKKM0JG
	 gf59u5E9mu2+x6cBXaocvs6J+HtM7sXqIkkn2e5RUZo+STncX4eb7R6nWPfmNXpqJu
	 cGl+X9nLbk4mFS7U6X9lAoR43UlyxObeU+T0ZWMtUFKVFivPXR+vgO1fa0WePbCtMt
	 5UD829gpuqdHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BAEAAC433E3; Thu, 18 Apr 2024 08:26:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 08:26:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-GpAEwAVTAl@https.bugzilla.kernel.org/>
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

--- Comment #41 from Zijun Hu (quic_zijuhu@quicinc.com) ---
(In reply to Wren Turkal from comment #40)
> I know this is a total newb question. How do I add the footer properly for
> the purposes of the log? Do you handle it or is there something I need to=
 do?

they are added by fixes submitter. yes. nothing need to do for  you current=
ly.=20
i will submit new patchset and add them for you based on the changes which =
take
effect actually.=20

thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
