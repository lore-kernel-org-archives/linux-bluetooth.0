Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF11D6AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040463; cv=none; b=g5UuScyOVGMiRVf51bn4Bv++ugB0B5J9jzAp8vWYtuD7p63Z+JaQ0nE4dyKbfsAJtI9DgCJdt7An5F0KpKfLZGZkSyTstMP9C455bV5c/wLtzQFLeZBJsEGyGD06XEFK8D2R0B97lacggD3hC3wMoK3chZNt8J48kKSvRzaca8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040463; c=relaxed/simple;
	bh=e/6pvFzExpcrYD/yGpMa49NB5buUiAeJSDztZ9LzI+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTsibBJqTVJD/Ez7shy621cPp8couMuK5Aj8d9VKrEA0NN+NRR3NfMHpIemhKCjeHO1QrlFnoLk5ERr/ML9IPnzqmKrPOpJqO8tn9Yw0e2ulmjP1eRgM7lGbbZFL/zsQhG7BKZP9/2fgOu78kkqd/yZjsnWAahxEnNOnqujbRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhCtgF2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhCtgF2S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 661C8C43601
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712040463;
	bh=e/6pvFzExpcrYD/yGpMa49NB5buUiAeJSDztZ9LzI+g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mhCtgF2S/SRXRn7PD0VyOrjbEqct6kmD/7x7OG3qkDUfG8yAgdXmvzR20ia+O/Zw+
	 1NnbL9NIkZTrkhA7/hQ2+qx87VDuAXKLR9WSHna2wZwRuIJXnksNBqrG3W4MBJtdDL
	 A7hlgCU6Fj7e8QI49Oh1FqE5EtRM70fnMz5yHYwo57PJDnQAFrcDgMIDQtUPgUWpOd
	 XcI0mUdHuBGvwrseXUGVec4zdL/RirNtoo3QMi1Aj3AJs79d7/Zmf1tkim3103vqBR
	 Z4g35uU5E/KmXDQfoklcW70AmiZfawb9gtP6/niqaQIuW6CMozLRYvtaVKJHVFYdTt
	 Yd3MYJt4BVoaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 612D5C53BD2; Tue,  2 Apr 2024 06:47:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Tue, 02 Apr 2024 06:47:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-4bSS6xJ0Vd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #21 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Luiz Von Dentz from comment #20)
> Hmm, was the original change backported to stable kernels,

You won't get an answer to that here, so I brought this to the lists:
https://lore.kernel.org/all/84da1f26-0457-451c-b4fd-128cb9bd860d@leemhuis.i=
nfo/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
