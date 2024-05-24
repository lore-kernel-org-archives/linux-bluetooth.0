Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83F12F36D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584639; cv=none; b=rkFOEF/yjqkXCi2ea/LlddE7hBEyQCSpQmPJxnCD89VCG6zxQZ7gUPwF/guN/SLl9pu2cEOdfZUsLCr/XBITePwUJanWZSOZn8FPEm2KL/Vmc+CsGpqyfnuFDRqCqrM/Fi30ECOYikqoYzs2/M+ZbX7VWyVk55a8/0yGKbMNI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584639; c=relaxed/simple;
	bh=7cfzG2ob7vosaLOMbQPjBxSXWkegYkMM8xRiNm0/lG8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISV114eXPay7Umlcokw/2Fi2OhCsCDlKuxcrJ6bRHw/zhri9LPJJ3wHISOo7FIx4F/PD+Wyk06HjRB/XeRha+zbUFZYVy62wzTgM8NIPvNiB4fNQVmgpLirR+Jp4XWLWKa1OXKrgzioqaYBIBI4fWdjcDP4si2Z4gV+cgqLEWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd8maaGA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd8maaGA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 160E7C4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716584639;
	bh=7cfzG2ob7vosaLOMbQPjBxSXWkegYkMM8xRiNm0/lG8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hd8maaGAroqgDoiDGv3+tZE/0/Na1q68c/F/RaRDpUG6tlSNeBIdjfvCyMQ1pOxpt
	 VbdDXhgFXfQ56lOyV1I9jBy6uhM+NM7Y3YfpEnezNTgDs+oqgUJSdOEruGT2bOV5hM
	 hq88JOHisr28iacdkp4voexH/lz6hqFG4xcYGuApCJOmnPdOgnkkk/DRqmdgVqC4pN
	 /jF4Rbjlaz6yk7cW9NALdMt1CDlDBtyJKiRuclbGXIPbgf3ICyBlgWPaEUXayfcSvv
	 MPMFtAcHN1XVlKIxz7PF7bGbQzQAXNqIHZ2WA3lSt/6mWNZfDKjuF5KCL1XLBV2v9p
	 cpJJ/dAMWxT2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E998C53B50; Fri, 24 May 2024 21:03:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 21:03:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-N9QnydNkyL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #30 from Dustin (dustin@falgout.us) ---
Btw, I opened an issue with Ubuntu before I found this issue. You can find =
the
debug info I posted including logs there:
https://bugs.launchpad.net/linux/+bug/2051720

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
