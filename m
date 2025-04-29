Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E422D320C
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936009; cv=none; b=oWDXwR3J7ZmrgUiMX9+gRQ7HRcwZAyu/W9c+t1PURdLTvhEJ9voBH4THFKqqjjuwH1+7/6+DisIiAKP4xyD6w1uS5kYscFVDSqYSX6CkvjvZBd6S6PVlkkkVE1bCftYwVEljbYRg9o00klHbssyP5OtEjUAzhUvHbaD9FO8flA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936009; c=relaxed/simple;
	bh=LvhjnhRNcp9+791jLl1923fMC1QshoKKGBvQnP1/Ia4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSJXpcTtNhbAaTsHiftV90YNpAX8G1xhRJZRXCTAGf3l9RZPf/JvtsqnVSFN1ncQa15vSFav4WV1jrZY5GkpMc0CTuMMlqvhhUDKkCJ7nSTfMR9Q1TF3fc/QjrCWzhdgNF7Unfo1deJc/3kZtYM9H4Qy4zDm2kitXtpzFjTcYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmH6t4kZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmH6t4kZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15EADC4CEEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745936009;
	bh=LvhjnhRNcp9+791jLl1923fMC1QshoKKGBvQnP1/Ia4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NmH6t4kZanDzIX1YQXYqKw3KtMN61ZNtj6bome0UVaDFzUn1dwu/sfZyL1pQCyMpc
	 Bgl4wU00ybNMpU8DyneFjhwRDxa/k4j+mKCIF5y8PQWG1zzwYZqEiH17HNdrY5mkM2
	 mYTTDo3IjwOL/2H7WELmL4+2huZ+ktmbmKYuIuCQbYR5oSdTseuIP2sBGLuw3xCBu/
	 /bsCBUSGaAblAC5x9agJrDgn7quWkzZ6i9cT26fvj3hbNDePVC9D93bQMN1xqyiJZ3
	 APkHQICLItYjLRX/8OA5P7FQhnIfH+NbHpKRDnBk73W6mxjq50IUiXNIvMMM/U0dJd
	 +OHTaqdhqElSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D01BC41612; Tue, 29 Apr 2025 14:13:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Tue, 29 Apr 2025 14:13:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: frederic.danis@collabora.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-HfhzZYGghZ@https.bugzilla.kernel.org/>
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

--- Comment #5 from frederic.danis@collabora.com ---
BlueZ is replying to L2CAP connection before encryption key size has been
returned by the chipset:

< HCI Command: Read Encryption Key.. (0x05|0x0008) plen 2  #51 [hci0] 14.63=
0430
        Handle: 71 Address: 40:1B:5F:B9:B2:8B (WEIFANG GOERTEK ELECTRONICS
CO.,>
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
CO.,>
        Key size: 16

When testing DS4 connection with my setup I got:

< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2 #37 [hci0]
9.315363
        Handle: 11 Address: 58:10:31:47:09:CF (OUI 58-10-31)
> HCI Event: Command Complete (0x0e) plen 7                  #38 [hci0]
> 9.315883
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 11 Address: 58:10:31:47:09:CF (OUI 58-10-31)
        Key size: 16
> ACL Data RX: Handle 11 flags 0x02 dlen 12                  #39 [hci0]
> 9.428060
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 17 (0x0011)
        Source CID: 65
< ACL Data TX: Handle 11 flags 0x00 dlen 16                  #40 [hci0]
9.428106
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 64
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
