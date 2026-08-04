Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBC35950
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857017; cv=none; b=hv4cwbaAQszUefqF1cpOTnlDOn5dOl6p3p7mXCpdakvdi3qon2hwZ+L60cwkXLBRe/PnjTc81IctsdkVeUMebaCYuL8QjOWwSqgIgQ6ZdQZ+97BTgGmGIL4di7TdBZ+2Hy4ONIOhPwghawXRZ6wCxJzmJ8XScnzGZMPKulKuils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857017; c=relaxed/simple;
	bh=rh3J9i/fvRtRH4Oc3zsJQiXI+6w5T5KJdvaAehDwYvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zoox2i28vGgrqvFbRpisvP2o2BWiqiN3fWmY6wOKCsKvDuDXwVg3oVmH7xdhefAyJdQkgrxqRmhrpbTXEt5facWYHntMNjPr0VYeJc2hIySNcc/50EHH2Y3HEXKCXHdjhnwVqJaraeYnEr+JjEKGgI5UiYCipsYieYCCcQU6V3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6WY4WfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6WY4WfM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2333BC2BCFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785857017;
	bh=rh3J9i/fvRtRH4Oc3zsJQiXI+6w5T5KJdvaAehDwYvM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j6WY4WfMaLLUvXVuyhCZvzdm3viGRTYcfy/mi6FJPv2gPo2AVX4OHUMkOjm/z1t/D
	 FmS1r9BhHihlmG6HfQeXk67kPLm76TIe1Bd11x39DKbpuz6NHyE/qELPATmEaq/QyI
	 4iO09yR+WygME68i9wT17+RT857sZy4HC2iz064Dh+aUQ5lvuVo5mEk3q5ZKo7i7Jw
	 y4oV5q7okUR/yq8CzojSDOnDsuYAtxtYm+7e0mgzHHkAfxzVdiHvV+K+5Slpb1vThd
	 HIbI/i8y6Zb9GHyCnTvkYvZY/8+nSLbyqkejtwr1fBy1SMb2rcO/niCNrHscKFrh9K
	 WXYtsvveoR7Lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 046D4C3279F; Tue,  4 Aug 2026 15:23:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Tue, 04 Aug 2026 15:23:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: serge.brun@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221754-62941-LVZ0eCjtrm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

serge.brun@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #6 from serge.brun@gmail.com ---
Update: this is fixed, and Adam's case is very likely the same root cause.

mihaits' repo (https://github.com/mihaits/rtl8852bd-bt-linux) nailed it. The
actual problem was never the Opcode 0xfcf0 failure we were all chasing =E2=
=80=94 that
turned out to be a red herring. The real issue: this specific silicon cut
(rom_version=3D3, aka "RTL8852BD") needs a firmware patch at "eco 4", and
linux-firmware's rtl8852bu_fw.bin only ships eco 1/2 for this chip. It's a
missing-firmware-content problem, not a driver bug =E2=80=94 no amount of d=
river
reloading, address reassignment, or rebuilding btusb was ever going to fix =
it,
since the firmware needed was never there to load in the first place.

The fix extracts the eco-4 firmware from the Windows Bluetooth driver packa=
ge
(proprietary Realtek code, not redistributable, so each user has to pull it
from their own vendor's driver download) and feeds it to a patched btrtl th=
at
knows how to apply it correctly =E2=80=94 apparently the tricky part is tha=
t a specific
memory pointer (0x801200cc) has to be set before streaming the firmware
fragments, or they silently land in the wrong place and the patch never
launches even though every command still reports success.

What I did:

  $ git clone https://github.com/mihaits/rtl8852bd-bt-linux
  $ cd rtl8852bd-bt-linux
  $ sudo ./install.sh ~/Downloads/<lenovo-bluetooth-driver>.exe

(Bluetooth driver .exe pulled from Lenovo's support site for my exact model=
 =E2=80=94
support.lenovo.com > IdeaPad Pro 5 14AGP11 > Drivers & Software > Bluetooth
[https://support.lenovo.com/ca/en/downloads/DS579027])

Result:

  $ hciconfig hci0
  hci0:  Type: Primary  Bus: USB
         BD Address: 14:B5:CD:7D:92:86  ACL MTU: 1021:6  SCO MTU: 255:12
         UP RUNNING

  $ sudo hcitool -i hci0 cmd 0x04 0x01
  ... fw 0x3C91950E (patched), HCI 5.4

Bluetooth is fully working now =E2=80=94 paired and streaming audio to head=
phones
without issue, survives a reboot.

Jeremy =E2=80=94 really appreciate you staying engaged on this even once it=
 became
clear the fix wasn't going to be a Makefile/id_table change. Given this tur=
ned
out to be a firmware-content gap rather than something fixable in btusb.c, =
it
might be worth linking mihaits' repo from bluetooth-7.0's README for anyone
who lands there first with a rom_version=3D3 8852BE =E2=80=94 could save th=
e next person
a lot of the loop we all just went through.

Adam (comment #2) =E2=80=94 worth checking `dmesg | grep -i "RTL: rom_versi=
on"` on
your machine; if I read your comment correctly it also reports version=3D3,=
 so
this should fix yours too.

Thanks all & Claude =E2=80=94 closing this out as resolved on my end.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
