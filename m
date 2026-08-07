Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87651381EBA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098883; cv=none; b=DFIUIP6zpmYDgTvkWltfb5Z52LClTWAjQrGefbVz82RQHjw/XQVxEnWMfUzy9R/OUEzrcj4mt3dV3Sod1lmw54GmnJf4XV27MOcG9MLfmTB/FOKi1aYzTlqmlpynQcK+I2nCdXP7Q216LPdd6nQlmH1IsgroFRIBHQ5cJbcX3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098883; c=relaxed/simple;
	bh=4Ad3mCZ4Fo81jBIopv8qDzn8VJQnm/jHx6/ri+5YPVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFC7ZSQ1mwtJ4OUqo4PwrYGhRfnkKc6eOgsj55amEDd7i8E7pYr3sH+lOfeH2Qj0BC/bwUO8H/nScEtPcuP6lq6cOigyTreza6eqTiJsC64+PeGYetlYm9vCpsxVm5isMMtwCKDkoiRwoPIW1Sn9ZBxA7q3Y/Ei/3wxO+mE5cFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcqR5ieo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcqR5ieo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36098C2BCF7
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786098883;
	bh=4Ad3mCZ4Fo81jBIopv8qDzn8VJQnm/jHx6/ri+5YPVE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WcqR5ieob/031342JDigIyO7k82avSLee0uI0qVpzzyJtU7wBTSyZnD0Z3iUXOCSJ
	 bu+5oMx2T6THZH4o/HNTgLPsqkr7pNS+qzHZmld15P4ucu8Z4CgqkROGNi9U05+SMx
	 XA1yGoHspTXZK+Kdga/riM7+HNATFUACpx8iHeaeJE+mFnhYil3Qxu/hokx5PB9usw
	 ZGgTGmJFqfM3rHgUqk0DC4is4NVMeAhFKh/a+nBNHS7fWuKm4JLbEY+H03JWPHpcar
	 L8bf0HKF/QEWY55DWioPCIfvr8/lx0uVpPpL6ZjebdtMKI64s2zGxp3OMmUk0PuIHJ
	 1dSeZffCfd9ZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1BB0EC4160E; Fri,  7 Aug 2026 10:34:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Fri, 07 Aug 2026 10:34:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: ARM
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-arm-kernel@lists.arm.linux.org.uk
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status component assigned_to product
Message-ID: <bug-221832-62941-SinGuqOa6s@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |ASSIGNED
          Component|Bluetooth                   |ARM
           Assignee|linux-bluetooth@vger.kernel |linux-arm-kernel@lists.arm.
                   |.org                        |linux.org.uk
            Product|Drivers                     |Platform Specific/Hardware

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
Most likely root causes (in order of probability)

* USB pins not wired / not enabled for this card on the Vivobook's M.2 slot.
Many laptops only fully support the original vendor's card. The fact that t=
he
previous Qualcomm card's BT worked does not guarantee the USB signals are
present or powered for a different vendor's card.
 * Missing or incorrect device-tree / ACPI description for the MT7925 Bluet=
ooth
function (power regulators, GPIO resets, USB hub ports, etc.).
 * Kernel is still trying to talk to the old Qualcomm BT (WCN7850) because =
the
platform firmware or DT still describes the original card.

Reassigning to the platform subsystem because it's unlikely that the bt dri=
ver
can do anything about this considering it's not even initialized properly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
