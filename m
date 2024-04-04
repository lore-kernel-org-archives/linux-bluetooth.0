Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118D9461
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229983; cv=none; b=YyN7USY71Hz16L/WIMOMKaDoi1xPIfApke3eAbuit+cKmtW8YLKIjqXVd+qyv5ubNiIDmNQ+dcAWCInzzAsKlbqZAZDSt+fAeUe4gQMnfwyM9a2nJfKdnjYyplwQlvy1jNbb1/XWcLQrJkb30FzKhEc6rpu/BeqA9tk6ab+Mas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229983; c=relaxed/simple;
	bh=EcpT8l2OTHEDwSGdS6auM3LsSPgcxSsuXu1c9MpMOS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSlW83SCI1jxVKxHuonRv0PdtvViC53jtQ9V1a+jnBN/THn7RLbyfZbpQJL6wJtsjO9/uYvXLYlvOWIhL2A64FH0vkXksTXY0FJ/kTa2ZQPg+7TPTenSDpoNBnf6JJU0LatturG5gIUg0g2mX+9pchDKuMh3DOwx8aswrEJjXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWPLwGyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWPLwGyK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE90C43394
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712229982;
	bh=EcpT8l2OTHEDwSGdS6auM3LsSPgcxSsuXu1c9MpMOS0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uWPLwGyK7ECaEJ2liSzGDUM5dS+8rM6lQEv2Z/GjZ7oiKd1ZTZLtiFQvrxUdEDXfx
	 Y+oX1xu87w4tebmR6qgo8BMf0RNFRINbuqRc3ulAIVbDKkbb6BMsxYZktGkse4kzkU
	 RxBRKvXy/bWStzzYA1kaqI0arkv0x7Xwi6W/oZZ21zfERRDxamh3+5JabgFMNsTf/q
	 ph9BD3GBLYc/znBpBn1Bas5xdgSBs9Tn4NFs9Y62JWp1e3SN9lqtq/0HZa3CPbZZ5Y
	 pEPnxGgwUD8arBxYl7XiCmT0B6WAhs4hQ5KGSu6+bLPKsqoIisJ6xIf2YMGt7Bu4Yr
	 nx2uRkXhv6MTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64DC5C53BD1; Thu,  4 Apr 2024 11:26:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Thu, 04 Apr 2024 11:26:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abetakehiko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218680-62941-X8wUXTfYb6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

Takehiko Abe (abetakehiko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abetakehiko@gmail.com

--- Comment #1 from Takehiko Abe (abetakehiko@gmail.com) ---
The same symptom with Gnome. Fedora 39 Kernel 6.7.11. git-bisect points to =
the
same commit for linux-6.7.y: ecd265f2aa01b9da6831a01b1f8bd6c1c3cfb5b9

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
