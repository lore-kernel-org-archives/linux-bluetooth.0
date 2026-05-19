Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2543DB330
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211315; cv=none; b=dd26YJ/UO2yizNWpHgwDHb5q6jtQnV/HgyQguYrGzOOZHwlRZERLoH/beWNRRuGhe2z861eO9gq6Vyo64mH+wQJyU4BrgSNQLVpFnokgPr+e7Lzu1YP5dhQanfG373xbzuSfTyJfQPg7kxPteUjiuTE1pV9Oq4cb66NsDEw10ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211315; c=relaxed/simple;
	bh=he3xxLSWEFYTSCyK4ojOaCU8YwEhaQAtgDnmujczFTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXsJfPyX6QRvDp5pKb3w+42JYCiLATX4aiON1yqnZEdOcumUpAnfTJJvnWxW/TPM/xL4+mfdDvLErpsAeVaT6/CxGiobI+MuH2ITP49awVJoCzoFqYc9RFlK0DO6aqs6WRe0fr9EZklhme7trej3wr0ENlnMZgxp+m6S0aA9Snk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY8V1/Jd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY8V1/Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACDC9C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211315;
	bh=he3xxLSWEFYTSCyK4ojOaCU8YwEhaQAtgDnmujczFTc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PY8V1/JdNTyq43ndOruAdJnSPqyeBKpwzSdraILGvwksqgmNmIBFBD7YYJFlCTFHd
	 4X6t6CFj5wRH8t5K8liWere4ooIwasJ1Xv9Yj60IixnTAiUNpOelBJyqnF3jooR0Dw
	 lRfBsk1wi3pslgcvJmp/YA2v3Mh+loSanPAJLAewR3OGrjoADbZ7DqiEyEQdTOICAZ
	 /O0eC4SOZwUqFb8GrqLYzMvoh7YA+eN/tukkwPvyo+wuOrVXIawjh51+dgR+7Zj3wT
	 CHBgSNpbQFD8HXveFWzGjZCQ6x6kvr9zSfx3kEUcpHKp4Wf1Rq0WkZRTRk9k5LYBRZ
	 MlK7AATEdmyyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A33B6C433E1; Tue, 19 May 2026 17:21:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1NTFdIGJ0bXRrOiBNVDc5MjEgKFVTQiBJRCAwZThk?=
 =?UTF-8?B?OmUwMjApIEJsdWV0b290aCBicm9rZW4gc2luY2UgNy4wLjcg4oCUIGZpeCBj?=
 =?UTF-8?B?b21taXQgZm9yIDA0ODk6ZTBlMiBkb2VzIG5vdCBjb3ZlciB0aGlzIFBJRA==?=
Date: Tue, 19 May 2026 17:21:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: gagnieux.virgil@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-221551-62941-5v1NMmY1zh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221551-62941@https.bugzilla.kernel.org/>
References: <bug-221551-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221551

Virgil GAGNIEUX (gagnieux.virgil@proton.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |7.0.9-hardened1-1-hardened

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
