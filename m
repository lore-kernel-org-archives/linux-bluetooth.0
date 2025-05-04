Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA02AD2A
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746397513; cv=none; b=klu3teYGUDiyd0jmKec6lcfGyGAYgQPN1q5bpsyRK1xOM9+aVjAViyVUCyqsOWm7UdnMRxY+vObFATeWBP2ea/0Xg+H3r78OG9ThmoA1xqv1DE0Drkx1SUa61ztFWvERHo0rZyM3xbTwhELexYipIyekVU2mmwE9ua+u6UxVjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746397513; c=relaxed/simple;
	bh=ukhYcE7MzqFfV2CgiL/7dA7UObneHE5EuwQyZ7SA0DI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqmcB4VNA3Sy4EdmxdsCml4cfhYiur00gAm15B2FZCOEJkquonGaawklpdCPZGLTAOApmk0z2CM2tTLVobGvyc5wlHWxQEOvn20MpWehim7gwqcELZsEYach6MafVaDchGxvv2MrVBTyHHwraCcWuTIVkyJejcp7+A6s1x2npm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPf/J6N5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPf/J6N5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C586C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746397513;
	bh=ukhYcE7MzqFfV2CgiL/7dA7UObneHE5EuwQyZ7SA0DI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mPf/J6N5g98W3dtgAjxenCt2zNj+yMbolZEazqa/SOacdFAgI42s83HFREeee03X8
	 iLbtfEN/7aeswuZ3mYpGq/ZAVASOq/QjYr68e/S2WXNdtHLUsv+GNODE6KIxVnDgaA
	 TlsKGkXgH7w+T1f/l0t2vGgWvqeN0Q7+BRNypg8Ayl6ZlmmgIh3yyBJAg2N2G29y1X
	 CpD+5dbmRzKFEvtZBe1UlA18c7ZcaGiV7seRM6XLfH3KqW+B+iSQiaSY19Crv6wML1
	 2H8ziFzp9oaeH+3pPewAaFZbN9VFibbhrQJyWEqRzZyZCqTmCA/FfY3afdsDXy9nLA
	 6LpDQQHKZFRZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 31C05C53BC7; Sun,  4 May 2025 22:25:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Sun, 04 May 2025 22:25:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: peter.weber@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220061-62941-8KoCQRJjrz@https.bugzilla.kernel.org/>
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

Peter Weber (peter.weber@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |peter.weber@mailbox.org

--- Comment #14 from Peter Weber (peter.weber@mailbox.org) ---
Question - Is this the same bug?

Since Linux 6.14.4 I cannot connect my ThinkPad X13 Gen3 (QCNFA765 Wireless
Network Adapter from Qualcomm/Atheros) to a ThinkPad Bluetooth Laser Mouse.

> bluetoothd[630]: profiles/input/device.c:control_connect_cb() connect to
> xx:yy:xx:yy:xx:yy: Function not implemented (38)

bluetoothctl/gnome-bluetooth-3.0 tries rapidly to connect and disconnect
immediatley a few times and prints above message to the system log.

The connection to AirPods (4th Gen ANC) works.


Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
