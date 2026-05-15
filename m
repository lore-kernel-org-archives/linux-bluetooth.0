Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B0306B31
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851553; cv=none; b=V/KX6RTPNHxNL35KHM0He4me2ZnuzOiCfHBzaH8+cwsDqASv/ua0runR4vDd2d9iqKkeLYZRdGbKi9PJ9YofcnFRs6HsBmoi4fOEdpKtkw1/t58/RW2V35CYWUcn2KHvk3Hfz04Db8uQZFBSv6I9H+UYQG1fjaggvZGgCwhSeL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851553; c=relaxed/simple;
	bh=nz1VgjxRrLLWcIgX0tOF/fMapLbP5oX32HFPtlvN6Qc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqtxTYeVD8asKnWhmuqDhQO450MoYR0GdobVi9dULDPnW0hPM1u66LrWosIpXa/7MRcVyp+1QCV3e6kNcVUPjNmEsKwE0U8Z+oY1HrB+1eOlCz2giLsxxl2F4zsH3y7yJSSFcmRuyssxLDZI5yqKUdUhZl0s3ZSSPzNRm3IOyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh9aJMWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh9aJMWK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9EBFC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851553;
	bh=nz1VgjxRrLLWcIgX0tOF/fMapLbP5oX32HFPtlvN6Qc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hh9aJMWKXv+CRG4lkjFAd+jmZjubFfSyZAWAeFVhjzv220vDfLbButCy2TmTnKDbZ
	 Z97Q/hRCqKE49f62qRPBIKDaPAV9ECJScSbFTNJ3KqYmUYNTZxYihhIPyedee5sdy5
	 z2tJP+4pyT8tGhL8+rTC5x+ejmD6LDoty3rYZ0Sd+Oa8T8tu1Ijw7rucIh1m4+Ikul
	 +2Nt0958gYwuNaLtFQM3k3dpjRqJyBUE6xk0Y3/v+mRveNAEcB2A1cr4jiuv4/EY2L
	 zu9pY54taYMiJyzW8Y6lHbdvHMt0irSciB9THvm0xFLTMmGhzvjLNlmdbL9Wlm3zQ+
	 cJ60VbawfqfEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA1BCC4160E; Fri, 15 May 2026 13:25:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221525] [REGRESSION] [btmtk] Bluetooth fails with error -22
 since kernel 7.0.7
Date: Fri, 15 May 2026 13:25:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221525-62941-UN8p2ZiPqY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221525-62941@https.bugzilla.kernel.org/>
References: <bug-221525-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221525

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221521 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
