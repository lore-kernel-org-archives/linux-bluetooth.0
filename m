Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327961B2EE9
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029729; cv=none; b=UufpfVPEbH6hHJ36jeB7caD3smJqNS7dPTrfYZBUdJfl+BfNhtk7TzXsMqAfSfmCbYRPHmkwlYA3XbjQ3VtF8TUcOF3AWGz2K2ekXfck4O0t2pqYMfihljBsiCLfjmv9Mfq+8ZCe8qkg6a0cAPCldasoT83ctsb3YL2PUSAY/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029729; c=relaxed/simple;
	bh=X4kh7nb/X0O93lzrgUlullZWc3u+BDTDItbJiuERHLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNE23e9kdiKAAqTV0Rd6g23MhBv2qKuytKVrinwi5i3uwAj4QjzUhbkP5J7VGgQ7VhsMGqreWQPsCv9E7HucJYKsU3mqAXhzRBvyRSRzOnG9+oPr9s9XbIs6IuU902moHsm36ulvHTeoJI01l+mQbjHO7lFakO469LWgFwZ3BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRICcEMN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRICcEMN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DDF1C4CEC2
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029729;
	bh=X4kh7nb/X0O93lzrgUlullZWc3u+BDTDItbJiuERHLs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qRICcEMNrhdquco1gKaO/GbrP8N9V89RElRUTLaXEBbnCgOMKRil5kEe53T7DkYYY
	 ovq8R4sRfA+OUt7KzkebALbMCm5vWof/lAutiV8mjIx7iheQLIFb68HiBz38jKtnSo
	 ybj8jApqacPLGg1xyA69jKi3H1HFfrNrAgVy7PMMK9gRtiQw33YVHE3QXht5w+kaAG
	 NLwQInjo89tKOKVjakK7yYmMb/5qcYGzDPXwzudftHJBzKvbJIbgdDfNkZcUtGwRKm
	 iwX7A17btU5ygYrvqvP87ezyVkP6uWczYq/5+22REITAepddx00H6pBSe/3xFadvKK
	 ki3mPAFgBnkYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1133C53BA7; Fri, 30 Aug 2024 14:55:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Fri, 30 Aug 2024 14:55:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aprilgrimoire@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-HX7I0jV1FA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #3 from aprilgrimoire@gmail.com ---
(In reply to Artem S. Tashkinov from comment #1)
> Kernel version?
>=20
> lsusb output?

(base) april@AprilGrimoire-Mechrevo ~ $ uname -a
Linux AprilGrimoire-Mechrevo 6.6.38-ubuntu #4 SMP PREEMPT_DYNAMIC Mon Aug 12
19:08:07 CST 2024 x86_64 AMD Ryzen 7 8845H w/ Radeon 780M Graphics Authenti=
cAMD
GNU/Linux
(base) april@AprilGrimoire-Mechrevo ~ $ lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 2b7e:b663 SunplusIT Inc HD Webcam
Bus 001 Device 003: ID 13d3:3585 IMC Networks Wireless_Device
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 002: ID 05e3:0610 Genesys Logic, Inc. Hub
Bus 007 Device 003: ID 24ae:187b Shenzhen Rapoo Technology Co., Ltd. Rapoo =
2.4G
Wireless Device
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 008 Device 002: ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
