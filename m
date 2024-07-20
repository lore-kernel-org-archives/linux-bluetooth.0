Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C635664
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440250; cv=none; b=QRvjw3IXBimvyjYF7+damFpgt1g3X0bv/NCW9hIe5h2RpupKo5xTe8VBEQWc0t2AFx9jpeawq03CamUYbbopLxyrYLYOtMQn+TQv5S90v2OteGXR7e6WIJoM8mEsjXaRobRKDNqcFWqDVnsjPqy7uqLXjIOXRhN7pXA+DFhYBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440250; c=relaxed/simple;
	bh=8FZy0ShGwlHH2mEWePK0ypywMEwLPI3ZX8bB4U1bVpc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnlEx8crvMdZb9me3JgocVWwcLPeXEbi41kbjMVE0N+PkilLg7YzyubKKZPQPJSf5PzN0rKLdUTThy4SBaHt158cfnVvfi2DsV4n6gn75y8oaXsK17Bzn/iNDm9EMz/i9TiLGBVSOvZTJrb5QeF4xZTti4DjJeDNOZ38Ah5ax/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj1PkxbR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj1PkxbR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E61AC32782
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721440249;
	bh=8FZy0ShGwlHH2mEWePK0ypywMEwLPI3ZX8bB4U1bVpc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Gj1PkxbR07RnhcqgPr+EVFWnQb/Ikas6Q2YPZXaI4NqzM8rzQxZjcPGkLhj9Gux4W
	 g7tcuszsY0yyTpR3u69Uce15gpRHUUVF2xbnDhBGiuDZ3uAmYcUIUAYTRVHAypq9Gt
	 /EXp3LqgGgVfODYsmQ43tcvXsAITU02yDY505njZ9no8uF54gCD2NAqeSdY6K/GrTP
	 A8ZtBXA6a15/uSRUmYvCDRmiZajgOuPRjDW/vL9XIXcNpbDoNr72fkX6mA9KscWAPl
	 ajdzp6FcysjDaP7ESTdH8abOzvELgLhfMEsTlZb5RJkDRiJpbNnRvotikA9aahsOLW
	 aHDHjf/HxNJJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 94BB0C433E5; Sat, 20 Jul 2024 01:50:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219057] dongle bluetooth does't work on linux mint
Date: Sat, 20 Jul 2024 01:50:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ricardo.andres.riquelmerios97@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219057-62941-ogHI78tGMM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219057-62941@https.bugzilla.kernel.org/>
References: <bug-219057-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219057

--- Comment #5 from ricardo (ricardo.andres.riquelmerios97@gmail.com) ---
(In reply to ricardo from comment #4)
> command 'lsusb'=20
>=20
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 007: ID 0b05:1a51 ASUSTek Computer, Inc. ROG RYUO III
> Bus 001 Device 006: ID 05e3:0608 Genesys Logic, Inc. Hub
> Bus 001 Device 005: ID 33fa:0010  USB2.0-BT
> Bus 001 Device 004: ID 045e:028e Microsoft Corp. Xbox360 Controller
> Bus 001 Device 003: ID 062a:4101 MosArt Semiconductor Corp. Wireless
> Keyboard/Mouse
> Bus 001 Device 002: ID 2dc8:5201 8BitDo 8BitDo Retro Keyboard Receiver
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

the system detect the btusb device but crashed when I enable the bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
