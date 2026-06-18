Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6B1F7575
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818488; cv=none; b=PdKj4DP+x3gFplkOAevyKz/hLqL9s35Y+0O21QgdYF3WIK//kMS7PP6+g98olmi0dnW96XJ3Jfe8zXmAgcy2DRQaj+2HwNtPYeluPJ8qLtdwOwFIA5n54yt0wojb78sE2vLzMA2OPb8NjHHcqpK2wo29CIQHInUkxGW8i7nuXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818488; c=relaxed/simple;
	bh=10bIv/nQreQiISca0ezaZb513GF7XDm5+bD016nRNKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihmMZWls+AIisTT6M/6g3Y2J0eeKRa96aX2aPVjjS2HYDeLTZOaHR8RI7P9rQEOlF8ZrE8fLQwkt6HBbxdgqjAEoF0z+qzKaOCpAsmG1UxjVUGdkz4v1kCgAs4Oao//HJmva2jt0sQOXgug9FOU5ltUl6UPwLl7BG8CXo5fKzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgh7YJKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgh7YJKU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 601C0C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781818488;
	bh=10bIv/nQreQiISca0ezaZb513GF7XDm5+bD016nRNKg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hgh7YJKUVB+JqI2zui7FIfLY+Rge0giYqpZEZOs1jeySI4HlQK/pVMYekPDGTj5Cu
	 Jy23m3RC7k3TxqbqcA99nAxXsGdmFTE+2IePWGBn1H7kEGVrBInXGdFrxtBhg984bo
	 UioEvpmKvJPFtqS19M5wcJgmodBLd6Ndo0BrvOrFZ2rPtSU/u8+tVUSZVuVTaODO/l
	 i+lTR2nQYsiAUoBEIaBnfQNmUvtTNZzxLLbn/Ld3wUyi1m8yfVyy8Izlm7aN46jOdq
	 KBTrRUvFjsuMhgg2rtS0pdpiJ8hMt/ZqdbstACtWF2vlSDp1XdGKNAucyHnufECrrp
	 EnyXJPOI5dCHA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48266C4160E; Thu, 18 Jun 2026 21:34:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221660] btmtk (MT7921K / RZ608): BR/EDR outgoing connection
 always fails with Page Timeout (0x04); scan/receive works, same device pairs
 fine on Windows
Date: Thu, 18 Jun 2026 21:34:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bynxmusic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221660-62941-E49s1hV4Z2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221660-62941@https.bugzilla.kernel.org/>
References: <bug-221660-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221660

--- Comment #2 from Zach (bynxmusic@gmail.com) ---
I've had this motherboard for a few years, and I've never successfully gott=
en
the bluetooth driver to work, even on older kernel versions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
