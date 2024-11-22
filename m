Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B7175A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317516; cv=none; b=o+Vw4rIyiwZMCGdxSW2q+wQKavZ2qabUCiBnWnezJvx2L8NdULJWPq57mlIaVxhVBdYPM5KVfjWTkLejXbwPjtrcBOwxPHWGJcPmu2mklfvW8MgDED2oGvQnERfZcOCLNicuR/Pc0pP7qhQwY6FtnBh23cePI21DGGWH5i7Genw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317516; c=relaxed/simple;
	bh=tjJxzz8Gfg4z9W5nTwaJTXgvIcc5UN1N5OUJuFXAK6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3epzfhZmrHGvW/BYBd6XbmJMhNixlQZK1UA+YTHTnfqO/KzbmZH1XI7G6MTFyfnplzypvaLnIWSgyN79mMrbMSFSH1YOlKZ0KWPa5ulp46IWfzcL1+XBM49jg8cFBZIZynhUxL24BsDNt7CChmtmc5jSDGWuePTydjaAqHXUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk8EmBlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk8EmBlh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF929C4CECE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732317515;
	bh=tjJxzz8Gfg4z9W5nTwaJTXgvIcc5UN1N5OUJuFXAK6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xk8EmBlhU0RMA2RpUAEO8eB6gaooMEtse2ZKnGCV8oOIQ/klPX7is1H03XkvwcsJy
	 H4gZWFwtHiqoDL6q7y3sEHzgvpP09WOpycUy70EUHKn6ZssPthE6GKtU8a0MoVKwac
	 kzdZ5OZnUNOJamFrCeYQFruQmKM0bduao3n3bBaVg/9MqTY/NUdwv4zO3mcjUoK4lA
	 ReAJXPZj4V5ynJyotpJazawOYXr/enKbjpqOII46haa8QYtsjgcuJIIZLvHViIoyCO
	 LnZqhZRnP017KXx9En83PpnPOI8IScvQh4qmzOpwDuIyxrGZMvdTPqK0W0s+Gd0nwp
	 kA6419k/fbtuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6536C53BC5; Fri, 22 Nov 2024 23:18:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219519] Hibernation Failure on 6.11+ due to btusb
Date: Fri, 22 Nov 2024 23:18:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkml@antheas.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219519-62941-5UtMeRxZ6r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219519-62941@https.bugzilla.kernel.org/>
References: <bug-219519-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219519

--- Comment #3 from Antheas Kapenekakis (lkml@antheas.dev) ---
Reverting commits ceac1cb0259de682d78f5c784ef8e0b13022e9d9 and
d09009bc80d9d0d812b988888c40cd86e52eaf1e seems to fix the issue (later is
required to revert former).

I will do more testing later. I tried to look through the patch to see what
could be causing it but I cannot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
