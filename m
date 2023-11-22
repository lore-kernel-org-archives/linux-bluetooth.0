Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E31BDE8
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctPQg+HM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCA6C433CA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 08:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700641719;
	bh=YHDRefKomRKMNbvesFihWvPGJ7LheRk1SZq/Q8UQdbQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ctPQg+HMSUPPEr4pIvdaumb7+Z+xSCvIkW1Mgw235shgykezv6o7/B9nUn9HYTYet
	 CaWlSRYtw7b/HcBl/7pPuwntPTtAOwl6mZWF/QW0UKFel4A1V/hWDoYPfh9uYlW6/N
	 HkKzCj8XwdHiNcKZepCJgLFUZsluZIjILhNSGZHF92+vsyz5LA29dpncDQXEw4PAzx
	 fjNHtdbZ79Lz/kr+nBI7CJQ0U03apGdjrMzysaag/JidTIEpviMBzVUw87fqugORbN
	 v4rrl/Nvk+c6h1cKir4BN10+95lX/2xVpNZqnAubsF06thjycvBU/bl6Ape1SstoMK
	 GJsjo2tNLILTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 191F6C53BD1; Wed, 22 Nov 2023 08:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Wed, 22 Nov 2023 08:28:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sy2239101@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218151-62941-WLmxBlF9cl@https.bugzilla.kernel.org/>
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

Si-Jie Bai (sy2239101@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|6.2                         |6.7-rc1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
