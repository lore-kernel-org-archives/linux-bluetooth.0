Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62B23BCFD
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810008; cv=none; b=W1vCS99QHRFZhzaP3S+ouTSCY+JTDXkN/M09LHEobrmBdpj+GhvmuR99gJ0haxcWsiyinrAYdU249HGjDtYQEwwsny0NjisE81sZIDBAdZLemCdo+VG6zNxYp4qZDnCkMi72aVC+O390Wm2lMeleN6k0FYz6Gmt/trWurXM6jmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810008; c=relaxed/simple;
	bh=+zMCGSvsFc5gumqcZvklJQD81+hHB+Zji97ryDn8rv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFIxSDuZrhsTMf9WbSbPlvdUDhWKWKVFOR4g1X9zFQER34VqJx+Ebo1Je3gVPx1S3IRmaPKpqugORqwyBC97YX4ONQgusBjmpSgqdL7fTHcWNvz7sJpBYmo6+/JHWuieG8PAJkfZEKkDr9GesOESS8bNjSFTOpM/61y96dqaxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTTlTS7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTTlTS7H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49537C4CEF8
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760810008;
	bh=+zMCGSvsFc5gumqcZvklJQD81+hHB+Zji97ryDn8rv8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PTTlTS7HSURX3qPRhJ7jv1htmNPk2VzsbhCt6A1ENdbTNkvKqp+aJTdMI3c8yOIo0
	 3PhkmLXxYSCiSIzvWRn+goWYhQAViZka7PaoocwXkHDwfHpSwc+Q1buOad2NBqSlH0
	 D1Hoa7xrEAqT64B/BLoCIgf2Y+Uy9wG+DgG/QsWuadGJV2GtlbIYJ0nuTLQl+W4IRZ
	 9zoDd6F6BkRpWm7146Si5tf4vnxat9xyNRPQX6/Or85W9v34Gmhz8E6vn2diBbmMYQ
	 zd53TNqkybXmdc1LXe/wGHKba5OxuSsH/ll129mxu7f6/EFB7UeGOF5/0qcQm6Upip
	 wTXdnxS2SeWCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 405F7C3279F; Sat, 18 Oct 2025 17:53:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
 stops working after user logs in to the GNOME
Date: Sat, 18 Oct 2025 17:53:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alex.jakimov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220682-62941-xPvXRtgFyn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220682-62941@https.bugzilla.kernel.org/>
References: <bug-220682-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220682

--- Comment #2 from Alex Yakimov (alex.jakimov@gmail.com) ---
The same problem also exists in Kernel 6.16.12-200.fc42.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
