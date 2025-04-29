Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D728E0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928512; cv=none; b=M/nQPJyKrZqF8P0enq3Kprlf0z2tGTw4U1LiNLhEYhY4oPpg+RPt/SYcbZ4zss/SGyHCRLtJKreW/fo0k+nSZnD734RUdI9WzWokMv1I9ZSevY9SXJEYVrjo6JwY58KLrF08urvbKweo3FL5lhXGp329RagANLHbf7lKfx8EVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928512; c=relaxed/simple;
	bh=YxiYeJ3a57xigBB263bYzFQC9FmeiOzhHVYam3R7zmo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rezPxbKwLtgOfLpkzK6VmwfKjjZXzPS/mTrJQf21WD01pZZ1OBW29t9XyWaCwsc7gYaZ0FtWin22KrphvAT8hAdLwKajJrm8dCqWlGKb9bPKoRz+AWt9QiKoV/08V2ytHutltMXA25f+bHGtm90VQRQJEeZwW4d4ESwToewDdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEyT88C+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEyT88C+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F13FCC4CEEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745928512;
	bh=YxiYeJ3a57xigBB263bYzFQC9FmeiOzhHVYam3R7zmo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dEyT88C+EefAHLX5dSVKrEt9qByws2RJ6O1u7FAP+d+85L9LDIZOkFlPQscu+yt5V
	 3GsQOgd9tOsu8nHT6xDODVzwlua5xPHh6vc7LQHImcnwkqh7I6md0VjkK/F/Z2KaSP
	 txVazPnW+0VxDoCLrejIo/G8TDnZzq2aWNHdOFRQf3XFZMRis2RK0XYdTWynGCFpNo
	 Byzs3nQUw1o/v/tAqqQF87943Q3RVh6TZtlLIxu5OToqAJZMXouB+cZXS9oLeMRv4p
	 Ag64okiJbK7mBuYnMljKOLDV8NypaiA57ze5an7p9Oa2GEVYy4FzJFAt9HoB15w3x7
	 B96mxsQYX80DQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E35A9C41614; Tue, 29 Apr 2025 12:08:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Tue, 29 Apr 2025 12:08:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: marc.geerlings@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-3vkMmw5gJG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Marc Geerlings (marc.geerlings@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |marc.geerlings@gmail.com

--- Comment #3 from Marc Geerlings (marc.geerlings@gmail.com) ---
        Num handles: 1
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Count: 2
        #41: len 310 (620 Kb/s)
        Latency: 4 msec (3-15 msec ~6 msec)
        Channel: 64 [PSM 1 mode Basic (0x00)] {chan 0}
        Channel Latency: 4 msec (4-6 msec ~5 msec)
        #42: len 36 (72 Kb/s)
        Latency: 4 msec (3-15 msec ~5 msec)
> ACL Data RX: Handle 71 flags 0x02 dlen 12                #44 [hci0] 14.45=
2447
      L2CAP: Disconnection Request (0x06) ident 3 len 4
        Destination CID: 64
        Source CID: 64
< ACL Data TX: Handle 71 flags 0x00 dlen 12                #45 [hci0] 14.45=
2457
      L2CAP: Disconnection Response (0x07) ident 3 len 4
        Destination CID: 64
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5     #46 [hci0] 14.45=
7375
        Num handles: 1
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Count: 1
        #45: len 12 (24 Kb/s)
        Latency: 4 msec (3-15 msec ~5 msec)
> HCI Event: Link Key Request (0x17) plen 6                #47 [hci0] 14.57=
4608
        Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS CO.,LTD)
< HCI Command: Link Key Request R.. (0x01|0x000b) plen 22  #48 [hci0] 14.57=
4651
        Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS CO.,LTD)
        Link key[16]: b4f8956a4b3d885efebf3a63647ab89b
> HCI Event: Command Complete (0x0e) plen 10               #49 [hci0] 14.58=
0396
      Link Key Request Reply (0x01|0x000b) ncmd 1
        Status: Success (0x00)
        Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS CO.,LTD)
> HCI Event: Encryption Change (0x08) plen 4               #50 [hci0] 14.63=
0399
        Status: Success (0x00)
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key.. (0x05|0x0008) plen 2  #51 [hci0] 14.63=
0430
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
> ACL Data RX: Handle 71 flags 0x02 dlen 12                #52 [hci0] 14.63=
2472
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 17 (0x0011)
        Source CID: 65
< ACL Data TX: Handle 71 flags 0x00 dlen 16                #53 [hci0] 14.63=
2509
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 0
        Source CID: 65
        Result: Connection refused - security block (0x0003)
        Status: No further information available (0x0000)
> HCI Event: Command Complete (0x0e) plen 7                #54 [hci0] 14.63=
5400
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Key size: 16
> HCI Event: Number of Completed Packets (0x13) plen 5     #55 [hci0] 14.63=
7400
        Num handles: 1
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Count: 1
        #53: len 16 (32 Kb/s)
        Latency: 4 msec (3-15 msec ~5 msec)
> HCI Event: Disconnect Complete (0x05) plen 4             #56 [hci0] 14.92=
2671
        Status: Success (0x00)
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,LTD)
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0001} [hci0] 14.92=
2704
        BR/EDR Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS CO.,=
LTD)
        Reason: Connection terminated by remote host (0x03)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
