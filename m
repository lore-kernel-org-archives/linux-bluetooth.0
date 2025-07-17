Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818571D88A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762724; cv=none; b=KMuFrPAPGgDRH4aomLpJ+5yxyOqDSBCD0fqCNd/HFVAARXS3gC9J+YLN4tApNPSdmB/ejurGyktRIfHPOnbTAEuVBSw2YwXCeHjCkfmFbjaOVPwxm6Sq4OOgWsMosmzofJtiJTt1V/8Va/W2QNAKmFUK8VUvkVdKlpVXauGX6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762724; c=relaxed/simple;
	bh=KrIfbkTMbDRk4ps/zt//N5YfZkq+ADbbwi5pJxzwuzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4zeMv6F3HR0ad+lwyXJRevFeLL+p6ap9t+W2aiUR8fxvHKf4RnC/xian8MW667pD4YMYztMUjt5wSSwD3Of3Qhq+ke75KWPng55nKszuvCOieB16SgFBJGMaMNhQZGbjswDaxBb0buQ4jyXNR5uKyL9udjvNObSuy4RNmq0lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxqB8iHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxqB8iHz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D3AC4CEED
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752762724;
	bh=KrIfbkTMbDRk4ps/zt//N5YfZkq+ADbbwi5pJxzwuzw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZxqB8iHz3YC27xMJrRDSC7fjBVjGseL+eCeFRGL1daHE5DpgWPr/p+tV9og089Aoq
	 7I2WznWjaVzsoEn1e/gWJ8oGmDSiJaLJKe9lhreP9tmZtu5l4k8ra7VG6B+pD+3imC
	 9jJiXqM3FnJ524VKBsW4vC5hKFbWzraoC6m2Zna2TvnYYdgdjrqdGtvGJI90xAvkC4
	 +b/U/Bgo9yWNlWMbKDxysMDicxDdR9aP0Twu4u3HhX37O1uyrDI3DrM3myCPB9p5si
	 RrpQwxkg86icmkHMjVRkgYGCc0NC4zgtyHXsE4kO7iE4TXsuzdVhuvuxTExV79sKQq
	 Y4P9+p/nWOeLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE349C433E1; Thu, 17 Jul 2025 14:32:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Thu, 17 Jul 2025 14:32:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-tFjyr7C7aU@https.bugzilla.kernel.org/>
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

--- Comment #10 from Martin Hignett (martin@hignett.net) ---
This happened again this afternoon. I tried to remove the module, but I got=
 an
error that it was in use, even with the -f switch. I looked, and it seemed =
that
some other modules depended on it - including btintel_pcie. I tried to remo=
ve
that one first... that turned out to be a bad idea! rmmod hung, and lots of
things stopped working in random ways. I couldn't even kill the rmmod proce=
ss.
I decided to reboot.

I've attached the output of `sudo journalctl -k -b -1 -o short-precise --si=
nce
"14:40" --until "14:50" > bluetooth-error3.log` as bluetooth-error3.log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
