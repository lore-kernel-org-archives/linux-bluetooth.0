Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA218028
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253565; cv=none; b=nn1f+QNU9fd4rfjWUYtm4IoDez2ovaqsef7H/RjPQdns+OuoN2cv44hykjqjQN/XKNSY3wINJHh/Mf1kLjxy10mlT4WfYKgXgkBDmxBmcQDMmpIA+Kk5pgvdNp3Lz3FzbjU1ABO7ojxHfM7dLngJTsXFTCf/4j1pG7m982p6IWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253565; c=relaxed/simple;
	bh=QvHQmnN2U7Bs1Hx4xo1IuWyGUYtt8SQpB1nBJmHdNBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASrMCe8ZmABGPV3W143w/nJuF6Wrvvg+lrGDbbO79q8pbKZLva2WE19Jq2H4zdkR6Y5dZa2lAsXXRjtlgI0rengV77muZKyoyiBt8M8BJObSUgNKYpkpgU7UKuot74hWMdSlFdsrG4X5I1jz1mSUafyo6NChtHI6Tbzy1YQp4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwAw4krD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwAw4krD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02B02C4CEC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729253565;
	bh=QvHQmnN2U7Bs1Hx4xo1IuWyGUYtt8SQpB1nBJmHdNBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YwAw4krDb5YTadnBeNQJZBTFzkdXmNvO8QvVOjIO2IL0TZsChslvf1A0narFXxye0
	 DjA1+KWIdPVq1E+o8JT2Nga92p6rN+c+Y6wXvlxlRxRCcF8zv/2Ikk2Yahur4/XfxG
	 toRRpj5PhzEM4rWXjvnoohSaO7Szkp9xOKzu6n7kK/GrqidpfRdxRTSQ2iN+Rvz3Fz
	 iKMSNR1XPu64RCoB0hBWImAq0dyw2KDIpRZSYhH+TjCHqz1978qVwEwNHtzpk5+ilG
	 vU8jlhImfYwq58beDhQMIe7nyLqmWH/jxe9rWGr9RK756dNjb4N+m4NiyYuhHnHkEk
	 kYLsMFA54Jqxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF64AC53BCA; Fri, 18 Oct 2024 12:12:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Fri, 18 Oct 2024 12:12:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sunabouzu.desert@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219333-62941-uQumXF1F5s@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

Denis Shkuratov (sunabouzu.desert@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sunabouzu.desert@gmail.com

--- Comment #4 from Denis Shkuratov (sunabouzu.desert@gmail.com) ---
Have same issue on 6.11.3 on Fedora 40

[  492.013592] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[  492.013601] Bluetooth: hci0: command 0x0c24 tx timeout
[  494.125556] Bluetooth: hci0: Opcode 0x0c24 failed: -110
[  494.303623] usb 1-8: reset high-speed USB device number 2 using xhci_hcd
[  494.517351] Bluetooth: hci0: Failed to claim iso interface

Bluetooth is working, but suspend is not - PC doesn't wake up from sleep.
Disabling bluetooth fix this problem.

My bluetooth card is Mediatek mt7921

Have no issues so far on 6.10.12 kernel version

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
