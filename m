Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5276321455
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591887; cv=none; b=rbCgCk/55GGwNwlAaEV6gmX3aUbcUOXCKwKn08ArK7DkXSrkAB6Y2N69cuUKHV81zQH1ofSKL4UX7kY05CUdtyK+X3btVKCXpHl9F97Rf/JyIzbYIuqq7e30nIzv/SS5Qra/U+4y2tadkMUBXr/REkmuu1TY7bPSSW3aH+Z0O20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591887; c=relaxed/simple;
	bh=Hjl6+vVzljn6GxHk8QmD6gqmsyYyWcczBW2OLspIzvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bq8S8kUqj2A8vCc4iPd3SVguEUaYhk0IyHkGhCyZwSQI+5Dt+vIlSKEcSHHPPiXXLPqPdFzZ+5ByhdRsL47z17LZxtq0Jrtiao4i9aP/JWo7yt+1VoPBZu4aHPHFQs5ruR2fxIMCvj/n5PiEXLGSi/dkj6M2U2ViPcLF4C/SiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj5FLFIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj5FLFIf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA4AC4CEF9
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757591887;
	bh=Hjl6+vVzljn6GxHk8QmD6gqmsyYyWcczBW2OLspIzvg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rj5FLFIfq2+4/Fr1ux1kth6fI1wTwiHxjf+ZKYARiE3NVOgjt2jitlSIi7s8anGTY
	 Z8UyAlW3SCZvxXAPwYhDjrGxr8/mbGx6OTAnfon6jVH2brsJJ226opazMWlmzQpWGg
	 LyqDlO4iKHPlMoV1YfRGNe6kNaFjo9+pZwXytNCHJGhYvpYI52sH34q2MLdEeT/Wvm
	 8Ds5hgYwWjKAtFrzapvVfTKronGrQcAJb2Eh9vRjRN3+tl58Yt6MO7RltBLtyUWys8
	 du3gjDgyZFB4ibNenkiUwTGIZlw65yBFxp0KXpebjy4zYHEBTBU3N9kYPkFsqrXD/S
	 sOySfxcgq4OfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5271FC4160E; Thu, 11 Sep 2025 11:58:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date: Thu, 11 Sep 2025 11:58:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-U3kVlnu4KC@https.bugzilla.kernel.org/>
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

--- Comment #14 from Jakub Jankiewicz (jcubic@onet.pl) ---
Already reported:

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

But I'm not sure about Windows, the laptop was without OS. And I installed
Fedora on it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
