Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF67347D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947198; cv=none; b=sbXyObn+RKQr+QCzoKDBc0ycDUqp5dQ4Bei+dP8gTw4f1WszOrlYMgHvCeWgE6mFlYPV20NxYgcKFuC6v//kUBfPBU+BBom3a92vgq+da9d6ScGMMTh/NVAXrdbvTdLTnp2Z4fqtVudDmbf9YHOO6Z70/4fPcXyicPZ/qD2J3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947198; c=relaxed/simple;
	bh=cizh6c5iu3lq+Ywx2Fu4CNR0ATJgncSeBF4e4k7XNLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kefu0JiDCZUlE1q+h0AhDZ9T1Y/UDt7iRVaNzD7Qm2FeHPnsucBCeI7WunnIPXVldVOj7Zyd0ilfFSqYPELQYJSf7OkQgndHFmvjbomAY7loVcZ/QdhjupECICnedkwHEQChD48sxjqz60D6SVEN2O8AGseIYBT1pPX/CC0gjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtKo3rRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtKo3rRl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DCE3C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721947197;
	bh=cizh6c5iu3lq+Ywx2Fu4CNR0ATJgncSeBF4e4k7XNLA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HtKo3rRlAeAwbLAjrJD7IEWSxbNcWtyLD6nDv2t39MWlrmLOv3nbMzPc080MCPF0y
	 dZYHmkO9mOZXYnNNQuQeO4pPqniSV7czLpD6Emq631zS/VbRCI1LqgriWZUTBLuBIQ
	 dwgTcwNfX7FJig2449yDEG9I1A1hkuFgC38pwKYOt1csbWXsh2sRe+Qy0xPDiIRmqn
	 5BW2yzE6ywScQdEJZVAejnDtCBo4OlWKS4KSEEUrxh5R/l5CrVn42OKmTGJRNhY7l3
	 rClt7f9ZJBBCR8k2H2L7HKjtSX8Yb572dBsME6iw8fiVXpZQr6o0VEsGsuQBqzoAeN
	 24AD0fuWinMhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 971D8C53B73; Thu, 25 Jul 2024 22:39:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 22:39:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219088-62941-Ky7CuBNa7N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #18 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Created attachment 306621
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306621&action=3Dedit
Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
