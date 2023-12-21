Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B155E72
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elSrJQQa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7626C433C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703172446;
	bh=PAm8a6EbPux5nNkTjDef3qwkSw+ZnkVv20rE6p0YO2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=elSrJQQaSBrRvIWeGraxW2/PWQHVBPNJNsJ4gFhQzArJxt1B/rLouqUJBnrWnRmGj
	 kWRnBomrGNEX7f9se2mbIDmL3fbCANs9N8U+AskO0Ek+VgSyWj2h2Fxk5GH0rjDv0R
	 xZ+F8u5+c6PhAvRpfxnrjCI9Ql7NXone8ITFoSK4LC6YYrqRaZIAMW1iFyVa2jUvuG
	 DrXZ4TbnUGQuYue8lPWAUsabznph+Qwbm5SrRMoBVjKg4pk3cJuVh/yCGZmuAERzTC
	 2fdFQ2KIPKOqajryp351M4FNNPSGpjVi6EPmqKphAyk4yrxcKnG0du1IzsHtH1IZfG
	 3gn6oYKVBmM8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AC804C53BCD; Thu, 21 Dec 2023 15:27:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218299] kernel BUG at mm/slub.c:440! (6.5.0-5-amd64)
Date: Thu, 21 Dec 2023 15:27:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component cf_kernel_version version assigned_to
 product
Message-ID: <bug-218299-62941-gPSTChPIrW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218299-62941@https.bugzilla.kernel.org/>
References: <bug-218299-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218299

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Kernel                      |Bluetooth
     Kernel Version|                            |6.5.0-5-amd64 #1  Debian
                   |                            |6.5.13-1
            Version|unspecified                 |2.5
           Assignee|linux-kernel@kernel-bugs.ke |linux-bluetooth@vger.kernel
                   |rnel.org                    |.org
            Product|Linux                       |Drivers

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
