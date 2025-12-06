Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467592FF156
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030622; cv=none; b=kdAWDkX1Z4TNr3d2U0nSiSUOGE2zaOhaola7vdQUqWEbMVEyovU9h+OZxJANInx261+qNbwY/+L4ocHQ/DaXaINxtBEtXdKuhxLyEC4Kn2zwIemdhxeI44gBiiLcXeOZYktGZ8QQIfDs5I0KB1pZ/BhC6yHodh6DFtQ2MeilZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030622; c=relaxed/simple;
	bh=Y25q/VGgHu/sEQvBlv4aN3t+lRVKJwt60ubQw+HLSGc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQlIgVnsC92fe4oqGiUExo2hTFYFkLmvbNrkWSViBnO8n77hzcA2zXeFpdtliDLuj/07JnEbp/jAH/ziBuRWOc6IeeeQOfoa+Egw3JiRMq0tPjutu1TRJ0xK+pXEXc0/NDQadwsv8+1yds+QxvpkMcUq4OQhsLfZemuI45CH0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJUiVO13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJUiVO13"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C50E7C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765030621;
	bh=Y25q/VGgHu/sEQvBlv4aN3t+lRVKJwt60ubQw+HLSGc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZJUiVO13EeMCJe8+IkqAU+SQ02/5RcyOBC8s8NfElPc5wzRnfPbzXNTaUkEdwgdi5
	 6zXSxYXYq9ILOg8BLs9golV6VGy43p+2T0BMBIuwLSDeNWf3XfJymLpiF13rJkUXaA
	 /sDghR2IVHjalVfSPNKy7MZsUaPquLSVZsgG4qUENxtMWttjDranRttr3HVBj9idvA
	 V+4Jf25x2M8LO9/CWyepv/9uODN5Y2aGiINmnLzwe5F+RtYziQMHgnKsu5qUksOSGq
	 OOUj2PCJfBppjWhEM2C0l2n/E/kXRg09YF1NyYSMIzPPWYkSSarrlHBgbJvc7ugwNO
	 xHq0l/EyVaD8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B8EDFC3279F; Sat,  6 Dec 2025 14:17:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220815] btusb: Add Realtek RTL8852CE device ID (13d3:3612)
Date: Sat, 06 Dec 2025 14:17:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220815-62941-ZRTtoenXIH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220815-62941@https.bugzilla.kernel.org/>
References: <bug-220815-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220815

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #3 from jeremy (jeremy53561@gmail.com) ---
They need results for
sudo cat /sys/kernel/debug/usb/devices| awk '/3612/' RS=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
