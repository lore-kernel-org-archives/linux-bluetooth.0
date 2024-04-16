Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2C15A48B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254910; cv=none; b=BD+f10WLGaxtb9scg1HnPPdGsNXxa0sIZWpDdWMxbyE8O2mM60RC1ovrcsHR0EvKRO0f4z8pKIrl1vxQGopvQMbtgQvlPPN8SUOunNXTicR1q3ayutFBfZpraAFzc0x3t/TP3tL6sqSaeZqi4nf+un/4qygvY+2MQ6vxnIg3mVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254910; c=relaxed/simple;
	bh=E2zIiT9du6LA9b+olwX489gADkqaJfisLeBRlNh+lVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIbYoLAncGdRaRxa4YFI2WlyS56G3rlc/7kQjyRpLZYpCNVX6F5eiENfcVXtOoD00wdfEsNVtswHk1yvXiSbEKg7fd6thtiiXfcKDqr/DF1uHGG8WWJGIX+ShJm71Y9x2ATTF9vNMWk38fomIyOznuU/XrcUP+fNwuZJ+SPd9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM3pgEZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM3pgEZg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CA0CC2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254909;
	bh=E2zIiT9du6LA9b+olwX489gADkqaJfisLeBRlNh+lVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KM3pgEZg4M4vgS5Fjs4ibITTg9gBl1j86ian9Tl0g+F7JhMsSRXFBbZ/Kh7eePzhe
	 7UBEIo/qIZY39U7ms9Q64l6b5VCJItC4J82ZshtFMfGsNsSkD93LmHzQMXayoTPwF+
	 aBn1/aqORwYZgppusxb4gVCuhqKcYxXbu6Tc/pnqxfCdYwfzBs69hrI0XRVJbs2cYu
	 ePBq6hni05wLdJo+YjmTWIPPJBUX1Pfb4tCfl18675mhT1KQjmx5cNwHVds+fcVAKS
	 yvKwdwPQU93YaUKhN6TssRQpOqyQEVXzWtpVCWZV/SCL2d5u5Jqn73NDh4CWLPsqBy
	 F2hQVM0YZhkPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78D91C433E2; Tue, 16 Apr 2024 08:08:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 08:08:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-iEWoBJR0ty@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #17 from Zijun Hu (quic_zijuhu@quicinc.com) ---
it is great.thank you.
not sure if other cases will trigger this feature.

I think this regression issue is related to below two fixes. will sumbmit
formal patches to fix it when have spare time.

// it will cause disable/enable failure.
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
gpiod_get_optional()")

// it maybe cause BT enable failure after reboot.
Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev")

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
