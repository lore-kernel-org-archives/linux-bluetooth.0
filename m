Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1A12CDA5
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787993865; cv=none; b=DhKGqKp+fLD7djrRnIMDLNklm7hcScaYDardIHU/3sn4C2PvjdY5E2h+AGMsmQTGiOgZ/DY6YHH1Q27ZZwmZUgUfQZxbEMCIg0r8iP8FPYREzB4aRDP5jfBNSH6RU9as1NISsyWq88/UuyUw2HhvzmhIbVSrRUkS0Pv+URmhkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787993865; c=relaxed/simple;
	bh=HInAiUnz2wo8TAQf+JXbYcjuPyAGWVx2UIHC7yX6Myg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LDDLIeSi56ncj2iWsP+qkBFX0o2uQ0SFiQk5f0QSNFWagPYy2WQETXlGMVouya1D02Q/oH0nlpOCqPcng6M0db8PzKxBgYrmWloEDkPGTL6/gCy7vEhtBJZkCmc667e6PwP40WsUA2Eju5L+dw89EWfcXZWCxXg+E66YKbWt8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCq9bFEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCq9bFEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85B62C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787993864;
	bh=HInAiUnz2wo8TAQf+JXbYcjuPyAGWVx2UIHC7yX6Myg=;
	h=From:To:Subject:Date:From;
	b=SCq9bFEZNxzKBL5TiL/p/100q0D2wo3fRUb7iMZeqbsutv+MF6HiC2p+IA7PTzUjP
	 tXOiC0F7tO/2MI9avGaivnwR+CGuOAF6uzL0C57jdAFPRvtWC5rSd7eQ1h8E3Tt82F
	 eR3lowBbAcFNk2LX9b9TsMYrqpGzBlm4gX0QrcnnEmTU221g/2HiaVn35lPMeXIHVC
	 T4AYP+wCxKye3Ri/to5zpoNhNqHuxIJwMigIMxPWu2P5G6J7nipOnQza1kvSAZpC/t
	 PtvV/wvIAMoIfKV/VawC7vvJFPT9iEwnTf3RzLPdH3PozTBko9ApvMv12oW0vBQKgV
	 cleyvzgArBSRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 62E2AC4160E; Sat, 29 Aug 2026 08:57:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221934] New: Missing USB ID 0489:e13a for MediaTek Bluetooth
 (ASUS X870E-E)
Date: Sat, 29 Aug 2026 08:57:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: tee.winkler@live.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221934-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221934

            Bug ID: 221934
           Summary: Missing USB ID 0489:e13a for MediaTek Bluetooth (ASUS
                    X870E-E)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: enhancement
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: tee.winkler@live.de
        Regression: No

The Bluetooth module on the new ASUS ROG Strix X870E-E motherboard (MediaTek
MT7927/MT7925 based) is currently not recognized correctly by the btusb dri=
ver.
=E2=80=8BIt gets treated as a generic device, failing the HCI_Reset command=
 with error
-16, because the USB ID is missing in btusb.c.
=E2=80=8Blsusb output:
Bus 001 Device 003: ID 0489:e13a Foxconn / Hon Hai Wireless_Device
=E2=80=8Bdmesg error:
Bluetooth: hci0: Opcode 0x0c03 failed: -16
=E2=80=8BPlease add 0489:e13a to the MediaTek device list in btusb.c.
=E2=80=8BThank you!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
