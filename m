Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0E2C851
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQH3Jogp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1610C433CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703563075;
	bh=2CvOktXqdJkIBQVf95QAiEq16aWFGdF/Dz/Wg9uObXY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KQH3JogpDVStMEPVnv8VhtdxPoaas52MvqZXM7GIBqqlCWkpBZes5qP14o6D3eDKo
	 vKvyfGLjQmR4oiC+OfJnUxx5F/yHnNVACpOeI7rCxwTMBX1/JfmX65Edt6ENceGKqg
	 6mFpEl1d8q3pKgiELXfQLyjcF63GJdCAam8HixQynG/bVZMl+YIM6gCKcYXXlTuwGo
	 RucKvCVI5Q87mSxIN+tWmDI2WhYWJTlCQXe8Em0+hC/W6vI71KONnqIpOZ1T/3i09i
	 wHi9ppZjWcsxBWyyBuMWD36J3R93rBKnH0IHQ/YP0gAbHQeXgzQ9AdIX7lFj+JFpbP
	 X3/lkP+8LjYGg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C47FDC53BC6; Tue, 26 Dec 2023 03:57:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 03:57:55 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218323-62941-s9CcIJJWrs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218323-62941@https.bugzilla.kernel.org/>
References: <bug-218323-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218323

Yuxuan Hu (20373622@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |johan.hedberg@gmail.com,
                   |                            |linux-bluetooth@vger.kernel
                   |                            |.org, marcel@holtmann.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
