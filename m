Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CA2116F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567954; cv=none; b=bLVgCbzjSSl1+cgMPULEXlrNeksLdsTLHcS8rrfdW0UI2gxIzMolUFCJc/92zdhw5LJ83+tqgrSeyzRQw57ivTtqcg472kXAUfLxMjFDG1cviDa+9nbTd7MW/INm3kc3Sgay+k1aFKwaHezyxui2ZASHf9QAGhaJDbE9lTLu+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567954; c=relaxed/simple;
	bh=3WZj5g+mATE5O9nIGMMQd7mw3uJU2vDs0QvVN3E+19E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=clbTJpm78ajNOx1eV7kMWCUP0IqDLtOTbEgsaGEVgzoCEWMjL57gVgmbgGII+UO5qP06AseVCauxrdrNo9blG/bmcL9yXT0M9xLDHbbdqxWTlRpI/Zv49Bw6IYKTtitsxqpXaC7H8YhBlk1FrHP2p7StEO/OD1/qiH7AvVlGMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCeC040v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCeC040v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D924C19421
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768567954;
	bh=3WZj5g+mATE5O9nIGMMQd7mw3uJU2vDs0QvVN3E+19E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BCeC040v+ku29/ujcD0U/tJuuL1eP70O9AarQbRGyeQVmmECWJIEy1lKvrr1geGK8
	 +rrvm5kdrS/kfCFvnhgjeiRBXX/xatB4cpI4rg3bFU5g1F+xHnBGBoz/w1wv/mWNOM
	 8DcEG8mx88AIj1pVXz0gklNhNcUFYpNfJTNqMBSFdqcz6OEOI6TLBzSVnVRNJKIYxt
	 pCFdVQEO8EdjySJ5NGvvS8wNQ1DlsBWkksAeakuhZefm9STuFs1weEIlG3sqgBs/W+
	 bVc3f6L66YvcaWzZvHwEVW7HNA5Cmfxdl4eHhyT1UUKJBm+IBEyOh5DOkB3GpITQF/
	 V7B/WYHmW6B0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 726DDC53BBF; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] MediaTek MT7925 Bluetooth adapter (USB 13d3:3596) fails
 to initialize - reports as unsupported hardware variant 0x7902
Date: Fri, 16 Jan 2026 12:52:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-220986-62941-YaavnMb77e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220986-62941@https.bugzilla.kernel.org/>
References: <bug-220986-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220986

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |bugzilla@hadess.net
         Resolution|---                         |DUPLICATE

--- Comment #1 from Bastien Nocera (bugzilla@hadess.net) ---


*** This bug has been marked as a duplicate of bug 220682 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
