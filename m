Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28383DBB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173336; cv=none; b=chaB7OEEWZ8T+1sqzbxxw/fb6EkD+GpdN3ZXHaBlDOrpdpyZi/YaHCoSJgq4q/X8AZu42fIOr3zSmjAoQsI/VtQ+CDY22FJfASvy3Jpyj35bBk/Wf3CvY9F4UqZVgBO2MSo1TQgYyUvGgKz5k5FCesrUtkSeFYCwGujSLRqJ3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173336; c=relaxed/simple;
	bh=fRF9IkbQDqvNwKsaoAxPvRwagQTjUQBRdZ6mBp7LuXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4qL9CADyLH99IOv40bRbF6c9GefPLpUs7hbeRWLiIfNPScAR4pduJ+6fjSlbV4lpqf3CFHkpVAoCllU8gexOFVbj/qxmKFwIMaK2bdKVshFkaIKKpElQnqZChxFCajNmc3wNwXvxUAG/+kbnK/GWqs8Qj0RYzXq/yH+oBJW0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iko+Eu7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iko+Eu7q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83816C2BD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173335;
	bh=fRF9IkbQDqvNwKsaoAxPvRwagQTjUQBRdZ6mBp7LuXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iko+Eu7qQGpzz8+gnY2DV/mncYUnGHPSdTdSoHWE2S41Aj4VuzdCXNaWloV6P4nJq
	 chz5YI1461ebf9dHyEpsTe++Th1pKaNybg6JAV8I/reT7ljfAUtXFToSjNTM7YMwxo
	 XTrT1LZEzXHYfpdceY7dTfp5lJAWz+Qd/k0n4eV9EQlflyPXVY9/CO7oAn6LNmfyKk
	 dA61tZOtOmMRGCQOBzp35sLfEEYUOyXLAPArlzauMSOn5mb62q5tskF/eD2BJ3X8QA
	 oGDfbHTNY45mtKY5JL/lu1YYGleKNYQhunxKqQj1qgmTgTI3vZpmTt1fS4wuAjgnC1
	 n7KcQXr8Nm8iQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A22EC433E2; Mon, 15 Apr 2024 09:28:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 09:28:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-BxWeWcrygf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #4 from Warren Turkal (wt@penguintechs.org) ---
> The dyndbg didn't seem to add many messages in this one. Maybe I have the
> wrong kernel parm to enable the dynamic debugging messages?

This message appears to be wrong. I believe the new messages are in the log=
. I
guess it just doesn't try to load the firmware and is much shorter.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
