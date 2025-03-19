Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3720E30A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396126; cv=none; b=FvFFLWWRkuVbwuLfzT+nT3Ml4hfIPiSztlBCWe+T6nIWC9tI71cP2gSa8oGzywyLxAb2XCxcTD+QQRtt+OaU4bx4nBZHFJrX53nZLto07Znal65VF1zoFXePtbv5l2aeZlEBldI1bPYHZHMVj/5ykc93HUT1RRdQGw/mc7inh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396126; c=relaxed/simple;
	bh=4EEgqNVG6HeTWkg62TJPsQqi+ALhrJ5RBQdsLFW06p8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwfDf9tAn1RcWX4VMTpAo6p7rLBVRdY5VXLk4K1/p3ozFrtemxqrHvmKR+0Qm2R2gzgypNJDORoyUoGqEnFAx+T0oNAGF4q1fKeXRsiUV9ROdxAq2pwrzoHbnP6ZjaC6Pr3ocQtBE7oCNBzI6DERH3kLtyHOI+x1ylJHcKgFcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8+wMwDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8+wMwDH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D16D1C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396125;
	bh=4EEgqNVG6HeTWkg62TJPsQqi+ALhrJ5RBQdsLFW06p8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L8+wMwDH7NVAxChtT4IXfDs8xhMaPZXxJuG3QZF+d7wqjjJCD0YClCYfTBUPXIYOJ
	 Am3puBFyx77QhiLMsVAJFqniMS20EU+uddA1uoJpQ/qMZFGoDx2WSnVPMTviyXPf+Y
	 TgUgvtAUhWypHDfGIObUc5smlqwQwFCi/HEmTMMWYTtaWvu3hQ+SweMRE/kQ16glgv
	 ARNyDGaSWE2OSSuBA9w5hqV2V4ZWdkLfubOm8QEKd3kPl/IlgEUtDwUCgyFe5+rp0+
	 sxGNdlLdjg/T7xNYi7UBhxykxQSV7C7UDONTQ4b7bAZOaYd0vuXyrXjcON9eFbOUQl
	 hp5iteX6eA11A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6F50C4160E; Wed, 19 Mar 2025 14:55:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Wed, 19 Mar 2025 14:55:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219898-62941-i87ujVuods@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #2 from Hunter M (miller.hunterc@gmail.com) ---
Created attachment 307862
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307862&action=3Dedit
Syslog when using Bluez Dbus API

Syslog using Bluez DBus API - shows that new_long_term_key_callback() is not
hit during the first Pair attempt.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
