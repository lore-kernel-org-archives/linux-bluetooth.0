Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369521547CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792321; cv=none; b=ekkatL3XXGlwQw33NWGFz3IDSpBdeDN5VtNr/37M5v99/LewyqZWttP9gD+slQOGiLcBxaR4n55LSDjGf8YEJ1kydDIKd+bQ+Nc09gbKTx+sfSEbGRW1q1qWh6C2FwnATyLTxKugCB8mWExc6xQKeBbjgT54d7D8vVONCx5JR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792321; c=relaxed/simple;
	bh=mb9HQOLEyEe8NdK1Gb5TtF5QDczokv6m1/ptIxcqcxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ha5AUDenNme250Od3FMyMGWujZYGU1a1WxbqkTnGInIQl1ePhf7h4tXG2QdKTxq4euVkg/NqdAR4OD6UG7XhI2Ols5jfH3yyKgKYFRJmV9dpl13jLzfCrBwHcjB6JQHXTB6AmVlzqp6/zaTs5vMcDIRLeh0uFOfioMzBiM8JZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mASSvQOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mASSvQOz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1842C4AF09
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752792320;
	bh=mb9HQOLEyEe8NdK1Gb5TtF5QDczokv6m1/ptIxcqcxI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mASSvQOzV1RIiefuAE3TKjw2by5+0uOTQL3m3+2K0A69w5bYqukSIExlv1SttkJfC
	 ueKe0PKV87pPOEACAXZA3aa1sB3TBQCMJltWzj5Aca76E5C/BwHPMBOjvFARtq5Jvu
	 ILcFWpfytigAvXVjKpEFqTpwKrZuofcWROIa8TAmIw+6bWZZKNoCaQN+sTUBozK8p3
	 5T9lZzjqAjZBHzA5Fkc8yJosTj7UsyWimnBEi/0hrhrh4dG23fRUv6JgONSx0sUQtQ
	 T/PGT56vTGopSB6XG3MOAt70Hyywi9YDFkphLPirfE99vPgvbuPMKbhDIe6jUlPd5a
	 eTLPHcVxexhLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C7315C53BBF; Thu, 17 Jul 2025 22:45:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Thu, 17 Jul 2025 22:45:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220344-62941-LbaAeuHU9f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for your report. Is this a duplicate of bug 220341 ([URL][1])?

If yes, and you ruled out the newer firmware, than bisecting the issue is
needed. As it=E2=80=99s not immediately reproducible this might take some t=
ime though.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
