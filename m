Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A0359A65
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307562; cv=none; b=EDn+fssk1FXnr3zadICE7mau3YlOUY8Tx1FFI4nhrMv2uIcpQvpqsq7nwLEfeaguBVEZqppdr95lKHMbTkA5MefQrxQKZevWF4KUAoz5lAW56QDqi/2cB47HlIOA8sFW1x2vwnZbqQKHX2Hk2afa+EQwZxnDzlueoG74tIBwujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307562; c=relaxed/simple;
	bh=hHu7Vj0KVtP4MdITvLIKawOYklnfdYX3A4oZB3UWMDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lb5Px669Y3j9a2Gc54LmuauXeRDdn707WQlqLB372as4IadeC1D6XvEvcIMxEZTxKcgJfM4FXX+wc3Ax2yne8m2a3XyLs8ZPvQHXMjC7oXu/nrxEfqFZBjCrYEVJUZVU4b36oPFJJiDuZ3FNOyco5hAnnjhl8VLDiacPKLACW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEK+1Yyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEK+1Yyr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A4CDC19425
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777307562;
	bh=hHu7Vj0KVtP4MdITvLIKawOYklnfdYX3A4oZB3UWMDA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BEK+1YyrwbmRhQyTtOxBI2300nKEdpvEWLKZuUyE4X86/sIP7Ew5xa9/A0RORub6t
	 Z6xhr8+xbd1ystf3/dxWECOccTnLEAhSOCcY9+NEz6oatJHYIW4qx8Y5kc+oncmyou
	 vd1ACkFGRyQarrBlz8epH7acIWVFUpLrJpKlChvlL02etvn+dvVb1ppi2dtWUCT2vS
	 pFEP4XyMHvGKHNrfdAdeHJLUcUG3dpzmgfj/aJ4t3Mw81NwDQkqe2Di4Fn+oGM1h0o
	 gSsGE85jnm5qrID4kNGfzecsY6KUIVEokyTlJnFoDMzX0bhcNbMZ3Ac3WSqd3hBoDm
	 G0XN8u58QqbQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12D49C4160E; Mon, 27 Apr 2026 16:32:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 16:32:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cristi@ieee.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221426-62941-udGeLHP46R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

--- Comment #1 from Cristian Cocos (cristi@ieee.org) ---
Created attachment 309974
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309974&action=3Dedit
System snapshot

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
