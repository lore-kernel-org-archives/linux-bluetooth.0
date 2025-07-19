Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9720322
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752932210; cv=none; b=T+Ij2RHnMkpI4TBKK6Mp45Xly5N15Q+9LA42w5AUGHzZSaxeeX7/CmI6PC9V1in2/0lvzzxlOGEeFZ59csBGdSOWFi3XONwml1hZnioivyYPKPqT68ul9VvMp4IYxrJYU+wLrNba4pxAiKzNEf2G3Ae0LfCo1y1Q6s1ql5qu8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752932210; c=relaxed/simple;
	bh=NESbqJpgN699mZXeNnceOmQBFL4LXEDhPLE0NHLwfxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeBC/zfvg2aP3Endwebj+5FCDNFvat7MDwSCxmne27XuUA09vYOa3Qr2eyQ5kV7vMgDxldCKBIEDgd1auglvxu5WSTEjxS8zx6tKWI7rbJCddKBf7M641JcIO2oOT3hRWD6gPGO0jUEH4vRlsind0fCv1X7wRstNvKqpzQKC0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4eBq+RV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4eBq+RV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B78D5C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752932209;
	bh=NESbqJpgN699mZXeNnceOmQBFL4LXEDhPLE0NHLwfxY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t4eBq+RVohx7+0JhgE7QSewzc2XTQRbZtEqSDp2jF8hp4fUCWD9++ogIqHa1zYlaA
	 vTqhvTlUdpYSVWXdClMXdfAQlsYD0adIaQ5rb5i/swWoKEMl7fN3N/F5NwiFReruc/
	 9wn0F8HYIsB156JYsf9wPzrMvqSccVt6Ov8+b4xqEWXFx8Jt27+oi9TrldobbrYQIh
	 Hmyo5hl8BfkzmcxFaO5Fq2czIuk/CcZTDeBe6MELIHwVoyKhaJByn+NeOG8MJOfZu2
	 bAIKP760VGOWeVUMnxdQgwQFmPQ+ig8jSKdS/bzjnQI7lEZ/Y2oJBgwKY3XPFwtBJ0
	 BI2jKcBuMz0jQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA461C53BC5; Sat, 19 Jul 2025 13:36:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Sat, 19 Jul 2025 13:36:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tal.lich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220344-62941-Ijdx5cBFJd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

--- Comment #3 from Tal Licht (tal.lich@gmail.com) ---
I think this is not the same bug as 220341 - that bug reports the stack
crashing and Bluetooth becoming disabled. This is not the case here - it
just causes devices to disconnect periodically. I suspect the firmware is
crashing and restarting but have no way to verify this. I will try however
to switch to some older firmware and see if this stops. Will report the
results.

On Sat, Jul 19, 2025, 15:06 <bugzilla-daemon@kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D220344
>
> --- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.d=
e)
> ---
> Was the Linux firmware updated on your system, so you actually need to
> test an
> *older* firmware version?
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
