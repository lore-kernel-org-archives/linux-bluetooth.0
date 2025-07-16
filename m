Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B7289E04
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649838; cv=none; b=YuKqHKsNkDmWivS7mxUdLRsoSxaRWxwTVkSGmX4cdsqFecYuo5pvufACLaUnp1U4x9szw5EDrbx2b6VUjIC/6yoi2JZLPbhwYQ5Fm4Be448JU/fNJ5UdnAFRd154ZH1mk2B+s8rD68Wq60EHPucN0JFEgRXl/5YvgpxV2qhRZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649838; c=relaxed/simple;
	bh=UWFt/c05ZKk9ebADnSMaYAihtdBYVugi3ACp2xfmCNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVsAMoNNv3f8RobIeXTNFR2CCiEXjhHCT67DcdhQ9B9X301Iiek3k0B0dZGPJkXvxNQAWO+t7t/EXdREPRDQ10UmvsT4C8xYpXWPoDRVOHybR/h00DK00r4Pm7zBYyIMwyUNjCjBa3RWPsJixozx/effkQ+9CsjsfPutwCj23oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLxN6CAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLxN6CAV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BBFC4CEF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752649837;
	bh=UWFt/c05ZKk9ebADnSMaYAihtdBYVugi3ACp2xfmCNs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MLxN6CAVbpvcpCXrDwNAo+yG/GS60y/DLT1VzPvZVjdbm6QQio/swXp1FfGYz+eVp
	 W+vXKdiL/wo8WRfW87y5RC2R6qFG654QC0QMlv8abMr09tmZzi/vG1IydKDkeFqU6I
	 qQ7jFmAGOitAycP8tHa96avPRBRlyBz8ncFNOZ5gKecJSsjBYhl64NVNnx0ivk+AJZ
	 d9H6INJ2054jo69tcfXFrtak9HA23zoQL2XRhmpue1gviGF7RlOjmmTAw6JwM0gaZx
	 7RHPyYH3n45k2EtSNC2aLFfmacJcktRv/2VIQ8LkGj+AHXBnHaml7Zl2UY+hhsr/Uy
	 2AWDYRAMPcujQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EAA7C3279F; Wed, 16 Jul 2025 07:10:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 07:10:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220341-62941-9yJ1qRwS1V@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mpearson-lenovo@squebb.ca,
                   |                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Please add the output of `dmesg`, so more hardware details and the loaded
firmware versions are visible. Your log starts with the hardware error belo=
w:

    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: Received hw except=
ion
interrupt
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: 00000000: ff 32 87=
 80
03 01 01 01 03 01 05 0d 02 00 06 0e
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: 00000010: 01 00 05=
 14
0e 1e 00 10 fa 53 06 b0 00 00 00 00
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: 00000020: 00 00 00=
 00
00 00 00 00 fa 04 00 00 00 00 40 04
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: 00000030: 10 00 00=
 00
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: 00000000: 10 01 0a
    Jul 15 11:54:59 martin-work kernel: Bluetooth: hci0: Hardware error 0x0a

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
