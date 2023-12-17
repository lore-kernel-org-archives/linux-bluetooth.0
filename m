Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570A481A2
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8qaeu6s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF3CC433C8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702837921;
	bh=VUB01ZtHOQpwFrGxR/7IAlHzDIvBBfNK8p7Hrfws400=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H8qaeu6sPWoakhpkpF53IPWiMbA5erh5imj6ZeACZWL3NnBHYTKmcOVx/LJ2NNIWL
	 Wy3Qw2tf4JIta68QIXn410EkucthEplzRYWzwirUySyJKQeoIeTymFmzjTpi5DVPgF
	 9V6Q92vtp0m3z2BnUAM6oVZp+Yw6tWo9JKxg1FQEiIO94WqoqRgJTvBGbA2c2IB6tT
	 4TX52Qb8+alw+9CUACOjtaq4LC/ml3ok1R4+QNw9mMVlIeWNeS4HwWvRBFyzXT/0pe
	 ete0sKGILVXXD6Tm2rTBdXe1PnA3zzpV93iSsnKY91ld+O8K0CQWtE2CB9FzptjtfB
	 27m0pfOSuV9ZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4AD43C4332E; Sun, 17 Dec 2023 18:32:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Sun, 17 Dec 2023 18:32:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218264-62941-EY7YHJL3ZJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

--- Comment #4 from Marco (marco.rodolfi@tuta.io) ---
Oddly even the copied keys make it fails on connect with
br-connection-create-socket.

I have no clue what is screwed up at this point, sadly even this workaround=
 is
not doable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
