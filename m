Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10EA289E0C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471643; cv=none; b=AiYXp6qe6CEVONR9//EhXFbi4Biu8Qj3yeivc+bufx5Sin7bvjSV48bKmO6NUy1pFXRbGi7S20DIiMjWhA+OsmT/tI5FBvus05OYTssGMQPGpfX++g25ouBMhAzI5BIbD7zIxyvjIxF8ii+xFkoBLmgFLEvWYnGsDODgbybGSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471643; c=relaxed/simple;
	bh=ZIQwe0lfjW7+EykaiZkPzuIl/lVN+HNh/hk1WQ/uVjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWJbiaOa+O/KYaigryO+Io8uNOc+l0ux8GIxFX8R1BKdMsQVXPeE6ctsFkeS6SisNcaChF6qcPUtA2N0ZH1L/x6h/rcyVf17eLMsMxpY1WwDNvUYy6RasRac5qoLSZakEObGaFrcG9HdJ7v1/ULKEpep4S+S5Qxay1Ey43BR0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRQRL6BQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRQRL6BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11CB5C4CEFB
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754471643;
	bh=ZIQwe0lfjW7+EykaiZkPzuIl/lVN+HNh/hk1WQ/uVjY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KRQRL6BQ3HXreHH28adyAqyyQYdyd7QJEG24VqUh7DWTSiUYkVfxXxnn7P2OAkEqU
	 j3C+tYYBLQFUKHx3CCcI/DzUyaNPG44o5p8M2UJHOPgwDfwVTQnEZXX19ApZ3+mCor
	 utIXdan12oH4cOVPWZfNps6otexJ3WkmMGih26S7Nk6utNvSB2k+T1LKVRfG6nY8cj
	 PxxWtBCGUcjrsNjzjiiUr/ccQoKPO272bEND3Qlii+yRJLpe/3xlB4c0acVZMqL74E
	 kiK81mSoawaZfbM35ODO3Dop6cTC3Z5Q0bH2tp9yhqhDafVSgIBFEW1ToT3qM+Neeg
	 XI9EMD8k5hBew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06416C53BBF; Wed,  6 Aug 2025 09:14:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220419] Bluetooth stops working on Intel BE201 a few seconds
 after connecting a BT peripheral
Date: Wed, 06 Aug 2025 09:14:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anton@ekblad.cc
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220419-62941-PR5yA3V9eg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220419-62941@https.bugzilla.kernel.org/>
References: <bug-220419-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220419

--- Comment #3 from Anton Ekblad (anton@ekblad.cc) ---
(In reply to Luiz Von Dentz from comment #1)
> As far I know BE201 still use btusb, not really sure why a change to
> btintel_pcie would have any effect on a device over btusb but perhaps the=
re
> is something changed that affect btintel which is shared between both.

I don't think that is correct. lspci describes the card as "00:14.7 Bluetoo=
th
[0d11]: Intel Corporation Device [8086:a876] (rev 10)", Intel says it's an
CNVio card [1] (which I think is pcie only?), the problematic commit only
touches btintel_pcie.{c,h}, and btusb is not even loaded on my system (neit=
her
before nor after the regression).=20

[1]
https://www.intel.com/content/www/us/en/products/sku/230079/intel-wifi-7-be=
201/specifications.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
