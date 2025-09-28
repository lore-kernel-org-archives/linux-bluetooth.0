Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB02DBF76
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053748; cv=none; b=uVhXBtvvaU/Y7hPVAnWkBg7RbUMeKe9njH0XNwAgeHkJUDt5Uu0wIqxAuWknZwdM+Y5zYBZLoYaDeEtL5rpnD6n1A6Ub5xM33B0SiOydSQQNNK7LpV/oi53RK3ahmhGghgh6wwRl8+nX0f0XhCgKMkoEleznTZj6+6pjz5dHF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053748; c=relaxed/simple;
	bh=36s+ekz3vjPw7Ujl52Tg2i9gTUCDXh2yAO6n9MVcvew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+WaguxMZjsP4qocYGBzRYmmTe3cnlQ0+pQcvaygvWhavjx4qW6B9Stb7epKs8yCcZJvnzddcTdakupwj28BXKApRfVBOX3w48w5BIU0KweKdstqtKIVTxu2je/Nz+94GWKPJPK+04g5/o6JcnIGGqIRQNGh7CbEfW6D8giXk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWf3v3Q6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWf3v3Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B81FCC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053747;
	bh=36s+ekz3vjPw7Ujl52Tg2i9gTUCDXh2yAO6n9MVcvew=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DWf3v3Q63EvJblgVoVWOTdr4W3+NJNaZAKIbHB9Am1k8T6wgZuO4a79mdBhcY1gvT
	 eM+l0OL0MHbpqKDC18/xnVKAZSqZSLA9ztoXx0TscrnUOC8QR2w4DHvIuRxZ1CRk6d
	 nR8uAfjs6uEo9bO+Mwz83AbWvQQUlk92p15wgg4JthtypNS/kVH5fi4Yy7d/MtcQnb
	 mmSdnbUlSbYb6CHNX9f+yPks28gyw86cuRjdgl7aS2VPwTdOSm981v6utgg5d/efP2
	 qe1ot9rcoXscPr0z4N5lJc8Jr4SZRvaaz2ZLACp5AEebNhp93tPUb/yI7arhhHGhud
	 PdFVxdvQxrmtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AF6B2C4160E; Sun, 28 Sep 2025 10:02:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 121221] Unable to pair / use Genius Navigator 900 Pro mouse
Date: Sun, 28 Sep 2025 10:02:27 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-121221-62941-BLrKavqS24@https.bugzilla.kernel.org/>
In-Reply-To: <bug-121221-62941@https.bugzilla.kernel.org/>
References: <bug-121221-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D121221

--- Comment #11 from Artem S. Tashkinov (aros@gmx.com) ---
Is the original issue reproducible in 6.16.9 with the latest firmware?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
