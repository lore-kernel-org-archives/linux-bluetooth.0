Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A625D553
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200204; cv=none; b=iYDmsyxM/O40GQhBky6ouE0ySJ0UlbgUXkUj0zXZ1BoZvlHlvFPG36TwMzZRTdEafRI0EfZiodX4zaFnG1FjftexUpb+zGYlUODf75Pmny6iBhozFxKqtytnhrCa5bJiOlx0Y5N/b/ovMF1Z3dWUxJ8YVTQEgzehhZnAx5tZNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200204; c=relaxed/simple;
	bh=cib0t84cz0fmRD5zl67pX7rCc4UhSpif8woU6/40hAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGL/5y1zpgJxUw8GLGoeI4FnRE6wdfBA9nbULb/VChGVGNgFwinV1mosX4cRGu0YsZgFHlKf7aZV+ZYTXuI9bqxzoLhC1bWK8wMAGwkI5FZ4+WOUlkNQkOkWDoCCgnx7GqA/25xKD4oC/KLjcaWSs9euVDrh3elaemuMm4QqXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/mh2LGZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/mh2LGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B133DC4CEE9
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744200203;
	bh=cib0t84cz0fmRD5zl67pX7rCc4UhSpif8woU6/40hAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h/mh2LGZh1b7iRR0yT79KGq2i+eVukVX26S6AcUmXG+jPPGy02j+SGBU2FWi+6hbR
	 ov2Plf7e1aS7oSp9DIjeR+14B+T1kCqIlk6STz/B26Pn8KLUqACdaDCQl6uyCmz6yl
	 CRvC1A6zm8g5Vk/aKSyZmWfa7hmJTkgFQ3/CqitNAphGuvjqPWWTSw2BKewCXhyaYH
	 Pywcs5LC6V4aLn/4pMC2j/Ha8iGvx0Y8nY1+qYrrZs1rb6Qz+qq5WkB74IBBeMIUE4
	 +nzochqDqSg28REfl4pLEpz28UC6yk7Pp37RZ3ZlzX/06Gu7zwO1LaGjz+47KVLHuM
	 LKeSdkpkWZhEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A750FC3279F; Wed,  9 Apr 2025 12:03:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] Intel USB AX201 bluetooth (8087:0026) device is gone
 after system resume
Date: Wed, 09 Apr 2025 12:03:23 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: khalil.fazal.0@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209659-62941-AqAz1oYwxR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209659-62941@https.bugzilla.kernel.org/>
References: <bug-209659-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D209659

Khalil Fazal (khalil.fazal.0@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |khalil.fazal.0@gmail.com

--- Comment #9 from Khalil Fazal (khalil.fazal.0@gmail.com) ---
Confirming bug.

Bluetooth Device: Intel Wireless Bluetooth (USB ID 8087:0aaa, Intel 9460/95=
60
Jefferson Peak)=20=20
USB Controller: xHCI at 0000:00:14.0 (Bus 003), 0000:00:0d.0 (Bus 001/002)
BIOS: DJCN25WW
Laptop Product: Lenovo ThinkBook 14 IIL, Model: 20SL0015US
Kernels: 6.15.0-rc1-1-mainline, 6.13.8.arch1-1, 6.12.21-1 (LTS)
Distribution: Arch Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
