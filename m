Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB52066D7
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657268; cv=none; b=IwoaQMKdcmal7TMx8j9NsWhSaQRvvyFXFZtBb7beQJgOL1MdzMBtwLvzw3HLWKYwWS3xePOA9XQJUZHm4ws0CULVgyWgSzEax9aPai27gluuaM6L+BMFfk5CffHuS5mgkzgJ2oFG9uYHPlH3uVqK/1u6c+jwao8+h7d3Acj5Mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657268; c=relaxed/simple;
	bh=o1fafGh+/i5MlJCT4LliSCW+B+s2+QWfM2W1gYVzNxU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=esgBHZ0o8FwXt4/u0HwL9fASMIom15tK3dJVCOkEXXdDgCuG/j4JYzz+rXXMknpeqxM22AzkcoTSNfy9fAAgxlOC/iSYCiayUkm2fMpc4xbcgAmJYwDNSiBNNEmXozL6lfpXgYrQhFvvDWu4k8jqy9MhLUfAQiKmutchYoNTruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5lwsawV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5lwsawV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A17E1C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738657267;
	bh=o1fafGh+/i5MlJCT4LliSCW+B+s2+QWfM2W1gYVzNxU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O5lwsawVFLnvj5pL3+k30s79IQnrfsB5ukeIkG2bVzSwL9wU9tL2QrAnMFPh0Dj6J
	 9U/WktCZ+EK6DktQAsISAwwdynlPHg902oZCRkXcTQuSDGid69DPQqgcQquSnqn/rn
	 RIh2Yv6uOlF66staQ0uoVVPxeyB+cQEWsmks0dSg8WY8SwsO/JhhPMtLxlAYQ3nUR9
	 hImDorWjX7wcroufDdITpFyBIhNBQd7+MvDiffaSOkvTkMdXZMSHN4clCs3U8CBdAC
	 yCfES1911sNuiMJ84UxAZn9h1FcYjlQkq1xIs3CGWphQq+bu+I+ES8hCk6X+bU1Jx0
	 jjKjHEqrDPKlQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 826F6C3279F; Tue,  4 Feb 2025 08:21:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 121221] Unable to pair / use Genius Navigator 900 Pro mouse
Date: Tue, 04 Feb 2025 08:21:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: evelynwang0308@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-121221-62941-m9PNo27ZqN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-121221-62941@https.bugzilla.kernel.org/>
References: <bug-121221-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D121221

Evelyn Wang (evelynwang0308@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |evelynwang0308@gmail.com

--- Comment #8 from Evelyn Wang (evelynwang0308@gmail.com) ---
Troubleshooting Suggestion:

1. Update Kernel: Consider upgrading to a newer kernel version, as there ma=
y be
fixes for Bluetooth issues.

2. Check Firmware: Ensure that the firmware for your Bluetooth device is up=
 to
date.

3. Use bluetoothctl:
- Remove any previously paired devices using the command remove ADDR.
- Try pairing again, ensuring no other devices are connected.

4. Toggle Bluetooth: Try completely turning off Bluetooth and then turning =
it
back on before attempting to pair.

5. Check Logs: Look at system logs (dmesg or journalctl) for detailed
information about the pairing error https://mylocationnow.io/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
