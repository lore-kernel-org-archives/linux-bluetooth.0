Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442E8824
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840257; cv=none; b=iYp5LF0W20f0GkixYjYSGP2sVdDkfcukG+1gPAeY5BGoj5TZ3qRpd7HFByh+3lD1mqHsUulUDcc4JZj+b0HzDVQjXvWIglR07tljQVaG2yxNKkq1Uvy/GzPjDS1XbiiRBxs81xg8KPuzN5oZK7YZwpC7WbmjC1f24gISEpsc/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840257; c=relaxed/simple;
	bh=5yuUJmiXo2mp2FNIctvIsnpaBhvEChEYLIZw2lAArQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiSJ6z4e0d2wU5kwuRXr+rFR9fR163IHFpSvBNDmgTrHAM9qfUwmU3dN2qJc0gzXQYVv8p5vbZ0EWHJUR7KqSZ2MadjxcxMCyRxnZMIvVFGwY+onISwmdnwMvQJeuHYeXT05XOEBLC+9sbmKXTLoxphOGKaTP8XnDXKYoFE4Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmlmOBCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmlmOBCr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982ACC43394
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 02:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706840256;
	bh=5yuUJmiXo2mp2FNIctvIsnpaBhvEChEYLIZw2lAArQ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kmlmOBCrz2nzvqnYTaWV2T3Ssg/B6w8N1gpLrTsVaY/LAqGwQqe6xSaoOUBTdBc8U
	 hBGlfMUgQCMwqKzpWoPlFy3b4kDV7JwrHSitjOIQ331+t1bZXAdAcikGPljNcN0gT3
	 0Xm4pqsGCFUMXLkwoJtioBpHL6MzCCIKjphfcqLP3QOGkp9JUiSwxIg5HVSdSqs8AR
	 BA1Qpfe5JMXz+qPiVcWjRTNrFAdpcnfLQJKFHN++McdoZdqyzq5Hxvh/nyjAnRlxWX
	 VcAw3gjB1dSb6DlCnEU5LhLbSYJ+TrOevMeARLV3Os6zb/avqxM0SglUwhC/g0lXQn
	 L+SiosF+kImmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82F5BC53BD3; Fri,  2 Feb 2024 02:17:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] KASAN: slab-use-after-free in hci_send_acl in Kernel
 6.7-rc2
Date: Fri, 02 Feb 2024 02:17:36 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: zhenghaoran@buaa.edu.cn
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218440-62941-XwKIP3U2dN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218440-62941@https.bugzilla.kernel.org/>
References: <bug-218440-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218440

--- Comment #2 from zhenghaoran@buaa.edu.cn ---
(In reply to Artem S. Tashkinov from comment #1)
> Is this reproducible with 6.7.2 or 6.8-rc2?

I guess this is a bug caused by concurrency, so it may be difficult to
reproduce. However, the call chain codes corresponding to 6.7.2 and 6.8-rc2
have not changed, so it may still occur.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
