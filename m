Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE673749F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188877; cv=none; b=FGsVRrT6gBeSA4g+mCUohTTfqJVCSkijYA6IkUe0aK6wlfRj63s7nCuDehC02qD2AJqvZhgrZtxYMNBKjm+qGDCko7eD0CKh5m8h4ZLsAAU73WWE9BEk3YMsSjDJfc+RgGnqDySJqpay23/nSIvpJZD+Nbh0j8JpH/dfJAn5NQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188877; c=relaxed/simple;
	bh=0tRFMgIXYnLDzbUBC6H+d71dqPrOD09FV4NKJXUPe3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STsRLj5T81LIl+diGlj8o6uRUsF4hf/RxJUvsIRxE/hPFNyx/ugrMNIN48bNIG/U8CnuWjbjPYrti44LSMLMI08w9N0g0YES4xeypuAt9AxP4LaYUYvuh8gfUp3vHWNDRm+8gUW//rFmmFWsboFcCznBPT6AVTWMBD6lQY4AUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Ilhx3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Ilhx3y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8333DC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781188876;
	bh=0tRFMgIXYnLDzbUBC6H+d71dqPrOD09FV4NKJXUPe3U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M1Ilhx3yeJFbvM8qYMYpHGiFt6VDjng40LOMtLObmOdYoPumKhLPWD75lXxzieLnr
	 uGwUe+jszaKGqEJ1u7RrJ1tkEhT9I//H4QrRYWXsS7K5CDkMA1o8TQAUGyylp/Hefw
	 txMIVyHqKsJJSIhTI5cv8YhytKElSmfcPTcsNn6Cy74vQQ0kAYgJvWmdB/iDRvEajP
	 /mzh4Cc6rqsNAnnT8Qt/M+/Kgz66GuWHnlweo+ORXortdsScJe+Nba2AZoE6K2OWo5
	 M+3m2BVjnhJu9gpz1k9QqPd3GMQqcaIjMBs92LZLc9IwLpoxMk3NFg+De25Wnr4wv/
	 XsNYcVsyuRHwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6CFE3C41612; Thu, 11 Jun 2026 14:41:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Thu, 11 Jun 2026 14:41:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nibheis@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221637-62941-HeSqcSqueG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

--- Comment #3 from Pierre-Olivier Vall=C3=A8s (nibheis@gmail.com) ---
Author of commit ed10eae8facb3b4bf2da7104cec95afdf0209114 is ravindra@intel=
.com
but there are no corresponding bugzilla.kernel.org account.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
