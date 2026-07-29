Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57F35292A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307451; cv=none; b=aH8rPGzzj0uHgNJWLTXlj//CEPozBOiZ2ikK+0wAFsFH6dY+hPn3wR4xD9F5Syl82St2ay/tgFHldB2P7OZ1SycMzaOs2Ik2RUTFRhUvgNLRSfkSdAsOF1517bMfP4s1BLXnBQz8iEO5RWTsj4Bk3vyUPf9kBvi0C/euCZp3yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307451; c=relaxed/simple;
	bh=tRrHRxz/+Ly5kYK0CLxmB9YMWcntF0o3Pt9cnWYPkeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/Jxj/jnhLkFamtQzKgOq929ej1aIO82s4OCwC6/5x8tCrTSuc6hgOqr7bBR+we5vlMKtzOuWMXNL38bHHSe4pLYEwIqYwoXNm3q9t0ALKsQqwolR7wZfXiyr0QG5ago5P15Su7/saf802RvYTMq1JcoWsMaIPpYKG+i4h1qh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQscNKGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQscNKGb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6C06C2BCFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785307450;
	bh=tRrHRxz/+Ly5kYK0CLxmB9YMWcntF0o3Pt9cnWYPkeY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QQscNKGbvS+cvhe5kXf8ISxdBzRuKg2ZHeZaqkDFCDK5be/dHThpnr72lIMTUUs3K
	 W0R+dT2RQedx7CkelGCzphjuY7k5WTBLhbdNynmxtMJf74TH+PWBWMp95OK6bj4ZSY
	 HiyCons+ezo8o4+eAE+A5i8Qy0YhsCyKeSkEl2Gi3VthbUupWiyBOW6UKmZfT5Jp0T
	 vsZixdEnjHyZuWig9pbJNmVbNqH13P/d3bezuqbr7I955KmvDCJ9woDkFGkahqa3oE
	 uUzM/H2CtTlVk4HVOIvrR7I1Hu8XKjSkew1O6OhgvdccofGTba6/9cMCHITKJtULnh
	 0k0r0Rum7c7ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 96EC5C3279F; Wed, 29 Jul 2026 06:44:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221783] Bluetooth: new-device pairing consistently fails on
 Intel AX211 due to ~20s delay between connect and Authentication Requested
 (WiFi/BT coexistence?)
Date: Wed, 29 Jul 2026 06:44:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221783-62941-LSVPoWDxWX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221783-62941@https.bugzilla.kernel.org/>
References: <bug-221783-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221783

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
So some 7.0.y version was the latest that has been working? Unless some
developer shows up here within two or three days with an idea what's wrong =
you
want to do this:
* check if mainline (e.g. latest 7.2-rc or newer) is affected
* bisect the problem as described in
https://docs.kernel.org/admin-guide/bug-bisect.html or
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html=
 ,
as then we'll learn which change causes this (and whom to contact to look i=
nto
this)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
