Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607330C631
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049554; cv=none; b=Rv5FnOItJQj4ghWwb7iIiZ2mP2Bi+Hj3s2P9fynsrLwKuYknqxT/ZpjIxIsUFSeiMnQckqtLnRvzf65wtImfyD3qYsFu4XOch7yjI5N2TzRN90VBOqcnEqmWCUlXCDsiEjH2qiAcyy92GnBOqKbkxuLJQy2A5Xm4IodgTFwtt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049554; c=relaxed/simple;
	bh=IZBTueQSndoHiVog7AzGNCIntOFTetO6s/h49Shr3zY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDXH8BQS5OfJCH729XI0kedIb+ZuQPgu0uVLTyGCQD+CUsWQNocSTCg9yZFUhpSxR86ILJBVeoQoKXWPMD93WiqCsZifo4UsW5YcwZO1ymHeW0dT22TcGBFOJBDm1NQm4BkKCWQkKCkGyNzlQJRN2/btIVWx1NJ+MUa73QqEwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW6dWcWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW6dWcWv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A99CC2BCF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778049554;
	bh=IZBTueQSndoHiVog7AzGNCIntOFTetO6s/h49Shr3zY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VW6dWcWvSyw+ERhYBkqh6f4eMyDJChVoChqmnRM7XD4JzoqzupwYgrUdv3iHxBiKB
	 1SRspmTi5rohcr50q32D7g1KpdRVETJf9YlX4b+89Kiexze1mjFvWCimVsTM5OjlJu
	 LKqHoinqNwlyF8AfGMQSRXUSR1WhgcoYhIjioXkeP+lJSKoT/fD0hyK/fI0LOex1v7
	 NQ3plUlbCsKreNRFq+0Em5QAgBstcXCMQ/pCTXVLiQ2pmhRonmNwfRBc6VYCKj4Lea
	 j0U8zJDNDEN+wW6PdBgepD2ivnggOXoAPxpApZFRWWzXk5PUX+x5zhLe0tpYLEf2t3
	 /wDdOh23TfCIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 093E0C41612; Wed,  6 May 2026 06:39:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221449] Wireless gamepad stopped working through Bluetooth
Date: Wed, 06 May 2026 06:39:13 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221449-62941-isMMDPCIsd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221449-62941@https.bugzilla.kernel.org/>
References: <bug-221449-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221449

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Next to trying the Linux kernel, could you please run `sudo journalctl` and
look at the date in the beginning and see if that goes back far enough? If =
the
gamepad worked over Bluetooth back then, you could look at the first occurr=
ence
of the error message, and see if these are an indicator.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
