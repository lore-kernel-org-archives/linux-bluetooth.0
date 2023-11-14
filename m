Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF60D2E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3HnERsz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3629EC433C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699941042;
	bh=CiUF3HM2mqGN4/4FUSl6wF1O/UNWsy94Ymqzm6tDN+4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U3HnERszeVG7mxaMjamjf89sigz86XI2QExkJSXFiRgnfhtSEcOXkvO36eQDrDaTM
	 VNn53zxJhIbzZG5OqsuN8Prbc8/vDY4aEof2GojOLO6SndgylR0XhaKqM9zyqx1cg4
	 9z7cm2zZnRkkRgCkHTsu1YARGTmd8WLgCS7ICKrpF4f1dGAWMtyCmljvAXeECeJMvh
	 o0x0U1blZ94cTNUNttNuwm9I8m1cmcAUdV/dAb8c4nFNzXOWzaO/C3bJPFD/bcp7Wx
	 F3vy7Pi5TjN0UycOtJe1ZitI7nVa3gGD/M5AieHpMqiTA8DZ2KHbzWpz3sLpiEH7Hp
	 EEvLfLMZ1QYKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D6DAC53BD0; Tue, 14 Nov 2023 05:50:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218142] Bluetooth adapter fails to recognize on kernel
 5.15.0-88-generic
Date: Tue, 14 Nov 2023 05:50:41 +0000
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
X-Bugzilla-Changed-Fields: component version assigned_to product
Message-ID: <bug-218142-62941-M3Pf35rpwZ@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Kernel                      |Bluetooth
            Version|unspecified                 |2.5
           Assignee|linux-kernel@kernel-bugs.ke |linux-bluetooth@vger.kernel
                   |rnel.org                    |.org
            Product|Linux                       |Drivers

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Does it work in 6.6.1/5.5.11?

Could you post dmesg for both working and not working kernels?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
