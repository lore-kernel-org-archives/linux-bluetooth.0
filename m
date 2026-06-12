Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0783D5660
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247462; cv=none; b=qQLljMt3im9FTR7E8dG84ybM5PiDrJOL0FCVpzJ3RYr+MRY5vWLkThiVyQ7T+ks4WgrcFg5W1u6cMFHHB4K3BHFawlztptV3nl7yL8W/N7MZEnPGP72oRt5gHZ8tjGGVdToxDNeXs5eVIjxSmXZv2AZtQ4pQMlQZ2MaJxwit460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247462; c=relaxed/simple;
	bh=hsn412VofqP4WNUVoqXM7+7UOHijsDFVUlb8sDAPqRw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfHZrteRRnSYxjPii6SNKXjJXaokC7kxcLiM1N99X6XmP9uMXrm/unXQofQYdfEkUDixUY9JefeAVL4OuCbyW/M1mBQucV+ii00iJ3X/dEtZYb6hAJxFVB4oyAjvLM6h3fAqeS98v+MJWj+ipPfeIxQxdKrdJf7OhhW6eeZVrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/N6Swrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/N6Swrf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326F4C4AF0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781247462;
	bh=hsn412VofqP4WNUVoqXM7+7UOHijsDFVUlb8sDAPqRw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E/N6SwrfIteA8rmDqSfG+pzBDZEjkReTjryGPAGl8CN8VMXAj24z+TWhY3CuWZnlQ
	 d3IijQxcoqutTe28DtEnWCyLvTtK0c+jfy6vDISGe8T+U0DYYNueejqanyeFzoGiEc
	 7FzctXveLEuVpQ0SKaIj5Yhq58sXXciQJifUcOYSuMjjmj8Cwo4rI6QONj4QgL/W3L
	 wAGb3oWHtCR9QS5QblACr+izqYXue23nwDd2IL12BlYoqxNoQL9mrl+mX5yO2USVbh
	 cz/uGM6TO1A1WPabL9/7ruSVKB9T4stqZapr43KAPXp8q49HzOR2aYr45Fw+BYTGM4
	 3opHcYuOVbY4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2C4B5C53BBF; Fri, 12 Jun 2026 06:57:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Fri, 12 Jun 2026 06:57:41 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221637-62941-4vlP7yKNPB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #5 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
This bugzilla is likely the wrong place for this and most other bugs.=20

Last time it iirc was a mail CCed to the linux-firmware maintainers that got
things rolling:
https://lore.kernel.org/all/f689f4a3-e5fa-40d3-9038-8ddc12eec241@leemhuis.i=
nfo/

Ideally someone affected would do that (please CC me) -- while specifying t=
he
exact commit that needs to be reverted.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
