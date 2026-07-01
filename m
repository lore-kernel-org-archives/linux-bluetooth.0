Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8052DB78C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888170; cv=none; b=t/mmrFGEbJ9W/7Mo1GTidGx9njWXOv4VpeXPwv2xWK00R09ZlFv8SNX/4EvEsn8VgkfqKRpnPvElDHdPlZL305eENUji3RaYKvcYMMxIicPK3HWw+btRMBMf2dqBHQnigCMIUBD86d7/FTxqy+LsCWwCCiuLBwQHUMG1KS0QmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888170; c=relaxed/simple;
	bh=MssTcRg00r2GxxisW2Ymt3NF81zPgAsW6XnPlUrbuuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcyFT+5sabK++ND+T/mXJE1X+0kxu/NFtgNxC5/HRCiJSw2yHwrMgUNdgPqvJKhCVop8/WLATlIQa5BGScTYpPb2Zy8dJIwBc+3sOGpUIcGR+zgjncbtp1fMNPosYIfWa+KHA5kDPFljgZtPJmUgOkod7ryBnbw8IAeFYvD68K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXI2HNQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXI2HNQb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31019C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782888169;
	bh=MssTcRg00r2GxxisW2Ymt3NF81zPgAsW6XnPlUrbuuM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pXI2HNQbHuiscLefjCpGXwZQqyWyd39h1UoJkiy+Mj9P7AwYEiTIxWFkaJv/7/Uvt
	 HB4HAhemsbYp54reyJTNVQouXR3o0wKhfgvkA3IIhPsRQvGIhqUfXb/YeAzBQP/85m
	 3XaXYrO6qfFHboXzRyPaAdTa/EgkADx8q18hzABEVumm2yWQiMTo4FhYMx5z5KfyLq
	 zdIiRF0I6aPYbNH2kv6ID7RZQLP/HdHuAiGv0uOCXGI5P7ZOQNe7S1NTZm9WiqeUYH
	 eQPFWlaTOTwC0DMvWz62+yNf0kVLBI9GJaZn5QL+WI3i4fIWz/W5XSR43sSEjN7TuD
	 wxIOCFeaXn4Ig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19E30C4160E; Wed,  1 Jul 2026 06:42:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Wed, 01 Jul 2026 06:42:48 +0000
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
Message-ID: <bug-221696-62941-8sWQYN8j83@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Not my area of expertise, but sounds a bit like your problem will hopefully
soon be fixed by
https://lore.kernel.org/all/20260626104604.3465124-1-sivakumar.bs@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
