Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159992B2D7
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176533; cv=none; b=PllS36fExM3O4JO3QRJAbdC3/pJpG1HVgFwGC1fEIao8Evw4abV4qwYzTDIVAA4VGSrNyZ2nMUJsUbkamEf8scvTQgU1GIpou8AhAuDhQpv249qcaN7AxP7Isenk2iSNcETIY20nMIinavoYOn0ipRixOqgfWBUASBMChdAQBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176533; c=relaxed/simple;
	bh=GCvPP7X6Xg0gNGQyw/nw6t/nMJlKgkM0yv8qQE+uedU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5yApb9IOUksQTCsLauz05L+WpUbvXUqzzfEL9vFUexcwURXUKPABg147xbPeXgd2X9P8XoS5NUl0Yrp06cXmpsb8T/aTD+QYDzUWIkcA1h+4NSSiLQcAp91izhobP7Gby1Ge9lXWp3J7AEbvUFVU1okVy39JJ1sZG86vsK349s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXOwXZGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXOwXZGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD741C19425
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783176532;
	bh=GCvPP7X6Xg0gNGQyw/nw6t/nMJlKgkM0yv8qQE+uedU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BXOwXZGQBj0f4+zO71nHU5Brm2loCO86DnnZ20zXCf6oiRoRiEwQzo9B7BmQei0Y/
	 QuqJi39vf8+d3ZztQeGIgbETCNMlbTO4N3k5brRo8mUMG7X8ELpq8jBdQ1F/+k/Pbs
	 CrNvcSwZQDk4Ikm8FUf5XXdn50nR/kU+VOYJ/vbZf0P0zUYY6A4H2G81+wz3vyQc5P
	 NSq0Ix4JCtRsGvsb4L961LooJCZw3NFnzxn6VdpMSWQ+ayxgWwRIJTzyVdMBSqAXpt
	 wPcy8flaDhRkAgNqyYxnxKvEOCO6tG0PUs+y9p+9Y0jBcp5bm3qRfUl7lrwS9xWoQJ
	 L9boXjn66kRqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3C49C433E1; Sat,  4 Jul 2026 14:48:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221627] MT7925E - System locks up with flashing caps lock
Date: Sat, 04 Jul 2026 14:48:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tom@helix.me.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221627-62941-CuMUcMID0l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221627-62941@https.bugzilla.kernel.org/>
References: <bug-221627-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221627

--- Comment #1 from Thomas (tom@helix.me.uk) ---
It's caused by switching between AP's with the same 6GHz wifi name.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
