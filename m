Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792547807;
	b=l/ZPTpkCXrdj/F2R8qpLcd7LCVviMyiwO9UjkgatA6qdQvxEQLE999O0k0KLEs/wR9Vn
	 pDXNRNGkecoQHWi4TbARWfgqohSEctH75SF5kwQHSRxNbehuvzLyJyEx1f7ireNJpGMo5
	 ohuC9IxC5djOHIHzNwqxd2DkeR78EU0o//VDUY1m0zg9gjVJq1nSbyv+WXlFT+wLJVkZI
	 E2Rkr/0dx0lecrW6H8uhJtuB9VzVlt+/KX664Jq2Su2rpFzGNitaQbYY+oa/QAZ/ts11C
	 gp+Xr8Nm+Tumo0q/HfnRV4N3r/bNVSjCtwUFNNA29KzXLffPyAn+QL6d9l67Acbm8Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547807;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=2p2gJPbH76pbFFP8cqgdqsAc5kd5nfy6k7zTTYKo/jc=;
	b=e9SdHcbNdhVs5+AzyY5A1iu9iHSWY2W8NLOnJ1iyslXdyaCRk6SCNRSVV+oLYQ9ltsqU
	 cTjFxBTQWEGglt3OR9uI5wh7Xmz3wi1dbtIOijiQcwHLPozBYGCjAP9MORmQf9ijk5oZv
	 /u2n7HyYkUfVeHUZhdbcirq8hIO9RO3j3MbYIfJ2Izm2wGiWjGZ9nPS5wnAUeYcmPgV4d
	 ye2mDjs/1GhOee2OEiqaSl7+z0m7motQZCFV6yNIJbd+GCA/XLx+KOUvc5HJ5D94L1WXq
	 awb6C7/Mz8IsHA1rif8E9iYGDeg4xPIwUq3pavGONytx+XyGW9rE7tMNtsSq2OYk3DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hxbmwGMc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0E606A323
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hxbmwGMc
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60325771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792547807; cv=none; b=Six/e0b7gIb3TLDpVC4xw6cXQypiLFDrAxaRypAAvKlptIEg0gtFKmpN+mBUjG1j154ERoqCmKeeubETL9JAk0V0axAGRaOptavhDFeQYvSdn6FqCs5c2VGrZCf7eo5lascla7tIldWn5rUWQMVD/DlSqqX7pGP57eITQlFU5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792547807; c=relaxed/simple;
	bh=SetO7AvH/zxR4jSkT5NVH0nJQp3+h5Ze284ZBJaGBJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJpBVK4xO439vp5EgeP9DXwAPgKdEsVL5htYhmon5aRCxN5Bb2q1Tq6iVLOJylRcAKpC7QAhcEhAfY9wIpZGorDHQEDBWSrV1p6BgnWJo98bvPXYogSHll8S9ypohiv5GN7uG0rEIhNexMPYXzxxHf23Mz4qdyvU7n/7v+ZMDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxbmwGMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B4BC2BCFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792547806;
	bh=SetO7AvH/zxR4jSkT5NVH0nJQp3+h5Ze284ZBJaGBJY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hxbmwGMcZLa1GEEZVKbCYAtHASMuK55Ps8fP5NphcpK25hKuO8v1kXdICD4FjYEgd
	 NUCRPLv4Pv0nAXmT4K2zl83+sJoMwL986IIoJGw4Eu7WBovEwO7/FknTkMZWMXnamZ
	 ertvDbAkpfpLkI+mvVJUM9/okan2mzv+HrDrX5zQFwdCr6ZxIwq8ftYXab6tZPNTPR
	 8v2jeO2fVNhmOYcT2MWv+B8CHdqw7GrInEto16YX6Q5GlZKGsJEWUSF0AUJMFb6wxV
	 mZyeEoxD26x2cg9kQtNRiAJEPponJ08FOKyns3LT+CEVqzO8FfNJUwqlnS85OqVgbP
	 gIoAiDEnFTy9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B2F21C41613; Wed, 21 Oct 2026 01:56:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then "subsys reset fail" and permanent USB disconnect
Date: Wed, 21 Oct 2026 01:56:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hongweifei@cyue.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222164-62941-ABaN1CLGFd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222164-62941@https.bugzilla.kernel.org/>
References: <bug-222164-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

--- Comment #1 from hongweifei@cyue.net ---
Created attachment 311208
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311208&action=3Dedit
Kernel log around crash #2 (2026-10-20 20:01:29), unfiltered

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
