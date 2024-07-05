Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC132148849
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195350; cv=none; b=IyqTfL2M0v6bkzUz9xzzrzbw9BTqkoUzfKTk0oQRq+Q0/nS90Mmcw3g/wPuc1T3suvCtGrXm3Z+lfjYR8VilDOPIydfWiNyvhDSQGBG6VEEJXQ5KzuIokLZMLnn404EAzdT/q/Nxm09MiR+bah3kAkIFaf3K7QVuJVApUExxME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195350; c=relaxed/simple;
	bh=RAoFa//R3rsAgKTu8joLG/q0ooI6huBG217Jx3u40BA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhShMGqbWBhEkgW2vHLKGDPgcT3nrmz3YCNAWZmPc4syJbSvdrcXpRPqMb6BtWgYHVPi9bsxpKuzNUh97ACIJq1C3ror30R/KKqkJs+S95VdX/ndf7IDoUaZOyDAXwrR+jTYShZDsrN1SHHMItCWVLMolnoZvPNmUAXDZLduiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsc9FTFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsc9FTFX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE710C116B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720195349;
	bh=RAoFa//R3rsAgKTu8joLG/q0ooI6huBG217Jx3u40BA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jsc9FTFXEazJOqNgwbtd5YxMwNImp2TgLcpwE8IDqLG7st0rg6yGyU/jwcIlCOTMa
	 ormUQGjZk6FPCp3zDfuC/1I7eox8qei2WSHnmlxNA7hnMoztpRPuMkOg2MaVwpN5it
	 +PKB5s4Lx2uAwuOt/CFFred5ITZv3hjmgTa/IvvbsX42ihjPOaeBPAXMF+B0hzGjXE
	 fUYSG+pIAPQrlNoqSqHjAG6Rgx92U/jy309RebImSN8BOdj3Zvjh7BuZe3uGCEnMAf
	 Ef2M3PdXcOXfYXXM0d9g4ftUMq7VTCKE28FLbasDueBDKGoBSEPAS+cXdzXc2ad+QJ
	 PKBE9y5IOnLlQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A5444C433E5; Fri,  5 Jul 2024 16:02:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219003] "Bluetooth: hci0: corrupted SCO packet" on W800BT on
 kernel 6.9.7
Date: Fri, 05 Jul 2024 16:02:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brauliobo@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219003-62941-XY05GAtxXW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219003-62941@https.bugzilla.kernel.org/>
References: <bug-219003-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219003

Br=C3=A1ulio Bhavamitra (brauliobo@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #2 from Br=C3=A1ulio Bhavamitra (brauliobo@gmail.com) ---
I can't reproduce it anymore, so I'll close it for now

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
