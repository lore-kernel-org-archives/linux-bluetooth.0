Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46827B32C
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154745; cv=none; b=M0TLbCWqmokUAQGl/CE6NJYFr+8LjdlHG6IhJ+DBJv8rCrxCNchaKRz8yqtz7dghKtFa2ZLNs3F2vX6o8nUtHdb8wc+XRRNIMxB7z+Lbjheh9UhNYVcyBgCDWfF6mBdstE7oVK2H4vJbF00ClmnbXMHT2GfWHadrQGWKddNTCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154745; c=relaxed/simple;
	bh=6nC2VpMJnMU6yqyNCvVkbKOwYNOP6AePjhJ+eXCAXqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PixGA49JwHM9GphKjXwZCC0rynreqJmwgHTAzZS8hzOvg+pE5jWKU0Zh0QUC/r4CfEEZzSrM3StzoTxBWNzC7l6AXxh3l537+Z5QaTn4hoAXfrSZEcGWea/CBeeYTe6Q0rzWcQpsdipGg5tm29d0pxgNIzWvA31YcCQrf6zxQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRaU7BTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRaU7BTI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 947F6C2BCC4
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780154744;
	bh=6nC2VpMJnMU6yqyNCvVkbKOwYNOP6AePjhJ+eXCAXqA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qRaU7BTITaBGlhhuV80r6JFncX19PIS9L7S/LcCVF8uUcsFtroxi++vAiWPBHsBvE
	 OpiIn04SzEc8yGS6wBj3aLwKBLdBwf1ZcNqeA+T1hejsBmNca6jU2+Qq0/CS00NH/0
	 fdQz8ABOjDiCqfymH7ImBbURYbK1nX6riS1V22sY5ZTolOhWKqhzFAHr4GRdErOX8K
	 ol66G4PX0+m1h1FTsFqlKXCFIiWNhjJTn6rNnN7bvHkfhgFzGT6sO1uzL+0hAVSObJ
	 kWWwd4Cq7/MMEejl07vxsbEf3foSil/Ft2/HHTcL1A28aWifXU4U8K30dpbNX7tfyi
	 60E5DCjXMP2+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7BD77C3279F; Sat, 30 May 2026 15:25:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:25:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221598-62941-0vwKIzMOGg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #3 from Alexander Paderin (apocarteres@gmail.com) ---
Created attachment 310212
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310212&action=3Dedit
btmon capture on Debian (RT)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
