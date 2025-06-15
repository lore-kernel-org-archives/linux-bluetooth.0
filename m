Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133EA2E11A3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022641; cv=none; b=ePcfSVPewVkPHpAQfTvIuSWMmd3FXQFmMSNyRy6TZkvhvBB1621w2NxYzrHlKof9Cof+8XIobChAw6cGD6IOsN/UuLTgdsaBBjw+lNZxuG+hvyNMFrwWM66OsOoNCgK7SX/yK4Uwtgt0rMybhY8lESTjEgGympnwglpyZ1FKz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022641; c=relaxed/simple;
	bh=GyqWEhQ/skyoYx/d804L9hGckw2Y54ZgokMKpNUKVdQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fq5dKJxzTq7/Le7+oWVbV2xneAjrwMHN36pH+OVKMgJWuuTyuMsvHBgXBKMnVCjOsK4Ps1Ui8bzQhJI6jQ5cKxJJ3VWSHbSksg7e9VWVcf8ZAdDkX0rt6KXPV04hXAl2ejdvLXlhNNjIKwaL+MIqaQJUdIrMvk4MRUbvhLCcgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adDlQKSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adDlQKSG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCD1C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750022640;
	bh=GyqWEhQ/skyoYx/d804L9hGckw2Y54ZgokMKpNUKVdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=adDlQKSGg5Mrl67xy5zygnvApb6u5uf4/btZBxnXILwmT2sNwOBihqWH56s+75rKr
	 hLpsLdziD5stgkJZm5iHBdRawKls2+ZWMcjfJCywIhbas3XJ2q4eM+dn6R9dIWCW8Y
	 NkvYWJoeUIXsNuuPEcvfWKy9mUt0uoyHL3P+iWZdP6aeYC0hYhv+UFTY3PwSAZu9Dx
	 oK3fK3PGg9PzzjHPjFVgoOYh2XvVdNf+6Yz9E0LTe+w4pyARB8rP01hxtu/RFfjYti
	 xUYWK6Pj2EhkBU4XraY/fluArP7HT05lWR0ONVAX17Qf5z94YtjqfWELf6lZrIIem/
	 JDmXa/juTgnIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8360FC433E1; Sun, 15 Jun 2025 21:24:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Sun, 15 Jun 2025 21:24:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: are.mehus@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220237-62941-iWdISrQG6G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220237-62941@https.bugzilla.kernel.org/>
References: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

--- Comment #2 from Are Mehus (are.mehus@protonmail.com) ---
Created attachment 308261
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308261&action=3Dedit
Output from lspci log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
