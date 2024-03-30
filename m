Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15997E2
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711763398; cv=none; b=L/MIkDwR6GDSeJ70fXsiEPa1OTXlnWy9J/qztA/et+Bb2FV5FUk580QXRzHwjVHmwmEl8w58pVMLMNkci+5LNIbL5y97wq2QI3tAWIQeaa+i5cx9PpvLSPwbNkDunp57Vkevm6QHFtuUrnq9KbYbv+mHbMbUgWCx1Kg7ImtPAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711763398; c=relaxed/simple;
	bh=IlxGDZE3PHSWjCVVHV7AiJ4n6bKK3fLWXw4Vu/1jDzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PR3P7fJIWQiP7n3LXRiATneeaT5m9POOBxQF7UKbcLCtDTWnQETKClp9oAEA596JkUWJZjp9G0/s1+leVnrv0uqTuvlNUYGp6XR6EJrYMOiqUayTfxoVIxTRkgwjA3uiGouhz/MsOoxbzQgXu0gBeIU1WGeBj+Qe3vAmxLpEf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9C5RKMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9C5RKMy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35355C433F1
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711763398;
	bh=IlxGDZE3PHSWjCVVHV7AiJ4n6bKK3fLWXw4Vu/1jDzg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F9C5RKMy9mhFEuV+bLQHYIFuazRW9D71pVSB1hUQByIGzFGaRZv5X0aWNJhS6f83R
	 PJ0enbOMaAIu0iI7FkvyuhB3IPawUDyiradiLsZQ7X5qmBb94PONaY+hO1heRonWNU
	 clrngFZ7OP2rUeSynG8kZXt+JH1dn4ODnbug+wTMAWNk9cCTN4ElypjiltXa3XNUYv
	 xq3AjUDTDBCLioQ0arekLfPOPEPpB7+SPZpcYEtgSAwdZFhu4pgqQYH55fvdimOBYh
	 WIWj0u3OZ6ATnRse5Fw4F5qzy/DQtAmcCkna5AuynrMWQSzGfmpH3f/yoDoxKNtc64
	 cFVtP+ocan6nA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 26663C53BD1; Sat, 30 Mar 2024 01:49:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 01:49:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sugaraddicted@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-yGKclWMVgN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

sugaraddicted@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sugaraddicted@gmail.com

--- Comment #10 from sugaraddicted@gmail.com ---
Here is the bisect.

$ git bisect good
b53e5ef62fe9853648b4478bd6cb3aba970a6f1f is the first bad commit
commit b53e5ef62fe9853648b4478bd6cb3aba970a6f1f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Jan 9 13:45:40 2024 -0500

    Bluetooth: hci_core: Cancel request on command timeout

    [ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]

    If command has timed out call __hci_cmd_sync_cancel to notify the
    hci_req since it will inevitably cause a timeout.

    This also rework the code around __hci_cmd_sync_cancel since it was
    wrongly assuming it needs to cancel timer as well, but sometimes the
    timers have not been started or in fact they already had timed out in
    which case they don't need to be cancel yet again.

    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting requ=
est
callback")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 include/net/bluetooth/hci_sync.h |  2 +-
 net/bluetooth/hci_core.c         | 84 +++++++++++++++++++++++++++---------=
----
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/hci_sync.c         | 20 +++++-----
 net/bluetooth/mgmt.c             |  2 +-
 5 files changed, 71 insertions(+), 39 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
