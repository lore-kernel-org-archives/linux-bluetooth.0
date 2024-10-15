Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A51DD0EA
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006490; cv=none; b=oQCwP67vu0D080zxfTR1aKCxNEIrc5KC8z1eXxXWbIXS2D/QbrmcaMyC6ORNKCCnxteEikS/IU0vpf16pFc9OOoA0lW2l1trmIGTfpH04vorunMdWms33vVKlG61YqUtJfFVrO+Hs3bT5Ru2aPwTICpZP07M8Wh3PJG8Kb3wl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006490; c=relaxed/simple;
	bh=eUpgYdL2ozivQY071kRfiEx1mnuUy+xbPc1i4kXJtOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je/CV4rM9uEr3G9uwUnbSaYpI9mnVuEV0tdHb2UHgSKiVobwN4i+U8iawfh0vXNaXyt7X5qTkxS6CO5Dj9bbbht3Io1ZXpnpCL/u0VbI9ZoOFlyDVpZ4EyqB+cU6hI2gPrLwG3FYwKASB8IHqfM7l4N+sAUdbT4NRN3RKgwU0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2GPhvAd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2GPhvAd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E98EC4CED1
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006490;
	bh=eUpgYdL2ozivQY071kRfiEx1mnuUy+xbPc1i4kXJtOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P2GPhvAdn1GFY2eEgZqH5X77/T2Et0zYL0254o27X9gi0qAoOowiNV9ykJjmVcWHq
	 BdygMxMfhXIbYe24YYVr+z0drHjkJK/HZAFor6mTwjHcimWAkTZa5ihexdvh6fstDX
	 3p77GD1rOWSXRQ48Cy60P2ZryFalJPOyHoQInzcwQKBvRkkzPcLv+ySM/iMllp0V1x
	 7BahYZ7e9BwO//4aX/YSAOP1SSKHVz1bTpqol7w+TYn+B/SGXk/BjcoXBgoxGgjaEt
	 LFjrc7KzLXs1iZdjrlvTH7zPQXcLzy/jX76r76z9al08Me4zG3P6f8rnN5NpQ+YJuE
	 gSqU7HJOUS7+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 20675C53BCB; Tue, 15 Oct 2024 15:34:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Tue, 15 Oct 2024 15:34:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219385-62941-a3XqumetmQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #2 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
https://patchwork.kernel.org/project/bluetooth/patch/20241014202326.381559-=
1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
