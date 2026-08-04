Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD04963B2
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865278; cv=none; b=TLjQ4/UvinsOz4r2TSyOl809lLeBaDzS+BI9HcopOwhlKx0u1IWcvovz04bs9B7l7u2Pzn5RvE75ScUofisdEoQnnaVWNJQEQB0NDBxIs3YgbrFIVEqeAmzlI7NDDeQTivcOQLpTb2bIHxf1nic06wueFrgJJxGJ1BeNPnGV/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865278; c=relaxed/simple;
	bh=5Yn21sIXZiUBk+IA7IrE38NRceKSYWEx6SwTO6n2LcE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO+5hwDbrIr8BFT3HIuVxK5yX7+Z6yZRPgFVjrRobHG+4w/wLoHcB4MlOBUB52oVWHLRaAzSqvWN5Ml2wSIedOAgw4G4QYgO1e3s5egI6r9Tsfe3fsOqofXpidcwvKWJi1quwu48N3CEpY7yztrBIbhAl7D5Y6DJC4q/6EasMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKMMXP3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKMMXP3u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22541C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785865278;
	bh=5Yn21sIXZiUBk+IA7IrE38NRceKSYWEx6SwTO6n2LcE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oKMMXP3u+kFFqCduN934+/wsrWgnF2JGF3pNc3iU4sHcoyOHM6zMPHiQtrgi6sm1p
	 YiDgpQju5Gy3rf7bHo8yftgLaazTIjX2PlwAua1WNJvfgV1o5BQDTRQYorxpbuJoVP
	 cChOJvyDf/FZ+OjfWjU8I3b+SN4DfSkb7ST9ab7GZA/DL7guvYHPSUpRRvv2muVcgb
	 hoH8HaAIyieKQV8QSIE7EsYVeRhClKGmgPg88OpA8PO0XBtXObsr1qBP4Jnd0r7GPz
	 3+M+Vvs1jJQ49FqKerlEhCDCBdQmTA4V7pOsVCeWKxKtVtcrznFYBxkCS+YvpKZIXW
	 fQnmRI1OA+jpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08BEBC3279F; Tue,  4 Aug 2026 17:41:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 17:41:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-vYhQnafOLc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #4 from IQ (lnxps@bbtex.net) ---
root@A16:~# uname -a
Linux A16 7.2.0-rc5 #1 SMP PREEMPT_DYNAMIC Sun Aug  2 13:19:20 EST 2026 aar=
ch64
aarch64 aarch64 GNU/Linux

root@A16:~# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

root@A16:~# lspci
0004:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 0111
0004:01:00.0 Network controller: MEDIATEK Corp. Device 0717
0006:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 0111
0006:01:00.0 Non-Volatile memory controller: Realtek Semiconductor Co., Ltd.
RTS5772DL NVMe SSD Controller (DRAM-less) (rev 01)
root@A16:~#

why nothing appears in lsusb? If the btusb driver is too old it would at le=
ast
show a device id...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
