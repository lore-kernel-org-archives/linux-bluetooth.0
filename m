Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B891F8691
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182313; cv=none; b=AA4X9cgV8aYuaH83ms5BbuVfcOvs84CvqQm0Ly3m43iBbsmHM13L/MO1FMDsh5wrgzy3lja03gzw+KLL5GWcLER5djkN85gLhN9tUeHg5sqV4KQj2Ylx11V0w59KHIbXDI6aqdx3oG50Ye6xPX8oO6b+aLQu57G0p8EGK9UriUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182313; c=relaxed/simple;
	bh=oJhAqFO7rGdATVcICgXbnaSvYz9lsBdG/gRSDlqfcuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOZ6fJQ807SK96lgkNNFvba2yq0c5EeMEXWms/fflEtcqYkXojdsm1rH746t+rn0QoDTddc687qVlV+Nk+X/ZrgaShyliCiucJcIeyMKQVnB4JGhx9pC/wTVTHDc6uLXqrdMMZzB8inrkIlfwEknlNgB1v79aBGk6S0Ck9gF+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMzsyVjU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMzsyVjU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC813C116D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766182313;
	bh=oJhAqFO7rGdATVcICgXbnaSvYz9lsBdG/gRSDlqfcuY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vMzsyVjUeCzT4HqgOIV33wvgDCr43f7+nxJV1FejVdkyU0YBzNPEsSrWZUmzA7vjN
	 c56q3Enw/c4gnT0jJnedNC/Ptg83Y+5Ed1Dr/gZSF7tH5Xjk/MTaJURmT6op0p8hat
	 XXSGl0a5Q6J5LauBVwUHUfyVCo2udPZUBUW6RSQ98Q3jZ6tMlRZZnpTMgRR0EhGzxi
	 GYeFunWOeWDYmyIQdbg+fLm/Nkp0svnAA9uzUdbKq598IPU1AanIAQib2QQzg4gDQg
	 PO4WGm/dl7BQ8jRhpmp49rz8LFRMPKRzt/QUznTQMS8DV4F1euFWtoxJNqpQsqN5Hv
	 gudc0xiqpUi8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E70D1C433E1; Fri, 19 Dec 2025 22:11:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 19 Dec 2025 22:11:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216936-62941-TCkm6jYks8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #26 from cheako+kernel_org@mikemestnik.net ---
Created attachment 309052
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309052&action=3Dedit
Skipped the loading fw attempt

The dyndbg settings are the same, the only change is log ring buffer size..=
.=20
and the contents of that buffer.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
