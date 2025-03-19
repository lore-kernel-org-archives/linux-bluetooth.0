Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C28528E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395989; cv=none; b=LGqEUE7gXZZM9BVe5B9M7Cfg32nBe8zvOfsSSrlPc9mBwcOMBeqMcMUQWQahJQlpH+iIC8oFvtju8eP1stHfkb6eUsBYC+5JiDMZpAQGLFS+e3VdFIGN4bJiOmGjWwxTFhIQ4O9aZZVqzkpayOLo2ltMBDg6TLVc3PDeiO18g+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395989; c=relaxed/simple;
	bh=Y85AiHxVgfZbqtw8oCSQbHIUujP0N+el1MbhUpE8+hA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5Ry6/ObCWNTE2IvJWoBAuIeDcTKeLIimD3uySCISHgg+cbHZ5FdGmVOeoTgWiwX3J+Jbn79RY6c/rQMlg0pf7WWxNYKlWZkxy1CraIN+qIZIqOA+8B7mhydYZTlR+9vb2kQI3o+uoZIa/FfNZmR8/KhuP+21MnyntAgInoE4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKCvtYSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKCvtYSF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96F3FC4CEEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742395988;
	bh=Y85AiHxVgfZbqtw8oCSQbHIUujP0N+el1MbhUpE8+hA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JKCvtYSFeTLu2vxYm0h3iV5zu2IW9N/kEnu4TIVhJptIuP0ZrJoyYbd3rcv1jk277
	 81JST9ABdEo8DIXBM6CHdMnj0Bu0dLDxmmJxCdOpljjC7I8pMoKFAQNslt8QYFkYyn
	 rdf1Q4Ca9b3Lw5wBLuj/cHrwL0Uljjd8PrzkvgSM/Dji4qqCqQ0hLpYwWW3ihY5/M7
	 suaDCaXdstBKwyFjQAA74umzdCPEb4Jsppsw3YVBRwV092uwzu+ahbGwRiyy3HS+qm
	 praSIIFKxrLTMZIVcCVVO31JTtZ1OqXpd5d7WnJbuU72i/AOHNf2i0QxseVbwRiJDy
	 cxDphe6IjxdYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 84A94C433E1; Wed, 19 Mar 2025 14:53:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Wed, 19 Mar 2025 14:53:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219898-62941-QMWqH4L7VM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #1 from Hunter M (miller.hunterc@gmail.com) ---
Created attachment 307861
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307861&action=3Dedit
Btmon trace using bluetoothctl

Attached is a btmon log file when using bluetoothctl to pair. It looks as
though the LE Start Encryption on # 48 (8.710910) is followed by the Encryp=
tion
Change event on # 49 (8.888913). Following that, the new long term key event
occurs and pairing succeeds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
