Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB16156968
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240730; cv=none; b=WvrcCaxJfLb+XpL5+Pk354wFY5+gLSF1yujcQtcrsLJBw3SurgJuDZS9MCKW6CXRub1LMk/t2+m1CJu4ZwoQijydhXUUV2qpnsbWREZuU0k05qZACosZe0aZ4qq7c86rLRjGh/AJ4dISkleXEb7+QGKMKxw88LhDR4NvgzRTYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240730; c=relaxed/simple;
	bh=cfKPW45tStyl441PBDM3be5RkCV9QDBipxmljW6O3C8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV7NqNLQOB0JdICVVJ1Ja+74pPmhc969D3HO+sCyCCJ2JJ3yYc6YvnT6W+6Rmb5cGgCiR+c5qpuICm5MwnCvWSDXOFD2bTe7FnMPQtcA3AMrHvAs4MUJjbyYa3LaZf4vzzaStsxa4WwUmPu3QBwZ50XfMoLZlbsCcoQE6R278UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrYUXN9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrYUXN9g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2382C4CEE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736240728;
	bh=cfKPW45tStyl441PBDM3be5RkCV9QDBipxmljW6O3C8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SrYUXN9goEdMXl5d9M5Fz2wly+oAk+KVYe0pwaZfSfYaIUKCCFAAKzh1i+7i6yGmr
	 bB9zqGyFg6oF929vaxcUDLYvY7tQwMuXDN6ajREteiJCDfLO6xgiJc8tFcKCe6c09P
	 6cGagH9393jmuqeVNf/+1P1rvUt64790/xE/Rwhf8NHbCFSQluskF6eAkdW3yt81ix
	 AtHxSfvt1PnmZV5lOmRKJ6dvIm/X4TzfBNBBQB3gr9F9qvZ/3HHz2d4PKlwDlNdaIX
	 /VyrhMmGJ8jjbkzeTLumZ3p1dvXfqQDzSWOiyOVWuph1FU6Dwi5heK14DO1UxKjHqR
	 j1AUls85EzeoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C6030C41616; Tue,  7 Jan 2025 09:05:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Tue, 07 Jan 2025 09:05:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bojan@kseneman.si
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-hjDoaHn03q@https.bugzilla.kernel.org/>
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

--- Comment #12 from Bojan Kseneman (bojan@kseneman.si) ---
That's odd, it seems to work normaly on MT9222. All devices take about 3s f=
or
me, but again, I don't have a bluetooth mouse

[ 1557.845962] PM: resume devices took 3.106 seconds

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
