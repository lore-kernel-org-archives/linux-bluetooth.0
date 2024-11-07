Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F372170A3
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006334; cv=none; b=AgaqvyBcdPrJyE95y5GJwBkeDKm0nv8wg7lCTDrOGQ94+w9I24NKxDkH3FFlYOSA5eFGQtzw+Wzyg5oB6a+5hLJo4cwmw6ZbB6Ib+BnT7gVvughulwV7LCZatvsXttC2KXO3GJp7Lx8RkJOCIZGi0ZiT4TFMl9974go62K9NqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006334; c=relaxed/simple;
	bh=BMogcKNqOphXUnaoSSp4R01LUNTH/nCn3OHoWxi5eu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LavEt7SwbolIYvt+tvKWVCZDIAzpICGLqdzFsFi7HQwSKvStwtv1uzUekwgCNZyEyDy0pBG8OKSY9JA/oeGHTVskVNtkwUr4DYGNwaayZKkwMPg4Kpj5Rs5FYQD4VOEN42xb0lXfTeevqUwtNT1IC9K3pffHuEXhXg5mumkbzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI6dfcxy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI6dfcxy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17660C4CED3
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006334;
	bh=BMogcKNqOphXUnaoSSp4R01LUNTH/nCn3OHoWxi5eu8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aI6dfcxyRwg8+ofev7oeygegcvJ4wIzbaK0bypa9Au4QENw8jNXjB/1il6cYuKp3L
	 gs9nYky6JGsGv+kH4GwVKtG5H1wKCZAd5CtA22y0ikhCCTxFqiMPR3/vgy/dOHVQ1J
	 mNajsm3pU0bHRt7weUtR5dunyODZY9N5fgCCLrJJBtf86ptZM9/13bNRHUZOpB0O8q
	 hX7NUKP7TqISj8YV00Cz2fC3ZolLezUwm4L8nXZzbQ2ubfrC4Qh4hUwaWEywne8oZW
	 b3tJeQQWx43DCUR31lWfoPeA4KQukFugG2HG8kAwldzy4KiapJCMlUOzS3WFgDXWAs
	 pBxzj1vQ4WAhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C7C6C53BC9; Thu,  7 Nov 2024 19:05:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219481] Buffer overflow vulnerability in btusb_write()
Date: Thu, 07 Nov 2024 19:05:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219481-62941-SkWXab6SbY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219481-62941@https.bugzilla.kernel.org/>
References: <bug-219481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219481

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
The only reference to this function that google finds is=20

http://www.datashed.science/misc/bcm/gpl/broadcom-sdk-416L05/bcmdrivers/ope=
nsource/char/btusb/impl1/src/btusb_dev.c

This is not found in the current Linux kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
