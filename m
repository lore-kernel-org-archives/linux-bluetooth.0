Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBE1E1302
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497172; cv=none; b=A7M3jAXkv9xubBWGjqRS7YeqbU0YSQ8W7j49/cpC+jvbwUa9uUnGKF0p60NNJwPLzIV8lFyd5Lm1bRLhhw4X8X19dH8cGFSc8bI8HQLnGcaR4PhcDUeSUNyihc6kCVTgPLBbCGCSmfy+RYtferArAdMzM/vFPnNGMsaItPeQFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497172; c=relaxed/simple;
	bh=RypJsBXHPG6cI6T9FAtZrnIOlPDvwp/pKRJtdeQDwdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYppuJj7avb979MmwFZlSAgWbSzNounkY2Ffd/S/gdVkH55WuSo6YsZABei3K4xllfTYcHmdgMgkehqUurCtY5B2d1aBKTg+X7RctLj2p7PNMAsi64mURptv+hJ0sQB+yzJZ/6cSipcNzyFBQylIljCNNuJbHOh1wTBU3jKITjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZszxDjIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZszxDjIM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FAC9C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497171;
	bh=RypJsBXHPG6cI6T9FAtZrnIOlPDvwp/pKRJtdeQDwdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZszxDjIMXXArOrGeP1sD1/Tb8zNeDl897np5TvPu53sS9V6dUCzs3wMcwjsSPx+sr
	 Yj7MrEvTq5UlLGTB0wp+Qiym9yZssG4vn+h6ZtHyhQwiRS5JUD2p9X2y02ldKISzUf
	 8BF6iVmkuFYmWOKFS/zlVeM7wyYKjwDpfbIo0aVsQVR4idwyzNAkXLe0sprnrp4oQU
	 WzuDUOKrUvZTG4OeQHrrt0e6yQn9Qnvls53Nz8JatVZWLYLg72p4viir7B5z+Nmre9
	 1EjeOFpvRVXy8IV1rtGR7VPHpuYMSvg2XV5EVspEMneVCWsKs/T+/lZ6aY7jpQVk6A
	 jxmfbd0WbqHXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70FCAC53BCA; Wed,  9 Oct 2024 18:06:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 18:06:11 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219365-62941-WTpgnMIOvb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Thx for the bisection. As Paul mentioned earlier: "It=E2=80=99d be also goo=
d to know,
if it works with current Linux master branch, or 6.12-rc2." I'd say it's not
only "good to know", it's requires, as that determines whom we need to cont=
act.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
