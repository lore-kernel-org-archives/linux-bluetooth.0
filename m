Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA735AC31
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359187; cv=none; b=EyDIy/9P4qqSCKK5iszkr7tpu/ldVpE+9aIHT/OjHQxHZ8E2RRI7rNAWLS9bcwwc64dZQN+DjLw5jvsUkjZoMKsvDtTFgQjp9/oNH9eKwv9y6kiaHHCeh6RPCqpYe+P/N8fjASbMrq80/ekVojTFeOSIVwavfO5dEnwtgY/OACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359187; c=relaxed/simple;
	bh=MqVi9GGrWtG7djJ7LvYQ+AKqGuGXsILR6mXOWcKYOc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQ7RnCil7uVuJYW4r9i64mO16babQaHMAmWjlCpjjNDa5v9ED7ItXG7J615Q0EYDAf3ZeloTx6C8W/mQHxGu1y5GXnT/t1pzTp2ILzXsrSWAHAIehK8UmbPHsKmBsQDH9KVKuXcLqT2in+ut+iCoG4xSXzKSkKzBdIyU9x8tqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMm5b8Re; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMm5b8Re"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E61ABC2BCB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359186;
	bh=MqVi9GGrWtG7djJ7LvYQ+AKqGuGXsILR6mXOWcKYOc8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GMm5b8Rer8dSk68kHxM1KcodvaZSjlj7qDO1gOh3QexzoZz0aejGZeZc2J1eE+xOa
	 sC7/LVspiALFSuTKLD0elV4D4OgLg6qJQ66s0H6JtDZUald03rzUeM/CC0z5yQOcPD
	 XIRabWKtPDMBH4Zw9KuiUzUXKT23xYttAODzGoFfLqaWIW5534CsXHdZYEnysIRLrU
	 Ol8bkl4GMx2m9KM3MFz7asaOu7jXz2z05zU8nx0LPJ3+jEgInzuEwbnqR0evJ/tvwG
	 nPiTtWkXIprz1ivraxLF3uP7RQRfqDUfkPdUDlyez2HwMJCQ9gK4lwd3j/yb3bSMUq
	 5PER60nSgyWQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA91CC53BBF; Tue, 28 Apr 2026 06:53:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Tue, 28 Apr 2026 06:53:06 +0000
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
Message-ID: <bug-221426-62941-pcAG0Iq5k8@https.bugzilla.kernel.org/>
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

--- Comment #8 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Paul Menzel from comment #7)

BTW, thx for CCing me

> https://www.kernel.org/doc/html/latest/admin-guide/reporting-regressions.=
html

The most detailed guide on bisection is:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Best follow that, as it will check latest mainline, which is important, as
6.19.y is already EOL. It will also ensure the problem happens on a vanilla
kernel, as -zen kernels are heavily patched (see
https://github.com/zen-kernel/zen-kernel/wiki/Detailed-Feature-List ) and t=
hus
inadequate for upstream reporting.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
