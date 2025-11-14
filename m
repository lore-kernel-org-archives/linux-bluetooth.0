Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3703313544
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150680; cv=none; b=Ctz19MJuIb0HEk2n9Lqta3XemNnTPr46mZ4OpNifb4qIN5rR89NkbQDK3+9dwbOPENv7nWnTZIDpvUTlljJ5IQOJNfyQaY9pPEl0a1aPrlfO98nI3EM3nvDRc1y2tHtKxEDxun3UI7q2+iI2wGLNec6SS2XJnBK4fYqkExrerxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150680; c=relaxed/simple;
	bh=hi+OcwcS0FRnvzmdlYGn6jlG2II74g27uHphfVouOTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsQjmQT7+X+ss3mHel5rfb5R1J6sMyST6oSokosNjk6rG21knBDHBjwxpxudkNN9wPSQoVtyrHFAK3NVVpxAtH34U3xiu6sBYipEnLllf5oXAUfq/XPkYSvLWap4XGuLYUqFnFlwr13D6pfh+Gv/eQK3bM4qyuQoiNe2gjFD46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip4GkgWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip4GkgWm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51219C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763150680;
	bh=hi+OcwcS0FRnvzmdlYGn6jlG2II74g27uHphfVouOTA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ip4GkgWmhMgJNpsCH2ci1u7EBW4ll4z7GHOITorFZugdyd0UghvLkmVykjRnx5OIm
	 NWoMJwoWhmjTd0XtNjWAlXAwxYav0SBKPAfV4Z8q6n8LqN+WcwRyxbUaGyyXM2Fr4Y
	 aEaZEn3dCRZ/a89rJ2OfYuPUdJnbCydZx+ZUg7KPT7IG2D5YcbfkWX6DU1yv2fmd0H
	 jS0/9HUb6PriN8i3FgfTy6h8zlFFo/+hZ6PNGck/cCoxBr2zTvKna15wa+jB/dP0HJ
	 t4rqdAbGV4zm9/aOpap+1movfX1N7xEzaXgA6LkvKc7zg/LJwvkYFr47oca+6Oxa6W
	 keWiiFyjUBpRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BB2FCAB784; Fri, 14 Nov 2025 20:04:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] Wrong indentification of Bluetooth in Lenovo Legion Pro
 5 16IAX10 and 0489:e111 Foxconn / Hon Hai Wireless_Device
Date: Fri, 14 Nov 2025 20:04:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220564-62941-MWGuqB2nVQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

Jakub Jankiewicz (jcubic@onet.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #6 from Jakub Jankiewicz (jcubic@onet.pl) ---
I think that this can be closed now. I don't see any issues with the sound =
from
Bluetooth, the logs are clean, and the MTP device was fixed by a hack on ud=
ev
level.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
