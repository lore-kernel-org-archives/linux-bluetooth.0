Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030463C8C53
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760804; cv=none; b=CO+SuVHs2D/uWQFk8UtP4yBt4lUJpRV4mzcPSXGyTolIh1Axh886kK6KN9p+xD9Fmitdw8qKeRFzs978WtsoW21Xa9QxvzhCivLAHQKQi22dLajgoao5ddVQnjh+YeGbDSy50u5ggRrj/bpbLwBcf9MDLbRuo6pz/GAEg5wm2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760804; c=relaxed/simple;
	bh=3RX27N65abs4rG7C3svDFKBcaF4Oq6RwndCYf6wElfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XD1TP+57l+DIHrqJdZSOp5mLDefpkCPdkG7cSR1QFcvNqbZVSm+vqWmA1LWjeFcqa+etQqRPjB5yC9wF63AtQu9EUcaI0EcyVk4xc83CKlcrzun5jBGvZJs1/qGdIC1ufkDZM99RtB6TJ8Hc149HLh2oFpHKu5w0Ij/mu4e0VVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpbo/7Qo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpbo/7Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3581C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778760803;
	bh=3RX27N65abs4rG7C3svDFKBcaF4Oq6RwndCYf6wElfg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hpbo/7Qo2P69w712dvAatVjOh3tHVlw/xZqTIHnYUUA49z1we19a15fM/BLGzmVTg
	 upTSGC98mbTjdvaoXP4WRrX+UD5cJHxVuep6xlOXvNN8el1/swL2u8oGImU7MhBMqQ
	 2ROXOycyzVEEcco5tsxULjuAA4Ut3TkmIz0GXyjqGBYIbTe1F86kQPSdESvwm4mXyk
	 8ZV5tMWcGAC2KKHCYhScLsHJALR1nNcdVLFVoBhlDLsLNiz/48pZ0ASs+HkHo45czK
	 UwJK5LundIuVQmq406GVTSE3CqAu6VDzX9UVibPoMrJnYb5eFHBzXmctWr3x4KtJIJ
	 d0l5s2ppKTzig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 93691C41616; Thu, 14 May 2026 12:13:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] MT7925  7.1 rc does not work, but it works in kernel
 7.0
Date: Thu, 14 May 2026 12:13:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221511-62941-Pe1OMxaDR5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221511-62941@https.bugzilla.kernel.org/>
References: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Please bisect:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
