Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6842907
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260488; cv=none; b=dg4PnGnOieruGfwUIJHlW0AFn0uhnaheD4vYR/4qmE8x/NEnoQyWJaQCOze+xlwIuyPPsDQ5xYdbhN8kNUMuta3o8AQN64iRGNPEha++dL4DU88DkuY90GvYFwD+yqvyIyl4nzGOz3pI0ef+FuamtbTdRPzOsdkkg/PZ29VGTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260488; c=relaxed/simple;
	bh=FbkvYsxhGz0SoiV3nwCISoDaSxuKYDqNgNorvzKj9uY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7CQmeMjknZ4ao5muovJfLXwyKRycQlA5O8MlK6xlI669SGXT90bp2WHR/uPJMCUWqc4+wasRDTKdzt22BSHo3s7m0QZXBTusi/dD619Noh1dnLe24neRJuMxbhwsP6ZVjQIo++vniR1QHWHf9xKiLcem5u+QtdFHEheIddwivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+29ePdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+29ePdh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6360EC113CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713260488;
	bh=FbkvYsxhGz0SoiV3nwCISoDaSxuKYDqNgNorvzKj9uY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C+29ePdhLpkOp9QZsnpvD9TrxCSyPCbY32oBVtDS0RjMr+zOFJUK6GcYZ7Lq+BqSr
	 +mE0aFY6/yQBkXlBV4bszMeJmA6tlaJKtue8090sxA/SdByCQ/c5ye23/zxlkdRiNe
	 4wbn1LGffBAOtkLBCDx4cMWSIxHh034RRGFzy2IIzFzXg4QD4fCJB6qYuxtidOqVxh
	 1DCCiRrBkRTLb6ImgWZo0Ulnthw8dlkSuc5iENzzFrEFR73KMAnv4qlep7t4OANPCW
	 a8pjCPz2h745metWtVFDi21lKUi1minxxuZNVEbpETHW61XGpLB2psAbggb1WAU6jB
	 NMrdYzto0DpCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 568CCC433E3; Tue, 16 Apr 2024 09:41:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 09:41:28 +0000
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
Message-ID: <bug-218726-62941-ToqicgRqiL@https.bugzilla.kernel.org/>
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

--- Comment #20 from Zijun Hu (quic_zijuhu@quicinc.com) ---
i think it is not related to linus kernel.
the disable/re-enable working is not related to the quirk added by the hunk.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
