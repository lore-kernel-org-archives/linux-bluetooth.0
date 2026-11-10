Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351197;
	b=NtxsfYGS6ANeyUXMdHXh8dDt/F4uxBLJscrshGNUqnHXOENumuxhpLRKN6l8sJzqkNRL
	 wgRXD03KG3RSz4AE8ztY6JBhwI9WyAvihF9UVnWE+HhE1xClX0ts45g9q2a0fawLS0RlG
	 rctInwsbdOu4Dg7DjTbMKQk98ZM1MZFQIPmVyD/nEb2bNuNQawPGk7cgAeDQUnTMnQbEc
	 5S2jCXQj4Bg94rCMV1nlcHy7+53Y8HHYXUBFYTGiX2UNd0+GVF/jXMJ87FYki325sL3if
	 EcvqUDKDjlv1LB9QyN7htS9249uEq7ZA7gRXMoGhZsu1Pl9QtRI1aM95nqwh6WRWWQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351197;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=8KU5SsZJFzaiqiddNwWrBmquzlTf9ZMJFkcHJPAMSZo=;
	b=j8LCBSfDfaXvFMpSV5V/TmZjCoBM8Lae0NLbdZHKDlEKQgmgp/bZDM9pcogLx8P9czwG
	 OSt5XyB4/EjjhsuURKi0zx6ke3iSFwpuE2pBOcKmHap7S+APFwZETg0yug20P2kNcrS8U
	 H74yP7NPq0W4N5MWhs/raLxH4rkyUGHImM4u7aiU8vB/koIeZvlDdWKgqBI977zzGpfUF
	 PWZEVaXsBGh67s8ljUO3XbzR2gaRxBQVh2J4OijqGObk5uGufrqyGaEWNmiOFANJ/8B0Z
	 2Jt6eqQ42LNA+2dam3tkEAaORp4FxETBbS8+ptRy5f7FduWetI27ybxkQQKe+eS9K2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYC3m0dW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED80606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYC3m0dW
Received: by smtp.kernel.org (Postfix) with ESMTPS id F03F31F0093D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351197;
	bh=8KU5SsZJFzaiqiddNwWrBmquzlTf9ZMJFkcHJPAMSZo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=SYC3m0dWPZgCIMUErtBxfi4kBdwHwbJqSUDUeOqRR04OnSprq9eypHOQ+cMGQ/pHV
	 ULZz+azYfRG1SYzwfIw2Xnxb8SvAEdPKvytpJdUrC2vxCY4BUOfytunb3GDgu7yS5o
	 8iREPQH7cW0fSPENJ6auuhOedOdBBpRVhWOFkNgAoR7uYxSIVJTxVVNZmjBFazJtxr
	 PxfPOMVB6cxc5a4oj1wq1Q/zmeZzPCZyYZBnzIn/NODK3SIplJO2kwHZxaP7cjfthb
	 os98mx7L7+PfJGa8uWOxlkz/Me8fc4qSHSO3pJR/AM8AQvdObfxoCDTJCLoFFOHrRq
	 JrbJ5x/kwVKow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB5E5C41613; Tue, 10 Nov 2026 22:53:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222250] v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed: -22
Date: Tue, 10 Nov 2026 22:53:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fgbreel@posteo.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit
Message-ID: <bug-222250-62941-xiaGJU0qke@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222250-62941@https.bugzilla.kernel.org/>
References: <bug-222250-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222250

Gabriel Francisco (fgbreel@posteo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |4dd10fbbeb9c33709edc89916e1
                   |                            |9c03c780a0751

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
