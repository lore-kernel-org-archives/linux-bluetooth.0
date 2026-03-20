Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A11B3925
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997582; cv=none; b=lnEwAxKTCXjvAXhmTNJqeM6GoIBGXHIASxvQ9dp2fCzI3sUptMpFZZYIR9GAQ8Xr4X+i2EPr21xDznzx/s3Gz5mGtFld1Elv1oOAM60V4PxMJXBThaT0FzQoinrNkC0bbuSSH+a1P4x2W8X83QcoVAM30kJZoRXcSFzWDeaMlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997582; c=relaxed/simple;
	bh=+HPHM2gPNrmZydvXGuKaW1I0+FhGX0Q/Ae7+U6U5hLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FycPkaU5tABXq5GVuqIqRPJDVhWYcbUG/zs4WYIr05NUUfVeDVkJ7Rm3KZ+ixH9M8sCTVw2LVuOwa7R+3ajx/kOGYLvHUsZywPQBs0siQ/gARgQSUGjiDQonk2zqsh0C7yAQtwtR6fiJmfutfuekEFP5H6F8d1GkqD61fGhbwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onGnSB7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onGnSB7S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6EFC2BCAF
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997582;
	bh=+HPHM2gPNrmZydvXGuKaW1I0+FhGX0Q/Ae7+U6U5hLU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=onGnSB7SGs9gMG6EbZSlN9oUoCLHfNyNTIWpeYgIDpyTNjkFQWsncAfp1WONgTMTA
	 qkRYkSnksDWrfWmi+8+WQdQzR43JDU0LKQ3whFDkx4SvKX2YdCXwtKb18oeH4hQHkT
	 94im+WGb4DcnfmEmeTyP9SnVnvwQ4LmBJxfZNXv7aWUV9g//1WvBtcYYUu9KSImK52
	 7hdjhLf9u8D03GSZW42IeP4yGPjrw7txV1+5mm0Bxazf7LYekFnOKJBQOM4C1pUFL0
	 AXGrcpynOgx/R9akDx5j4ejfLgwBm8RG9ghXarZr9Sg64X9rHEwnfm2jOYifhvM/9g
	 9a74uNBERIqwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6517BC4160E; Fri, 20 Mar 2026 09:06:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221263] HID: Apple Magic Mouse 2 (BT 0x004C:0x0323) reports
 wrong battery percentage -- hidinput_query_battery_capacity() reads buf[1]   
 (status byte) instead of buf[2] (AbsoluteStateOfCharge)
Date: Fri, 20 Mar 2026 09:06:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Input Devices
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_input-devices@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-221263-62941-P4eVTDfvKh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221263-62941@https.bugzilla.kernel.org/>
References: <bug-221263-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221263

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bugzilla@hadess.net
          Component|Bluetooth                   |Input Devices
           Assignee|linux-bluetooth@vger.kernel |drivers_input-devices@kerne
                   |.org                        |l-bugs.osdl.org

--- Comment #2 from Bastien Nocera (bugzilla@hadess.net) ---
This isn't a Bluetooth issue, the problem is in the HID drivers, reassignin=
g.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
