Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4D2F9998
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232387; cv=none; b=f2iyBNy0Z0rKiN7joqsH9cCrbDVEUrreb7DdYiixP3tKKbN+JkQQNdkQ8BEkOsEnryyPU0qo7iSSaKKOF6GxPFEpAM2P+U0+7fpKz9lZLwakKsZEw44rrrXgxSn0lHz00RTlHiqSB+5Ffp1JRJMfu09h++dBsC0m4nAI+vFpdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232387; c=relaxed/simple;
	bh=XB2phavcicx5xX0S11lu0UTmuYJMKuTHQ+ZO9mcoz/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbHijP4Z4Cdep2ITRGDD5uZ8vUnM3L1LGHNDxNMCiY749Ilrha9d1aFFJw9KA2V1Uol7vXIf1nL+wCpkrBKvLmP9uaGWZgVX9DkjOot6XD5rLgZlSRMaxc2BAGtBpgTXS258Kr5ihOkVDiFpOyNPYPp0oAZu2MsAwCB/c3PVPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTbLQBCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTbLQBCn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E93EC2BCB4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 05:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776232387;
	bh=XB2phavcicx5xX0S11lu0UTmuYJMKuTHQ+ZO9mcoz/Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KTbLQBCnwGJdTEL0AnY7rQFzHktdvZrqSKqN55K5LlX4sRp9LL+NCiINRPua32cJe
	 LSP51N6gMa02ZGd2ZcGmbbOxnd59+xdVZMM4t/SuvOsFlIp+FFyowyYBkjIxOqI7wY
	 h96H0iLq1StLbqMklp081yNge0WSgQKYu0LTpWMbctmTIkepGLAcz4eak7q95qCeUO
	 iluu5713Q+IMCqi3N7PtkRLflML3n0jsyIuP/h2B1MRfYW/NPMPw8vyTUbO+ypfu9u
	 fqyr6DGJCnzfZBwQefgtXJFZjFs5R2dLmtG9crVvO2KaEcrlVCXZ3kVr0tZm0ReQdV
	 Op2rMssWr3Mfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 32F26C41612; Wed, 15 Apr 2026 05:53:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Wed, 15 Apr 2026 05:53:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221346-62941-hKhZemO3PS@https.bugzilla.kernel.org/>
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

--- Comment #4 from Zhang Zhigang (zhangzhigang1996@gmail.com) ---
Hi,

Thanks for your follow-up.

I=E2=80=99d like to clarify that I did not close the issue because the prob=
lem was
resolved. The issue still exists, but I temporarily marked it as invalid du=
e to
lack of sufficient debugging data from my side.

Here is the current status:

1. The system still occasionally hangs during shutdown.
2. The hang happens at a relatively late stage of the shutdown process.
3. It is difficult to capture logs, since at that point most logging servic=
es
are already stopped. Currently, I can only observe the last messages on the
screen.

I also attempted to rule out Bluetooth-related causes by blacklisting the
relevant kernel modules:

* btintel_pcie
* btintel
* btusb
* bluetooth

However, even with Bluetooth disabled, the shutdown hang still occurs. This
suggests that the issue is likely unrelated to Bluetooth.

Given that my understanding of the kernel is still relatively limited, I wo=
uld
greatly appreciate any suggestions on more effective debugging methods,
especially for capturing logs during late shutdown stages.

Thank you for your time and support.
Additional information:

* The issue is intermittent and not easily reproducible.
* I am willing to test patches or enable additional debug options if needed.
* Please let me know if enabling specific kernel parameters (e.g. debug,
earlyprintk, pstore, etc.) would help capture more useful logs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
