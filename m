Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040454BE2
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425725; cv=none; b=cQfB/WQ815aC5qPt6Vb03RhwwWcILmxSoS5f37t8vMLPimVaSyMc1c8T1kuUugN7lMn+x6APpOsgC7x7tnPrv8UqgrLqgpCw05IeN//02Xwp7aInhRkLjfvXzNnjxG6o1J1NJ/4nVVehpDrmZZPxzOnvX5WKNwimd6lZHzMEtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425725; c=relaxed/simple;
	bh=zpzWl/Kmqqva/MkPvZMvUYA6q0oIo2NKvgpET1YUxMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+bmXI7cwo0Rb+wNNeXdwKUJDahZmYcxAP7AvqadM7K7sFQoVLbuDyvgSWNfZaVZRd1DMJi3+Se2HjIPTo2RkkYpJo7kr/siyIPnNfRzX9f+ZyJ0CNWy/PCzKkK3+AhHjg0stU6ra4t1WxpqABWUsXnem6HWla4MF7Iya+61Hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkthBuYs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkthBuYs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DF57C113CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713425725;
	bh=zpzWl/Kmqqva/MkPvZMvUYA6q0oIo2NKvgpET1YUxMs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PkthBuYsYm2J4fQ2jThyxLdPdra8fN86hL0EZKG0z2gNCSJthd3FTaI5ynOtremih
	 BEOYR3RCGuUihdDxTvcI4ghU3a14G9hltJcnv/7+rN30uxsRRJA8iUJUpXMmY5EWPl
	 ABqIz0DIAxr4e4K8DRrXCQ+muqvSSFQWBGUCAhFIHxNcusRCQUDOT8i0zxkGIrDmjl
	 /kXJdNtAxdhrlmflBptG++6N+2viYig8lIeRXO+OKJBmWtaebnxWUiTJVxsH6KfDiw
	 Xv16ZAVurz8Ktdvi0nArnp9liER3mf6NvcBl/6vZzj+uejLic2RnUFMewM+SCkT+h2
	 b3B9r9TeEcPzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 76E12C433DE; Thu, 18 Apr 2024 07:35:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 07:35:25 +0000
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
Message-ID: <bug-218726-62941-MNfbwXMaQK@https.bugzilla.kernel.org/>
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

--- Comment #38 from Wren Turkal (wt@penguintechs.org) ---
Can I add a Signed-off-by footer to the patch somehow?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
