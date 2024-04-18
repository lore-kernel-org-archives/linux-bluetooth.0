Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519A39FDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426273; cv=none; b=fupDSw919Z+mL80OozVfS9vkWpg++eqxpkUyRSTlKGicAawK5iXLgK4Yc9ac4HBqn1JYEqDlg3f5sFJwKrrYUUBIm6EcgYShF7kfzUMc2g3aRGfbmMFjYO/rTwkgGGGvnyq0yposxOX7+qbgp//5+HZ2HSwqwgrOXq5VPvlSpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426273; c=relaxed/simple;
	bh=pNc864rHY6EjIKwwXdLBoNhTDUHQlq0FASi0NVkNlmc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHcyNZKuPeQZ5+90XwDbbtC4U94q0JzjEmwZNWmrpwOUJN4GMbgjMEnjGMWp0N+86auUrDMu/riYh6iNFso7J08GurrsYkjyayI03ZfEqrvJquqg41nT19ABlUjHm0QRApoyWpjOHsfJ6zzjvtyW38OKqKA5bLSUHw7dT5Wx+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keF9JHKX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keF9JHKX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F855C113CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713426273;
	bh=pNc864rHY6EjIKwwXdLBoNhTDUHQlq0FASi0NVkNlmc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=keF9JHKXTufNsJw1l5gGkJnGIiYxWUvWwt4kFGWBagmpY6zrnZAz2zQrNR2Z5c5SY
	 o8gCgUpIdh4UMOgVSgK6qACzpURR0LdYS2uo+F1mtqJA4lQ6xT4k4mfC8Ey8XPnBUB
	 0c7X2UZNDLlnunu6amHvWbhbjZIBcftaHe0+L5rXmNYhw1OqN6DjvF91TYhT8U9TWx
	 qZl5H6sbPM1n4H3LMYYIPQoddg0iyocoDAnEQOX42gUDwv8vbZODqiGF5G9UbdI0Xg
	 h6ABOU0uvaQAzfPX3QgGkfLIFJ2YEQcXdXcqmi1n6ucQ+/Y3NCFB5MEpQb47t5azTu
	 bPhpc3ZGioB3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3025DC433E2; Thu, 18 Apr 2024 07:44:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 07:44:33 +0000
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
Message-ID: <bug-218726-62941-xE1xOioPTp@https.bugzilla.kernel.org/>
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

--- Comment #39 from Zijun Hu (quic_zijuhu@quicinc.com) ---
good news. thank you @Wren Turkal again for co-working to debug this issue.
of course. you can add it.
i also add your Signed-off-by for later updated patche serials for this iss=
ue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
