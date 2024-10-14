Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CC1A76DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924152; cv=none; b=Pm3SIm7QqcuOGddqwZiFJBZlSvwvWtCanZeOPAFW3FMwBROC6RqOp2+WWM6od8+1BGdivWxYqK9m8K9m/bA8B9tjQ8sAGy/tUkRaWFV9hbDQXHb7WifXGY2cf3mWrAcaOwr7uT0NoISpfr3ssy+vVhFwZsjOARNWSpwl0FuORck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924152; c=relaxed/simple;
	bh=Q7v1ZwWpO/ydjZzFxKOd786cuoQbn9MWdydtLiMpw2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkacYaRvokz+fV/LoxqD40dQkQmtNCdrYdSCC2fBBuqkpcowgpMjKFeQYGC5lQXzsi6hg15YKbPHdvQRHSItXjdL/fVYfrvv7Axgf+tvDC/mN74uEQU2QiBZHDmSxrt9k8Y8PrMs4AfZ0SFbDxSncvuajdiScut2+3Na6M2uA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg9V2t0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg9V2t0p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335EBC4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924152;
	bh=Q7v1ZwWpO/ydjZzFxKOd786cuoQbn9MWdydtLiMpw2E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tg9V2t0pQIIAd0fh2+5ISheMRPTPE8BuhA/EXTi89xA1YkyDlGS3jnx17ZggWpXe/
	 gt/bvFL+fe5bxkjf84WCi0OJSHJCWc1yKdWiQz/iQg3/Fezk57sl5NBAvAATJ90Kc4
	 s2HLyM570hvWrWTSBOc+qlXCx7j7yosDOjNff2x2lZLFlZWYyYC3helBAfnylXR3aZ
	 XNH9Vo6/PhBrY13lGFExZvzVO+A07sJgI5EvU113DW85gf/kCZpACFZ4vZEnYVysae
	 0Sgz2nu468gL0tg2aCQzhhtCYiZR3YV8/1IBiA2YiWB8WYZbEfLwdjaujNCYr+blsL
	 HiNH2KOw1UuVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25B32C53BC2; Mon, 14 Oct 2024 16:42:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 14 Oct 2024 16:42:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219387-62941-ep7RvQD3Yc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

alexknoptech@protonmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
