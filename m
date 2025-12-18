Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33853A1E64
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094936; cv=none; b=VIx9tjqHQu6v/P06UuyKF7r2crFI03ZlEkwvKMwCOVRiHBgYmiq3ytSdvjgAkZebNuDfDUfRa5LSd/59QfkTX9Pb/JKoz0G92FydA0BqCKbkAngRRbpuW9C7o+kglaTKFP1IQWS8FTs4Yy4t0BG0AYN8GjsJPUiM8SzOqEPqIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094936; c=relaxed/simple;
	bh=cisfjgjwbzkQ7+vhA6v7wOPzJ1+S+CTLarnKrxFzkXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjM+TNXB5u1L7Fcj+L5JnC83R2X/UVbcIM4B/RYbkrRrksHchG4I1yQr6kzu34k0WRyL4Ncr48RwRGQX2P13baG6AkHyVB/w6JwSKFTiYNfqZAGpNgLbv7hVZfnKc/wIqu49BEL4raLZ2U+5j4hKtwDBHXeY2zj/zoBM0Ya3Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyUfsbhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyUfsbhb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B1FC19421
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766094936;
	bh=cisfjgjwbzkQ7+vhA6v7wOPzJ1+S+CTLarnKrxFzkXY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nyUfsbhbxGFjZEllfKandTrnJlF3BdJbx2iK+tSCxx8vb6BeYs0edlAUFDl15PlpF
	 ovDIxZZMM6ZicFmwC0BvqONqOklTG/hs8jJqp5ubi0AMzMYvcZRn/8cnPmv/z44ALr
	 URfS3vms8fqCX4R5TrStsgwMocf8r9sGaivVmcPonxC2YLKrxstjKRwCGzCKpc0Pf7
	 kLkDBvO77Lq1GkV0sO9CyqGlBEhWmoT6XS9nu8DYvkNNVleTHyzUapJ6dmlRnXsUZz
	 NX3eoK0+bNvm4rf9+PgcfFTlE+G+JAXv6wrrO05HjcG8blrTlSO+UjHgLt1s/pZ2MI
	 Au9E8znmVShhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5CBACC4160E; Thu, 18 Dec 2025 21:55:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 200007] HP Elite Presenter Mouse support
Date: Thu, 18 Dec 2025 21:55:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rdunlap@infradead.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-200007-62941-OYzwsUKXAN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200007-62941@https.bugzilla.kernel.org/>
References: <bug-200007-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D200007

Randy Dunlap (rdunlap@infradead.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |rdunlap@infradead.org
         Resolution|---                         |CODE_FIX

--- Comment #6 from Randy Dunlap (rdunlap@infradead.org) ---
Marking as closed/fixed unless/until someone has a problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
