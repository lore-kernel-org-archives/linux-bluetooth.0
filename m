Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05002101F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943074; cv=none; b=AS1hqifEucf05SGE6N09Cf52bo3fhlbm/nqC6r0DeNjDfqswKyMJfcQ9rsUpxDprJoUw71zAR/2x2UbG3KlBZL9NS7b0q/sXZ+m7AJAsSMO4qVMZwofCQq6yAW2d8PAeXmT+igVPXfqaKeZ8p6vsOyD6sGpiouVapxe9wo3NyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943074; c=relaxed/simple;
	bh=AFyi/ouYDxV5JAVJ4XYb+k46vkrf2ozLUXUN5tItlrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWvPJd8G9yvQafhdMZ6q2y0KuPNb9LiK+8yC+MUdgfReeVeOUJZ7PbPgFOwKmB9FNFppOkU80Hb2VUR2pf1NhthFgeW02CJVlzPE2+uDX9Ren1paZI3WDVx8JmY4LFOdF5zp/jSPWZsaVNAp0+VkpONHQ/xWVhUW9yk5zR6J8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGiNkV9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGiNkV9w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B893C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721943073;
	bh=AFyi/ouYDxV5JAVJ4XYb+k46vkrf2ozLUXUN5tItlrw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HGiNkV9wlCfzqmMd4V/36yR39mDSjLIzEXwQDdbJg8V6n5tCgdZtBiJWln0A62d+P
	 z8j1+SujjxN2AQuDogw0BMDW/Yi+N8MZ/yKL+Z4u5UT4xuCZ29w4mO07T0ZhgzQoMN
	 0FV9a5htjjHJxJNAG0rkQltFZf/Jk1kBS/HQcKlEwM/cdxI3AyQB87eX2zH+rYT6Q2
	 HKj3apWC+uOSp2xrdL6Wc8dY+/a0xwSY01HEC6oVZgN4qCjNRKe3Sd9G0ZJyJ38ag/
	 tXt0UBslmnJ5qSdLZxEhhvPuagia23TOr1YONxZz2igwZAIz/L4idsA6E3l/i6A4fw
	 1qX2j0nFEc2VQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8C3B5C53BB7; Thu, 25 Jul 2024 21:31:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 21:31:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-r3GqWI3GV2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #12 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
How can I learn why is that?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
