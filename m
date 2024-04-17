Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749142A9E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342132; cv=none; b=euJ0M8oHUtrkdUYVPCsQsw5U/xvWS/alvJaBVHCMi1v6NfWtd9eLLsOdJ47VDLlxau2LhXtfA73nEoYYysS1VJAJ4m0o3PW6SO4TA5TtzYqZxrjs8U/xo+yytvPajr13ImLyaxpZt7X10SjLzraqNOkpH5E9VOx6t6PWl44GAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342132; c=relaxed/simple;
	bh=sKpkHbMOKoS3nPFW1PbE2F0ptCDrcc2110PIHx9WMww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FyERfLnQDLU0XRnikwIAOKXNfBCMr5benWVQgZZipAcJMdq8Mp3Zv0VTow+olJue5lKThfXk/e18RQRE1ZCPpb/Ntxv4sF9SPziyqNQ0/UBQVaymDY2yBn23udQeVDL0SoPw6wG7PdGl0EQJe7I42qKN0oJliLqCy8CegW5La10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2AseH0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2AseH0i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89111C32781
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342132;
	bh=sKpkHbMOKoS3nPFW1PbE2F0ptCDrcc2110PIHx9WMww=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n2AseH0ifHtNEsOMdEdaBmCiqGd3tJeCQRrkSvGrVOvU1lkkBCTUm2OvYox715jaW
	 ysep6xyMWGsIvmA0fsg6pR00PE4BEd1QR5tQi5pdddQVV4I0gPVuLlKOh3f6f+s+c5
	 GuRpwHf17gsyF01ZQwZhcngtMcEycW1t2robpC9ms/a/caEjNMJTEk6na8Z9B+erQ6
	 cS0oP1Pe7UGfhgLFF6RjAgSbVEeEl1skyGC2VrgkLCeP5ZgHwNZplzoXwDHDJJQPGa
	 A3aozbEk6UH9BaafMBol6cPxJqKJOGf8m208Op2rK+V1R8XwoUP7rzBtFbNEQx+8UZ
	 jQ89vIn46rY/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A9D5C433E2; Wed, 17 Apr 2024 08:22:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 08:22:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218726-62941-9uECS2C17U@https.bugzilla.kernel.org/>
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

--- Comment #27 from Wren Turkal (wt@penguintechs.org) ---
Created attachment 306173
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306173&action=3Dedit
00567f70051a41 + Zijun's 2 patches + warm boot after working cold boot

This is a log from startup to shutdown of bluetooth-next/master + Zijin's
patches after a warm boot that was restarted from a working cold boot.
Bluetooth does not work. Then I shutdown.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
