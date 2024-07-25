Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA438181
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866414; cv=none; b=Dt+sf7Bitu/U9Z2zpbzpweUZYn48KIuednV9LVvlUNHIvIKBwZFLugGyQB9KU+7d3mMjzwzowQPT1g5iLmgDrHQgAZkyZbwGLIMlVnq8LLk2sOcVn7ML6XYEDTVQsHvIukz2DwqfWua64JE4EFSNf1CicjiOzuTDQIfZRLJ/8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866414; c=relaxed/simple;
	bh=ZQfuvbpW7Xl4Dyg27QvrnAQf2cjVEaqtHNZxzcwN+fQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UO6+AFkI8EbO3siJ1w/wCx66pNZHI4NEN2UTdXIeClrpzhLo2tcI6+m62Ijx227dEJz9Ea9YBCYpPowb9UszuYYLWxi6u3abf7b75VKwb0fbshg2FmOrRrmflS5ezGH9X/jV0x0gYJYa1+hzv+L4KguhllnUgAveJUB01dU5xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFgwhgHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFgwhgHT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42456C32781
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721866414;
	bh=ZQfuvbpW7Xl4Dyg27QvrnAQf2cjVEaqtHNZxzcwN+fQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tFgwhgHTSq/sqJ/docpYmiSkTUFgRsjuy4lC/SG9WsIzxEdJcVavovc5VXXcchQkj
	 Xn1EJBrKW6YjXU706IUf+b9lC/vNhyZFR2btOcTvijT/9RrrbMtPKXT4qnSOuSsxIr
	 DHXBUTJSAHNqPPoOI+f1B9rCViYdGLCoIvI0HzMcHOr8EK+L9wZ9mTzJjFBGcrrlPn
	 /yTOrAZjQkEyVdF7/P2GwCie/Bl5ys2oDAPXoEtZtdiTByGd/828zGNVRbNJ50WIho
	 cnjoEr9FVERFDGGpxTH/jFBbSGBSOAQwIs4tGxEhnG7LQmHOTAEagQ6V+prGk2wQhO
	 EUgCXMhVtlL2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2FDEEC53B73; Thu, 25 Jul 2024 00:13:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 00:13:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-4i9qgLGeDy@https.bugzilla.kernel.org/>
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

--- Comment #3 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Converges to 2e2515c1ba384ae44f6bf13dd64b9a0a950798c4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
