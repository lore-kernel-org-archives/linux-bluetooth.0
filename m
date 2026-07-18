Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D41F5825
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380869; cv=none; b=Fwd3Sil1sdrS2z3wjYyPgWmTRoOjq4PO1b4WONq5HYaxNzvjRCiWYdU8/6loavtzVbF1hCrK0XSPARbyy95i29aO4z8FlazdReQ3VsfGyirdG+x2r/3JnSYYkUbPWBgGDb5B05BpSQ87jhz3ND0aDuw3Ea47p5X7ozelXSPTSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380869; c=relaxed/simple;
	bh=eQ6WKjD+rgG32Iwy57ruzDASs7gjqf0uYkIOKVMMc38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyYtrTuEvvHAVLoaBbhtS27evc1Mr+DhvRkUerEdePdrLnMT4u8RdiXY03QiujZ5Ay9VAJDe9TX7dZyZATRQ3pDKx12kUD0sVLNdkUdTi6a9dFqnx8QdIKQi25p56r+Tt4d3lfFIWALGMqw406iVDtKmGHkzzRXN5I4Glon235A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHPCPa6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHPCPa6O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F96C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784380868;
	bh=eQ6WKjD+rgG32Iwy57ruzDASs7gjqf0uYkIOKVMMc38=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pHPCPa6Oc/Ke5cQiJxdnmychzuLgo+brh9YBTFaRz8+qRsiDYpVf6z53LzCGAQvlv
	 Vu+WMEjTNodQQBXdsbVYGDAgeidmwbZR/YcmYMtI9ILTaMvlEiCBj5jagL1Os/THz4
	 bsQaF7nBA1uYp720TbmtHwXTCFLHH7ry80c0UityBa0alErcJY6H7AfXW0ZDuuiwpH
	 te3qhkOct9rNzZvbxNMafFiPR8CvWXBm4GBq3rS6+veaulkCw2jMUx84gr+2TUObld
	 kL09U5lsEhY+s2dnn5vupMtygVsp44jsarqFB/KAmQyF1SjVXGyYtT3i/Cpq6fwPWe
	 4GDe8FR+pe3Zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B561FC433E1; Sat, 18 Jul 2026 13:21:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MjBdIE91dGRhdGVkIEludGVsIEJUIGZpcm13YXJl?=
 =?UTF-8?B?IGlidC1ody0zNy43LjEwLWZ3LTEuMC4xLjJkLmQuYnNlcSAocGF0Y2ggMHgy?=
 =?UTF-8?B?NykgYnJlYWtzIGFsbCBIRlAvU0NPIGF1ZGlvIOKAlCBXaW5kb3dzIGRyaXZl?=
 =?UTF-8?B?ciBzaGlwcyB3b3JraW5nIHBhdGNoIDB4MmI=?=
Date: Sat, 18 Jul 2026 13:21:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: dev@fluid8.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221720-62941-eJmsZyQUMq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221720-62941@https.bugzilla.kernel.org/>
References: <bug-221720-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221720

--- Comment #1 from dev@fluid8.de (dev@fluid8.de) ---
Created attachment 310475
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310475&action=3Dedit
extract bluetooth firmware from window driver files

With this script:
python3 extract-ibt-fw.py [--verify] BT_21.10.1_64_Win8.1.exe [output-dir]
you can extract the firmware binary and use it on Linux.

The script als0 checks if the SHA-sum of the extract file matches the expec=
ted
one.

You also need the Windows driver files. Intel doesn't provide a public down=
load
link anymore.=20

The Firmware is in this file:=20
BT_21.10.1_64_Win8.1.exe

Download link for this file:=20
https://drivers.softpedia.com/get/BLUETOOTH/Intel/Intel-Wireless-Bluetooth-=
Driver-21-10-1-for-Windows-10-64-bit.shtml

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
