Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC5AD5A
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764506503; cv=none; b=mOd9aEjY/oi8Pz0H+OjDib3jfVxIo5H4z/Um0g6156Li22t2sOhp3dyGGQ/yak2F/QnKOqlBikGQygTZNOGloSBzpkFKuVPablxbz09YSJ9fTu+ZB0aCWzXDW29oVof0dlU+qU4AebBOBt8efgj6cI8UUGUu8PKnVwC8vQ0EsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764506503; c=relaxed/simple;
	bh=qsc2O8eFXbtaqbraQ0epqU+1nktGc8K2tgLrHjufi6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+xqkaWgdYBLJJnQeWV6WJMTwgH+2hzkTNdCDS/mIQdNZ1FYYWAR8zAMb3VJOqDQd5OJQGAUXHcFOxbTDopVqQwcqLjFao3Teb773bxKv5TL4hUGErcgKEeLHNWITsw4Wy+PsifvuJWqbxHDdwVF3L6zI7Ep4/9aM6LBC2WkxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKBwfkYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKBwfkYb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6FCBC113D0
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Nov 2025 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764506502;
	bh=qsc2O8eFXbtaqbraQ0epqU+1nktGc8K2tgLrHjufi6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CKBwfkYbFTFYX0/S6LchmtlbXdjtdfbJfEcJl3e+OaNovUbxPcGewoQ0tuv8cfbJX
	 ciB9gSO35Ft9jqWBXV+oFYMrVbXyK9UbXrFmWB/+84m1Qrv4/UmKzsbR+6GlnR5P1i
	 rmf9IsxVcxOeE3ppm7hLdg0lTK2J0Ew8qrP2SpvJcuF7GPo+GkCYzTxcdshqeEdgyd
	 WcU+/bwOq0rTOYFadGuQ9RRbRbf5uY5X2GCfjFRPvhVUJytMeOXKwjH5cIuH7EmAhT
	 JAKJOxhIHE7Buo1Zxrwan418iM+S7Zc+CYMAKUBBolz3c5BNzy4fUa8qeEoZHWInPz
	 cdmAHZdgM/D1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6E09C41614; Sun, 30 Nov 2025 12:41:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220815] btusb: Add Realtek RTL8852CE device ID (13d3:3612)
Date: Sun, 30 Nov 2025 12:41:42 +0000
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
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-220815-62941-BVQ8yJ0VRk@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 308985
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308985&action=3Dedit
[PATCH] Bluetooth: btusb: Add 13d3:3612 for Realtek RTL8852CE

Thank you for the report, and providing the solution. I cooked up a patch a=
nd
attached it. It also adds the flags `BTUSB_WIDEBAND_SPEECH` as all the other
devices have.

It=E2=80=99s common practice to add the device info from
`/sys/kernel/debug/usb/devices` to the commit message. It=E2=80=99d be grea=
t, if you
could provide that, so I can send in the patch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
