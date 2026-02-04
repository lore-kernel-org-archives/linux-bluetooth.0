Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042616CD33
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172808; cv=none; b=CRpd3VyAwdp7HABhwqB8yRhPGVEGRKjXuNSwznNsrU4+AroDJQu7c/jyQ6A9B4VYLRRDbmC0GPXArG1P/UHZnY8X3UfhytbJDE2N7GbZon8MxG2ZOo1LCzhb8WaF22idpyRwgkxDLeidob3/8apzOADj/YFnachZMTipKY9/nK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172808; c=relaxed/simple;
	bh=SsHYRYBWwq0jTIL+K4bTczSc49klTxpiwQRrSp3Lkvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTTR0Ppvim4W1PNOLRavYBtr/TNsB5sYEwB1TzfJdnzfrpVnNA6937MaoE5M1ZMJBQM4iwUzMIsQ1jCbYgPMPLSDklOGdP/vr2aAmKn7goftB2io7fQGNZN7DD+7hPT4DDUleUSVAuBUaBQ14Mk5vfAbQiODID9r2Y7+57KT7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIEozOF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIEozOF0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E208EC19425
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770172807;
	bh=SsHYRYBWwq0jTIL+K4bTczSc49klTxpiwQRrSp3Lkvs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tIEozOF072krlnmkpQvZV2m+cORO4itNnSwTZedXB2a0gT7kdtsdszVF1qTKXc1PK
	 2WE2c6Idh8qQhIbpwkSlYJlvrPaC98k9Blh7JawTzlIPEBIrNL36yA8R5vz8wyy/ls
	 txIQs3YBc8g6/dDEpxUusOVpBj2kY8xvIEica8/wgAW5/rQMhMKTBX6ovB+lXa2CvK
	 9DdYkCK7DybULcuAIFt+BM+il/OHx1JClLYTg/a9UKcChk+UXGwWs7CovV82Kz12p0
	 gnDbA+EdwEZ7MjSTkQpe06QeFiVuwL3W5xnIK7QN+MbJ8xqPGE6jaCbX0v7Xv6jxK7
	 0t4VSDEI2fy0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D0AE4C4160E; Wed,  4 Feb 2026 02:40:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221041] [BUG] bluetooth: hci_h5: kernel panic in h5_recv
 (general protection fault / KASAN null-ptr-deref) via TTY ioctls (syzkaller)
Date: Wed, 04 Feb 2026 02:40:07 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: w15303746062@163.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-kernel@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221041-62941-mB4esOV19o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221041-62941@https.bugzilla.kernel.org/>
References: <bug-221041-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221041

=E7=8E=8B=E6=98=8E=E7=85=9C (w15303746062@163.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-bluetooth@vger.kernel
                   |                            |.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
