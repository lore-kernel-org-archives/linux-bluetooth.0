Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884C7E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmSaZSTU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F44C433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700101670;
	bh=J2MXx2HFjNRcXohAsGfHDLNHoEzpi16PLZ2Y6rpgCRM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YmSaZSTUKVwAEsxGMCwHRGsPl6+3D2xj87ZyGQAmPh/S5KCysQ8gik5QYLroBh9EL
	 oUq9KcSBODOu2BgRsIObb0g8IHeHJP+/M3+OdeJae9jM0KNVw/LfglOX19RrEb3eoR
	 B78pVMUNW0GMogIsqQyLG4EdLDh4AZWgkIcWpSLLb/QgqSFEK/XWnqCu7eGIRlEpx8
	 +M2zNSXMJLjsnQJGTa3MCqfBtx3NsypoijXqoZ8zcVj8G1//GQk+oN+zRLqqZylv7O
	 r44WZgnOL+55ovgmYlSI1TcFMS3zIo0bfJ3BPHnOBrkzAeTshO+7oRxyJ7xF7md1M2
	 0d0dqU3qTNMjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBC3EC4332E; Thu, 16 Nov 2023 02:27:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Thu, 16 Nov 2023 02:27:50 +0000
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
Message-ID: <bug-218151-62941-QNl3ckeuXy@https.bugzilla.kernel.org/>
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
     Kernel Version|                            |6.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
