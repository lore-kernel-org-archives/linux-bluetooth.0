Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEC152161
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566192; cv=none; b=S0+/Zl+PAKbSjJhaDkY8kjyJc0GkMag1LmNgAtl2w1ipjnc0m/zqVl/lELutC/5+SLZlFqlF+3jELZNiCSfhJsrGMlqW6JAjOwplosxPNciXtbVSL+kLl+wAXuQR0xbXsJ5tj74pg9bL5mRlrVgARgk6puKK4EhQ9xSXt4Xx3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566192; c=relaxed/simple;
	bh=BPzLDkOBKXSF1PsDll57T2fZHWaxhLZ/X8CAKq4lFM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRs7RiMLMjYtGwYxkNmJovm4aeyqcij1N9v866x3ytHrbyakxIRMKMYgCloA9QP6UjIrhAckhOzpEC5xzx6QhqQPHONZowOlfIY+LFU3xYKemejbFmA5EBINVzQ5FrXtOhN4HMDXFk7Nh048RMoNwNEzv/9pkcxhbtQiVcCmYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHc9qn0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHc9qn0r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B73C43390
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711566192;
	bh=BPzLDkOBKXSF1PsDll57T2fZHWaxhLZ/X8CAKq4lFM8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CHc9qn0rKClC6PSwVoQY3c4BWpHFPrwxEav2wx4q4TlSLSAOgxFZYBRRGaM7C/xcR
	 xSu+/3sYOPuS0sAW0LY8VbEme0lRNkD99v3SWGTh+Xq2nt2HE9oJvu4KS/thMJB4VB
	 DO5mPY4urGTroaZLFEesWdpmylVM8vxh6k0RrUZ1E7ds8VU3sxZ+yPujcZx/JhHFAp
	 mIBn3Ps4JSv/wcgbkFfitNNAJAk2DE5qa//ytThz8FOnywZK8yRkxttrKBBDhtFiU1
	 Jqvt/pMFoP5HcmUmCzFs3k3c9g49hXH3Atq1Qf72ELxr1IFMuaflzgpjRiKZlN+ZWj
	 jRVjs3T/VIydg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 272DAC53BCD; Wed, 27 Mar 2024 19:03:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 198919] Xbox (One) Wireless Controller won't connect
Date: Wed, 27 Mar 2024 19:03:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alexis.salin@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198919-62941-QzhR5OKBUD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198919-62941@https.bugzilla.kernel.org/>
References: <bug-198919-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D198919

Reaven (alexis.salin@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alexis.salin@protonmail.com

--- Comment #10 from Reaven (alexis.salin@protonmail.com) ---
Hello, can you add drivers for the Xbox controller? It's one of the most us=
ed
controllers on PC and it's annoying because xpadneo disables secure boot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
