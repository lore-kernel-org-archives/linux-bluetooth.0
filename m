Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F646AA85
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856314; cv=none; b=l41IlpCz8IBNYG/8GVO/T9zy222aUIPsMjmxs75vSGVlkE0bOcYDP6GqbI84PhqL/sHlpddwm8WMxNoKkE7qlGyS4gLOzL0I7n2ej4nZKQRoMi9bVDz3+6gwidTgcKo4tTmvxVfJzNiVotatSNDvBigehsE07e4g2BFLgoTbY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856314; c=relaxed/simple;
	bh=R2ULMVtMnv0y0ovrErCahSFQm0IxfzNiNpacL30SRwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoNma0lSLtveQUBcZV28gFMq1A3dNUhtLRKGFkuI8yDsx1aAmkd5qI34raqGxJ+Hnz+f8ClumsvHPBzmnqGDiiU92Rb5Ll+ScO0eNB/6MqnSPhkgGLlQjK9/wvce+k/FL1+SX0G7JXkisyLQ5NkBUtXzClLrfEFHm5oghhfifss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeCqZu7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeCqZu7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE100C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785856313;
	bh=R2ULMVtMnv0y0ovrErCahSFQm0IxfzNiNpacL30SRwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OeCqZu7QmZx62L1HRY/P4mWT1o4TT7LXjgWNIRoHsMPaB6M8+ZPuUOHjLjRQNXpOo
	 LqnbwPABLkUXj4U4vcl/hA3/y1JCMVpmZx/vdd7CMrOsvFyucL3esCQGwu4RJaQXJp
	 p+cc0g/bhAyZM1PlAchnK6l921i4A+85VOS7MBXDn24NITxvNNgA7/UfGtgFz/Joki
	 2BodudokJ4m9cbZdaQDEygIEtv6ycF8Cs+SypKXsGJSAvRZTSfT55yCE72hILEY2kt
	 2IUJuJlS1q++G3RiRxk2KOQxOuzu9oR0xCgpqRnpdzRIh2jjWrSxNJfqpSTHtzKe1w
	 J4uK2/m0Y8GIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B9F3C433E1; Tue,  4 Aug 2026 15:11:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 15:11:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-c1pSB8HDyt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #2 from IQ (lnxps@bbtex.net) ---
(In reply to Artem S. Tashkinov from comment #1)
> This is a really old kernel.
>=20
> Please install the latest firmware and try either 7.1.6 or 7.2-rc6.

same thing: tried, 7.2-rc5, nothing shows in lsusb, WIfi works.

Latest firmware installed, it loads for Wifi but BT is not found.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
