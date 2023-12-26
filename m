Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BA18EC3
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvF1r3Wo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38DB4C433C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703562134;
	bh=5oxIcBhCnTTV6WZBdsMW3uESKOc8ngB+TQzrvB9lSjs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PvF1r3WoxklSdwbwhicRtNlWP8eF65IsJ6WdGuXU9SOfLxwqb/eMVPHSNUD0h/WgX
	 GS3I0PC14Pwi5tm8m6sJLqEeqmynAH+Q2BaKIxv0KpDIRMcfups0FzLmQ0P/M8Wo4m
	 SGQbUr9dzsEyCza2MlGem3J71GTjgsidoicu3upEt2pFT4InY27dqDoseRbsMydCTS
	 IrnpAi/lXaNiFn1ynyUPhqHTiK2ZCM4WlMEhiW2GiEH9fEw1t/zT+UtGrNCOWaXEOG
	 C/24vkjR77k9I8x5bbO+ug9e7D66nF4HG+5gVLaXdJSILxFZf3grhs8cjmwSjDPElU
	 m4WspygEaZ67w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18C18C53BD0; Tue, 26 Dec 2023 03:42:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 03:42:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_kernel_version
Message-ID: <bug-218323-62941-cS9PAX2dIv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218323-62941@https.bugzilla.kernel.org/>
References: <bug-218323-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218323

Yuxuan Hu (20373622@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |20373622@buaa.edu.cn,
                   |                            |baijiaju1990@gmail.com
     Kernel Version|                            |6.7-rc2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
