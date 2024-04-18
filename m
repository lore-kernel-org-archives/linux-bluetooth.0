Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12C1E489
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429319; cv=none; b=BOhJWP/NmvzcORXIDwEf6lvXkujcxgb49+EcX7rBj/pfcpR3Ymx6D1+6J1L8zyectVf8lqIrRBiUWoo6vy/UpE+dknxJsXUhn6OMSjE2dXdtbgPdnborCsTDsNDLEtKGHis4tFlHG39M5d195Prygev9ev4IK01eghoR3ldQlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429319; c=relaxed/simple;
	bh=kXhVWDJ9IA0fZxo2lghIOKSy3KdUA8Ns+ly+9F1PCeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPmoSVp+NufDpchc5sqADZdzcdyBCJp9n1U4AGkRrFnjLDD8M6UXufwE4orqxyqMaKmIz2vWgU5VZ02GI7a+/BPbIRHdrgldBHvjMIqTaJak/WllqyJLAYLCSRlJuNpaDxmCnLmiWUMv10J93oK6vpUEYHBFOy+3NpauHjFfsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMtVn9/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMtVn9/H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95E16C116B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713429319;
	bh=kXhVWDJ9IA0fZxo2lghIOKSy3KdUA8Ns+ly+9F1PCeU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lMtVn9/HgEolOY1GXkTj2RgaiYCAT6dGzQcijmAnlQK5WobJ/tLufbRsWLc9HhBao
	 0on3kG290AamsdK1umngrF3LqGzJv+BF4WSX6RZjnUV67WsZGzNkf8i53/0RrO+koH
	 7st+wDTMs2mjKF6yzA+QmbS0AuK27mrA1pof3YaULMJxsKB+Z85XSQGhBvwYWqLIg0
	 5E/tGO4o+dE8egIIq3uysw0C1wuOVr0lxB9NNECK5jXk7DB8QPpcI56w3+O4TVVz7D
	 RY/ZnU14MqcGxjSRa/qC796w946cmaUigRB5K6cfZbfgwwr4ngs/cSG+I1hUS71lLZ
	 RD1sSC2M5234g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 806F8C433DE; Thu, 18 Apr 2024 08:35:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 08:35:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-ooOePDaXxW@https.bugzilla.kernel.org/>
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

--- Comment #42 from Wren Turkal (wt@penguintechs.org) ---
Okay. Let me know if you end up needing anything from me. I really apprecia=
te
your work on getting this fixed...=E8=B0=A2=E8=B0=A2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
