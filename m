Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613C1A700
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdddU6Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 591FFC433C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703561715;
	bh=z4QxoDKEbYWsc5KOhngvH6JT4huggBtFJWVLt02Mti4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IdddU6ArJFVYg3/FaP745Nx4FXJ6iKVxGfuKTHFmanratf68Oz+L/Epe59L4VHq2F
	 obYfdbqEIGtP7bbV2bjeucVv7fSDEDGCiqV1amfay5mql/V26YKssL+PVjILEiOoRI
	 V2XKTf/QskYsOw4S/AGkKnv/CCKO5iR9+DmGTKHnLRnjyLBor/Gcbe1IGeFzyfGvss
	 /HHh764RRmrEmPLkhwHI1ZlC7/SUwaOjomwsv7ka3qsg/LawHM+m2ssztIG73EWYjL
	 fuKMllJ8XPbQlW98k1P+ldFhPnT6w/wtYnETsI0uYjmvDS2YUjde+d73Z3c0HCOZCr
	 7kKg2/1e/Rrxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3D487C4332E; Tue, 26 Dec 2023 03:35:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 03:35:14 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218323-62941-0VwVtbwOml@https.bugzilla.kernel.org/>
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

--- Comment #1 from Yuxuan Hu (20373622@buaa.edu.cn) ---
Created attachment 305657
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305657&action=3Dedit
Place of Encryption Key Size Response in a normal connection

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
