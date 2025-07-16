Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663B293C5D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653814; cv=none; b=C6DKp5bm4Ez48WI0nSSaqNjT9s8f9xjFOYQfUCiIGKULyBFyWaEke0SA8ReXPW816w8TQlMCy5fOJTIOhp3kQfYZ040GGVmNuQaXuiyEcGI3GQTRv0wvzyUTeiFeGZHlktSscZwj/A0kYYBIq59jTK8t+YbZB5FBv0tv1jfubpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653814; c=relaxed/simple;
	bh=BrTQbswg7Eql9Ce1oFJl1eH68MSq8IIO6Kh/7SYuatI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7xUWpjXXAikgm9DLptjC5QvyrvGF54Nk5NfXtgbEmF2k/4CNaEsh7qSnQ6GyvtmUa1kouKmQ7w7/Fy1/stkI2sWR3DdCyZuCxOIz7iJj9d7T+mOrhy5csqmSmHKs3hzMyrEg6hzGXWa6b0vKYsfTToq8smDH3xli2OC8jBzYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPyqXqc1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPyqXqc1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB582C4CEF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752653813;
	bh=BrTQbswg7Eql9Ce1oFJl1eH68MSq8IIO6Kh/7SYuatI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lPyqXqc1ejxnUxb8uT8dHewk0zWFQ+xFIBPVvi7kMIqk+/a0eVKSj4hlQlHHzZtx/
	 MWF/DLNt7L9d89GJMZzpGyistHD9RxGbDS3NbzLGClLUV1QIQJ/MZ5tafH+j/XOjv6
	 DiV7VlCs0S55F9hGU7nWTgRELMnjMJdklzewFMVrjyBOuAybWrwBExL9BxXcyaMwgU
	 I3jRiAfq2D58ioGlYVAZaSvyr1kOHb22SLEt00gpmpK+DFJORMiLVTJLW3ET0RA8z2
	 cgLlsNhl00RxU4nJuZB5ypb2kJC3Yb3piTdpceaXrSpYHeL6moG/cXqKeTDGPwaz3Z
	 1lXNCBsslk9xQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9514DC3279F; Wed, 16 Jul 2025 08:16:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 08:16:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-jT8WrG8iiY@https.bugzilla.kernel.org/>
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

--- Comment #7 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
If needed, I don't have the hardware anymore but I still have a backup (dd
copy) of lvm drives which hold /usr + /var and /home + /
So maybe I can recover some datas from the issue if it help

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
