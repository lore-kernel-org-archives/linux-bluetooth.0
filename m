Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358702C11CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812620; cv=none; b=JLR9DzBGch2qS5dkxL3RA1GvW8hkLEzHK/eZ/YbnN4hrrZHARUeL19GDWsoKmPCKSDyfMAsfJZZtxIvtWg/ZqhtjNB7kHcIP7q9hRW/CPQzEfY1yKjX6tx9KBI36/Bq9zqmLjse2tB5EImU7cCUR+45TvRBaJWko9roa3otxudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812620; c=relaxed/simple;
	bh=DOC9/Sec65PkqBqSZks2X+LTR6eMPcC/W5nUdot3pqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbo98Pu3cPZVXfSWJaE+tTe9NiKWx0qW4pZQ5ZcOVhWLOdBK3clxvvmcfPXiDUlCOvDN0ysFQ0pRZlOHjw5oZOEe8kt3bKRAGGAXLn09Czwu11VDdAgEleILz+5eTUDdckiAdSCJvbzgSbtsSv6TQpudxBLW2RUu41tllhSw1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD59EBXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD59EBXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA253C2BC87
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775812619;
	bh=DOC9/Sec65PkqBqSZks2X+LTR6eMPcC/W5nUdot3pqw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JD59EBXJRAnNnrzDC1pQJRejXUl2hBUmPwZnKJvO7N9tsABhNYB5TsKTw4VeTPPaO
	 JI4KcEUDI40dwgruVIhoCnJVYLB5+G8HVD1zotp0BrSfj65vKN26vgf5U1ezylGrKX
	 fc82NkAjgOIzBJbVu4YMAkX9CeyM941JaNY78/h6a/jzJnuoXDMup5M93N7oR9ehdM
	 os/D2IMRHSVBrUwpwSLUOlNlbPhPJIxXJ4j7Vwg5ou9YjdYCfr0IPrWzqdcFRo3ZoR
	 qN5gK733oPwDkop2KYblgWXzupBEcAgddOCyL+8Aq/zS8P6MiBCOwd+H+tf+qZvsb0
	 zCWTCq5GC9WnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B133DC53BC5; Fri, 10 Apr 2026 09:16:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Fri, 10 Apr 2026 09:16:59 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221339-62941-3iIy0rWuER@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kiran.k@intel.com,
                   |                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
This could be the commit below:

```
commit 81608d9216ce1fe954e205aa867655b1a5bce1c5
Author: Ravindra <ravindra@intel.com>
Date:   Wed Mar 11 15:21:05 2026 +0530

    linux-firmware: Update firmware file for Intel Quasar core

    This patch contains firmware files for
    - Cyclone Peak2 (CcP2) - AX200

    FW Build: BT_Quasar_REL53843_22.180.2607.53843
    FSEQ: 0x89.3.35.37

    Release Version: 24.30.0.4

    Signed-off-by: Ravindra <ravindra@intel.com>

 intel/ibt-20-1-3.sfi | Bin 801016 -> 800036 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
```

I [commented on the linux-firmware merge
request](https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests=
/955#note_3239391259),
but it=E2=80=99d be great if you verified that changed `ibt-20-1-3.sfi` is =
really the
reason.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
