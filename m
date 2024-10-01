Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF129CFE
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764424; cv=none; b=kr6dMIjUsLkVvpsG2TMT0phEbiD8c+E077lmXDjIyfrOylc1OevVOBiRBiJAeS8/zTX64PreqnRBVxKbICFLybKKa4Gf479wvt7KFbl9XNsVVvs67EunzouU+BbxzN1ahDbg4qDE85yMT/JnRuKQEQ+/Wzy2SZelBcPOCi/+Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764424; c=relaxed/simple;
	bh=GizPdqaj728/FyC5cZgHso61hobTc9QvykZhMhRy1Vk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWhDtTHNOj+HvjgUVRBj+nC0wi4qKigSyhwhypMZurkhcNArb8MKGqKeFeA34wpKPMDMSZtVoyfI7PATBVT3FreeDIKXF+80JGnNuUaT0LbqErc5qHN0lPNnFiOzJ18BPRj1mTgAWKkSN5dK/emw3A5s967JVvD75I6TnMqSyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urqRGtkc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urqRGtkc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6501FC4CEC6
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 06:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727764424;
	bh=GizPdqaj728/FyC5cZgHso61hobTc9QvykZhMhRy1Vk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=urqRGtkccIdiW4P3ID6GRZ6kyHSKJ3fhz5RAmaW3uxHStRF/TIiH/P32Rw4TY6+gb
	 iM8Nl2saR/83D2/TyWX/KNqRAtStD4kZPisGFmtZeAMAbRSNCEcNYp7YLg1R7ro2il
	 /mIRHTEQT5CqWID3whL8NrBTb4FgcbNJm3JhYbeYT1Da/Itw1D4U8sS22tqchv4Fhh
	 mi7NrWU3PlRCamZQvk7RnNMfntpWrHAKB5mAlSGwvIfJjV6T+pQLdFDlFAfg5AoOAh
	 zCpXcAUWFPqq0WCvxDIRcYNBMfka+yWxEg0Bjxn1hcSFZPtvvvtJhJZ+V6pTOmLGyt
	 nXGCfKjzRxqTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A16CC53BC7; Tue,  1 Oct 2024 06:33:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Tue, 01 Oct 2024 06:33:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219333-62941-7QVX5FRoj8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Does this cause any problems, or is it just a error msg you noticed? And is
this a new error msg (and thus a regression)?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
