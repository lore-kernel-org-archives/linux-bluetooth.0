Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96091C0DD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737201; cv=none; b=RGIpEyxbk+v3VfwsVTk+RVsjNzK1j1WSkISxpAu/OAg0xgP5Mh/D1ibLnfKsjXJVixir/vmJKp+CpKiCRjcPfF1pjNlk+Cr7HCKkOSZK1BiRbCrPb64Xb6FtxqUGEAy2yXEql8Dhyb5O8UDgZvJJn7QH6gaGFE2ysXzlZ25dlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737201; c=relaxed/simple;
	bh=uo6gjUQ1VK9Am3ANJmG2FsAo0dN897s0rurLdBN47lM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGE6ydilZwsmGsQSn/UhWcPvmap25iW5tuURJ4ggjndM8lZX/IJD2QqGbjpKS5Sc05G1F4i0UbfPxgZLAouiBbPbqnyBGqQOxShWzI6yJGLkzodKBDlAAuUC6zCrJt6rkOyexVVBryOTRSlOADMLLBVkyKpgJsUy0rBEPdLg+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzd6r3qD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzd6r3qD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A44CC43394
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711737201;
	bh=uo6gjUQ1VK9Am3ANJmG2FsAo0dN897s0rurLdBN47lM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kzd6r3qDqI9qrmPGLU9ZH47JlkJZ+xV3X2ueX6ofmzEDmAI7TV/Q+whaiirU1Sb71
	 4+kXBx+SZ5jRRRta4mRJbZU//anawKSBAfs5qZSVBsX2V8xQRGaSK8cu6aCNuKrZmq
	 7xNCoFwLQUiu28wsQq5LLaiOiO4giIaFbfAlhEb/IJSuRvcpS3z5oNf3aXZSxQf2Ak
	 fZwi3tXgCquN39mdjomVRbw1fi8KRwkZhELNj24GIVDN3pw72pgCNYCk0LS44TPC6d
	 A2fXz13+dhQRUA5dgNRJIL/kNXEtHEp+d6x68Fg/WaQwxQwKofWabBXv0Mq9mrcrct
	 LrNuo5Y+UfXAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B071C53BD7; Fri, 29 Mar 2024 18:33:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 29 Mar 2024 18:33:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-sv2ZMcpO68@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #12 from Gurenko Alex (agurenko@protonmail.com) ---
(In reply to Dustin from comment #11)
> (In reply to Gurenko Alex from comment #10)
> > (In reply to Olivier Delierre from comment #9)
> > > Had the same issue. Somehow, after a long power-off and turning on ag=
ain,
> > > Bluetooth managed to show up and the message was gone. Using an AX200=
 as
> > > well.
> > >=20
> > > Currently using kernel 6.8.2
> >=20
> > Wow, indeed, after upgrade powered off my desktop, flipped the PSU swit=
ch
> > for a few minutes and it worked on boot. This is very weird behavior.
>=20
> Sadly, its short lived. Mine stopped working again after the first resume
> from suspend that occurred after the cold boot.

Yes, same here, after normal reboot or shutdown (assuming it happens, becau=
se
it also hangs on shutdown/reboot now), it **only** works after PSU power cy=
cle

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
