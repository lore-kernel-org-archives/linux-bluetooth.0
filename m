Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F522E3716
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751865982; cv=none; b=S17vm6F8W6Wv6QaUxntbXOq8zskopNSmVnQZ98v/PtCtMjftdsCXDXW2xeDlKawYksbSKEru9ShJRsvfKlD1Fz0Nz1zoCeBpzg+AY0TGcgWxOmJRYY/Eb7I4ekLzkqvj2Bzt3weCd1B+DDxtfg8cRyoKSI4QsKvEGtXcZWjEYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751865982; c=relaxed/simple;
	bh=yVRrdyPMFXr8sUMyrjyHRCnejTEcdFt7ql/FQa+feXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLbBKJq545DMRUysz5IKnfXB5r0yfhYdtfTDPoORoLRjQHiAp6Bmkzqa0JqATzXT4q8t7QGmoVAvFXeAHWrC2XSrKIh3CS51op6nl3S82AEQCGk+9xL00cwSaK/9oZNexd+cvpFnGxa1IzdDM7TUsYDySg8o7bektWrwS0X1j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqJvypQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqJvypQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 976C3C4CEF6
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751865981;
	bh=yVRrdyPMFXr8sUMyrjyHRCnejTEcdFt7ql/FQa+feXw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sqJvypQJr3SfLRorMQURrWr9bcoZGf3Re3R5oabtQgGNdf9MlSk9N/FJA9K/EETDy
	 3PTCGpz2Wwn12IDexH9c0rlSwCCOpvnCEkgg4/he1FRI4OviJDoq82DPL7efPlfJiq
	 ZV4EzhwYz498mPTPT6G3/kDlcRkC7I26AAlJIm+wYqmkyxKZ/OTiCAom4WtpIL4dCl
	 bxNqUVzO0A6h14OdgaHdOEs3p/mhyInh2ih6MbgMVOFCt2JJfpDfIShHARZ+Wan8hW
	 JFGK5148Abj6e1Ocns/nA3BWIJZFLBLKVNeXL3a7aXYS5Tihi7D1uGDcj7ZAxXsJnb
	 h2RxUEDmKO2aQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 89CEDC41613; Mon,  7 Jul 2025 05:26:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220306] Updated ibt-18-16-1.sfi is bugged, "Invalid exception
 type 03" kernel spam
Date: Mon, 07 Jul 2025 05:26:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220306-62941-z2rEqoXIqd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220306-62941@https.bugzilla.kernel.org/>
References: <bug-220306-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220306

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
