Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF212DDAC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667883; cv=none; b=AbhJc0PqqrxCeaHDzGxV7VzK+Hd99cdbNO8avbF6C00VE/LroavFHZ2Q01JxbwGiY868SrBLh2D2ppqNvHZieKquXrOvqZUNz3YqpXJ7W7T0K0mfgzoZ0rxvZ3/QNJ+yMJQZvRsjF9l94oFAkcbFF14W7jhN6fQaXWWgVWXbVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667883; c=relaxed/simple;
	bh=5/gc1ZUs8Vj1ZSEU8C0VOuSBQfHzSnqj+AuWr289CdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qiiOao8RSIpiKzw+OOjRBwCrm8QFjWJhsFWQNtcc/BD+UXIyYlwr/Eq0G5ngbZJsnDhSzpE09k7XG6bVzRbeNhKM1+osMTgcAvf2c5RHrQ823yBIVh2mfCLNZeBzBrMO6NpzCblUp9P2puHLswk1PFFHdavyHNMu+GoLCkhIvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQIO7WhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQIO7WhV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6174C43330
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712667882;
	bh=5/gc1ZUs8Vj1ZSEU8C0VOuSBQfHzSnqj+AuWr289CdI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sQIO7WhVb3MDC1wIiujciu0LWPbDMJDUfFBJ2uzV17iL2zukoBrDhALfnrwhbhhlB
	 Gq50XjRs+7vAoq0Q8cJZDOgn+zg+PyC91LOEwZgWzqG6c9hEyqoFlJv16V/BATb218
	 TVs6UgaW/u8/Co9T3KSH+oaMRMvyboYACsQglOnJlAEfQKpc0/MtugUS9ZJVMryRWB
	 zwwe2ASupuOIRixN57bxGvZbsWEsMAjX5d+9CBpN7XiY28OV59ffQu0y59Mv/lpdt7
	 cZyZvKyX/GRCU9lTwfMe374yIUFtxn+3/O56F1wTGfl1NRap/SpLT1XqZvqyL8O2Z3
	 +QU5/BMKfzMIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F16DC53BD6; Tue,  9 Apr 2024 13:04:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 13:04:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: contact@odelierre.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-NL8Abnv9kl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #19 from Olivier Delierre (contact@odelierre.fr) ---
(In reply to Jugoslav Gacas from comment #18)
> The issue has been fixed for me after upgrading to kernel 6.8.4-arch1-1 on
> Arch-linux.

Can confirm. Upgraded kernel to 6.8.4-arch1-1, removed btusb from the module
loading blacklist, powered-off the PC and powering it on again, bluetooth w=
as
working.

Tried several things such as rebooting, rebooting on my Windows drive,
rebooting to Archlinux again, powering-off: no power-off hanging, and bluet=
ooth
was working immediately after each start-up, without having to deal with
modprobe anyhow.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
