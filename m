Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428A3A1C3
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150195; cv=none; b=BGfh+xmkRLie1YpjNlumKwNx40WtZSaJOCUpi274XphEs2QQB5pbdWmNg1CR2DNzfLHDPefuVDNuSbV8TlUJLsDV9yVtOh4z49P2ZTXQRX88aEOqed/4FE6zaixfHO6rWTq53sl3X2O5MGoJUdHTRuajOox7ZX4GaBDsVin9BKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150195; c=relaxed/simple;
	bh=tR0KqEIgiN9Gk8E53xmL6dnjVKpqZcbeT+ZSd8dWkEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPl+uKKyKRvXjN5KQPRiNdb7/Rp1Lf09ndolOmUEQuxKk/e96qeCuDehnOc86cESaDpeoDpAG5E9pADJQWwLU8+lS5TqunCguc9pMKfFfRWRf97gmQTDxYMkzABlqfd+M9w4db6niEA6rXZMGXdGCHIzzwfYr6AtZ7+E65eZWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvncNnqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvncNnqU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AD2DC43394
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150195;
	bh=tR0KqEIgiN9Gk8E53xmL6dnjVKpqZcbeT+ZSd8dWkEc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TvncNnqUxHTQ7QStaEAbIXWTzGmPwM2a/eqELcrQXH3QKIGsorjezCsZ+1pdrD2aJ
	 qnb1xrb1r6NZzKU5qRgz/u2pFetePTM4wTv4mcieNeK5q4+bbtGcaQYbbhjpOpEo98
	 rqe1LMXe9QtnHSp7Xq2S1bhLLRPTSmM7mkvQvU9JqmxSKCzYYCE63sbI7aVuUeH3ok
	 UVUzzyvZWyInuR7AsmGLdVpGybItvXnG2auQVD2SNZ2vNBsYxH47uNk/HBHBSwvUq+
	 jxbT83vJeWJxqwc0EYrghZO7QvyxP6BovBh3zGkUgRq8glx26fdfm8tyo80cQwyxEl
	 XBGR1q2alAp2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2C9A4C53BCD; Mon,  5 Feb 2024 16:23:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] KASAN: slab-use-after-free in hci_send_acl in Kernel
 6.7-rc2
Date: Mon, 05 Feb 2024 16:23:14 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: zhenghaoran@buaa.edu.cn
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218440-62941-m8aODM1tKO@https.bugzilla.kernel.org/>
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

zhenghaoran@buaa.edu.cn changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |ANSWERED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
