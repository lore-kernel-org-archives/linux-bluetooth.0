Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A14175A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317445; cv=none; b=OudUhqMeTQdFnXET++v+jkyrIp5N9OOQIKPHdLtaFJgbpyeq4UiEZ6WV9ejmB0AMHiJgWo2tWoeEFHAA2p5DqVCEYXaTiOYw0dxICXbFMA+W2VTZZbgT32Sb1ILsCHdffTsnBkJ1u5Rn9EN0lNKaBB+yzSSzDz/icuM+92BhnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317445; c=relaxed/simple;
	bh=HAHBlO5b/1XPTi1aUgk8krMM5spGwLAWA+r5TlXv4qg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skfhmEYaiVfzBKVqWU0tUPZMfnx9GoL2Qo1eqUd5ZcuYy29l4k6FRyKKik+/dhepd55TGXWJ+Fs92M0dOGo30+GUo13ZDzIYc9fHq8m8XBfmDOLthUrbJnvG3xb0jGHAWxL4wl20G3GhTtTx2vzTpVoTFZP38w6GnxvZdxny4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gey09LYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gey09LYy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 276D7C4CECE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732317445;
	bh=HAHBlO5b/1XPTi1aUgk8krMM5spGwLAWA+r5TlXv4qg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gey09LYyELNQJtoureg86DPZuPfH3wYTPr8XhnDxrj0eRMOofxBVUoNkaUMPitLf7
	 0fNmUStWTqSx5XISVrjkIJAVSFgHggHTATUkUYDo5A3TY6crkulCuKaeQiNXNw3zI+
	 duCISTreY6ML1/DH+41tLoxbf5uWJToif73RNXi7MsrNtggbWd4mqdzi8KLY4zxP3v
	 wduOVjpZwtNPKyZFR6tKzW9R2771g6FT7g4jDu07uAaDl1kpGJRt//i4jRo1UmyeRb
	 kVrJHPN28DBce7FtpSWyZLMH3g+sq+rHH7aYk2QfERIbrmrlHLJKGw1yfmSdeJW6b+
	 yFPK/oYHYD5RA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1758BC53BC5; Fri, 22 Nov 2024 23:17:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219519] Hibernation Failure on 6.11+ due to btusb
Date: Fri, 22 Nov 2024 23:17:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkml@antheas.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219519-62941-qqdQy2J0dY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219519-62941@https.bugzilla.kernel.org/>
References: <bug-219519-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219519

--- Comment #2 from Antheas Kapenekakis (lkml@antheas.dev) ---
Created attachment 307265
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307265&action=3Dedit
Revert patch

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
