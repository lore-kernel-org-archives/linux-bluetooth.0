Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263E3AE6F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948669; cv=none; b=l7YsYS4afbbVx9Ppoy++vzIY1N0ATEBFo1BchJYoSjRfiQ2oYF4j6U3pGt33uhb3UDJtwl53yAEpNTGOJamTs79uLB6IgNCOxxN0Hr5Ut5JLTtAzcIVNqGAIN9ICkAsHGTao5ZbCIwafod5pvo4Lb1nPaT6AraWjUjP/NUuPSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948669; c=relaxed/simple;
	bh=nWYVvYs1MArpfVvj2zAaECG+gD0bh0INRfEKsIFqd7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qq0LTOGIF6Gi+R7M7wlRBVdtoojfFkJjk/i80fwDOV3jKSCjc7s63berckV3Q3XkFofjP/tDHQ9ehfV8sh4zYlhZmH98nIlqw9PjTdV87v+gBpXU1pZOTQ2W13kPq6Omk1lpiXD7YovC1ZB7dk/zuhWaqejs/CtdNRSbYin0ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2pLjebb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2pLjebb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02B0C19421
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768948668;
	bh=nWYVvYs1MArpfVvj2zAaECG+gD0bh0INRfEKsIFqd7w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n2pLjebbS2CvWAU/isvBybYNJ721RkOJ48GcxXF05FMXrJjgloYAZQoj5nozPAtrK
	 ciNtAM19m7CHiErI3Ccfkzy0QSfNCYSAJP7BQb1e3eYk/V0E8b1lrByLdRXSYO6PK7
	 n3Hs8i6/FiaXtlwpK6AJQUKtXn3NhdyKAYe5DfsbzihQEbJgPM6GCXjd1uJvA9F+JF
	 vlubDtA1A2QSBfSQboyj3jwK/JPu81WEuEt6JmQZ+SgEJzVFXAZ16crxeghCVph7nE
	 bYO0C/FL+tDSXIBLlayVg9UJLDXxOr9LylhnCmC9fY2cuqz6KBpDDXbC1c1CbDyY6Z
	 XRg5PfS6HEu8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D5CD2C4160E; Tue, 20 Jan 2026 22:37:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] MediaTek MT7925 Bluetooth adapter (USB 13d3:3596) fails
 to initialize - reports as unsupported hardware variant 0x7902
Date: Tue, 20 Jan 2026 22:37:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aamolodc@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220986-62941-twzgksygR7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220986-62941@https.bugzilla.kernel.org/>
References: <bug-220986-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220986

Alex (aamolodc@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.18.5-200.fc43.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
