Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACED214A6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823327; cv=none; b=VwT6935uI8fW6bOKgXqlgPaCShVVSzRbXdpYlgEAcszPMR4jbVvDOhGyaHeBS0uDygEgFVPukRAHjh42jqUnmqOfT/RAQd+cKUPC8KMWvOJRR7hccxjid4kSgBOE38QF/9Pp545mYQ4zqt7mqLta0N91QYMiStN8SmYg5FIyEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823327; c=relaxed/simple;
	bh=v613IG0UfCf7p+pk7rs7ZM0GK+SpEEHGfYpXB17/1uM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dInToPLXBAYOSYfjk/OEHxj2YCSM+xj+G/YtHHAX/BPpr6YIRZMmG7iDMZ1Tvlp3LEUU6cobBhF3bTLf7femgEqOOPTpDGuzymiX7/hzZslZS2MuYzJNKo9Yw8RgrHsT8qUsrm7naXP8d1lBzE/h8UmHXJSSh5xOnzlZp3RgbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiLJiefa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiLJiefa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9029DC4CEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752823326;
	bh=v613IG0UfCf7p+pk7rs7ZM0GK+SpEEHGfYpXB17/1uM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MiLJiefaOyB00Gn8ZrGEytp50BsnHZN0JxuUYawUsYhwn+gGuYUdpgpjFhFnfVEkA
	 +hNLOkQYhk9E3WhlMkMdgkNeEbzONlrUXmJKGtkGhlxdHKIoJSVGOPKYtH/yIwKWbo
	 HtJzRtEI/rAwEE7xlviSnrK+89JWwySxhX3hXoH6WRa+7X02c4f7u/eGtrI3qT3Tog
	 xtt6lshQifee0pdJ/58G0jBQUksIVGRwHBXtbsiC13TYui32nUc4LOvzmrrqV6NMgP
	 BHrCyRIbQJjB8qsF8fIMbzgxFptalmJ8JzqqJR4VlSp39Zp8ug19BBkA7evCQC1TZS
	 x7hnQnpvUlM/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AF13C3279F; Fri, 18 Jul 2025 07:22:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Fri, 18 Jul 2025 07:22:06 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-UNQs4gdgjS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #15 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Dear Nicolas, good points. Just a note, that the Bugzilla messages are sent=
 to
the linux-bluetooth list, like the one from you [1], so the Linux Bluetooth
maintainers should be aware of the issue.


[1]:
https://lore.kernel.org/linux-bluetooth/bug-220341-62941@https.bugzilla.ker=
nel.org%2F/T/#mc48c93498be698b142662d7d131c624b98bf5287

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
