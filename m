Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89B7CF3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630378; cv=none; b=SpPfx2+Pzw+wjOVw3lIl9H6R+MHWRvWqHdHfBZA8/41cPyD4al+OYfcyaUerrmcu8tRSUbAHqsswtjfViTsINS2LZRqo3a/b5CjLSOtDbTgiwwS+scemrqMzRORgM0WipLbWz9t3UgHY1/Vp1Fx4oKQ8cpy7haMMFQ6sD38TE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630378; c=relaxed/simple;
	bh=fjkN298z21WgjvAxkUSGoiwHjgrBT74oGYruQH9zoyY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oo7kQQKgfXLN+ZojaMx1AgyCvZJHeY0gNG/zNXxOHKmd1IgJrJoO6oJsZdR3RJQsH0oSmS0nYvTjRZ6f4Ikn9sJrReERVSsas7Bch9t+PG4tb2cECdnWvNReDd50UdnAyRFRemqfbSdv8traQ8W5It1r9xTkBJ0CCBFaZo9o4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8X6Ppud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8X6Ppud"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67C94C433A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711630378;
	bh=fjkN298z21WgjvAxkUSGoiwHjgrBT74oGYruQH9zoyY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s8X6Ppudhk183BxgNYaL9dAVT1+uYTU60R6e0WAj6pOxx5cCVW3aaCI4C9LmZ73Or
	 vr4V9pA3vjq9ag2PpbIp8HnJzlcUndHoVNC2NNPJ6qXWjyby783cE3wRj/64FeSxyE
	 EL8wDHmyNbxXTcNtZOCyIFUpTspJPwBGcgiAL+D/SAHJpcQz2Pzp2tg9DU4FxZnQGJ
	 CPNpwMHH7tuAhm1PRlxgNEfBeZ39a5xtaMb2BNAR63mwRecWuLu1HtEP7IX+kQvROB
	 Uo3yDJ0Ni1hBMFewYBhGWa1kmL2mnXlWNMBhljf30g06XSC/eziH+5n4JbPrMIH+GR
	 apK29nmYVpHpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5BF6DC53BD7; Thu, 28 Mar 2024 12:52:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 12:52:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-91JFTLM8VV@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #9 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Can somebody please bisect. You should be able to also use QEMU for this, a=
nd
pass the Bluetooth device into the virtual machine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
