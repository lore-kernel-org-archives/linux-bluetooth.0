Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98D3B95FF
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440792; cv=none; b=AXMQMLfCRlXkC5lGx0FTJyfU8I+MJH+odb8cyAyDmUFxbYiYHHYm+bvkNqbiyrlKHx7nen093Lf15X7E3sBjPrWUxb6kpvrJV7hlDsBakFMbQCNZzIC7v3SwVRuamqMzFWfJcAqhvzcp/WE6taD5C7kp5rXNr7GzBKERzMwFBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440792; c=relaxed/simple;
	bh=7r6/rftzjApp1ytYb11PPF5IG0ZMP6I+pl3kl5LewlY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ro8OD6UQln9ojBASNdymUIWOTjaR3HhsP+/esmoZM9eKILaCu4GJR0VMlYS8cVG5NnaAs1RU5LTLjopezV1p+AWXZKyJtxbtNPBl3Z3eZsdYuW+InS/3uSYs3ljPUIy6n7aV4eJLOzN/UYYIrEkuTSpAXEjXGsDRE+Ask+ICgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeNNubJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeNNubJW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2259DC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779440792;
	bh=7r6/rftzjApp1ytYb11PPF5IG0ZMP6I+pl3kl5LewlY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CeNNubJWOhzoJyOkWEtLu89dINoSzRuuCoBJHXOWrPRhnk3WXQda5ggzznvBqw4Ul
	 b28/WkpoHws4jpLJfJXg2U+9wcpocjF47CMvBquQ4P3HIYr+XrX0Uao7t/p1S9eQmw
	 XNP1YOLrOPR+DMWxfWDn7zKZdUzc2p7pfmKe3Bm6ECmOHE56yeqVHezY1ufoR5QWIh
	 6AJN5WnT15rhG0/fffn4zk6fV66fTJd1x/ZmBUWaE4o3W/v9obLKis3C1Rcw311obb
	 aFKJ4ko17xozZnlefGluRL5bUUdgLUSD0SZRLhPqbTlZZPXlsntirWEOYozfVqyUK3
	 LE0x4/Wp3E88Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A1C6C3279F; Fri, 22 May 2026 09:06:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221524] Intel 8265 Bluetooth regression (BLE hearing aid
 unusable) in kernel 6.12 vs 6.1
Date: Fri, 22 May 2026 09:06:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REJECTED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221524-62941-tiOdTf3vB8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221524-62941@https.bugzilla.kernel.org/>
References: <bug-221524-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221524

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |REJECTED
         Resolution|---                         |INSUFFICIENT_DATA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
