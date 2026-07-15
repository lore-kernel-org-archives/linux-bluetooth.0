Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90924353A7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115384; cv=none; b=azoLWvJ+tL2KEk9nkCNXYZapTMStZ5tqjJun0Yg5krOLiNpjRgKQt5yZdF/hiCs/0HNLdsmjFIDKxKqwpcobPhvAGiG5xX9a71ySuahrDvk75zP+g73lksPc+QOaXiGSKdDiSeYZdRlQN9oQwbD+wqrQZSkxuJAXGttSMxyRYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115384; c=relaxed/simple;
	bh=xJKVYDVmJmMrvmu/Oz8oxw052fRvyk0azI9FsJIylVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4N6MQXMYYhfkv/0zirOzVdlmKs+Qh7ev3pFrdXs683T5i7mZjuQhqaUl44l3yOWGmM29sNzRc16gPh6168ry59WXLq8n8Rv6rLnNFYU++soE0M+Quy3VjvFZ6am4/q6Jq4JFMj70AEA3JzJvNQ64AyuNrxDGZN+JZHEOsvmoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd9GXXhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd9GXXhL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AEC2C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784115384;
	bh=xJKVYDVmJmMrvmu/Oz8oxw052fRvyk0azI9FsJIylVM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pd9GXXhLg15n36c9lMjBzc2FUKbJL1Pkx7oxl8tb7pWXPBeq9PNQ+R9hXYCH9NwQo
	 JoG8hYIAT0D7H+EbrO7dLGapZ1n6RGS+fCq8iU4o3qzPQzhK/GVpJqtfH750gpHDgs
	 +4HClMIvBhEKyznwp1TcceJ6rfSvAxrPlAc1hexoDBtlCTQFVPBU+nS4Ak/Ix5XkYc
	 iV74sGhwobnGyqku0IIFPFCwt6EYB6T0Lob1wwWJvSRAmI2jrH3GHiX69Il2vBLDVy
	 40V9+RglGkqiEjMq+idtgUcqAMbVXkIJuJmVFoeE9gMr6dOwrTCIRcIAQv6K9vu+3/
	 rvDqgGesEZrNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08D6DC3279F; Wed, 15 Jul 2026 11:36:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219410] Need help with Product: CSR8510 A10
Date: Wed, 15 Jul 2026 11:36:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hhsnakeg@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219410-62941-Xj8WXTYlN9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219410-62941@https.bugzilla.kernel.org/>
References: <bug-219410-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219410

hhsnake (hhsnakeg@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from hhsnake (hhsnakeg@gmail.com) ---
fixed https://github.com/hhsnake/csr8510-fix

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
