Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC528725A
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037366; cv=none; b=mBH5tSVC8EV2dGahKrFgBg+mvg9UN0E5bQ+LgGjBdnB5CUdEMQHveEZITxGX5I1RNa4cxmp6aJcbB70c7KdsOdRENQtMvqou6YYWSBlhj2zsvIacfXc+wcFGuTcwG0x1ormI+uWOUZUwTWC62RmQSvTEniF7ZacokMH38scNhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037366; c=relaxed/simple;
	bh=FvgL2vK63KxhUKe0l37LYxCc1+Bc/9vW+9UGibqQiJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3/4DlODKDa/vfENmFFi0uHQ6qYTedGjefA6L4EqcxMVcHYmeZY94OkrrHlIOTLo+3Pn8yZ9vAQQ4yi+3THpxQg8EtjhYRz9J0FtJz+UTHF/DklwmE0InaqQldRPPk6D0sssO7x9mgjfWPM8WRJStQLm8rEMhswSBrwqss+jCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3STln+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3STln+4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732A6C113D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Oct 2025 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761037366;
	bh=FvgL2vK63KxhUKe0l37LYxCc1+Bc/9vW+9UGibqQiJ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j3STln+4oTAlfpt14hnPeq4FQqfbQpuV7pdeJq+Q1FI+q69pMECwbifsVDH2mEE8I
	 V3KhRp89KCqqq0mRz6FfYVuTrlQpM3boLnOdW1b08AGH4xv7ReB0h97AvZbYXBcgN0
	 qvl+i2V77HAko4ue04ux7PaiaS0DxsPlzh7aKPAkJ6ZZ/p1a4/jokXcLhc5H5Hkk2e
	 kmADJoYHUhR5zorwyvA/bZ3tm+GAsTu0yGkSpgnEyJGLKZRpktiZdPNszrOuhlrLwg
	 5mIOIaDOk55L8XagMJtTW0j5YZgy4DkIx1560LCmhu4DNZpO4+uAwhCdFvlccC7WWE
	 NtKBn/sC+5lhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64D7CC53BC5; Tue, 21 Oct 2025 09:02:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Tue, 21 Oct 2025 09:02:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-KOHMZLd8so@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #5 from Jakub Jankiewicz (jcubic@onet.pl) ---
The fix solved the issue with MTP device, but there are still interruption
during playing music over Bluetooth. And this still shows up in logs:

Bluetooth: hci0: ACL packet for unknown connection handle 3837

It seems that interruption was not related to MTP device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
