Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282831F9B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099175; cv=none; b=PnkAHztko3DIPZLIgMyY1ce9JVpweuE1regZC/rvRU4YehMcGvUEM8u4APy0/STq0FMrfCmuN/6KQEgld5fgvwQjzsO4XoH8pKIqCh0pfXcEpK7PMJAsEAi7Lgu9Zlg6NYOZJxedxbPC3UE0zLI5ZDin4+k40CAndbjUOQcNYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099175; c=relaxed/simple;
	bh=4zn14t9k7fqfATLqa7orQ56SO6Eokx2H88iv5YwnQpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TvnoVjJyPrg+amivqG09KchyETMMi44ZBXJn1et9vzCSsNyvm1tgbHSYGVkusxiT3+3IBIuGhQm2RDxGnrNnQM+/pLNLi6FJZgQ1jxm+cUUJniT7QCzdZXjCl3UhL8fwzOstCAPHmx0MAI60PuhCnJb9HNg0wN6S6tI7+iumyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeieu0MJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeieu0MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 152A5C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779099175;
	bh=4zn14t9k7fqfATLqa7orQ56SO6Eokx2H88iv5YwnQpQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qeieu0MJx6FDCrHd6SypaLnLAaq1aoDbsYcg/SEhJnn2BZEQH52KCfaN1rwpQj3um
	 mWMhr8b/nZZ83a1b+YgtazE945JX3XJaH4932J4428qUGq/Ghfr3rCVWoKZxAKGgTO
	 Ec8dj26mvlLxrzGsm1o7rrGQO0zczvFTJEXxv2D1tKAhEcWZTJKAbttebvOx3Dyfyt
	 oEUhJE8VX/xAfpy7KvW6N2jc6JKAgy5zCr+oz+qCtwXf2S5zxgNvyWE4Of0P8ZUZWf
	 668C4nBClcPQOHdtq1WSpvClwjzPQcMXR9OKLS8uvQrmaoN5njV41l233bnTWBcwCZ
	 YVmZI55KIZ80A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 070D3C41613; Mon, 18 May 2026 10:12:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1MzldIE1UNzkyNSBCbHVldG9vdGggZmFpbHMgdG8g?=
 =?UTF-8?B?aW5pdGlhbGl6ZSBzaW5jZSBrZXJuZWwgNy4wLjgg4oCUIHJlZ3Jlc3Npb24g?=
 =?UTF-8?B?ZnJvbSA3LjAuNQ==?=
Date: Mon, 18 May 2026 10:12:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: niko.iskanius@duckpolice.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221539-62941-4vtSL4nabk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221539-62941@https.bugzilla.kernel.org/>
References: <bug-221539-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221539

kopper (niko.iskanius@duckpolice.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |niko.iskanius@duckpolice.co
                   |                            |m

--- Comment #1 from kopper (niko.iskanius@duckpolice.com) ---
Same behavior, when upgrading kernel on Debian Trixie (Stable) from 6.12.86=
 to
6.12.88.

**Hardware:**
- ASUS ROG STRIX B650E-I GAMING WIFI
- WiFi/BT chip: MediaTek MT7922
- PCIe ID: MEDIATEK Corp. MT7922 802.11ax
- BT interface: USB (hci0)

**Working kernel:** 6.12.86
**Broken kernel:** 6.12.88
**Firmware:** firmare-mediatek 20250410
(mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin)
**Distro:** Debian 13.5 (stable)

**Symptoms**
Identical to original report.

**dmesg (relevant lines):**
Bluetooth: Core ver 2.22
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Failed to send wmt func ctrl (-22)
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
