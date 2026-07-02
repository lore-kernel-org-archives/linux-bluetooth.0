Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24B46AF08
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983602; cv=none; b=aCmWLHFB+XL9/LFOup+5PVDhHBSbseGlVCpjH5RUhDFDhxoJ0okE6JBZRHOjXw0FtbWygs1Wta9tMjLlp7A5lTePCxQsmXixx8ef5CW0WxUVl1goSC1pIxqjnWcBdGBuQoDvfYWOU6clxdmT6W8sSzzr3p3VYMffd3UDbZVR/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983602; c=relaxed/simple;
	bh=Hcaqp24WPaGD1dAR3xh1DwuCihro3CjNIg/+NT8y2o8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQICTj0j/7DLgzsXjRXyTIbBQv+gPUFQnQo0kXSF0IL6dbNl2pj+z3M1HG2JNHs/uLsGRQJCFnJhJ4uyAf+2hTlWUXDOmWwiP3nm+tYLNCV/VEqEuBmR0JPMEGjA9iOvmMj2IB0L/2rocDHO5WTqqBbf7nMLWYCyA6dFOuelj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mahZDz0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mahZDz0e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B40BDC19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782983601;
	bh=Hcaqp24WPaGD1dAR3xh1DwuCihro3CjNIg/+NT8y2o8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mahZDz0e+5KREnPkBV5JDGDkCSC/bTfCXxNHP0WM8ZgHz3Osm9GJ3Olghe/gUMlwG
	 vH8pRz9SnACdK7sICW0KAkvvkjrdS9PAeXcScu7gfj3PwNePdPsCm6XPHgOc8gyvJ0
	 wESBvSvZ7uunJMKgmdx2Mp4FbSY2LLJs2YajgfSlED3mbYP5OklhiKyocVPMT+JB6M
	 ATJHh+hx24hgUlRXNPjBhuPWyl8lt2iVGXix7Rtbn3o65JBTQzdPHfdjALyyBitldt
	 Fcj/GkG13F5uzZmhGgtwjEjhNBkEA+M9VI/UsYyj5pcBDy6unZrI8v5zccDzfK/I2/
	 hoTrVPqWKaPVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8E3A7C4160E; Thu,  2 Jul 2026 09:13:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 09:13:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-ssy5OhT73t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #5 from Matt Whitlock (kernel@mattwhitlock.name) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #3)
> (a) if 7.2-rc is affected as well

The problem does not present on torvalds/master at
4a50a141f05a8d1737661b19ee22ff8455b94409.

I'll check the "upstream commit" d019930b0049fc2648a6b279893d8ad330596e81, =
and
if that's bad, then I'll bisect to find where the fix happened.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
