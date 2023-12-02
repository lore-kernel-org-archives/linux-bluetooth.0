Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C38BF6
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE0BsGUe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5B7C433C9
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701502150;
	bh=F6lSy7OU6iFkkesObE4Li4e/ROaZbZZdU+1jbyA7zl8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TE0BsGUeJ3LIHYhm8OwoSS4GqczHOImk2d+p109YSG+mVTdhjnmC/iqNj2ZB7YEYu
	 PX9fppVzUwe9qDUZMTo9dLMXtkdHzEP1H4nWsbZPJFgQUumxz4c+hI6xgPVnLRnfCo
	 NV3AkDvspZCXtxDow2Idg9bm+PsgOEzbDt3YK0t6Mgldm8d4FRb/NnVzqF6SvoBXMG
	 Z8ZYieJ9F0ShrElKJ1BSLBTDbW1SXI18BfW12W/nOzxGp1SS8/yq8r7d/l9EgvaSbM
	 fgqvLEfUObq9eqUMEPSD5RSwpyoT2gi03bXNfOCF2SQs6GLilwXXO0lRAuYWeGEoMl
	 rX5WpVhfA+HEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3473C53BD3; Sat,  2 Dec 2023 07:29:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218142] Bluetooth adapter fails to recognize on kernel
 5.15.0-88-generic
Date: Sat, 02 Dec 2023 07:29:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218142-62941-efjp7w5IkC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218142-62941@https.bugzilla.kernel.org/>
References: <bug-218142-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218142

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for bisecting the issue so quickly and reporting it to the list [=
1].

Could you please attach the output of `dmesg` and `lspci -nn` and `lspci
-tvnn`?

[1]:
https://lore.kernel.org/all/ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-ra=
il.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
