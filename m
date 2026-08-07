Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750302EEE9E
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099163; cv=none; b=JDfaoomHRt4/WiGeWVnqKHGM6XsuxQq7dNPvK7gry2RPcI9QOlauKVz+QgpYujcVNDKrzaKAGbMSceoYDz2TBXkvBeYl+qaA6/YNd/CLYkeMZFmbLrJzqMxSMHSISXoJDS6XrnJ9kLRa7NPaMoQ9TQEBeDFhLfvLAzytAUhmcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099163; c=relaxed/simple;
	bh=OWUZJOr9JiSwGYCnaHJReOiuhANdgfuk7hAtcprbV5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSQDmePRlC9Rfkl27LKOdK00qReTCXGK6yNcd3WgTsLVmJeY01SGuL89TjWPyLZcu6svMwwVW57M7nHBLcB1OM2qlVWdx7tmayn099GAET4B7Zz97tbsJFiCYrEpCZWeu+Q+tBp+5ghMfeNkAfX5k0TYPZy6osFBmYo3jV4AoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/MkMmTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/MkMmTo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1471FC19425
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786099163;
	bh=OWUZJOr9JiSwGYCnaHJReOiuhANdgfuk7hAtcprbV5A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I/MkMmToKqGP47d6dXbIvz0BPIJdF6QoQVpuREB44FX/gkZNw3CZjjOGRPODS3JJK
	 +AIz52c6/gP567QM1VhOlHljXQf+w35WSCGyvOYy0Fr9glOtMvP9pdWx/bGV31PihD
	 gVciRI1OlbbBFazTbiUAD1/IGCB0eUFo8YHPXiyoIFv1Tpxkdr2qMZD/oQh8PSiMoL
	 8Xg9Jsm3Vcw226VHGbAFuQZBQZlr/Or3W4cjyVfru8QXPy/KbSvCnKC3FY9CbzwweU
	 5YXoCs6NYfNfVsWgbqwXAr/7rhY243hZi15vGDvkdJXdDzKlKKLXasSQ16TLugEO9q
	 j9m2SR8N581HA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EBCCBC53BBF; Fri,  7 Aug 2026 10:39:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221837] Bluetooth (RTL8852BU, 0bda:b853) never initializes. 
 Opcode 0xfcf0
Date: Fri, 07 Aug 2026 10:39:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221837-62941-y8qzyJzoWQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221837-62941@https.bugzilla.kernel.org/>
References: <bug-221837-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221837

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Your last log indiciates that your BT adapater is fully functional.

What's the output of `sudo bluetoothctl show` ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
