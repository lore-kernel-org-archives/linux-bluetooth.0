Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD1B67E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057895; cv=none; b=EJi1jOLygjnCIcWNrrG3la9Gdaii/5FffSGb1zGzsHKbjGU9oMcZMOouCvEr+KsGNlkEFjYrAEa9pPqN03NSxwAo8+vwQqlJ7KLooGw5gcxkYovRq0hgH2+D0xVs6D78Qa4ZvuOucSdAR5GqRbK81x3sxjAyHRpWI4a/+Q+0I0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057895; c=relaxed/simple;
	bh=Uvj7oIBzg3vnN2/Cb7RF9LmOmht12Teu62O6OWHu5jQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQpZ43V/iEUgskJ6gj9GjdzSBF2/hHJMLJxbc7AE7DVsYScwpiLPUi+ddGFJLKybhXxg0V1jPTs3zcz4uZKdjuuphZqH8jL4qkPeJFyuIHYDhbdQtUfA8wN3RZ7Is0RSMlLiyBDHjddcwv8lihxh57WV2VuZ1Y7QFOpTUpko5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkGILkDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkGILkDw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 053D5C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729057894;
	bh=Uvj7oIBzg3vnN2/Cb7RF9LmOmht12Teu62O6OWHu5jQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pkGILkDwydv8m1sEaFpYKd3Kjf3ctncHbRhGyCJbY6ZTlwkjU2JBfte5FulfCT27M
	 1WTJdLE20GkWedbyHj5vPRw0XnNv/7V0NoXKd9h/gNRk6U3GsqcQI8yaTUKR0/Gnms
	 gnDw/vuSKm1jsCmrLg9kRm/8fq3Z7ZuEo37HPIVpIidjvpn4K809otUr5ffKNUz0+W
	 CgbtprYjH46wPB42EiAbOGlKB8cG1bJ97kYSPXhu5MKcfRrhVNhI3JH2AD6K8kpq5N
	 ERVkwdUM1if8mwCIhdjhRZhXGuLp5XiCLTxZMMLzFVS6prt/YsK0Ejruh+ajI2nZ+n
	 fgFolIQhB+VPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF934C53BCA; Wed, 16 Oct 2024 05:51:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Wed, 16 Oct 2024 05:51:33 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219387-62941-lDclbCBrmZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
A few questions:

* Are you testing with vanilla kernels? That "Host: centos Kernel:
5.14.0-514.el9.x86_64" is likely just from a sysinfo query, but looks a bit
suspicious.

* Did this happen with earlier kernels as well? Or which was the last one t=
hat
used to work fine?

* Did you update the kernel, or the firmware files as well?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
