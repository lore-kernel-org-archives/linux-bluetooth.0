Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4A13B58A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626709; cv=none; b=Fs9ujpRAijbCR+nrqrH0n+yPT1KaiomXcf6BEAxZWsRZuAy4NUIXeY+R0Raef37us/fD5CwqjcVvuXkNS32obEzWpfJJJPUyFPSSpIs5upYcy96/FqN6PQMD71a5dGPH5yX+6KY9ehWMgRczJAhNEelELAgIeb6oZT9X++Iv/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626709; c=relaxed/simple;
	bh=D5+FuZrKak9sawr7EgMP0XIAJ7ZtmlNNDfMO5aNKgDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsYbakpXRyiV6dJqaNKAH69uNSAxB9/iIe4zNorEmRqUGQ4r40NUL2mcWl64duoqJdhqeeyPnRVvIyCFY6UIWA22zzH4gPFPw+ykE9RJ7af4GFw5Z93m3OnEFnA1CzNiGflJmbdu8yd4YunGajv+Tg9P84p1wrjNhPXuBgwkRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z//k9GyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z//k9GyE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B11FBC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626708;
	bh=D5+FuZrKak9sawr7EgMP0XIAJ7ZtmlNNDfMO5aNKgDw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z//k9GyE0o+2kFRimlyj6kfaOlilgB5tIagu5LgvGC56ycTwPAgsX3mI+760IlwU6
	 aOCRsCN1E8VtWxaCHpccxanqfuJROnOGIlbaJuV5mxN7FTyyspqnKKq7Kpcin5jXDV
	 8ewdZWG619vvYnT5PobIdYWIOZeELM86I8OB70VwUJiOASsMCM87iNvzTSGMygR79n
	 j0BTORhJZ1e/aPAQfJSpc+6VYTilYqNvW+UpMVrHueNNCkLqyhz8Sti1RkksDVcyYa
	 CRhuhgEceXdBUN6PNwN7qIKsS0+h2/FtbXTpA0cZpCDthLZTy9lm/tj+a3RAG5sXyC
	 CO5rY3WA1Zb7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A38E6C41613; Wed, 16 Jul 2025 00:45:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 00:45:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sameeross1994@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-izjIQuXU3u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #3 from sameer (sameeross1994@gmail.com) ---
Time is there in the title, I missed it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
