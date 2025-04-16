Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF7217657
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835367; cv=none; b=PxvqoU2F+4BTSCkQFiwMUofogJZln4AmqZyo3tB2YR8qe19dkvtAOAOI3iH18Z+qQnEvL0ZE37Zyopnw9snsZ+BbObl0STRS7h+n6Tmr4oRW/y1u3oMLL4D0gOT5qSYSer11jR/fhTwSGNRAIne2Wt7QrPM9aypWOVZB7L5gzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835367; c=relaxed/simple;
	bh=GO9jdi4gACO0uxmc9DdTOHn2mznwzZ8olhDMTpAyeQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqkyOp+cznxvuxFkFyxfBOLcxOKjSCx3g11Xre/LKqSH6b29W2a9wRbEeft9RE1YZn3oAuqikHpLT3OhSlKh03O/5fPsWHcw3owp6DZthse9W/a1IaYqC/QbtUmgRifClEiUdZPE5a1rcpCY1AXcMc2Cj3eSezP9iaIFp11ceUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L16nSZVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L16nSZVG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24918C4CEE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744835367;
	bh=GO9jdi4gACO0uxmc9DdTOHn2mznwzZ8olhDMTpAyeQU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L16nSZVGnP0EbsewUVG/+eFevZLyAW7cHniDj7s0qiQP+CXTFf8jS/D9Z7LZIjqez
	 iXoNg6wART79mtoUqSSOy3ofIx+iYiV/UIQYDyQ4N9pjjSfMOXMBK3tvIGt48DVQtG
	 DC92M0mGTkJVmGU9ulH4nT9mMK6omEJ2DJ/5Q0PJMyarZ6nCfs2lzKmPvPzs5eKvO3
	 a1Lpbx1Jd0AOYA7FtiXXuUtXLUYpF0ijp1Qa+sm91omZWKpiX1JGUW9vyj7J0J9JUp
	 0vhut7bXo+uA1wZU4zdnuQUmFmLMh78A/4UaKeCS/RprnCsR6Sp3d1wNDHISDFisrv
	 6URd12YjqBVog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 088C6C41612; Wed, 16 Apr 2025 20:29:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219854] Bluetooth devices can't connect after toggling
 Bluetooth unless they are re-paired
Date: Wed, 16 Apr 2025 20:29:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linux-bugzilla@ericswpark.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219854-62941-7VQm0Q8KoJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219854-62941@https.bugzilla.kernel.org/>
References: <bug-219854-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219854

Eric Park (linux-bugzilla@ericswpark.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.14.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
