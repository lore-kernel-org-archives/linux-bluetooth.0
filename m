Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9323909F
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246112; cv=none; b=A+Lcijn/PurtXYVZAwDlwDrIYeFK3hObzqMytR9ECn+5f305zahhPDGVVGXdTpJiLWcwq39K5iKxCwOL+7IAQz443ZOby/03e9jGAxldrBIOfmh9b2jmkgRyRw5QN+aBH6O90NET+N/z+vfog2OuOu3rlBK8n5nELj10v65QQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246112; c=relaxed/simple;
	bh=EflYxk/k9ow3PypvPZUTsAd1eKIYJFmM62dLKpewFa8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHGVR4FEBqR1fYJlDHn/qEAUFtfB6PX6+DoXZZovXU22muCW7nEUGUcYoU2Bn6SDdDzDEyw5ZYbEHuqPpfQxv9rh4fCozBY6kNJNjb9kMBcim0ALTgVMXbX0yEbejwqc7U8J5qg83GIEvr4KhCGP56ucZXBXt8Zy2m44dPWT6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I852tlfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I852tlfn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43F12C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783246112;
	bh=EflYxk/k9ow3PypvPZUTsAd1eKIYJFmM62dLKpewFa8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I852tlfnuqr+xhhajv7hqQpPRvo/UHLmS1ZdLKyhvwXgXrUsL/8i2pOGaM9/Yz+Dh
	 S8EEgRwdFi/ukl0uU49OMVBA114PBmz4hxAGAPu2chtSvqjduDadXG/fN0wzqgV3MK
	 zZ5ERm7+u6/DrnLarHrqNBegK4wMcDKVXGV+scK/5Uw57d/IW7a5+Rv9NJmj4ZvNUv
	 w9GVg/jhYmqEHqGv3rK3aED07pDvi2DPoRbvG2gSKxCQCBRprZes3dCkCz2hw1QcKd
	 YiftiVTngz++27M48Rtc2PpvmWagPlToQt6Y7XliLguEQA3I54LRmDPmgdkiscVRaQ
	 y40367dM0qOuA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 35EF0C3279F; Sun,  5 Jul 2026 10:08:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MDZdIGJ0dXNiL2J0bXRrOiBNVDc5MjEgQlQgYXVk?=
 =?UTF-8?B?aW8gZmFpbHMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg4oCUIHN0YWxlIEFDTCBj?=
 =?UTF-8?B?b25uZWN0aW9uIGhhbmRsZSByZXF1aXJlcyBtb2R1bGUgcmVsb2FkIHRvIGNs?=
 =?UTF-8?B?ZWFy?=
Date: Sun, 05 Jul 2026 10:08:32 +0000
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
Message-ID: <bug-221706-62941-M7GJSiaDbt@https.bugzilla.kernel.org/>
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

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
If it's a regression, please bisect:

https://docs.kernel.org/admin-guide/bug-bisect.html

If not, please test 7.1.3 and 7.2-rc1.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
