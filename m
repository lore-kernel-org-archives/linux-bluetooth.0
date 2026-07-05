Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1A3563E8
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246071; cv=none; b=ZvUEhOKJM8BdViOSsKjjUhKwWAfjB23rNrimOEsAiaaIzSYPORYOF4L5pVYoDWraEGUHNjRky5rCCxB9q19HvcWCOQAJoK3DVo1m5hWCb5JfDh7CTV7/0SjMfQnxc4o8dfDL+e4yyemFinkLNdcJ3p04cjhLU/dM91eScPKCu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246071; c=relaxed/simple;
	bh=IjBrYGUyZPbse6zZYxMXwEtse1F8J0gJmRhhr8syS7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iMxkWT3IKDUh1vr78F0eSucMj7HxhrHUz0ZvjlLsggb/jxVeBPy2HzomgMqXI/vkKn099h1lEVTMROrgd03+uWj2djn89R4WryrdIU+5Usj/aYda+lzilfqWE/sxzmxvN+YLeWmSq0LOLG1r7wZNS/6uKashGBNFxWdck9LgRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezd0ym4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezd0ym4b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C665C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783246071;
	bh=IjBrYGUyZPbse6zZYxMXwEtse1F8J0gJmRhhr8syS7I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ezd0ym4b0OPdPFmCGkPeXzD2ysPN2SrdrcMr1OqgWt+FMD0BQ1ffTd7XV/xlucF2M
	 q2/PWKHY1NjeinURC9aJ+W+bBHvjFKd6MOBiFOW4HzIMY++loKI+IBbE/uDGr9jbBi
	 7eBPNachm+WrGIdJMErq/90ZZqSF8O72fxsj/NvmZYLm2EkqeJf+rG9GDy3KRVDS4b
	 NPJVIH9j3tz7zE3nuYw7KnKZF01PEt5160OFRybWOaF0J+sfE45/upKY5Wa49pRAFe
	 TqHeIFA/XLU7ynCapVd0Bm1QpqAiEEMpvYdWdyP/WbQuu290MTBnd5p/w+t+ib9+px
	 So9M2F2D+BT+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4891BC3279F; Sun,  5 Jul 2026 10:07:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MDddIGJ0dXNiL2J0bXRrOiBNVDc5MjEgQlQgYXVk?=
 =?UTF-8?B?aW8gZmFpbHMgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg4oCUIHN0YWxlIEFDTCBj?=
 =?UTF-8?B?b25uZWN0aW9uIGhhbmRsZSByZXF1aXJlcyBtb2R1bGUgcmVsb2FkIHRvIGNs?=
 =?UTF-8?B?ZWFy?=
Date: Sun, 05 Jul 2026 10:07:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221707-62941-TAbqpOYhwO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221707-62941@https.bugzilla.kernel.org/>
References: <bug-221707-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221707

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221706 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
