Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75BBF4E5
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKtED/ez"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB0CC433CA
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701542873;
	bh=Qb9Sq/eeJKWLAqns33wLVAFS//61QkKsv3dbdZoibgo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EKtED/ezmA/q+0w2YAA4/XY/6BTkeilCwx4ICfwkrZ69v+RW1lXCESquqp61MxPAO
	 HHKzCgH/B26ukAIXjLxPpROyZxBQjuduSIFfmRcNtsxOo0MAA+k0qR7T+YgF9XRtHr
	 uthOOZfqkpwSuwvyz28uEwugoBsZyH+nTCsCZWlB5dBNiPuT9wz15l54qbJAGMLzZq
	 D5x0CAtb9pPUMZAtm2VifiC2HvYH7Guc1b8/rSjWzGK/aAHtofOUfEtOeadveMe4Zf
	 gcJJ24miYkpe6Fl9XCUb5FxZu+BIRXa1vQ+kLut/5nip4ET8tcfGZqkEORwbP6fxXj
	 P2KZRtNj98Vkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C302C53BD0; Sat,  2 Dec 2023 18:47:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218142] Bluetooth adapter fails to recognize on kernel
 5.15.0-88-generic
Date: Sat, 02 Dec 2023 18:47:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugs-a21@moonlit-rail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218142-62941-PxZBnqi4Lo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218142-62941@https.bugzilla.kernel.org/>
References: <bug-218142-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218142

--- Comment #6 from Kris Karas (bugs-a21@moonlit-rail.com) ---
Created attachment 305530
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305530&action=3Dedit
Output of "lspci -tvnn" on the Asrock x470 Taichi motherboard.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
