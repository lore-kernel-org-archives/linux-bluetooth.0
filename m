Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450211CFBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASo6D4Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5C66C433C7
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700493819;
	bh=hNjBxSY9vXLMCmSNFEwSLWUTq5euZmmlF3ZN9hXyZPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ASo6D4FcOOTlqcAmRcn5FvXoiqBfDxQsZLOMzdtq+x13u3r05STdTwoMPLxJuQiA4
	 VVNQaH4jHeTWk0ihQ1+p5un2W1h6FPBswOv8aDhO1uD4PCplZDJlbzVK+63+1xCkpa
	 NgwOsKMpUiEhlEfTyXZY+JbA7L8sF1TgTW1nzPCqFGysIN2X+WgYLvDLYVvSfo+8qI
	 SJjZBnAuTnfDE6TGxz38DMadY1P4d5Q1+m4NdjN4kh9oXpR+42sR84p1S9x1L7jY1R
	 UihLyiO8llwmbG1LDocEJyfvatQhYOW1ysVonykLvpG7hlmcAvMFkv5ZwFk9OUtyJF
	 Am8S/ubG2Vw4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1EEFC53BD1; Mon, 20 Nov 2023 15:23:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Mon, 20 Nov 2023 15:23:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218151-62941-CN16Carlt6@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #3 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
https://patchwork.kernel.org/project/bluetooth/patch/20231120151039.323068-=
1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
