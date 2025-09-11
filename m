Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83A2550CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589576; cv=none; b=ppkO5U9EiHouOnl+DuzaqQZMzjiaqi3I9uepRNAsm2d9WiZ4/BxgsNAZ0CvzJQEljuCk4Qy91E+PKfjoUIzg9NJvNO1lj6mZBhyQV0augjss0/xsv5aGNfDwiRvendt0duWjqggA0B7rsKh51oxG3k/COZPDqu8KMnXqXs/SWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589576; c=relaxed/simple;
	bh=cb18xh6s7O91snfz/0ZRDfWiI/J7nR4NlCykWqVSXio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PzA/n+WlGDZuMf1PS8O+xrAstbkYfcZoRMgnHEfShrOp0je7FbnGrgintdhrw3d6js9cBdBzrJKrE1Ou6wmEn7JYatVI3HUD6k/W4MkDtLGw6XExxxUCLwVLeXdopR4jvfJn+OZh2tzpw9P144IuETEW4x8uDhu9+cZ/302zuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ermnv2v2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ermnv2v2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6416C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757589575;
	bh=cb18xh6s7O91snfz/0ZRDfWiI/J7nR4NlCykWqVSXio=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ermnv2v2X5AU+vXZVnEFBUw6hxSz+shbTK0vgecymTxLIddXivWpooXpe0eM8ZtLK
	 HE7Z/Scejls+0ndswGzk0xtS/0XTWPVv1hhpzdPCGGQJ0m5rL+Q/dsjyqxgTs7wJTF
	 8I2llq6jS4ThkVLKjpwSLdLajQx1c7Dqus0AUTvNy8W7eBYD39+HcMKP8DPqyRje7S
	 cttWMrlSibfyuhPXIRWxA6nEj78aZ8yC3RuZTcushcg4v2Xono194HQX7K9vkbBHmZ
	 ctIfcOO6eN+Tv5s+95BKy+nAfJKOYhsFMjsJ4yYNqQGiDwlITaG9OFIPPE5ZA9lFh1
	 0N3ZGEYzOv4uQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE369C41612; Thu, 11 Sep 2025 11:19:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Thu, 11 Sep 2025 11:19:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-FYUYJUR9xy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #13 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Jakub Jankiewicz from comment #12)
> I think this is a real bug, I've just noticed with latest Kernel 6.16.5
> (Fedora testing 6.16.5-200.fc42.x86_64), the music I play via Bluetooth
> speakers is interrupted when this happens. And it happens a lot. So this =
is
> a bug in the driver that needs to be fixed, not hidden.

Open a new bug report and specify your HW.

Also make sure Windows is not affected.

If it's a regression, please bisect:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
