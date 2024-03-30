Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EF2F2F
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806271; cv=none; b=XnHqLA5zWBdHXMr9L74hVuGzB/v6n05+mOnVxc3hIBZX0vVSw3a7EG1ivHwqlRsfQiN9wb+5bLG40yzZNY20woCNViyX2l29On3QvK++2NRZhwinT/2jbreQleUjllbdR9ZxAdzJF695AV7rAErtlUevsjeIJsvZgp/avTF6+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806271; c=relaxed/simple;
	bh=MLQ/t1LGPD0w/JPAMm8wPw7TLBVv+fLhYmGGtEofC9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIvQI3xypFPFtePUU24oqZzInb6xQxYAS/yPBapym+XzZD7FDxWYtREpdyCf7kIJUS6yjY5jmsiAfU/vgPwntIK8442T92oi2zcB1z5+b34g0pRF2Hq05LYkeCZkF0CvUDudjov/xpzEml0Bueyh/tp++bzIYUgPrm0COiDPPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRLx22ZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRLx22ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0C4DC433A6
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711806270;
	bh=MLQ/t1LGPD0w/JPAMm8wPw7TLBVv+fLhYmGGtEofC9g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JRLx22ZS9X2FR7tfY9n3JRYanaxYFwtALbBq4JA+icn51zZEqjelIaitBnbISah/L
	 k0CbEkVUuiBDN0tdxdsT2q/yOlQ6nLNh1Pxq/6GQt/a7SvNltb0sLD60j6pWqu7pID
	 6bULRTOVpxvescaLBJnLi/oolPXeCjstnnHFOPvhAeblR3nAyFBoj2JSnG7uXXPYzC
	 exDVDVsFkfnoh7hMVwZ0Gqk9DoguDptJPAA9/apVVGQcplFTmo9zkp2M8seGmVTUzc
	 q8ZASBf9RdL0KtSb/pfsoxxaMuKTj8+hCL8IZgn/qBgATnp+WVkVbZ0q07GIrXSpcM
	 iqJ/iCPwFKz/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 94C6DC53BD8; Sat, 30 Mar 2024 13:44:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Sat, 30 Mar 2024 13:44:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jugoslav.gacas@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218416-62941-keRd0BxtHQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

Jugoslav Gacas (jugoslav.gacas@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jugoslav.gacas@gmail.com

--- Comment #14 from Jugoslav Gacas (jugoslav.gacas@gmail.com) ---
I can also confirm the issue. I tried using latest kernel 6.8.2.arch2-1 on =
arch
linux, and also LTS version 6.6.23-1 and on both I see same behavior.=20


$ lsusb | grep -i bluetooth
Bus 001 Device 004: ID 8087:0029 Intel Corp. AX200 Bluetooth

The behavior is exactly the same as other described.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
