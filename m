Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47536A8D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341916; cv=none; b=hoL4YDAFlu811Bn3vZAvM9fICK1RpmGGHWpuc+ji6zxSBHhL7zE3NB8yXMT8WEBcCqxIlkOJYJeChKkWrhX+/GHyrEAseUpv39/QMxhEyO/yTAkGKyogVMoXDEnxMqtjCJYysYXJ/BYEghsCTBfztmTg6lyC3SsTzUoIgujRfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341916; c=relaxed/simple;
	bh=V1qDGLqB0PEAIN2HugOsn6s5Gnu34N5oeozxab2gt1E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tR72LRC+6UCu4n0apwT17ymjgJpToy+0agMEQ7/iWSOtd8vMJeY38/ftmNLpelidz6dbc5Q+lkk8q9Cgydts9OP105lkyOKslKwfkeMCnpdHxXYxGjeCEFgU+9O1W5s/kVWcWvbRounGcALYDhG74RppvIz2wsKYXWBa0hUhDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjBVKFUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjBVKFUj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6239DC072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713341916;
	bh=V1qDGLqB0PEAIN2HugOsn6s5Gnu34N5oeozxab2gt1E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NjBVKFUjQRypEf3jHG19d89/qVWHZC6RxKHGUnTwSB6JXG1OVfKOoM4my3ChU76ex
	 6I8yHeCgC5hdn8e+Z7On+WiXzB75Qn1tcb2HI1dqRVcEauBtUUH1Fks9Vev7slGfOv
	 8MAVUSFOn3YZpw9jGZOF3Spd3KZUWd6QbzD27Js7EiZaSWYrtxXgKQ7nTWIDA9rRJ6
	 vTajRhrIFz++O7m7gCtLNG6pwrZ/DMqtyTjmLF9CQAVh0tQijGrN2vXhFzPPjtyURx
	 7r5P4MJP0eETaYDAz0W2BXSBSdzDodbqXH/VNTcWv3/PVnETN4ON4Tv7vIOkeDTSYs
	 7jACVwR4AObwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 53122C433DE; Wed, 17 Apr 2024 08:18:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 08:18:36 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-218726-62941-wzKnIAzgRa@https.bugzilla.kernel.org/>
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

Wren Turkal (wt@penguintechs.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #306152|0                           |1
        is obsolete|                            |
 Attachment #306153|0                           |1
        is obsolete|                            |
 Attachment #306160|0                           |1
        is obsolete|                            |

--- Comment #25 from Wren Turkal (wt@penguintechs.org) ---
Created attachment 306171
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306171&action=3Dedit
00567f70051a41 + Zijun's 2 patches + cold_boot + toggle bt

This is a log from startup to shutdown of bluetooth-next/master + Zijin's
patches after a cold boot. I toggled bluetooth, which failed. Then I shutdo=
wn.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
