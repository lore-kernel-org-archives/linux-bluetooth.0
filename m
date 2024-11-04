Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC91B6CFB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725449; cv=none; b=amiutEYNocLKcJybUqItVacjdepmXefjKmllolET01woSKC6YYBrGGVRHbYK/NXfookaJaQICkbL/Tre7vjwKKuw7aGp92lpA6wT1FFQWC4JpBIrBBEFV0EtVZOlUqLIRwZWINAGaAX46UgadBWWRoYwDp1pDzjVP7xfyRN+XaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725449; c=relaxed/simple;
	bh=XjvpT6nWXMiydZ+TYgkBHhMia/oueJd88bF4tVay2Vc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/toBBwWQkPe/bp3wR1v1gXEG6XAw/b9wkVsXoAkWzqDuawpQ9jry523pZI3bo1Ifur0Q4wwjEF2xH8X1Zz8DcdBdxSp3+3+PI6OTN1qf+U8ZeaJfvAwqIRhBCg/DhyRhNKU0TDMDaYM5nkBKXOVLLW/xKlvClWdXd5z2LAIsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhKbCsPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhKbCsPA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FBC1C4CED2
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730725449;
	bh=XjvpT6nWXMiydZ+TYgkBHhMia/oueJd88bF4tVay2Vc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZhKbCsPAQAKagT//draEJWLYtKSXPAcvLggNL0zXxfRbda7P+HLmI2lTfHHnGxRQH
	 dqWkBnowp/7Ljzh8c+6o1MUX1Z12ieM1D4iUbTluHSuonEjjKcou2VXGX4EwIq82l0
	 ku/3G44lUyJqiD8ubEeoIilpJ+Dw4DKkuNJrvG+4V1XH5EwHihyIYWQse9sQ54idLt
	 e9WthjV0h0sLGRHsNmphUKUByIHhJB5IgG0Hfor1t4/YdZ5yxQcPvsQAlrSuucl0Or
	 MA4FQbPkTLi5OcQTIqvfbCtbVf1Wi9o7lgF39Rs+yu5nAc7uN8lplUiylYhbkznYjS
	 JZ2y5h/F8fodw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 17100C53BCA; Mon,  4 Nov 2024 13:04:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 04 Nov 2024 13:04:08 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219387-62941-WlgRyrZPTa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #7 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 307132
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307132&action=3Dedit
Output of `sudo lsusb -v -s 001:003`

Bluetooth USB device:

    Bus 001 Device 003: ID 8087:0a2b Intel Corp. Bluetooth wireless interfa=
ce

Output of `sudo lsusb -v -s 001:003` attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
