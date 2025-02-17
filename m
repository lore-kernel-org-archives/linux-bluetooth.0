Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C82248B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806053; cv=none; b=jELsVj1VHIJN/dqleLoPLbjdSgIta1EIenv+6tAnOf4KCc4qu0ItJuUie5SlsDLnEh6JxlnVxCVO6x2TTgE2A2FjiZb5IEcSThhGu1vYj6Ws0LFI6oirUZ3GJclJKwX5aDtphpIwDCNIZ5pxZBKL6VMN3q0sPZp7zwnOJUlX6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806053; c=relaxed/simple;
	bh=SZfiQYlhdIZgnVs6a3w+vY9qgxS7YBLs16XJBoHG+Io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syRATAuD8tP9+trLrZ6NAVPalmacR8joc2S6XcVGM3pM547LfWMf8vG3Z6uk6zzfPLI7H0SZp8FQDNtZyxwNtVsXNEEw5zaEa6i48GW5a2fB+se5219RYf5cXGrK6410a1Oal6VRkuaZFGpa3iL52u3/R+qoIXvG89YYU8E/1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7P5Qnpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7P5Qnpg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21502C4CEEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739806053;
	bh=SZfiQYlhdIZgnVs6a3w+vY9qgxS7YBLs16XJBoHG+Io=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V7P5QnpgXhw9KVnZcW5dXvdxAOVen8Wov3hSfIGcYBRmJ5a5edqeQzkFuHnucLDHs
	 TWDK7+x5k33RVBYXYpUpM6rR9QxZejPP4YsNvuRr/Co+wlSsnfMen4ClSNlaM7dbZ7
	 3mywBP5+CBxOcUoeGvCJQExHKTo+ukB1YzVxMQs/VI2cebsuFBfKaXck/f7FA88mmf
	 2UwpUe9ATogrKrkaBS/anrbCv/3bSicKqgI24FDt/Yeb6yWua2qTGVkcku8joFgSHD
	 Lk5Q4E4A5f7+jthmbJjcMqSzL4qXB4+FMG1oSkVqXn9NsJe9sNO5U/GMBnh/v0s4xH
	 Lmh5pE3zMsH4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C11AC41606; Mon, 17 Feb 2025 15:27:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 17 Feb 2025 15:27:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaromir.obr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-adCq1PKnhQ@https.bugzilla.kernel.org/>
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

--- Comment #18 from jaromir.obr@gmail.com ---
> The workaround with the service containing "rfkill block bluetooth" works=
 for
> me, thanks.
Actually I needed to use "rfkill block all"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
