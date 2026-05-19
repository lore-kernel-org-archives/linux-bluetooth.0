Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98512FE05B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169727; cv=none; b=lGPzUoO3aCCukDVY5XdRtaDemNq4Q3WkP4nrA6v5LEgEt7t9E+GvMOIB+pe8pqqoNmFQ3Uaxl+wC918jc+Okip2bnMnKo9OxWw99C4S5GMvQB+uGfgulfRAwPTgMt3hmjeApZaxo7iPKeWObIPTRuGIxLCDUMEeSVSi7GpHPXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169727; c=relaxed/simple;
	bh=/W1KOSj/43EByxH4creotTxz28X00NlBKjMZaMacBBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQO67L+sRRitRxmp+Z/4/0gris+lcj3N+FS4K74K9leR8A2wXFTQSSpRkLshAFCtFLpAewfbXpjghybRqMsYOTZfdVxQkGgzLkJXLaBfjr00RHUbf/sS5evVXvAPoKG8pH56fI0etRZa5CvE9KsWakX+U1rWYO6DJTGl/pnOk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4rHgY2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4rHgY2j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43604C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169727;
	bh=/W1KOSj/43EByxH4creotTxz28X00NlBKjMZaMacBBM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h4rHgY2jLcUUBPvqadL41eqiN5yZLyt7II2ux69m21yX+vU/txULXnSFfs7OxPT16
	 IrqRDcaeSX8rgrmV77nbt1h83KsGqgO49opnI30w6BCjTFfGf8ONWgj6dixIBDCzNE
	 fiKE2xOqwhTRoacF8I3tle97tkWmp/vQz4OQXg/HTFEj0d6Kt5qDDXk/xDWA3WTUTa
	 2tUUtn1RJGI84rR2onREoGGJL8ZWJITgz9qxOANXXIIeUs3y0QWy75ojvW3UkIZ2Ld
	 GPUaSSEjSvxynHNozIgNIntDSiRE2OE87wcnMfePsXrA5T5M1JpbKNMfs3eYXRaS4S
	 I1N3vh0hXR+QQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39A44C53BC9; Tue, 19 May 2026 05:48:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Tue, 19 May 2026 05:48:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jirislaby@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-7QnPu2VE3n@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Jiri Slaby (jirislaby@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jirislaby@gmail.com

--- Comment #11 from Jiri Slaby (jirislaby@gmail.com) ---
It's not in linus/master, so cannot be in stable. Once it hits linus' tree,
stable will be poked to pick it up.

Meanwhile backporting to openSUSE.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
