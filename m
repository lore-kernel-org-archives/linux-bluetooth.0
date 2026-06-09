Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED53EB114
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027905; cv=none; b=HZoZ8ZtN1Ue2QWLCG6IA+oTw2IsCgPIrpO7esddh+yQQeNjayRj9ORko6M9zcd1Ls7wRnMcGssYzZlLsV/ejf0Y8+ceXJZUlwwXeo8bBo6GITzri+w1lS5Extr5r8ldHb/fUtDn143xyMex+P3JXSgwjumTh0kZrEDTuKl41DrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027905; c=relaxed/simple;
	bh=L/52Y43HY/wWRJkpq1fdv3EwRM+OwKyDKugxq65LLFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dO8bpYeygWXPktT7xgBy5oluvGJHTovHma/VAy6mANGLVAOyzxjWxUivuFK7ooEfPqw2vVXf75o8p217vJ1VKPdwMKCqQmdpojmexai+AAcgkWhgR7kP9wUunw8AFlkEBiSz6TZfzvN1B4IKSUfllleB9Jp5Twf1n08geBEFYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvEoF8A5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvEoF8A5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16877C4AF10
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781027905;
	bh=L/52Y43HY/wWRJkpq1fdv3EwRM+OwKyDKugxq65LLFc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WvEoF8A5GMwjOMxsoiF9WW+aoNdf+wGpEJcQHkQrvYBiUUY45t0BUpXHIByl4Ga2i
	 B3BlAkCKH551ZRTaX4ywZWXlu/JYwSHS7lQrzKSbYG9SxHx6WiK9f1Hr1WS2YywoFA
	 Esz/uZPIc3lrLLPGVvNJ3qlHMKqBHmAancJRawNj2MvFCTSOivLoPy1FIO99jOXR5B
	 0YgoeG/2z+IrWSQm5XIeoBXTzObbGZdO07CPdWMGORmVthfvn2u3nXlHUdDXXPwQir
	 Ii8Jp/wNXkcOC2OM3vh1Rf29ZI4+IIcqg3jTRSoSjS+uZweFfoI4Z8w2ExbvTTTaDO
	 Uke7uY+Z/yJmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0EB73C53BC5; Tue,  9 Jun 2026 17:58:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221629] Bluetooth l2cap: ident leak in
 l2cap_chan_le_send_credits() stalls BLE CoC
Date: Tue, 09 Jun 2026 17:58:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: florian-evers@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: see_also
Message-ID: <bug-221629-62941-eNVkKjZyfV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221629-62941@https.bugzilla.kernel.org/>
References: <bug-221629-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221629

Florian Evers (florian-evers@gmx.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           See Also|                            |https://bugzilla.kernel.org
                   |                            |/show_bug.cgi?id=3D221592

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
