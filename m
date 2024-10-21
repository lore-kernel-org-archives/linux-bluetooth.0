Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F81F1314
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518775; cv=none; b=Q8yhgOt89XxWJfH6Xn/FbGiXP4tIoq56OAR4vLoa/5rfxFMXNg2wdFk1TKyAO6wuGhEB6rsllXPnbFdgWdsvAH64EYN8+/OxyuDaMe9utvxlDj42fBq1Qlej93xslz0IM7iYJsvKinwF6ndZOkSXIUkBAUZvotgRlHI/1xXLues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518775; c=relaxed/simple;
	bh=N42hCw5osus73AiaZ0JEKlXrPoc17O1oc1hijPI8G78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlkosvDxltOsdBZ/XVdS18nRzTwbss+BSrij79DxV41+5fKnE8EwsO9+CSzHxLKI5dwwc6IOqOUAuru7fRA+XIhlfs/9tAYSN+QY4PsMKMeEYJ8/+Hl/gQrGQJdrB5S3xfUjjWzIJzleWvNb/GUC8xUJolf/ubu8NBLu/iQIiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmF4uZ/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmF4uZ/N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE703C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729518774;
	bh=N42hCw5osus73AiaZ0JEKlXrPoc17O1oc1hijPI8G78=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QmF4uZ/NSKFWGaV4eLwDOJMxCDB0DQGjfXJK4ie9tWleStCOima9CWpkcVxhL5COo
	 7nkNYO1uqn0y3dEvmMR7Lwi3rrjbU9ao/P3KEPS6oD8MwrZu9Iag7rK5g1cJcHIZIz
	 g0uaOnVP5hzoGH2ckBLcNLwp1IVJrmMz5W/929eniZ5UtpNwHaNvqkjheL00Ui9xdP
	 bFnEE3vEoUbYCLi+28QCavh2Gg5BGB2FoRVjK4saL8FLJW9mmAjh+XIT4lE0DZsjUq
	 +13vLwkmiOwi6Qrv1pudY98ZEvAtCSx26F8i43axXsBgRcdUyYTkJsw4I5IHTxN/NE
	 mqeNjhuyNArSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BD057C53BC2; Mon, 21 Oct 2024 13:52:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219398] 6.11.4 cannot connect DualSense controller via
 bluetooth
Date: Mon, 21 Oct 2024 13:52:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: velemas@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219398-62941-ZKr2n0mWjh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219398-62941@https.bugzilla.kernel.org/>
References: <bug-219398-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219398

velemas@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DISTRO_KERNEL

--- Comment #2 from velemas@gmail.com ---
Resolved downstream, see
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/86

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
