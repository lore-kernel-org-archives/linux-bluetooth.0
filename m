Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C9446B2
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEP2dLoo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A744C433C8
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824846;
	bh=j3lrumldoAf2q3wTr318zekJQZ+xd3X10jy9ERqnyr8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rEP2dLooTrk50phhyBrJlf5lAbIcggt3NBTRwnBpbCZ8YrU8XT8H5bXz9LhTnGq0Y
	 c+w4hTh9HQXhCXEV5/IesVQgQ6yCEJMmqKyHwQaLCorBkvLDwjovDcZJEOKqX5cAcG
	 I1B2QuY+8wefGybbxOdgg1GAJcmlmRuStDWrxR8X4PHBq79aTuUBueck7lFjygDemC
	 mmefUBhgGislarbQqm+Yshn2Wmxko47hZqm44vXzk9jobQrlp88xaD5qBPRcLd6U82
	 EZ1ix0MLom/l75uVcUGCDWDoRpErdZg2ZbOSa4X3cUl1xmXz8Ydw/L9R6i/9OaujSb
	 YMjm49fMO/8dw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5B1C1C4332E; Sun, 17 Dec 2023 14:54:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Sun, 17 Dec 2023 14:54:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218264-62941-9hxmSLkVGE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

--- Comment #2 from Marco (marco.rodolfi@tuta.io) ---
tested now with a live usb with 6.4.15 + bluez 5.69 and it works perfectly
fine, I'll try to find a live usb with 6.5 and test again. To me it seems m=
ore
and more a kernel regression now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
