Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123023392B
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154354; cv=none; b=jFyLCL5GHNVbRiRGUQ3+tyKJaoRJJ/U/lTsmuu8Jx3CYeh3ThYjzqFu/k14R7b4YD6bDZp2vfMdtckQoWBlTkV1SJFeZA+NRaq3MBQOaKFidLaAql2tawhSQymOoTuh78LleufghmdVuRBB9EMZZwww+2Spk1jLal70Be+Ri53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154354; c=relaxed/simple;
	bh=nC6S28g1gXgzm17Uu7C0+7ZwVaYBvWBPVJNI2y4gOss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRcRxNrS6WE/pKZ8VNYMeFOOjDLDLtTGgDYnnIcVa1Ivc5PykegEHnkYMNZdiLp4cLmx0oMJFQIqMbMYPheGMaialpVSK29Q533jLIoM3z5c5ZipfSMgVeQve/2RJZIKw24iaD1XU9q1TQEFZBwOEfe40OC7r15F2+S16ISOeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKeiC7e9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKeiC7e9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 073A1C19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780154354;
	bh=nC6S28g1gXgzm17Uu7C0+7ZwVaYBvWBPVJNI2y4gOss=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WKeiC7e91afYtJ8c6EyUZapAql/jkJjPoXOpejT9UT1BOLkCbKVOr5OUap4o7GXCd
	 NR3gZWr8ADK4MqoNE11aye3uBF10obCk7bp2zoq3RxPgNvJ6e/iT6+QNxeG2k49pbK
	 0O3xmNiTxSQEwmMSN7DELrEKPaXV1abqBHFiYoFJTqDb3yOfnW9QMFPj5i2KnhbVQE
	 idKE+x7fuTCmvEpXJrjs0f74XgCP/sEseFfY4tRrYBa/vrvaItaUWOtvrHeu2Xl2ry
	 rzdZVtuB2Ds2hkeYttfhLXJJSfXjNNiG1tecvsqMyg3vRDgqHW3xHGTlNEfCZHV1io
	 e1mwHA7qgmXBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F075CC3279F; Sat, 30 May 2026 15:19:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:19:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221598-62941-APHgKA8Uf9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #1 from Alexander Paderin (apocarteres@gmail.com) ---
Created attachment 310211
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310211&action=3Dedit
btsnoop captures and report draft

Archive contains the Debian and Fedora btsnoop captures referenced in the
report, plus the local report draft.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
