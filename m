Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDD22258C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128135; cv=none; b=b9U1/IaHHXVEJfxOQYM9VVkvIwxeQpEgKvn9CgZ9oDCuXBAQtkILDxdl8cYFzluPVyYngeF6sb/gBIK1oLGEcAzMwLGwIaLg/urnqE422ouGCqn/EVJBwfdCJ4GbE8fa3m2Qq+9vzWvLEfmqiVUuw1u2cYfm0j4giIp6F+OVFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128135; c=relaxed/simple;
	bh=dwvQXDgjHCd4qVulyfD5p9F5rFoNgEgOH723wTp5Y+Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCcRF5No+OY0m5mg6E6ZQvUqZNvJgGpMvXRU5x4H2QFXilHfiLOSpgdgle4mUv/Lne43HfDbXgKK9dkemGuriM9fDx44JP1sr3ILjy5EBfIIXz8okbKim0abvwevEtBtAX2vpetGjJGT0YIIp34MjCLcAJcR05dDfVZR0BsYp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaXBMHph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaXBMHph"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC184C19423
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775128134;
	bh=dwvQXDgjHCd4qVulyfD5p9F5rFoNgEgOH723wTp5Y+Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZaXBMHphUGNKLbB+rqUCGECoSfD+ySSVdepbUrdjZo+Kk27rrjxSLFeB1uz9LWdl+
	 BKyFn0fOtBYQRASoEeCRVfdi6Zh5QkvSi48XmwMfOsfeu273IjgZgTU8HnVZUraB+J
	 p7xPOaH60AWVYq7uSY8iVmZtqzOU0E3cjExXASAbEAy5PXAhUEJEcGSr3evMGe+95F
	 euaaaoiC9GoJBzlbOjFHtxu9+7/1+BTUKp8VdCdd/P/tyLWowczkqzJF3fvZ4P7D+5
	 bOcxNc1uzZ4nCHXg9WD3rC9a31gJlkcoPNlQhhivae4teN3mC9Qi29Z0QbyY1UdET/
	 Hw0LfSkAYLvDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B377C41616; Thu,  2 Apr 2026 11:08:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Date: Thu, 02 Apr 2026 11:08:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: i+kernel.org@schimpf.link
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221309-62941-4ujIdg5ydK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221309-62941@https.bugzilla.kernel.org/>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221309

--- Comment #2 from i+kernel.org@schimpf.link ---
Yes, absolutely OK. If I can help diagnose this further I'll gladly help. I=
t's
not easy for me to debug this by myself.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
