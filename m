Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB72328D8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeqlJUfN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14532C433C8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702828312;
	bh=JBXXo059Qv5dTNKj8kGyLEHsYHFJ/xlwP+2HnfwSLKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jeqlJUfNosMCBUQ6rBdYlgJ2uV3KJAeHs6SPmAxGmjZBFRPL4B8wQ86GyjBrA6Epq
	 kWFhuiChqPXooWkDL1Q41xJm1tg8rUCQv9/6ngRpTp8hadOXfWbXNZe4CoYT/AWOtn
	 jR2cZIqPYAVEosAe/2g0XtGAxtSbMq5A0yoqAkN+n0RtEfQnncpqtIRuWHq7Z6ZdDF
	 kp9ke4U+HG3T6e9qZtWZf9g80VIs5ugqskYBvRDql/6pBSviCEjMs8Uc3bcKzIKhUt
	 JwnGs0UiZmqEf5lbDW3sfCZsMwCqqupdC9scjkd7rRgsQA/2JLyd/j9zam1muDqp2i
	 czJsbC/5zvG8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EAA4BC4332E; Sun, 17 Dec 2023 15:51:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Sun, 17 Dec 2023 15:51:51 +0000
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
Message-ID: <bug-218264-62941-KOrrUSZweQ@https.bugzilla.kernel.org/>
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

--- Comment #3 from Marco (marco.rodolfi@tuta.io) ---
6.5.6 + bluez 5.69 works 100% fine. I would reduce the commit space further
down, but since I'm on a Deck + on an immutable distro (Bazzite which is Fe=
dora
Kinoite 39 based) bisecting is a pain.

I stole the pairing keys made now from the live USB and I'll place them into
the corresponding bluez folders, but to me and from what I've read around on
the net this seems a kernel regressione introduced in the 6.6 cycle.

If I could reproduce this on my workstation it would not be a problem to
bisect, sadly it works fine on there.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
