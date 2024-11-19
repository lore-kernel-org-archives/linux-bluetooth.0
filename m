Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A01D79BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045511; cv=none; b=TVCAeSe9rElJ5M+oGaEfv4itMto0tFql3X9rklfpoTeD3MwoEkXFKYPzNwnXZSTtJAXDgVirK1NnPpxj1MIEq+MqRovP2F2t+OEKg7S4a/EbFHT9YrBwwVtZ79/KYu0HoLss+JkbFeYP57V+CFSdq4qwFdoB/mTvig6Oug+aa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045511; c=relaxed/simple;
	bh=louD6FGkzIZV1/+nQyIOCbrYcM1iE11+3eDJKFSS4p4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uS0wsQTKsQDwEjWWzZ22QrPKOa+uEAICc6pOC7ZfSG/J0xVfWTLp8WS8cDEketal4lI1OE9mPYcHb+R6FrYCQ3oKU0ArbmQiDM4a0QSh1T7BKMVqgIQV27Jf8E+FZ34G5dA3O/miVqmHqtC0Iclo3ZJwFjFcDLeeW0pJYD/9x98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYcMaE41; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYcMaE41"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAECEC4CECF
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045510;
	bh=louD6FGkzIZV1/+nQyIOCbrYcM1iE11+3eDJKFSS4p4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sYcMaE41rl1KI7qGBP1CfkgULffgF6E/mVvqd09fN0ptd8nJFZBaP0ZdFVTVW6B2o
	 tyhqqg2l6tIXXaBcZ8stANNrkU0JrOwrUXN/GKeqlje2vrDiIA8CFU4Y9wIN2uqiXL
	 r3SVXFTGCsFHv4VwZC6bg/pwGCOKeDhI+Sr+zSnoj1mj9O0HqTdbgitSZudBrR/nd4
	 OjB6BaR8/97Rvlx9Fv4F/ofNta/o5J2GKAXZyc8sSXy7YFuOfcWGTo+5eGIMxCNncG
	 wdw9LNRRX3X3Cho9+wgI9yMweRp6S7mVbVewkN3Ar6u4e3rMGKo8BTKTfDdFkcaGML
	 ZStYk3MZ/68Yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3982C53BBF; Tue, 19 Nov 2024 19:45:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Tue, 19 Nov 2024 19:45:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: h@realh.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219514-62941-UFMh3drJhJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #1 from Tony Houghton (h@realh.co.uk) ---
Created attachment 307247
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307247&action=3Dedit
dmesg shortly after booting, then successfully suspending and resuming with=
 the
"good" kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
