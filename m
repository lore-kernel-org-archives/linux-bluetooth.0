Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA51759F
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763835; cv=none; b=Y5xuJxGMomRFtuExlVWnzX/Q00r482LP/if4uxLnq9UX4g5G4U0moOxxz9LqmnoyL6Yc1GFqgIEtymcz7vWNirLCy9MyrUOdm+HEQRx//oIXNFEsxkCzB3wI3OnI7fADEP043KkYKaE2orKWacBssj7jqwaDDxkFypuZ3iQ4DZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763835; c=relaxed/simple;
	bh=+jVDJchzE32fflE6C7wf7XDED8pElv6qjtq/Snvrgd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PT/u/bFH8JWxlcb+T1ulcmf9O+yOMj7pI62u3iHik0SD4wE8hvu/Sv0eQIZyNUXTK/hBrsN164CfeFADu3vPZKX+zsQPq2fqr6ehFuLUy95/d9UMPvTOf635sKQJMpjbHAtjVnUY5bnGmSQj8VFCXAD0YAJkigyGuNhirNr40Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJprAuSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJprAuSf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 122C1C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 05:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713763835;
	bh=+jVDJchzE32fflE6C7wf7XDED8pElv6qjtq/Snvrgd8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dJprAuSfA9B64aXWdhmG3x2toBzw8ji8FWa2yO3JeZdYBXrCybElB5SBUXq04M34p
	 bdU7Gwn9rGKUuR4wKQbAQ88XRG3lQwtsV4bIzwU+1OVT7sbBYp+JthT7j2hXJhAn4U
	 5Ybi3mSqk4Q6mWjKIqvdi1jCKfZArTVhiMupe3hsk3pG2FzYtlv3Mg0/Hj2StKEAcF
	 Zpm7hQ1hjVohnnUpo2qALpp0x8mqO9C/1pSme68t8GZRQ79ofzUK1uiTaSOr1y4Qj3
	 gAnGA95ApjqJijhGhT5P4nkcZ21MfVoGunsrTbFEMSjBSFQoW+VUDJZNvYTQhTUkvI
	 R2/j71f6+SPEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6956C433DE; Mon, 22 Apr 2024 05:30:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 22 Apr 2024 05:30:34 +0000
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
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-218726-62941-fyTNUSfu6D@https.bugzilla.kernel.org/>
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

Wren Turkal (wt@penguintechs.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|IA-64                       |All

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
