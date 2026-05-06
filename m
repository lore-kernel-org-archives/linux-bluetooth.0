Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C2239085
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033529; cv=none; b=skWqreRNesIM1pYD3kUUkuN0qp7V1zeIHUVbA89cWaOENtndetW0TS4O0amy0plB7E9NhuJugm/aOGn1nGEwAoWya9FeDBw5+lq8DgVcyW6meG4Kkxq/6qF7PUE76a+y9Ykw0D8Fm7WnLN7N/V+6gvbrxOjq0x7YacrcbEWLWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033529; c=relaxed/simple;
	bh=SP0bPjt2pDDSf5rwRs5QRFDsl8qC1aT2Gj3UETJW3YI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tL/vEBxRQPizurIqkM0ZxLMO8HC+7IkaXcYsldFxWsD5+O5rp1WNtFNti3iQbEpPemIXqAQFYRD40OZy0D/8lYCtb1/U5n1Qq0vuMx0dXDDvVkrcuhzOf72JFyvhB6gfc4ZR66/I30IVfJSjTuFgI0cQqpV/SYwS2vo9sYzZsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owJrV2ew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owJrV2ew"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02835C2BCB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 02:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778033529;
	bh=SP0bPjt2pDDSf5rwRs5QRFDsl8qC1aT2Gj3UETJW3YI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=owJrV2ewZAQ/9xkdBs00tfZcYOsRVVqd3ncTUCH9aLrItBkFGW7bmgaTelCT2wTk9
	 21nlM+6U1jaBn71sDWS/Hgbg8adFz/JPjBvoho/nkIpdaWrRgAuxTwCfDNJOFePls0
	 XzOMfthZxBPINKe7qtrHkhMdeRskIVa3OVlU4c693iV7PP7H15nkoPcC71J5J2x72z
	 RdCALN+dwH78STebOKdfN1Tn43hzlD4aEvCGksI2oQV9dQ++z4WS6ZwKMTe7YdE/pB
	 zFfCKoK9FCsmGpqPv9Aor2tHwEeptiAIdwfRToBswKHY/bDmvHFTt4GH6MS2qhJCN8
	 WsHJs8TFJ+Kpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E5052C4160E; Wed,  6 May 2026 02:12:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] Wireless gamepad stopped working through Bluetooth
Date: Wed, 06 May 2026 02:12:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arvin.ignaci@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221449-62941-WnKEgcw6wC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221449-62941@https.bugzilla.kernel.org/>
References: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

--- Comment #3 from Arvin Ignaci (arvin.ignaci@gmail.com) ---
Wow, didn't realize the kernel moved that fast. I'm on the latest version of
Fedora, which I thought was a pretty up-to-date distro, and 6.19 seems to be
the only version available in the repos. Looks like I'll have to figure out=
 how
to install from source on Silverblue...

What's a good way to isolate the kernel as the issue? Install and reboot wi=
th
an older and newer version and test the behavior under each, or is there a
better way?

(Sorry if these are really basic questions; I haven't really done any kernel
development before.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
