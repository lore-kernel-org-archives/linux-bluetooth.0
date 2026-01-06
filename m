Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B830EF83
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737727; cv=none; b=hogDrNbcCVC0RpGmD/GprnhP1AoiWk+HpAotgHsAfCU4umNPYOGl3KYrMzoKTsn6Hv/bSdTXtzXYDR4mv1GNohYeGhxiQMC3W65dk1Sibs7NNOO78CWyuZ5Vg5nMSPEifCt5w9IxS8eVjcrD7vQh2HCoHKfdU1SY4Uk92jQt00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737727; c=relaxed/simple;
	bh=bwpjdvuCCpjmUq0rjhqSMu5j7FYLvkml+bJyr+ziYjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/TsTIGc4NmkIYpT85BGXmkZg1QOYiY2ZK2nXn1gy9W+LUisjfGX6ZLcKdchmU3DQFaUX4T56RSj7Pfx22GUBiBak7Zquiscy9sgJ5wdqbu/rKaIeEjjlg2n0+TXZ0BfmbLyDwsLBezsJcP2Pssp3tK9XGcRAUcyZ0M0/B2R4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRojNfQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRojNfQD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D2F2C19422
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737726;
	bh=bwpjdvuCCpjmUq0rjhqSMu5j7FYLvkml+bJyr+ziYjA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jRojNfQDR3IDxKNi5TrqrxXiuy/oU2gxyJJAjGRU+M2QLiA/pk/WaEfiTxR9E9Qm4
	 m6MbhNME5CFUYEfTEQqI8L1AB9FStR+K0pyZEsNoHQiT4o47L28u+k4KxuXqWYfgSn
	 uaTK1nfVljh+nMnmsrfpu3GKCGMougM2AQRFG5blfs28hXFqxLuAgyUhyasTOC/bSa
	 Wpj6qNysZN6L/FivYDTX6E20pAtmknLHjRgTecmWmVDldpUbknjJ0TArREg3HdGPD0
	 vzc5gnSZxiC6OpEK6zmOm2OPuB4SLWAhzIsFq+cDyot8tSkdVpxoujidKrD0Tj3YOr
	 sZ0EYvkO6FBqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78051C41612; Tue,  6 Jan 2026 22:15:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Tue, 06 Jan 2026 22:15:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@onet.pl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-RjLKNtctF0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #7 from Jakub Jankiewicz (jcubic@onet.pl) ---
The issue is still present. The identification of the Bluetooth device is f=
ixed
but there are still messages in logs:

Bluetooth: hci0: ACL packet for unknown connection handle 3837

And there are still sound interruptions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
