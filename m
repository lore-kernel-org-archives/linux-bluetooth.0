Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342556EB61
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTk64OTE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AADAFC433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703162595;
	bh=A8xGG8OWsq9ymVxBxNMHOD3RmtLkcpXkKlLJkahok4M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DTk64OTEt0YVpURFxsl+/K+tM/htVVs4zN8GUL98PRkOcU4jPC5sASfEf27/MIxFY
	 q6njgjircsTbijCSOgZpWYmUrxgNxn182NjAqDqVpQp4X0RoLWlO7bJZRmAGY2rzbg
	 QzgBItqmxq/oweME3MGN2SbV/b4Hk3aZFPtH92seFaqCoMmqaUkpV2Q7kPhAouyJ9U
	 gdVZU8QNmODoR2jUV+MTO1yLx96ckvXLSD+IAjAgBaG5VrzOTZiAR7T/MsXPmYKlcP
	 CHp2R/rErm2uNZFhL7qEGn6KBkPchGelnsetu959R9se6+r9mL8/627sbjsJaObToq
	 nyL6hq9/VH6Fw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6123FC4332E; Thu, 21 Dec 2023 12:43:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] Potential kernel regression with bluetooth pairing on
 specific radios
Date: Thu, 21 Dec 2023 12:43:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218264-62941-htRZOa0WMv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218264-62941@https.bugzilla.kernel.org/>
References: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

--- Comment #5 from Marco (marco.rodolfi@tuta.io) ---
Today I managed to pair, finally, but I do not get any input from the keybo=
ard.
in dmesg I do get this:

[ 6539.432356] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[ 6539.432370] Bluetooth: HIDP socket layer initialized
[ 6673.460129] hid-generic 0005:046D:B33D.0006: unknown main item tag 0x0
[ 6673.460148] hid-generic 0005:046D:B33D.0006: item fetching failed at off=
set
271/272
[ 6673.460171] hid-generic: probe of 0005:046D:B33D.0006 failed with error =
-22
[ 6706.511559] hid-generic 0005:046D:B33D.0007: unknown main item tag 0x0
[ 6706.511586] hid-generic 0005:046D:B33D.0007: item fetching failed at off=
set
271/272
[ 6706.511625] hid-generic: probe of 0005:046D:B33D.0007 failed with error =
-22
[ 6741.248981] hid-generic 0005:046D:B33D.0008: unknown main item tag 0x0
[ 6741.248997] hid-generic 0005:046D:B33D.0008: item fetching failed at off=
set
271/272
[ 6741.249017] hid-generic: probe of 0005:046D:B33D.0008 failed with error =
-22

Bluetooth regression AND hid regression or this can be caused only by bluet=
ooth
driver shenanigans?

Marco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
