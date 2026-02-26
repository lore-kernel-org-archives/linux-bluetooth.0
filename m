Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D00410D1B
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120615; cv=none; b=dB5/Ld50Lq8IVHY4hBMzdv5piJunb7QriZaf9788r1EsGG7qLTnVWNnGN9YsUt6nY7yhdqfTUzWr4TREdK914cvFssw13wXb8KxTToJuHTXSwvHyyH0Y3s4DHEQiyxHYTrA42a7DYrW7FivREnchxqL7/rUToU0JamexwGJn2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120615; c=relaxed/simple;
	bh=SqpZ2zbcO3sDbx4orv8JWgkVjJvoWjX2aec37bjNVE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z995iLotfEI/dvgy+n+xmv3oGSXXKZrnNcEpUO3xdu2mrduHVMBgn94dmlfRU6vnohP/jM0yfJsCSs8lZsdTT+xOayxa7f4mTjXTIdwjpUpKAQfo24dxb+j2pyzomJ+yZ2CBPQN6ith5x+hCF9MyAoWTN2GyywaN1VnVLT2WUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeqcuBse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeqcuBse"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E59AC116C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772120615;
	bh=SqpZ2zbcO3sDbx4orv8JWgkVjJvoWjX2aec37bjNVE8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TeqcuBsetoZ5FKCqUXKXHCJsFUDjGFCaDoDV3tdkXwyJwLUZ8uOS2UqbTBuY14Z7D
	 mkzrXprbL5r5MrKAr9uFoGekK1Anwk8A+BE2h6uygfp/ndWbLOKXoLqzAqSUYX8coU
	 S8ATszHNml8g58Tu66O5R/tKGJx6lNpDAImYlTEzAZ+gr9i1Uw8OcZd1OdIbIBKPQb
	 R6mFhldiHNwCE+BVCtUshtrbzEIrFLedcdlpEmls0Gf79CO6hPhqjbt0X66c/A7XA5
	 kb/o9HU98cpbysQ6nEMjD+4RGrBNIOixyjWsmo7n+Fxg+l7B43q8eYVPVQVQFWiFR2
	 G+uvNjSbks+Fg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4F4F8C41612; Thu, 26 Feb 2026 15:43:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221140] 0000:00:14.7 btintel_pcie ibt-0190-0291 HP Omnibook
 Ultra Flip 14
Date: Thu, 26 Feb 2026 15:43:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: paolo.baruffa@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-221140-62941-NgAYp4eE5T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221140-62941@https.bugzilla.kernel.org/>
References: <bug-221140-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221140

paolo.baruffa@protonmail.com (paolo.baruffa@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|normal                      |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
