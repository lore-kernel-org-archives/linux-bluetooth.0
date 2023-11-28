Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765B10792
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Ep18nw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7247C433CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159690;
	bh=u6Ls+/FbuagTAlPlNuAt9VTBIpoQwwn/KPP3XcaR1no=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I/Ep18nwNvN5xgfVl1acR/x0iZ/4KURMQhY7Vumf7LqsZVTneQUayou57r4jME9Qm
	 rbpDj4+Jlqo8wz+J1i0hSES2ixIDiZVxjLLfSF6N7xcZPRC7W+rwMjZKNg59i68/0z
	 ucPvFcFHjKGRkDO8xAaNRfUIKHG8Ir5mSJFr6A8KZyZIR0EVIAqXJToOaIg+utH2a3
	 +kDojJhS98JRqzm2qUEM8G+VCbEwgYXyEOmF3d6yTJKYoekbG1SClACTaD1z4Eco1R
	 4KTwVz6yA/54zke1bVho+iJNpsuJqK8l1uVxTjfrrCQxXAKXJo0JdEEUYCmnS/i2M0
	 +3C5JXYdjKM9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C14DAC53BD1; Tue, 28 Nov 2023 08:21:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218199] Bluetooth: HCI_EV_REMOTE_EXT_FEATURES loss prevents
 connection abort
Date: Tue, 28 Nov 2023 08:21:30 +0000
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
Message-ID: <bug-218199-62941-fz4t1ihbxK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218199-62941@https.bugzilla.kernel.org/>
References: <bug-218199-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218199

Si-Jie Bai (sy2239101@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.7-rc2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
