Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC911DFFB
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945221; cv=none; b=RUrYcLStjJ2pDYdIKzb+v/RKq0wsDV2ggCuBZNcuZciFkeE+SlCRbZLYqlcTJgNBxOqJ4z9UYJV2ArkrVZ4suSdqmdQc4EBTmSa0vLcd7RsFkmMELTVfkD32Tt+e3mXCU0ovhzRZp/BOfSMq/+OwkRhnlbnz1tkmgLqGZUvGijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945221; c=relaxed/simple;
	bh=IjgHwRs9t9+K5Bbxa6vPisF3NIOasBvqzS1hgVQ0fTQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EpQQQQ/XReKXtVF+QwmkAOtc4fLiE7Q9wvR8KHQIazx0fc9WfnoAPeCkS6n90pyf7u2Xn+94/jXPT53s8KKW9DCeXzja6hzLCxurTclV1uBiMSUQ908cos5kEoJHtfXUxZwmOOiTtA5WKHJy79GX7ZMND3wOzfuh1zB5fcYV8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKvGGhsx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKvGGhsx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A3C4C4CED1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731945221;
	bh=IjgHwRs9t9+K5Bbxa6vPisF3NIOasBvqzS1hgVQ0fTQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qKvGGhsx+M8nm6bfet3fX2vi+Ai3oGvwD8uaYum+RpQdZMQa1OBXZ8h6qJ3HfY53I
	 A5qMTIYrxLrEA5zNX4SrVGMYY4bdFaGchKtY8Syi1nQzT95ni43gFPm0Rpyb+O+rZc
	 AUCaFlCQGI10fEKKZX88zIONEZJ+ywz6tf/dx0MeMoEQCxYRsMx4XF4TO9gSb/9ITX
	 PVFdu0E3UOf86BOS1Zj6WlOaF44xhYnUuBdLxMmg2054GYoXpWTLMpzk367oMJ3Fm4
	 pxyO3VnygTt6ygeIpx6Fjy4frnEe15AQiUZ7gTMnGjJLOyCD2Vodcw7qvF8prXkqYj
	 KEG+XZH6XHnvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 51E0ACAB785; Mon, 18 Nov 2024 15:53:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Mon, 18 Nov 2024 15:53:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219458-62941-wrVQUDogGx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #12 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
Of course 6.6.62 not 6.6.621.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
