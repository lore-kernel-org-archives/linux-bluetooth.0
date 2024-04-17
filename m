Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267E524D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345503; cv=none; b=tIvPzHLzTOXJf0zLr/VkCuulZtM9VxR7IRolC6STCXrPE5D1/vHGkiHK15To7iDLLxk+vTXxy6+5Zaxy+/qULchitcbivL2zBGznj5voAoZTvNxPVLz7qgpcHz3yASNIQRu9HDm5asuSzvROP5Oo7MSsIchoEtln244cliaIrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345503; c=relaxed/simple;
	bh=lF6nxXXEGp1UBR3Gmxbt1zRZt0HhxWYH1wIFpPJMy0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LiqBmD5Fp3SyWO9zfiZGK5wFNbw8picRR5Xs2Nkx6US34U9oPlZEhk9N2fkjJEYqIUi+szDoy45JL35tPuZ9CvlIEZIBQZs6BHrx8jffz8UoAMhiU9HzMuNhRf1wR7PzpFH4nmAdedf7qrm8cU3H3IWMl8zGyOQ4aCaegOpEPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeCoP8jG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeCoP8jG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 000F1C072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713345503;
	bh=lF6nxXXEGp1UBR3Gmxbt1zRZt0HhxWYH1wIFpPJMy0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jeCoP8jGVXD4Mp1yMbHJiiRsjTfy+C4mI67WekfAG2KmZafbv4Idc/bx2vtVaHX72
	 1QlkFZ/pADoQZwuhgOwLA0EIMzf7loa87TVHxLqnoQuNzMGXZ65bEWoFsc3JDrn0DY
	 QP+wQmbCgy8dbDMgX4Gg3Q/+UzrYZfzw4cEapHKHiO0ODoF0dMulwQNIa3NMY89YsA
	 1aepFOL2sGKTMFqx0dlSmYVomRL/lhzecnoDYSCjnbXzjkVm65xJjinpSsvn50mQBL
	 DblrN+/uae7JSw3w9raImTEdTvkgwqPUtP+vIECgCbQHssyXf17xIPPvzETS1mg9GG
	 CM4I+KAyO3VZA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E4B7CC433DE; Wed, 17 Apr 2024 09:18:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 09:18:22 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-TVtPj6RkZ3@https.bugzilla.kernel.org/>
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

--- Comment #30 from Wren Turkal (wt@penguintechs.org) ---
Just so you know, I added the following parameters to my kernel boot:
btqca.dyndbg=3D"+pmft" hci_uart.dyndbg=3D"+pmft"

Does this get you all the logging you were looking for?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
