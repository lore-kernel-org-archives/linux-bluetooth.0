Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE313C9C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272459; cv=none; b=h41mVOCZyAZEPYDJfRn2I6U+ee9jvnMVNzRDmrD/ye85oSEtK8qPzcRZlF1Iujb9B+Qa1IJDQYQVn2Uvgx7SnDSASWRylYqwC8zTVZypWEsEX2gH3hoITCmS7n0dw4W1/5jRIHovddGmledCV6SaA5n1U9QS3SH6qM7KWkxMaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272459; c=relaxed/simple;
	bh=Wgo+DH4SdqjcD8Mz3H7QjqmWR3NND8qvIMl8GRTr5ic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvY/LWdEpWpOXtE80rDD7UaLMi4QC0djvijRywphgba94DZ1clnAu5tss186/gj3SE97PoOrofH/UTZ/qYZAqN6bWj9COoARU9sHMeyQ91t8UpMNwWtEaZCfIxaIrV83ex+t15k8n7BUN6WCu6sVyKm2jpdNlWtMMT7qu1TLl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfzrRS7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfzrRS7H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9CD7C4CEC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727272458;
	bh=Wgo+DH4SdqjcD8Mz3H7QjqmWR3NND8qvIMl8GRTr5ic=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pfzrRS7HdISR6sUgM9mG05yMdamv1lEub36xP6ryuXwwsD17DVS5szB1h9cBu0Nny
	 NEvw7NMr0UxN/6ZtQWuS5LSJXPIt3L+/XXHBFtPrgrMGFN/TZs3fP6vEbjjwwciyq9
	 kMhz4dSrrOuEmkMCtcdndFiMqgkZo6ZBb+KZplePxIYZ6V4DL6NYd9CVRwwRqztb+e
	 W2nBgWsngLMJA+ouAPbIle9NaufU2hJsxKv5hsJVOK2kwEfpjsH/Z4561uB4V4wOQt
	 2OmXZDapKrNAO010HnAjLY4fvdU683h5/cwucaqtB8IUjuTWwoyL3iq0b9h/Zr4oNo
	 ILw9EkULTFF7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CD34FC53BC3; Wed, 25 Sep 2024 13:54:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Wed, 25 Sep 2024 13:54:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219294-62941-OzNEZTl1sM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Christian, I consider forwarding this by mail to the developers. Can I CC y=
ou
when doing so? This would expose your email address to the public.

Also: I guess bisecting
(https://docs.kernel.org/next/admin-guide/bug-bisect.html ) is not an option
given the "occasionally" aspect?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
