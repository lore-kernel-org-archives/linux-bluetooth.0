Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC82186A
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923250; cv=none; b=brgpMTXSwKkXkffCBLDvaKHmUwapjWa7VMlN2tTDv9DgxLlekS0l21+LuAMioz+T6o0qAyRW8FI7jkggHnFA25BTHCI2KYgOnJhSVudXG3OGqqjcowhlkmy4Dno35tIfKWZmIYV9gmyeE4Todlzwz97ejmQ0GnYnRpjc9Aj3El0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923250; c=relaxed/simple;
	bh=rgC08oVQn8BIfzhfjTek67pCLjF7vqlK1mfCLPmT9IY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7kUxAhgk0Qu5rGtavix1AcieFHBDPR2LTuJSJB15ElRxIBjeMKddnJ2Iqa4LNYcIMejEh4Y5OZchSGJT3R2jATqRT/d5J57TAmf+NnB58NX1p+Cl1ayCoBJd92fp7SBinwHPPl9B6VhPXaMGm55i15IalijE9WfOlhD8J2C7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFKWKLC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFKWKLC2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AE75C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752923250;
	bh=rgC08oVQn8BIfzhfjTek67pCLjF7vqlK1mfCLPmT9IY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JFKWKLC2vXWW51nhJcGZS+uNIm9uJtNqxHgQWV7HwC/nGSXoG8d6HJqyyE8YLgMbi
	 F2y9f+1wF6ftp8tZpfLFhd8XcpGDnRXNLnt/sSJZZ1Hy7lbXKgVWWyMLiWHgxyrMyV
	 CYkubc/FuHFblrd8KhXnqb3nyIYOtTVX+0IbTi0yAREGs9hTqYnaWgF46qsRMrx1Mr
	 /m4IIke5EK4r8k0n3pnz9lBXeQKYZjehewj7bcnXg49bl+9LdTOaRIKLl0yE5vA1BJ
	 8+DpVbWUDUcqQrmkoDNEIR/Zd5cKxZWdCg/aW6DAjh94Ut57bjcbMVPOOvB18dBtJX
	 A7Lq0BN9uq25A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E96B6C41612; Sat, 19 Jul 2025 11:07:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Sat, 19 Jul 2025 11:07:29 +0000
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
Message-ID: <bug-220341-62941-Y9OdNxAEpo@https.bugzilla.kernel.org/>
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

--- Comment #17 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
@Martin Hignett

What about mainline (6.16-rc6) ?

https://git.kernel.org/torvalds/t/linux-6.16-rc6.tar.gz
or=20
git clone --depth=3D1
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

(I had a lots of IO and netfs issues using Linux 6.10 to 6.13.1 ...)

Regards
Nicolas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
