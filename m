Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403D27B32C
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154825; cv=none; b=rXHwhVDlIRaqFbTsnsByd9H7NoGDvzktcuSnADuqymFAJUD3dhKpMZJbww017ivL+JLWydYQHwRFzQHjNu72Sf5wsEWfXL3VGf0gurnrOd7hf1hPS0eb8pL5haDnjAKRVF9joGNgz0LjdvhmIwGcMH/9IIwQMiOOKXm3AzdKyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154825; c=relaxed/simple;
	bh=3cvUZ52n0vuZGLD7qjAQ8clLZDsxPe3tGkaBRcvSl6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OiODgMW9B4RsNdeq3D8j2TbCFc4jL5yTLmeWTav/aJiPYOWO9+RcjcMRzDlp9GaGi0/0/eP0YeeMUs32HGEz4Q1Qr8ztiDwLfIr76U8fEY/U4LiVcUIVInonZnyrsCJF8KNcp5o1wSPzXpUX84L2O3EGQO2LlVRHO1WEnU7Pkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HopY7x1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HopY7x1v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D36C19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780154825;
	bh=3cvUZ52n0vuZGLD7qjAQ8clLZDsxPe3tGkaBRcvSl6Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HopY7x1vCJkuEVeuo3BXyCwlkEEniceZXm9Jrdp3wxK2gqouXDP7/N879t8bvZNR0
	 NKyLCjBTlsFnpiK6KueRfG8k9lWzFsbUkh9EaRHEUTuSwEmTry9G6YYx89ZIgpMIuE
	 ZQcd1Yz6txPq0vm8DmAud75D4rYhXDcao7+I6wzD+s7LweclVgr+njCgH4x/WOch97
	 YLZKBWfT5WlpPI3TdBzIBLQydHxGtsUcR96BipJ9UvuzuoHW2b5hSMaK86O4IT1mtb
	 Udn5viOppU91BpVHLD3sq0NDWrobIFAOrdQVqJHUSXy4hyHniUaaMZNylG8uKtLcxz
	 Lzxj+dPYI5cKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39C6AC3279F; Sat, 30 May 2026 15:27:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:27:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221598-62941-bBTpevdU9O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #4 from Alexander Paderin (apocarteres@gmail.com) ---
Created attachment 310213
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310213&action=3Dedit
btmon capture on Fedora Live

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
