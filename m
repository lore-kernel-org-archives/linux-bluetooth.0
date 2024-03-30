Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E23A1D3
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711827242; cv=none; b=qnA8Y6n/LVbKN2tcf8TmW7ChQxRXy0KJHbsU0QzCf01Wqi3wCWpHUalYdVORjN5vvcbycB2NesHxNgCIq54vlwr1urQnHiMOS80nZeR23PIiWDTgCbSwHViG4Z9i5IUJm9zKeZpuLNud+OMy4LI402erprJMQr2On1OWMHGbaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711827242; c=relaxed/simple;
	bh=S/b3jZ86KFTY/EJVgd7XLZqcL/oumwW/2r6oWGoVqQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uk340JELqFJaZLaLMq4gHY9k4sUeIuV81lA3n6yl8JBuUFQ8Wnr/8HYzbV0nOj4EkT6SnxjzqllYBE0R8g1sKlLom/l2fM07pl1d4etbVgo+9fWH6OJ8/wBgd1Y/5EkLnp3e/wnXxU5sYw/hh47o+kleSnbXNWTR7uO3/lTvhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgzQapg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgzQapg6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D779C433C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711827242;
	bh=S/b3jZ86KFTY/EJVgd7XLZqcL/oumwW/2r6oWGoVqQU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kgzQapg6xHaVdEGZMp08+zih6G6cB74j/BR5QZUIBfQBYPp5scpD5AQaPhtvs7UgV
	 T6KANCWOfuFWyrByi1tJ0Rh7oNPMGcCcLrBnU4ZJzLDyDjd3mwDGz0IB/ImgKipmyu
	 Nj5s/D7zad0yBUGilbrK7YcUGECBX+srLLwILBavrciHKFm0S5GCZCf2+dfoXvaA3Z
	 qnoEsojTidgMc0lsAE5Gi3+tDjDOm6dDLwLIVQN1Wz3HY54zfXKRtytBRncnageamF
	 OcwzNS25yJdtjXag2e2yXKlxo5koipGfuVKnOwjUSKvAw2DxF7lCqEyP/sc3v3WLaM
	 Wuz266S+nNnZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 35606C53BD6; Sat, 30 Mar 2024 19:34:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 19:34:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kbugreports@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-A5qRoE50sH@https.bugzilla.kernel.org/>
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

kbugreports@proton.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kbugreports@proton.me

--- Comment #15 from kbugreports@proton.me ---
I can confirm this bug for / in kernel v6.6.23.

Not that I care about bluetooth, but apparently it also affects usb.

This issue is present at most but not all boots, sometimes it does not occu=
r.

Real world consequence on my system (thinkpad, kabylake) is that external u=
sb
keyboard and mouse are not recognized -> system unusable. Inbuild touchpad
works, so I can initiate a reboot, but the system doesn't power down proper=
ly
and still needs a hard reset to complete the "reboot".

If the system happens to boot fine (i.e. the new, unusual output on the boot
screen is missing), those problems don't appear.

Going back to kernel v6.6.22 solve this issue for me.

Hoping / assuming the fix will also be included in the 6.6.24 kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
