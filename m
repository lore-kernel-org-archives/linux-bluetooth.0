Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085B13BAFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362931; cv=none; b=DzCZrEbiUBEsYGe5SKi5ZufcjCI2yNtTpljh0OGCpL4vlYosamQbTi8dJ1NGddbAxR94lvSzO/fSGoLRwRRuMv6CDRDht1C8+tnaf00EBlTcfOVj4xXCf3BmfuZ5qOVc0tXpK3G/Blud/5QRSCpTpoBU1Smh+FASYIY39KhvWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362931; c=relaxed/simple;
	bh=uyvMjGT1BbWAAiapZ21vI3RqVcdkyltztetr9sG87sQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TujoLkOOfncR+ppjCuCMk2kHAL3nhKU1ApNPjAJRvyI7YGIWBkpDfyvm8k+UQw9dF2ZEuvEqt2VTArK5UautfXJEJqjbiYHC1U1bnO+aJ23yFw2kODHgM2bYFNKVXIBvticFIgRDcxHFjUnMuGv4XarwwFRzyMFyLD5qICcIG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AryMLpXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AryMLpXE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81D2C116B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713362930;
	bh=uyvMjGT1BbWAAiapZ21vI3RqVcdkyltztetr9sG87sQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AryMLpXEaJrseU3Pd606Ll6B2yH1jg2PO10l4S2fpNJfp2KusHXaG6panvA1LQflh
	 hf0ksyG5oioLiRPI+DOBFDkUEOXziHe4+c7j5bVhIXtTY/8y1tJlMpvGcRLrIN2hlf
	 QUQjvZ7U53UI6zQBhfqBlp5dSX8xVrqb7ssidzX/8aiS8QxnURwOH5GKp1u1noRckN
	 FBTjzsh6gFH+rTkA76SZK3InHx63VX/uMFIc9PDhrx3/NhzQwOFCsLdTxXSnH0Dr6G
	 q0gwe3AgKNwAS0L7eUslmf915BdywToJp8NxOKaFbi5vHL5Vvgs4leLEY2+Y7Bh//7
	 jI008ded6Y01g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8677C433E2; Wed, 17 Apr 2024 14:08:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 14:08:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-SCQYhnU0uO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #33 from Zijun Hu (quic_zijuhu@quicinc.com) ---
(In reply to Wren Turkal from comment #30)
> Just so you know, I added the following parameters to my kernel boot:
> btqca.dyndbg=3D"+pmft" hci_uart.dyndbg=3D"+pmft"
>=20
> Does this get you all the logging you were looking for?

yes. the debugging logs are turned on successfully by you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
