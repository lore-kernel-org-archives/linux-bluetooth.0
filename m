Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0624A06D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639648; cv=none; b=Cmw6rVE5VhNU876xR3xDDGaxBrbkCO8C7scrFC6YG4HHnf8DJOnd8xWuc6cjfEKgFNSaoisOvBUkzSJFs27syJ+cOuKrNqsN9vum3fDmxd2MrtXMO+L8nPZNOc8R5Re/yxNNX7Xj3KDgH7Cq3NuGQH21Rp94RFxTswrcG2e7SjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639648; c=relaxed/simple;
	bh=sY9tVUyfsEu/GDXg5BiC0/pVJC8R8XZh1z5m5YnTX2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcKQbANtaFTMiCmgBeL7Z5XxcGHAZ8jqnMUUdhW2BbdUUpPaFKdYz80ndIBAbqunUyF+eA8bsmKCU8fl3ArZsdLyXNr4voJeumEO7YhsANnWECCOv9xV9xdlbj8CmU4uRFY0U2uZ+eN90tq2NcnBefSjy3BIF9LShpSV1oL+vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abeFBb1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abeFBb1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77039C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787639648;
	bh=sY9tVUyfsEu/GDXg5BiC0/pVJC8R8XZh1z5m5YnTX2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=abeFBb1QKoxh7XIKptpwEHBqgt7C8dDso99BsLnEUIr1WRUOVH6zv3nvzBp1j7oHR
	 Vd78OcKASxnp2yhHqxDOHdUiCJixOVbGa37+Igi4xaKeH4Z//P6AGBHz3Zkd3r0dAk
	 vl/gO5E2dWNmEv5e55Kob2zLK/W3sPnHLvko4FPAztr/3XxkHd7ZCtjKKXtQwBvkPD
	 QmK/zSEgaVucgAG7re44Ogs04PfqRnEt5sTp4t3WSw0LGQNOY2XXpZrcdt3YfGzK8Y
	 KhneRU64pYfby1Pvc48Wwv5RUSPlfuQgzXR48YibbnIU0q0npvDTHATYkz/oYNYBvi
	 skL5uv/oY2+hg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 53E31C41613; Tue, 25 Aug 2026 06:34:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221878] MT7902 Bluetooth USB 0e8d:1ede firmware crashes during
 use; reset fails and controller becomes unresponsive
Date: Tue, 25 Aug 2026 06:34:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maksheev777@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221878-62941-ea3bNvkHiq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221878-62941@https.bugzilla.kernel.org/>
References: <bug-221878-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221878

--- Comment #3 from maksheev777@mail.ru (maksheev777@mail.ru) ---
I tested an older MT7902 Bluetooth firmware continuously for approximately =
one
week (2026-08-18 through 2026-08-25) under normal use, including my usual
Bluetooth devices, without
reproducing the firmware coredump, subsystem-reset failure, USB timeouts, or
controller disappearance.

Working firmware:
 - Build time/version: 20220107141051
 - SHA-256: b720c3883aeaa926fe16930f3f4cddd29a3ecfd0a7c519f0a18efd42423b591e
 - Source: historical community MT7902 firmware blob
 - Current kernel: 7.1.9-arch1-2
 - BlueZ: 5.87-2

Failing official firmware:
 - Build time/version: 20250826211444
 - SHA-256: 4f53b5e02fbd933172e18caf952bda410a877eaad00561781528cb4aff58dc38

The official blob is identical in Arch linux-firmware-mediatek releases
20260309 through 20260810; older official packages do not contain MT7902
Bluetooth firmware. With the official
blob, failure typically occurred within minutes, whereas the 2022 blob has
remained stable for about one week. This strongly suggests a regression or
hardware-variant incompatibility in the
current official MT7902 Bluetooth firmware rather than a general BlueZ fail=
ure.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
