Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17360DC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929121; cv=none; b=pL5SaUYEHkWdYPrLxuz7d2Es8DYh6JJIXCee+MvHumTGzlUj1LWy4ykGYWM5eaaddYbe9a495PTB6+DxQhIbLT5kmkURIXNr8vHRTa1BE/R3AqMV7DT30Rw/w2zuELzRKVFmLTSuWdx4Ts8SaunsdzJQjRS6Ks7lbo+30wYeBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929121; c=relaxed/simple;
	bh=SBeZEnUD/qbqBz2HFR1vChfyfRs8puE7NEPuJhbMLNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOFaNrWXXb+xg2HCuyKf6lHRGOhuqeYGKSSu8dYvJeg7OFVR9awJX5FXI/dNQCQaG1dmzp2a6tEFykdUNxBLNLaPSJynj84Jg+mbhGWCoXHVUPy/bxpcvNrBzB8v1n0ckheEdCExFCpYgTT1J7lKmfyDe8ouAwPH4Tkc6ramglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxS0ZUq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxS0ZUq9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 924D4C433C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929121;
	bh=SBeZEnUD/qbqBz2HFR1vChfyfRs8puE7NEPuJhbMLNA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fxS0ZUq998ZCoZyjRP+H0JO3TE4GnHcDqjh4DSMxGI/cVN8FPGdfpDosL0adHQCTY
	 yStcaZZuthUcteFiUBNPC7Vgf8RscEXaSL/8xcAkK3/jZ34NhJz22/cIsFpuErJVGn
	 Qh6KBUoECnZ/rgzUaxu/Jt78m95tC95vuofR7xURGoW/r+nKCVhUXVYW3zjc8+lWpc
	 /3hLJ0wfdUw8pwfghA5fr+CItJUIJUOVIM87x8rAlaydtZsKgbW8ZBNbCFszWtt93n
	 JiHTysXaxwbNI6D1+E4C44A9+L3lGGDcPQOp7ZR/V7RkK+wQTaaTG9Cd645O5eW3F2
	 CA3po3l0gJ8gw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7DAD1C4332E; Wed, 14 Feb 2024 16:45:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218494] btrtl/rtl8761bu: RFCOMM is not working
Date: Wed, 14 Feb 2024 16:45:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manio@skyboo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218494-62941-IxWRoTagJK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218494-62941@https.bugzilla.kernel.org/>
References: <bug-218494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218494

--- Comment #2 from Mariusz Bialonczyk (manio@skyboo.net) ---
Created attachment 305869
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305869&action=3Dedit
bad: log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
