Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D341DE06
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863547; cv=none; b=dUNWDYf/Kp/AGXpGF0DfqmIZ+GZRWUGCS4GGHmKkCvA2tHgaEihZ7l9x0v340Ah0zNmyXDksI980n/tddDlm5LIwlm2mN/T4scMnLfnnguzDddYOuJRh/DiWTTdF/TJ8hy8zbMuUFacVoBb94zhphq4N4sSHxgNQ+uHHXYgplYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863547; c=relaxed/simple;
	bh=Czeaq50hgG45GFmnTkX1rm4VwVU1EPwLr5xvyM4KvIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aqg6UBS02+WGmr0eE6bA2vrPRz5GbtJRil/fhxcJ/dVtjE3cHOy+t9ck6SvspHr0jCWuccwRH33o9PX1vFxLj7nG1NG2Tc9ad+GRg/WtDVP7VohkUlTmJEXBLRGHxwCXpynXXDmiT8J9Xc0xJkK0Kpvh0EZKiP5bnr67wLiNLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvXKtMVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvXKtMVW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B521C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785863547;
	bh=Czeaq50hgG45GFmnTkX1rm4VwVU1EPwLr5xvyM4KvIY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YvXKtMVWBZ4PAQX8qOXTGC0/cUQoMu3ZrA486bnPmQj6g7WrRb6JuzdCtjhUQ0Yc/
	 GVjun1Tf3LbZhZMzd9/L9rZwaP3yQlhI3djjvz3F5FScLlMVkoqwVL/F0dd9IBT3UD
	 7/dTsnmBoJvR8fRwokZ7vn6bx0i3+/gfsD+N6YOa1Szy8R3FBrDp4ztZYfyoOtx4MH
	 2TzcmjQOJI5X7jvYHvSJzw2xnWG3onfdzgjb9ijRqV9GSGJVpPuIwrXXJs42K9W4T6
	 P801mr0paVf0Xf6BsfgJXv22ZTZB4GovBMjmHH/m7WNl1A5mmoSts6RPvsO/Hl6Wp0
	 y384nh6t03zzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 15160C3279F; Tue,  4 Aug 2026 17:12:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 17:12:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-spDrBoVnvr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #3 from IQ (lnxps@bbtex.net) ---
on the QCNFA765 2230/E card BT worked (it is supposed to be USB attached) b=
ut
Wifi didn't (could not init the Wifi card).=20

I was thinking maybe there are no USB pins routed to the M.2/E slot on Asus
Vivobook S16, however QCNFA765 has USB BT, unless this is something propiet=
ary?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
