Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA915E5C2
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 May 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748099844; cv=none; b=Tol0yIz0L4bsgO/yWUe0tF8JH2/gYL9GGW3gjRWA3cE8xECHTPFd9fQN7QSDYY1mbXLd81J4JQGEXNCt1dx7//8XIIpC6FKMyBhZ6SkjHv5YeI8jWYIndvlXpxzAgno8oAMZluhWHeOewTXjPL24/QGK5z0C1rzYRWclXatfjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748099844; c=relaxed/simple;
	bh=3gjhGQITKpl743wXKbW9deipkaKZWBKWIcB0JKD+iUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBK8w6VOgL6fS/GvYkzTnscNRyRLClvO0hBcrrRg+OLUU19LJCsAIZzj8dqSxbPoeiY3EJ2nm6WjfCxGFdttQ5YTsqCitWC1v838C+q+Rh9H8a8Impsm35P4TaaGdehlMyqmYzqUwA+xogBBSFYReDWNj+OKStXvqu4ZXMNMqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9AwwhKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9AwwhKt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96876C4CEEF
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 May 2025 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748099843;
	bh=3gjhGQITKpl743wXKbW9deipkaKZWBKWIcB0JKD+iUw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c9AwwhKtZO6eqvJPw2mWRt/uSAxbMwAqIs/AbDKwvdNFN/Mqmgx3wcOX5/9Trq6Lt
	 K26RlRWty41oXPOsYorz6SWuCXkiOgVUUbk7VCLfsuWh02KCz5JPHzF4jyk8P+rdFA
	 VeIIlRz2CqF89aqysJUEDX/wbhrtSUm9fQXY/Oo7jRubib61T7B2n1Hvr1vcvZXLWd
	 Wx0J2fu0QAWKp9cd9G3iBFy5Ke+uXtBjpIiSSp0ahyGp48cnja9IE2V75/8bju5ZNC
	 FwTfBdrT0NZtsbDyuA3QJ+B8XVZGEbW4Y+qm7OF4u0X596hN8/mHA/Au8W+hrNzOjN
	 9QLbdwNKF/Pyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8A9F3C433E1; Sat, 24 May 2025 15:17:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 201247] Intel Bluetooth device 8087:0025 not recognized on
 ThinkPad E585
Date: Sat, 24 May 2025 15:17:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jarrodmaddy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-201247-62941-v7xm26pQxL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201247-62941@https.bugzilla.kernel.org/>
References: <bug-201247-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D201247

Jarrod Farrell (jarrodmaddy@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jarrodmaddy@gmail.com

--- Comment #6 from Jarrod Farrell (jarrodmaddy@gmail.com) ---
Chiming in to say that this is still an issue years later on BIOS version
R0UET84W (1.64) released 11/28/2023 with the same quirk with 8822BE and on a
Intel 7260 later installed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
