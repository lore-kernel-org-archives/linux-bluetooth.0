Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD86D1BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696113; cv=none; b=JvPLzwXX8bBruzZu+8IFpPBo7QVGUbVPqyj1NR4s3mcq31p6uO6/CzRmoHYIIg3BQt0IpPFkw9QLh9faEzmSwQrXlwwkPj9dqgeXi0B2n1Ou9+9ZYESf7th8KdUlYbKko8z//RiWV8Lf1WM7c8RO+x3sHCIqzg8PFYdJRUwLrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696113; c=relaxed/simple;
	bh=OkBPF8mR2w7Fh3xlNWI134IvLjz/B1L16ZHdCufRZdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hc6Y0XYTFUwQ3gAA5amY7EfKNi6XZDKswB4dtf2Lnmbp5IKVsAMjsioZowo35yp2k3q3Cq9P15fA+6dxGHKz7KQJDYZeTH1nKPaCXnKOkDpxIg5eFWqqTgOcivtlL3lei9qwfgpnCmiu32vgc8P3f9DZ3/y6/Z9/j9Q00OQeWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBKisVDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBKisVDK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68247C43399
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706696112;
	bh=OkBPF8mR2w7Fh3xlNWI134IvLjz/B1L16ZHdCufRZdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tBKisVDK2Il4L2F05epsV3Ov4h/Uud5fZHEa1FxvT0KdqFBPixhU/jqG6FV0xRIO+
	 EChafD/MjOudYWlfFGI9ksaXuG5UT6GNs8LBEJWCihFOM9Fv5YOY3x+ASWwgEfveNh
	 hCycnn0e6HZ7aRLh/ycIHA5uZS8LoG7yHl+7QYCSnmjhanEShpTsUW4KIZvt6OwrZG
	 nD+UtXya9aY96npb2tH7uGKivhD+v7lWMZWRsIAN8VF9O2nIgmhTLz8eY4ZHTeA85D
	 Six8URKMR0eI6XwU/AkRhF1zHCSyHcDoXMIrlo22MY68O/skP3otQRriSyVU6kNO9I
	 zLXpQ1jZFTA1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5512BC53BD0; Wed, 31 Jan 2024 10:15:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] KASAN: slab-use-after-free in hci_send_acl in Kernel
 6.7-rc2
Date: Wed, 31 Jan 2024 10:15:12 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-218440-62941-Os0n16vx7U@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218440-62941@https.bugzilla.kernel.org/>
References: <bug-218440-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218440

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Is this reproducible with 6.7.2 or 6.8-rc2?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
