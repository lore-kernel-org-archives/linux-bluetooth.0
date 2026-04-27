Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B139FCBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317127; cv=none; b=QKTiUazx1Gcr+qVC5I49ImJYPjukxouDRu58m41kf2K5C1ePsdlby2nFfcAKisR/C/jmkGpnNXNf2XFt0ZbFujOe22Yrw4uOybJxIPsRyaVgYNg03dzvJu6iESE4GOwy8WcFMTHX3Ft25rc6jngNXinwiey9ZtlTK3kC57neeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317127; c=relaxed/simple;
	bh=B8y0hfPFEMh+EDKtJNHsttxwc9y89zET3oI6fwGvkNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q10rmQ6zTTL2ljvkliJUNQde/92SOjKBVyKdPhPjaiGH6EDYeH/ipfMDQ+FO/Zn6YtdNXY5SWoXyE41TGdYgLxioqawZdYBr5pXwCo9WMnxGJ6JAeJtSR5Zq4B3m0rVm6UgA9Df/h/j4fJ9qtIuddtSM9XI/DoaJ6RMwOfr5PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsQ+T6rk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsQ+T6rk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3590C19425
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777317127;
	bh=B8y0hfPFEMh+EDKtJNHsttxwc9y89zET3oI6fwGvkNg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EsQ+T6rkgo4jwqGWt6zDeYi5MjFBTCr7/O81bKnAWZKbutekr0uTrM7/XDPB6XfWa
	 jUY7+RDrGK0x2Vf2NIfvTQ9UiUUIio0XZimgckfFCZyK0vXKRFKtbU5/NLStM1s2fN
	 U7vY1IOG4NtA+qIpkFwrbhelXM+uEmgM/9bmmm36uslJgHATnBNh8HRZNOwTCPMPc8
	 gqMYacVJB4R6Oyeoe/sJSPECBzrsz32KFglz9hB0u1YYRKB31ln2TBkfM8J8k3kG0b
	 AL4KuLKfly+oTgTM6LFzNlbYI9EZItiuFgHW139SuRdkCrU9gUL6BGNK2MVprFDT3i
	 Fifzc1WrRC9Aw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9FA4C41613; Mon, 27 Apr 2026 19:12:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 19:12:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cristi@ieee.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221426-62941-vYVd7V7Hxy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

--- Comment #3 from Cristian Cocos (cristi@ieee.org) ---
(In reply to Paul Menzel from comment #2)
> Thank you for your report. Do you know if it=E2=80=99s a regression, that=
 means, did
> it work with earlier Linux versions?

I do not recall this issue's happening with the previous Linux kernel
(6.19.13), hence very likely no regression.

> What firmware is used?

BlueZ 5.86, AX211 firmware 202-5.26

C

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
