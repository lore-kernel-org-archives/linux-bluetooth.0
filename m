Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071A282F2A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521497; cv=none; b=YJjGI5ycXIuo0l3em/iot1/MBkmrvf7G8+OGQdAbjit8p5FsyC/i3LZjbEdE0/EQOMonoRglS53Fw/WGcZ1ZVYZ+M4zQKfOfd1z5bCe7mqjmjXMmHtC8huSN/cTfInd2XB8dhx6cZKTFgkc1a2BIr0xsx4j2hmpsaRMArio3fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521497; c=relaxed/simple;
	bh=FnKmcJfDrKoxsE4a9yYAzBhaq/U3efcLC2MHN2KSovw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V558VxNNYnQTNHav6GyyGJc/4ESLHe9dqIp2+/kki8MhBaGGe07WT502FHXjQmB8L+QpdxsPHjfUonNis9wkb9PmdZreSoxUonpGtwCiBNQASRYYrD5pvFtPWzTmdOCyWUa/qrg67lpXNEEvw8Byc9JyX3ajwnM7FdBmzXXC/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkr5YAWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkr5YAWn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C70C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786521496;
	bh=FnKmcJfDrKoxsE4a9yYAzBhaq/U3efcLC2MHN2KSovw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vkr5YAWntMDHDXQ4G3lOEvIlzTg54pDO1tncBC9fzJpJgbGbM7VpI3GtNGkxTbBSy
	 uodV91hsZLqMTCrA9YTYDjf74CzdXyHHRkIywyeinpIxHBsnn74vcFTbsjbywe721d
	 2PqxZuHvdRXqi6rG19BiL4P5NlPhGft4Jg21Fzd/B9YF1GYpiLbtf0UKcREI1oN88v
	 7TkV1q56YGZ4n37SRJGXuIkFMW6TfHVxDylo72/pnbgYGx9xVoXIj0dK4caQ7Qn7sG
	 WVltv5p+8S2A9J7i+gtEy64ckQ+iNnVMlEDKHkkhhwcq5mmeZxYhwsX3btbxfMDZqM
	 iHwASiGojqdAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4CC07C433E1; Wed, 12 Aug 2026 07:58:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Wed, 12 Aug 2026 07:58:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: rohanasrani3@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-qfHrQZQS1X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #7 from Rohan (rohanasrani3@gmail.com) ---
Hello, any updates? I'm still unable to use bluetooth. Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
