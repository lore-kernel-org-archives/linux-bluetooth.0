Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7919AD5C
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107721; cv=none; b=KQ5QU9CACalpamSUdIQEhBGP/riq9ATYs5brchm1y7cm92ErxZU9nUx/7NTqDOJi0VoGDosdyiqcue9qjvF6IGV1/bn/U2WG0Ezu5qCRFujEE2ryYHJCwN7zOzUVj+JUPCw2ndRxuvWGHD0YEpNOXfoY2AO9U9AA20n9GE94C7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107721; c=relaxed/simple;
	bh=yZsC1vUOMIEhbZgDj4CQyyw5IRzuwXmR86FnZ/8eUXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IA8XoEPfX5tQTcUxjvRLiBbVpZKIg+Bw5xy1u58qzSQB3ELIkRTM9FX/eO/Zru9WzBRyzjaWMssHSJHFS9eD8FvOnYa0voTSpS5IlsXiEFMJxPZhfWMMlfFtRkjMJp2hcLGCFT1/fD7aYTwTjBJ1YybjVIgmsE8iTYJGzYsbS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZHGPwLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZHGPwLS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A86C19421
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766107720;
	bh=yZsC1vUOMIEhbZgDj4CQyyw5IRzuwXmR86FnZ/8eUXI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MZHGPwLSh8tmmfIeELb6150NxzpJUWxjvqyrXrLtJM0SU1cwsUsdn43ozWY9ST58w
	 XxO9KSWvXuU1RbiFnUIjDQg10Gq3bRXAIvgPr3XWom3DbEb/is7tzQcnqlf3dikmo6
	 atUYyFPoKFCBPDDMrqAJry9/jhzdgO/viqj1Jyaum6/LcXNekZJ7SPr8dxNYBEE3oC
	 nQfUHIXTOFXfi9VpsJrBTddF7lA8Oqs0v19Z/tgaVi4NWYH82GxRI/ZKgVrR2exUKg
	 6pxsWjmlGd+vvnQ1ksdsTQyFtHWDjtuyzfDKygsDPMBKtSLE99sQ6XTybKR7hM6M6V
	 oHhmNWxoXiKBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A34DCAB780; Fri, 19 Dec 2025 01:28:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Fri, 19 Dec 2025 01:28:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hurikhan77+bko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-86931-62941-JQZHxFo3YA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

--- Comment #13 from Kai Krakow (hurikhan77+bko@gmail.com) ---
Randy,

the underlying issue is quite easy to understand:

All Microsoft Xbox controllers are sending a NUL terminated HID descriptor
block. If we strip it away for those devices, the message is gone. This is
probably true for some other vendors (as reported here for Apple Magic Mous=
e).

We are doing it here around these lines to avoid the warning for Xbox
controllers:
https://github.com/atar-axis/xpadneo/commit/1e6b074506b85d03d2636beca528177=
f482029b8

So maybe the HID parser should just ignore a single trailing NUL byte and
accept that some device vendors just do that.

OTOH, it may be useful to warn about it, so device developers can properly =
fix
their HID descriptors. And for that case, rate limiting is the proper
implementation to work around other side effects (like overwhelming an UART
console).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
