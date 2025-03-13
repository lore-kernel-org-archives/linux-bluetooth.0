Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53302676C0
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868760; cv=none; b=ZRLFY+8udc+wN18ySWGv3zcRr0zP5I/MCM48y/WFKnjHFkfXZyhiu4bJvZUwxZOX0X9y3KJQoQWjddgDNfYuFHGvN5i4A7/ZLmYKFAiTtROn3wOm6WIgU5j0CNX7OEqdfjgLqYQHDjJQnUFGO0tav3nTJs4p61cIjMlgCXBvigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868760; c=relaxed/simple;
	bh=pf9juoEnZT6rBnRfX18cLylMYmCr4p134XHHavCEj9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKeKttKwh2r51zRFpo//3EQTgVHWTRDQYFI2JScMAMt0YPeOMPz/GRwrgW/SqTonItZE1mUmnEcjd4ERq/WfR1GKo8p6SPsYKw1JCNYzbigc1f/MDhUVmfyCK+R92iJTAOoq4WIKAL4GuTouqGBUzdoMWdBJpEXswLjw8XjIIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax0rkPx7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax0rkPx7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F350C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868760;
	bh=pf9juoEnZT6rBnRfX18cLylMYmCr4p134XHHavCEj9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ax0rkPx7ejcqWru5202hrSVU8rUom5+S0yS9N2zok1M3FknXSZoEl1lZc6cNncK4E
	 tKVJGUJHCSsI01VFU72EmyvQa55QxmxHnlRp7Z4PoMNJ5E/o9x/LNt7KlDcE5jJXX+
	 jQELjiB9ZfkhltZzT0zsKHOjFaIki6XIcQQUyX7sgHwF23gTvJvTbaNjqt5astWEYk
	 mAmyMJAU4mqHUjkjySC+mLOPZetN2XCFo3L7BrLcqXq2L/GGg/loh/2EwE4R0KKK73
	 MxOKnW2qHRXAoFlUEy60Zxgdo2jjQcdo4rqY+4FsWQliuZvzG2dJ6esDZcNUxlhjNl
	 gbtB4GvbwXlgA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2104DC41613; Thu, 13 Mar 2025 12:26:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219861] Bluetooth device in reset loop after suspend
 [regression]
Date: Thu, 13 Mar 2025 12:25:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pierre-bugzilla@ossman.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219861-62941-8cHLLOOHyH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219861-62941@https.bugzilla.kernel.org/>
References: <bug-219861-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219861

--- Comment #1 from Pierre Ossman (pierre-bugzilla@ossman.eu) ---
Something to block the looping and log spam would be appreciated, until the
issue can be properly fixed.

Bluetooth support is not critical for me at the moment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
