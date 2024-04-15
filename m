Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456713AA31
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211199; cv=none; b=Rz3VpF+ifO136+1iCUdHRT46g+oJVxlxHSELWOqAgeMxJh422vfzripwwW2GrZlcIbS9gzBcBVv1FxaM92/gtyHGdnwrEjn6MytQ1/tlMhQglh6bFukJQb+CaE4Eu8cLs4dStNVHH0SFm838AR+NyvgzVCR8ezh51/TMvLOhoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211199; c=relaxed/simple;
	bh=nTK1hCioaWx76VN69QEAm162Tedp2TBL2nq3I2E0jMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7mrWxrpnYybhQq/rlTrvNQ/H41vEaLVK2UUMT7gUtpNBAqB8+XAnjKdMVPYhSnzbCsXJF7Ar89uH+ivR57JjZNun/6PlJNAsif6YrUoyUb4erKEBVgCCTV+cSYSPXCjWJDDUI4K7w+9mW/5lw8WhxYp1z6mh9p+iA182WjxYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swg4CG6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swg4CG6h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67116C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713211199;
	bh=nTK1hCioaWx76VN69QEAm162Tedp2TBL2nq3I2E0jMY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=swg4CG6hKfOw5J9YmnfflH2tVf8mJFpwc9+N1OJEq9KdTsGm57+lDVu+Mln23bboj
	 7t1Tvjq9F6C06ZP4Zz83jLXc15mnLZ2XrYvDV63cFEbJkEj86mVjCOldHg/djq0uoi
	 UsMl+yDC061+J1O6+1cG2IcDRxgervldrJkZku3M+bK7Hxv0ysGQ0L5aL0BP4vOT18
	 WtvDoZlslIqPSyRZkaZZuN9Te4LoBb9ZCr6f/vg3HRHkdVZuU8FtV6bimPwxmjdZt9
	 3sThCYA+7E5EcJ4XNsvANBBajStKvAfWhwRHoxqVDunPUoKWBy15Gd+UhWLc9fnSkz
	 HfnENOSixeWqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4FD09C433E2; Mon, 15 Apr 2024 19:59:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 19:59:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-OHOLPC8apv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #9 from Wren Turkal (wt@penguintechs.org) ---
(In reply to Zijun Hu from comment #7)
> the new patchset is
> https://patchwork.kernel.org/project/bluetooth/patch/1713175927-13093-1-g=
it-
> send-email-quic_zijuhu@quicinc.com/

This patchset does not apply to an upstream commit on Linus' tree, and I see
context that differs on the files that the patch changes. What is the paren=
t of
your commit? It also does not apply to the bluetooth-next repo master branc=
h?
What is the parent of this commit?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
