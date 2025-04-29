Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBE1519BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928812; cv=none; b=CbtqmGErnVqW/TEDTY2L4J34wEVA59fH3T4H+d0LJD8njCSzMrew1zf4rv8dxNDAR64yOWHl/NWtQRhnewEHS+sSIXxd9AN+/zRcA74wvTJJkOJ2s9mWDOPqkw0/qdHveRC49W/z9CTcua9ZgmbaiJqj6jTOTrWYZt47gtsBcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928812; c=relaxed/simple;
	bh=qKJijx9EweIY/Jr3n7n7+6ot34x8b2z2sjOn/V7i/8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEuuuTExzVSMcNSemyeVfO7OgpIf0qykFvZB+0F16j5sy+X/mqyaujhqpnI55PGRPEBHk+y7vC7BeMzjybVD/ZE846DLcHgCAGJKhBpdnQjU5Od2RkQ7vA+9w/XoNRHpXymeZr5ObX9B+V9o2/9G/vuuTmS748AakYvFTGMkGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJY2nhcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJY2nhcm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B75C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745928811;
	bh=qKJijx9EweIY/Jr3n7n7+6ot34x8b2z2sjOn/V7i/8I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sJY2nhcmFkEItnAj7qyrcf3pUY63WmpbO/bkBcB3hacD6aN0ACKlzBvw0U57tSRfG
	 IPCu25X0fXaII2gsWpXhOCNrt+4D/NDiQG2EPBA+3XGWbQax/sfKMFE8jXBykgTs28
	 IjYfziXXuEXULhn4fU5xqinb7LXqEAXdoQMlJTOLLM0mUoI4HH15nlrwqU2f2Vv2fE
	 ecBXCJEZpGzoTc48ifftsqbnz6HxhP/74CE8yWINCEnwqgIQikO7kATNNyoHrEtoFQ
	 lZSTNLWNNNsS5x8YSy0Kc476ZJ+6vQdN/SW1DSRCMbY5QEnYnAqzZeq3+obLyIiTo5
	 5Ela+ps9dAY4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9CED3C41612; Tue, 29 Apr 2025 12:13:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Tue, 29 Apr 2025 12:13:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: marc.geerlings@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220061-62941-9xZqJKl3fr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #4 from Marc Geerlings (marc.geerlings@gmail.com) ---
Created attachment 308054
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308054&action=3Dedit
Result of btmon -w /tmp/btsnoop.log of two failed DualShock4 connections

Result of btmon -w /tmp/btsnoop.log of two failed DualShock4 connections

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
