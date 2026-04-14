Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B637EFED
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151677; cv=none; b=SeLfp9HbE74EolwEA9ln/pjxwntlesiMR/DJLfHSZKudpE8lOZi7Wy08bwinSp9xFMQjrpkCNXZHPPA+oyI0mma8cmakwHxkV0c9BXINUgWN8ku6Uv+I2KFpxtQFYNYTUJjdJY83YEQv7hLrDRVLuopI/CpU0KTPiA+0cmjQ+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151677; c=relaxed/simple;
	bh=P1/ucJ3nUx3joiJ66f/9ov5d7uU+TkUSgcnHMZjxPmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3+vDXj6lU9JOyxmwfU2PhqrDVeZmFQi7PS/xIvn3vnsYa3PhAX8dUKxmsnyEjigJOA0Ru56bUTKtiQN+fEDNGfzv32Hi54qXn0FGal/W3KJeTCkWZ7lJUdhLdKhzgRpnQsS18sW3+7qL+P8Tqw4yvqm6Qskl/0eQEtfWNybjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbQ0n/oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbQ0n/oI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD3F5C2BCB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776151676;
	bh=P1/ucJ3nUx3joiJ66f/9ov5d7uU+TkUSgcnHMZjxPmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gbQ0n/oIr67+fSEJOXADMbCUnqjNh84PmF7lnVfoM/etrKa4b9R/AoM189XSwmsam
	 LpOTLhOPDVSeO14m2DyB1iS3z1Sbe03WJ2UnbgPrlrzQjj1mZvMVTWUkDFhC4uyEgW
	 reUBKscogRsdUle0QgI2o4xW8+GEy/8IFgMFj3Eag+GNVn9Sbk/guVgxrWq2KAg9eN
	 cnBNByaJ4pdfobXA0pA+f/AivYkj9eKlt9X1dBSk6ievmfh7WT/twR4g8LbMZ+BTm+
	 POOsCkWepV/DGFK/FLTWP+a5e7l3Oa5ywnDNXyRpFUrf9DMTPHx+jDxnGcrk3pD+T3
	 OJW7ndheLeppg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4ACEC433E1; Tue, 14 Apr 2026 07:27:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Tue, 14 Apr 2026 07:27:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-AZTzmWi8Ev@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #7 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Paul Menzel from comment #6)
> @Thorsten, only if you didn=E2=80=99t know, but for the Bluetooth subsyst=
em the
> Bugzilla issues are sent to the list [1],=20

That for some subsystems nevertheless makes no difference (even if they hav=
e B:
pointing to a bugzilla im MAINTAINERS, which BT iirc has not), so email I'd=
 say
mail is the best choice.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
