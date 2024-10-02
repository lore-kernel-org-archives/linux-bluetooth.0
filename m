Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335944C94
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853888; cv=none; b=fRvnAllJmSdD3gNt2KA7Ys2fmZ/bVUUSnUAaFMahDwFeLhf5D9VDF43Y59fByxRrzcrpnZG3BEuIBGVtdTh4G6n45NoLsGxprXjnkzz77nMkdk66mgER8Je6O58w8ZGmrdoDsGMTXDhjDBa0kIz+DmO9enNWlfSiZectKudN4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853888; c=relaxed/simple;
	bh=CBKr339bDut036D/OUyaAoiJ/P6VEAVi9QrcGA62HMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T35l1z1jTVniVSnHSFtL0YTuDgql5hbbYs3v5LAYKUG0hKNO7bZmaVBv2O8dDLTFSB4HFQCJlfhl1Yc5LBBtJiZPXyXbjZuaKqLwgE+kux4AYKJVmAfK6TG/BCLB7o7h6bVVxpSt19EV5SLCU5SY6rCXDWU4rbCSGtHVlpRtzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDMMSW09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDMMSW09"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B356BC4CED1
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727853887;
	bh=CBKr339bDut036D/OUyaAoiJ/P6VEAVi9QrcGA62HMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pDMMSW097JPdUIeQjPR5UghcgFSHj7IwNbW4cJ97ZpX3zEETmag3pi3iGT+LCWRss
	 DEStHsAz/PaVw9hI1bi71b0azEvQhvpDK1uVdrX3v7XhnJgeO4mqxk6JjxTKahwPsh
	 0VqS9tjFvbfXRCSuOhbrOtv2r0ELFHA5USMcUgKHpxPuPyVLlrkJ1nAza6cOeg3GmG
	 mZryxvxMQsnDlvMFIgelj8SCRRmkiGCa92p3jU59YyLPr/LqtV+/82OKwshpCDluza
	 UpL5a2uUAp/0MNyamzIqlmp+U/CewEUxx7yWM0nVZzVEtb2kZtUcxJH3w8/MGzsKEo
	 RwsREs8Zuc+aA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9D94DC53BC2; Wed,  2 Oct 2024 07:24:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Wed, 02 Oct 2024 07:24:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219333-62941-X000WgTsvq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

--- Comment #3 from sander44 (ionut_n2001@yahoo.com) ---
It's just a message I saw. I don't see it causing any problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
