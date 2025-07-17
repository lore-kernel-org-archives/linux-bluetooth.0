Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811621931C
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781810; cv=none; b=lPPh3H1SXIAi1D0vuUlduPrWn1GXVU+Y9QvygDv7vkEj379Ysk7QEL1jhN1fNCYfXfY5s9ml/QwXpe31PlWHTX95XqZpWj/Fth6QB85jCtOGYNulRb973CtxIlf55k9bjUldGr5DcqNzlwqf5hANW3qG9p//aFWKuI0m76Cx+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781810; c=relaxed/simple;
	bh=JA9TFwTqHRy1hapS6zzw+wVIcVw4kE3iGVyEv9Rh9AQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4tzmMTEJhHLM1DoGLUYgtXK2dnq+lYM6ZyXHGopwMAE6VvJoY8KDB8mVd5+XwDy3EFVwks2p/tjKLH1ckfm7SI822UbUGS7Bgb9Cia2ovby8zbRBX33AAFL58Vzf+TwU/dmgug1jMrOAKt8UApSyD/t0OEoPj3OMj57S4IHwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku4hLJtn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku4hLJtn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDD15C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752781809;
	bh=JA9TFwTqHRy1hapS6zzw+wVIcVw4kE3iGVyEv9Rh9AQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ku4hLJtnph0SHeFs49Op6iIYBIpJK1zv//2ytdnCS2QjBIwqfgX8QKboCeSn0brDK
	 fa2YM0C6x4ugzhqJ1VjxbIDBkcXw1Q6BJH+bfDND0EQerT4bPNRoXpFnhB5+jFamII
	 TFNYMiMEOuRFUf9NmqYOyZXZJd0GpUUIOvrSwnSx68+F3idxcyf8Uyv6S0JnsAoxzb
	 CpM0OOgDd0QBPOo7m3/YomCyU5bpORmiAGSICSgrJHqYNrevpXKpPqR6F2d0VwAnKN
	 yQSqWgA/AGez9vyNVovxU3phZZriEzE7SaZehTlfzwqdcmgFhAUL3RzxTU+pa5SCDb
	 T5APw+t92vZ1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE0B2C41612; Thu, 17 Jul 2025 19:50:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Thu, 17 Jul 2025 19:50:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-mFlQaDV1fl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #12 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
Hi

When I was still having the hardware involved in the issue, I did constat t=
he
exact same behavior as Martin described in
https://bugzilla.kernel.org/show_bug.cgi?id=3D220341#c10

I don't exactly remember all tests I ve made (a lot of tests), but I'm sure
that during an X session (using Xorg or Wayland) I was never able to unload=
 the
modules and I think even without X, I has never succeeded to remove it with=
out
making the computer crash (when trying to force removal manually and too mu=
ch
hardly)

Regards
Nicolas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
