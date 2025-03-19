Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA51DED78
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396550; cv=none; b=lR6sP/zlX1IfBR7gXNuEN02crpNBbq12iDJ8R3OwSBXeqCpBjm8Mr0zN2PiA+a+QsRm/2MRQzDcEBKoHWnFfgztJYGoZlvvnCBJCdE2435PLFUWa/AEavxoyUmU7Zsggbu23P9va4GyrnrbxzMfRVq3pdFK0/fs1/hOBlvv2vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396550; c=relaxed/simple;
	bh=9JRt77/AinlWaYdHfhYAlbv5ZlluRWCi1iHOvOZB+og=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qkkl/fbCgB1pwQ5ShlyyFk367rDou6zkxW35toCzIx+SsDn/VufkwjzUgDJGsDe+w+BOHx7Q2hbgKzKBRPLg+fd3eWcztoxW+rrbs4wwemKJS7AEQzloGVoj99YkZ4ZmrRTbwf6bXdzEx+jRdq9ghCyHbYSDldX6eTNUoQdQM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvHxoUmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvHxoUmc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7532CC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396549;
	bh=9JRt77/AinlWaYdHfhYAlbv5ZlluRWCi1iHOvOZB+og=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YvHxoUmckug5h+TheBER1Cyt/rkL5qrgsyqLICoLgsJZxynn9ov1liMbL9lriMa2G
	 CZdHdSf0eM1j6Ar1mBcVNkRExlZYSZ1g7PhKELz5x9rZGKeGgQFOFeSwB3khnYK3Na
	 TttFkhNakqf4qvUBip6tprBub7ZprwDQpA4LMrXz/CUVJWoh8DfjLIOF/dLQpnkRLr
	 PQluQHqh6daArJOGmeNYM8vw2CGsWjM//t2eivuVuw4xvZCSE+HsifowQdmdbSrNvK
	 CPuO4G8lxrZoKqVjHEdMFUgpgoDOhqhgmBbuDe4sYMphS7/0g3KdNqpYqCKpfoSTlb
	 l4aMPU4NL1hvA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67F45C433E1; Wed, 19 Mar 2025 15:02:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Wed, 19 Mar 2025 15:02:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219898-62941-nafBnMAQKM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

Hunter M (miller.hunterc@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.13.7-arch1-1

--- Comment #4 from Hunter M (miller.hunterc@gmail.com) ---
uname -r
6.13.7-arch1-1

linux-firmware version 20250311
(arch linux version 20250311.b69d4b74-3)

Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.sfi
Bluetooth: hci0: Firmware Version: 200-48.24

Note that this bug has been reported to Bluez
https://github.com/bluez/bluez/issues/1125.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
