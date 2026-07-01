Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0425B095
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914492; cv=none; b=dxkJ7R6sPlVNTuEtzh972AIsmqvUE7a/XfyDGxcMXtb18+nUwxcDDaYCbJjvYXQPHCNxdO/lHd/F7VNgejU9ucEt9RqCEcLec4/z/Pa8V5dVN+5OMo6/UNvcawN3YBiP2RRrMIpGRxsNel5k7+Qy60OU5pGPV6QO8xWgILCDtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914492; c=relaxed/simple;
	bh=HbOY/QyQDGFBelAf+4WB8w2ozs6sWSEhpTLFoKGqvj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwOSHhKZC8sqwoLQYOIe0nop7aQKX/rojh6g1EqeFibZO8Fc9c9OETtv8xiL+6hR6/6XdbeJl5T5H4W493uXMJ59D3JF/2WlEnmZij6DcIzGQvYfMt3C2k0NS4wPmkyP+iEQm71eoxcb8HiVKG3B0Viks6PcIfRrwYiH6QNv+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlf6l84c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlf6l84c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C94CC2BCC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782914492;
	bh=HbOY/QyQDGFBelAf+4WB8w2ozs6sWSEhpTLFoKGqvj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Dlf6l84cy/MpQny93jTpEtfYvXm0ymEV2QxqKWPqE2J8baj4N6c5qtgH0PrV0pJCB
	 5RVTWWTrNMaSykFx8VmSAMtXBeuSm+hpc2/MgERaVtwbRglfSyI7eiAESTGg+Y2DNN
	 z8SM0xToF3TvPpkrjo0ub5duLorvt/ubAZQ8gSyPoH30BXzs+1HxUM3ZkJPAMg3Kzl
	 AyQrX9xqreM6QKA5ngbd3W3q0XYU61ZLUjMk+IZ5U78ARqlLlAp4fMEJ4Oax5o++rR
	 dDkSwlZG0tBoOyTH6RfVl5zMHZNeIDMwHKoPm2UqfJAVraP9m1guF+qH/FNJezbfkD
	 oHI4q2ISD1OWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 293CDC53BC7; Wed,  1 Jul 2026 14:01:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 14:01:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-220564-62941-vxNicRvB2F@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #10 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Created attachment 310408
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310408&action=3Dedit
Output of `about:support` (Debian=E2=80=99s Firefox 152.0.4) (Copy text to =
clipboard)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
