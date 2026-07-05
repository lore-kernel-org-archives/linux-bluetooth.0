Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C9358367
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246071; cv=none; b=m+4g9FC/F+ZqAagcyAWB3oSIflH7mHbWKdIUeI3earu8yy1LKyH1wpPcrcHxB8zwy3qs3fxVXofWpwAylxH0QxJKQAHsenfl/dN86WxSZoU9ieSSbkoWZMpf6KTNun3af99WTYeM9Z5Yh7cuKkm7PMxgI7mStQhYSLUhr/CMtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246071; c=relaxed/simple;
	bh=cS3c6Gjvacfhmzoj3Tw31DO5bjgjrjC45IyLKecmqpo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r97e3TTq2TuXDuS/mb6085vtXGeHuumpzRDPsHEMhvlVtqyE1x/vkLaO/KIf9qu2xHvT0fkrDLc9OQ4Dg6wXxiewInm266tkCkKdt0fOHFNGpAVu62qPQAtuaRNgNplyGxSI3Iwi3eJU8lsRiPFLNEDcatsOdkvreq1AyQ0IP+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiW/VMkD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiW/VMkD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A55A5C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783246071;
	bh=cS3c6Gjvacfhmzoj3Tw31DO5bjgjrjC45IyLKecmqpo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MiW/VMkDkldj5/yT0RQQ8CezATkN9eqgKENJviZb8EoIBjWQXkTbGBDPA2hzOl9Xd
	 Z2ykgtfXicPa2v1T+DnUjTUcjpwMH4T0rqyjHJ+X2yoXbig30/8ZgiZdtBj5Q2m4L3
	 1O20HNcD1StG5tWA2LIdQdyk/TE8+974Xkmum2z9pkvwJILUf8RJjIOuBrJ2dPwDII
	 cMeX6DnEjPX2ugiSAGejYO/91BCzlffn1ESpL90l4AQX0fgPBsrn9WLNty6fLr99rd
	 oYtWg9pF69i61lg/fI9xy34ou8MvhxFHMjgQz2+I/pjxyM5zScD28tfsP9AC7quZTi
	 +BeztsH1WZhKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9394EC41612; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MDZdIGJ0dXNiL2J0bXRrOiBNVDc5MjEgQlQgYXVk?=
 =?UTF-8?B?aW8gZmFpbHMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg4oCUIHN0YWxlIEFDTCBj?=
 =?UTF-8?B?b25uZWN0aW9uIGhhbmRsZSByZXF1aXJlcyBtb2R1bGUgcmVsb2FkIHRvIGNs?=
 =?UTF-8?B?ZWFy?=
Date: Sun, 05 Jul 2026 10:07:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221706-62941-hizFLSHMYG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221706-62941@https.bugzilla.kernel.org/>
References: <bug-221706-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221706

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221707 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
