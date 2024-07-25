Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54C78289
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940562; cv=none; b=MmGEalgEF0zm2ju99EZ/7I/4JDI3mP0iKJ4WPwOOoXM3SvvNwVg619fEzupdXKiFaL/qZLy2cnxneIuH2ViKpwy1gpwmTUSv0WJRugAuIeASR44SMyA/tY9Bgd/qXdGEIq+wKA0AX14Hb0lF/5UJBD12iJTr5yCUphtIVNQ3Wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940562; c=relaxed/simple;
	bh=k0+4LNv3hnsgmiTfa3sMvb42nLwdGLvu9T2mlTgnnfs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJuBjUHeN56YthNQ+s4d3kxCBh4lS4XeJ5wRAxG6gdrbA0DlEyCLWO463SDMMr7l0nOIamnKF6VBiVCCYn47/negl9DM9q0oWS1Mrxkzd4cHQnyt3YsbGVTfjarOHYwZ6nP1VyyeG/i8HHtFGcSakDkQ9fXqZdaiZOadnvMlFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi2bHIta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi2bHIta"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E61CC4AF0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940562;
	bh=k0+4LNv3hnsgmiTfa3sMvb42nLwdGLvu9T2mlTgnnfs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fi2bHItaiB1EuCodO1qflsC6QvZ76kWxoAvnngGF+REbr1dcDaCdWNLw64fEOtJjG
	 5pq5iUnVPFXTiVfHyqHTvFG+t1sfWBFXLilbxQo5XGeTXSoFgv7CfvPr0ORBB0f/Hb
	 eid3IN+yC+BzKXG8D73r0mMzy77xHoS/1leAJ2tj+yWFUQ9JitIchm+nmZV0Zmcqk9
	 9mA/ysoToFZuQARfhvj6x+rwD5KNm9keOOEp6x7TfZDduBjxeXFLIzOze81906srDt
	 c46PeiJWl81WdXgVPTVyVB7C31YK0I86wiICtvk+SsmspbQ/tPxSXuUdLdBniZzy0/
	 t8VSkl9a+MhhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06E1DC53BB7; Thu, 25 Jul 2024 20:49:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 20:49:21 +0000
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
Message-ID: <bug-219088-62941-BaWD1papLu@https.bugzilla.kernel.org/>
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

--- Comment #7 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
(In reply to Luiz Von Dentz from comment #6)
> I wasn't able to reproduce with current bluetooth-next:

I now have two machines with this issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
