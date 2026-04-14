Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F991FCFFC
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149151; cv=none; b=pIKYkwbhunGEWMH2oVrZttOICALS3qQWQR6lysYT+6GcBjUM0cs9tPDOkL5fkkS8EnLIeZSveH+W5XSqa/PPFbQHxrBE+swtUgLfdJ3kqFLXhjPyOn3YidmeL6LbLZFT4cAiFQj9Nuf1PfaXeFS/O731CKLrftRcRE6SAJMo1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149151; c=relaxed/simple;
	bh=WI0MrnFVevMJ87LY8qn0kWqHoIg+BIg3j2KZ9iCPpvA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1LturieFS6TC1U+gse/7qAwfHeAdYnbXwasZruZVsw/QCPo+0rNkxpkHK2djIY9VKSW9s2tmma7OXNrbrTnMd7xZlAiiHvJfLdLWHdJqTDaWLeS3Cx55uVOWRKiZAmHxnlCNfbQgeuI0rbtyatZO18QjjXZ3a4L9FdxEmv3MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taek/2CV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taek/2CV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F9F5C2BCB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776149151;
	bh=WI0MrnFVevMJ87LY8qn0kWqHoIg+BIg3j2KZ9iCPpvA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=taek/2CVyaCwQkMI4J2ygEoJXkWMxjyVrgkrg092Ir2VNRRuq4ttOIm6kb1q4Xf+X
	 WHNk11PMQOIeCKX7EiXQx8q2PgHss1feDQCZ9+EI7Lwxs642J4nySwCz5B9Yce+017
	 Gdfo3UHYaJ2hjgI4Ay+9RNQOHjshtd0kAZE2qNCazGyLIXpGMBZT803PNY82JcJOnY
	 DCBh+N62z7TsEg5fIKMy8uoJjSXzhj7Mnftq2Hi5QCvwWeJAgdGkPNekw9oQJJksp4
	 G6OcB9YlSqhNuzWcGK0917ggc7+Ao+jjmbZLHDeWdIbOLxPjuc7b/s2uthzYq7Vm+2
	 DqkNRzwu4w37Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 766E1C41616; Tue, 14 Apr 2026 06:45:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Tue, 14 Apr 2026 06:45:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221346-62941-sO7UTp7Pix@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
It=E2=80=99d be great if you could comment, what the problem was making you=
 close this
as invalid.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
