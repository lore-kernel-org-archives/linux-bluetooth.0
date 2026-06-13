Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333D14AD20
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321055; cv=none; b=SKZZoAiIp/cVATO0eKnBcNt5rJKuc5pW/jPYaXjFL/aIhfspKfYBAeBK1qufFrfKTLnPVw7/VLGJ9bGYdLDrXCr7MuEvtzrnStffe8fEV78pUsYS8K3pwpExITgx6hPCMPvnbkUUbgtZtsLH9wKr37zGEemCnyCsBUV4u7hqW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321055; c=relaxed/simple;
	bh=kKjYJSlyOy1wqRR392XmlVPTRenZf9gZlNQjwI5rreQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjsfYzesFPmLWWb6SRwHzPM2CMmj/f/Hsm5XDS2a9Ew9MMzTgFHCeNhwuBEgSTmxPNsrLz0oM509d3i1UhUj7Aymjdq30dNKr1bHlhL7Hw96mt1/JTzioCrHCcOX7mBETYQxxSMYhCjR4Tm6+IVjHAR8OUdesvgCp/sQy/mRYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqU5yiDF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqU5yiDF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55485C4AF0F
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 03:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781321055;
	bh=kKjYJSlyOy1wqRR392XmlVPTRenZf9gZlNQjwI5rreQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RqU5yiDFnZudzJzhvb9va2wVM+OH60W3+wDSi4SjZNtOf98/cIM4QUQ5NtNE5eRDq
	 SNpAZ2ZQUet1mnOLlxuaGwNyJgyd6ysT6tRP7KoiD+9UQLcZGvK/tOFGjoAcP5ZxXT
	 80BT+PXxKHGJYn6rDtFV4DuuDqz2pMctQB8ILtVeGfPGd9BbQCAwBqCbUetEvCd3WD
	 a6QZ7MpAS0EyPTfyxH3gsbn5LXJp9NqEXCy7OduGvGXNQCuzuwzq8RGzx0I4agyGDc
	 1VI66gcqw4w8yRyvatVsdm/rDjhXg2CYwLbSEeErdfzOGli1R30Vn4ZMHZWibgq230
	 6GglI+rR6n5zQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46DADC41612; Sat, 13 Jun 2026 03:24:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 03:24:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: icechrome@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-snespIpojX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #7 from Dmitry Khromov (icechrome@gmail.com) ---
If memory serves, the MMIO-mapped UART requires
CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy for a port to be picked up by BlueZ. Thi=
s, in
turn, requires CONFIG_SERIAL_DEV_BUS=3Dy, but most desktop distros ship a k=
ernel
with CONFIG_SERIAL_DEV_BUS=3Dm.

Long story short, I was successful in bringing Bluetooth up and running on
Venue 8 Pro back in the day, so try compiling a kernel with the configurati=
on
flags mentioned. No further action should be required -- BlueZ should
automatically pick the port up and attach the HCI.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
