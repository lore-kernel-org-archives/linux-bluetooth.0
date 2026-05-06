Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE415E97
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041624; cv=none; b=o4zhNbex/8pxZYP4mCQtvtymIx1A2jUZ81rKIk2cAP3oxLL7Xu8ffw5x8aU1cxScPuj7Res16YgllwGWLI44/58V8n06nFPvaaIHXW4RE/Knl0rRg0pZeGXJl9H01d2MxUgwmFntdZPI4eNiSxcBHqCMEzRdr7wIooBU3C2pWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041624; c=relaxed/simple;
	bh=fjgIpkFvEiQk9dqROYDLqIfY6mPltDvTcHCFcOG2y0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDcHggVJRvVPtnCmntw3XvhchSsDjHQudLMeYgNFHnJ1UIbI+93UWeItFqTcnjF9zBFJGcq7fLEZpUugaf9AYNP2F6KBGXqh+HiRrHnh3bGBJ3g93c8aFwVh1wbKezrNC2pcxeMHHhPp9rZhHWAyb4RcxHAcufLBPQxN4ZQj4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYHLDCMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYHLDCMI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D51EC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 04:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778041623;
	bh=fjgIpkFvEiQk9dqROYDLqIfY6mPltDvTcHCFcOG2y0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CYHLDCMIA8EDCIfGIOMBJiwIx6urYUjPFB/P+WDp5OevFtzfER2VbqSaAaTOXH3yv
	 bH8hf1ShtT/IKp3l6+c4UdszvDOxIqMigfA58NPMm04kl/QdvembMukSEaeiZh8CUL
	 AxXOLPifY0RtfBTFkop3ThgIJyW+Zy2rmJPi8BJ29w7GSMCQx8UoOdUoZg2szG2mGp
	 28k5g/N3FiQ6o6k4ByuOO5jlu4pl7bUfJI7n1tzVPiLLQs3vO9g9JpItPinr98LhPG
	 hTRQPJHva8IFDUG7dKkjrPy/az7V6MT3qPl0T5nZ95yslRo1vTMvzBX1spHhgdRAgL
	 wyfSWE7HRQMjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8D361C41616; Wed,  6 May 2026 04:27:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] Wireless gamepad stopped working through Bluetooth
Date: Wed, 06 May 2026 04:27:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221449-62941-1RGNLgS9rE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221449-62941@https.bugzilla.kernel.org/>
References: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

--- Comment #4 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Fedora is preparing switching to 7.0. For the latest kernels, try
https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
