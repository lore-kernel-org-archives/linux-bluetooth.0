Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1862132461
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029838; cv=none; b=XA+IjpxiQBJgf8evoJ+V7Oik63ogCb5Xcn3VxZ6jDdLZIwI0qYqZVM7WB7/MHwknNBtZBXCJMCYo9y90ejXj0tgaCO8lx7FjCiOEvYjYWG2aGpunt06XdaP5LbFk7VfGTPpHQZak74LVAuPVaBmbQEAbNlqFmO/0MF6MBvoiaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029838; c=relaxed/simple;
	bh=MJksk4kOEX07fQHb0Bf0inQppQcffBBj5Uvthhe7Wp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFeAsSGImymJ6tW0nQvtyTDlKxm1NrbljFaDFeHpD6ETBja7Dfw7Oob1ysnC1dE49B48O2jrRtyp6zeJ+jgarb/gsr1znjpL0N/FKMH/ygAv6IIUNvpJ8Bn2YxkdkthOs7fKqSrQSY/M+ezLrLAJT7XfUQAdi0j1mPKnI9WJg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU6bL5Su; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU6bL5Su"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DBD7C433F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708029837;
	bh=MJksk4kOEX07fQHb0Bf0inQppQcffBBj5Uvthhe7Wp4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iU6bL5SuuJvu/mpkm1ranrpgYrt6emIVaRVV5S/FLx8VJFpgT69k9W3WdWFws90m5
	 vBLpItJY8u4ge+oOvbPjbirf/Zm0coe8eg26IW8mWrBk64P+KMDc12DwbmKFmW7ujf
	 JynButnzfLMXE92PSImKdzV668wq0d0p1UeCU0XQHMdtxrhN3byn1e/vrkT3KjDPJM
	 WkxLOqVEu0IkfEXzXo2hx0R59VzTjRwg8/6FijgWkQ9iVFyYMqgTSEpxgMvNpuP6ac
	 ZJRdr96eMULIuOg5snAEV+0aQD0810yhVZjszztRAB487pt6Iyah/8lSZYtTj0vZzj
	 MoZlc79rJXThg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5D4D8C53BD0; Thu, 15 Feb 2024 20:43:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Thu, 15 Feb 2024 20:43:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vjstink@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-Gz6nv9UAZH@https.bugzilla.kernel.org/>
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

Jhon (vjstink@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vjstink@gmail.com

--- Comment #6 from Jhon (vjstink@gmail.com) ---
I have the same issue as Nickolas, turning off the computer does not help.

The device is also the same: Intel AX200 8087:0029. Mine is on a desktop
motherboard.

$ uname -r
6.7.4-arch1-1

$ lsusb | grep -i bluetooth
Bus 001 Device 006: ID 8087:0029 Intel Corp. AX200 Bluetooth

$ journalctl -b | grep -E -i bluetooth
----
Feb 15 09:06:07 home bluetoothd[948]: Bluetooth management interface 1.22
initialized
Feb 15 09:06:07 home systemd[1]: Started Bluetooth service.
Feb 15 09:06:07 home systemd[1]: Reached target Bluetooth Support.
Feb 15 09:06:07 home NetworkManager[1027]: <info>  [1707980767.6232] Loaded
device plugin: NMBluezManager
(/usr/lib/NetworkManager/1.44.2-3/libnm-device-plugin-bluetooth.so)
Feb 15 09:06:08 home kernel: Bluetooth: hci0: Reading Intel version command
failed (-110)
Feb 15 09:06:08 home kernel: Bluetooth: hci0: command 0xfc05 tx timeout

Same error was present on 6.7.3 and 6.7.2. I believe 6.6.9 was the last ver=
sion
where it worked fine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
