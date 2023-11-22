Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880D79CD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI1z5p3s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A55AC433CA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 03:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700623408;
	bh=apR1T8ueQivOPB1TI0XdCJrPnXt0GnUWiafPVOjv/2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DI1z5p3sClrxfHId4HWDY9K2bSduoZJMYgdgGyfHCcfObN8YvN65LsWQFkGNiGySa
	 uQ4mfeBnLEKM6JuK5xt77KqRXzroR+f8GRTQb+nmDLIYcnGPst+X+o+eWTs7ptUvnf
	 xMxtyU9PBbqm+7xwGelOuL5+DoON/aQqKmTuKangKNVL766OT+nhEmpqv965DEDhHv
	 GNwDHI0k/8RpP0wOixeRknCZSKvHCGY4rzAtCdi7LQ91i282kQDIYGSHClC/EFh/Fx
	 MrUXi6Q0DPH97t5slEhqT55lXyB76Xsx8/RvtccLQABHzdn7L9cG+0NgUyaPzWmt8M
	 MnzOb7vSEglpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E41B6C53BD1; Wed, 22 Nov 2023 03:23:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Wed, 22 Nov 2023 03:23:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218151-62941-P8q9yms4m4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218151-62941@https.bugzilla.kernel.org/>
References: <bug-218151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218151

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Si-Jie Bai from comment #5)
> (In reply to Luiz Von Dentz from comment #3)
> >
> https://patchwork.kernel.org/project/bluetooth/patch/20231120151039.32306=
8-1-
> > luiz.dentz@gmail.com/
>=20
> Thank you for your valuable input and feedback! I greatly appreciate your
> response.
>=20
> I have confirmed that the bug has been effectively resolved on the latest
> mainline with this patch.
>=20
> I sincerely appreciate your valuable input and solution once again. It has
> greatly assisted us in the bug fixing process!

Do you mind replying with a Tested-by on the mailing list.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
