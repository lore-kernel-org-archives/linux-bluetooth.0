Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D31A9FBC
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363847; cv=none; b=VUQGN5Lcc2xzfAWD7vTGuVjs+TXDerC8NWyUF3YlnLuWAS3WGBCTmOvvIWNA35PFlnUGDEq/5qlpiwdwPsXJppjESlInOhltJyDI+nx8vnwefNgjx2MsupbIulBIjk5mT7GI+aNDh0//DzYtQNqAUq7zgmFHn8S9vSMl4nzWm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363847; c=relaxed/simple;
	bh=JL7Sb35CloIq6gVdLLSk850xu7WKkSoYOSGBem/GX6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pk0gUookcyb9UyIOpLr+8ntgr/8MPdi0g2Ca4igPKubAm3NoWe1s5ZY2wGXvNE/1r9mb3mD06he1dVhXM1978FmetWRIERg1V4Z+A5UvcTbE6NXHjBMd3ehh8tYmEq6n1Ygf5KHmYEjmDHpGwmI/9UN0xe4NZ7jsiuphezVNWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQVdBi8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQVdBi8R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506B9C4AF0E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781363847;
	bh=JL7Sb35CloIq6gVdLLSk850xu7WKkSoYOSGBem/GX6Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DQVdBi8RM0dcjR6CeM+I2jH5Ktm3PKXFElNxHyOugGXgMuqWNFovpwzBS7sJAasDm
	 lAQ2smdowEvfSwY0xoQUPX1r02qb2U3Elj5QMZ9c3hs3qw9RHsaKEnT5KVK9HSVMs2
	 ZL5i6kgwY0R1St4JcVnpRF6uhErQ4ygDXNKl1qoq659hqNfAwoSJh0zGMTqFlYHP+h
	 cIXW4FL66gxQmDJ+DFPhz0y2OcQaLWoP/9mm8fGNh+KNCLqzB/DEnJXBDo2bHkphQp
	 8YJ3aSn7QfWyocWtKlOsFSPYOxAZQjEvQP9mvV6n2qWOO7cSxoazSxqCBkdCC7xE8r
	 38Xf8gn7Dp0FA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4654FC53BC7; Sat, 13 Jun 2026 15:17:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 15:17:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: icechrome@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-k2ohbVoKts@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #12 from Dmitry Khromov (icechrome@gmail.com) ---
@Hytham, noted.

First, please disregard everything I said about `CONFIG_SERIAL_DEV_BUG` -- =
got
another Baytrail device mixed up with this one, my bad. That said, the actu=
al
problem, according to my notes, is the UART's `baud_base` (2764800), result=
ing
in framing errors with common baud rates (i.e. 3000000 and 3500000). The sp=
eed
the controller is pre-set to is 3768000. I've dug the tablet up and with
semi-recent musl-based Void rootfs and kernel 6.18.35 (CONFIG_SERIAL_DEV_BU=
S=3Dm,
btw) got `btattach -B /dev/ttyS1 -P ath3k` working by manually setting the
speed with a `TCSETS2` ioctl. I=E2=80=99ve managed to pair and test some BT
peripherals.

@Paul, since, ultimately, this isn=E2=80=99t a kernel bug (though a patch f=
or
rfkill-gpio is still required), should this discussion be continued on GitH=
ub?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
