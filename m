Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6A1DFDE
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729434478; cv=none; b=msSRVesmQEfdEfUrAgv0zJI3r85cg7JpTK7HU7rFNGiC3sO2YLzlw4qXJdxp13UnK31hIbUnTiVflOTC/Ou+OubsZfUxJTSzLyqwWjXoWnpPAd+Ckz2hU6OaY9whPv9WwnTUZjoesqGImquRHKI1BUaYLS87TOOR6412x31/d8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729434478; c=relaxed/simple;
	bh=iuaNMv4uJ/w9fOKr3PFZylhB1wVjKuCLWGnvRWL3/gg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLXSdIkm9rC/KmCz7iyhyC8QD/TN7y4QfGFEyMraNFuVQTi0oyOWvhg4WhQipWaEiJfbzCMsrg3GEnD4XUffwtXsNPNirtBEjQdJRkIouaOYfqIgbkdEsi/9W0Az3q5WXtiKs5XHgYP7PSrnpAzno755du3T2FDo4A6tKr093hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBCfy13s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBCfy13s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47FE1C4CEC6
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729434478;
	bh=iuaNMv4uJ/w9fOKr3PFZylhB1wVjKuCLWGnvRWL3/gg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rBCfy13sn4iyUXxS8LGRoHUX/qnujnECGOBCyP/T1efV6wJh1UO5TnuZ1QG/cSr/w
	 iKF3fSL7mgJbF4UVR1fmdOULrMH+3ojJDHB9cK3bdKHDwltB8ZpdsXBx9ftuZlwb1u
	 Yq5LYO7atJSOwqXAqrZhV46E9arRUDYwUYN8MwRCrygg5EbTzIV8XEGXtOYLhYQyW2
	 WYNTEiHGngec5S1XL6sp18ZDg5jJCajhF/vYKqdoCV74+z/TTibXv9ggMpExzE9m/A
	 nC8r0nAdXcWBLU0Q5TW8ZQV3KGx6KSRLOsbyFUS6ogKjqa2hb7l7CWI0uf68WueDs2
	 8r5UMO8B4pDeg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33681C53BC4; Sun, 20 Oct 2024 14:27:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219404] mt7922: bluetooth can't find any devices
Date: Sun, 20 Oct 2024 14:27:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219404-62941-hv3q1LWeUr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219404-62941@https.bugzilla.kernel.org/>
References: <bug-219404-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219404

Georg (g.wenzel@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
