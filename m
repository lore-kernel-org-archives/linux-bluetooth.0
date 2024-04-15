Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63D3FB89
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173240; cv=none; b=jMcyka4O4+VXIaaLn6cxljiR9x6rk/ekfd651WozziYZBtEE83vl/Ot1PBtIjAXllGkhyFRyeuISTxdgIG39MmVGC+Y9GtJ6zq6kIzpWBKpAwFIGQHgXbt9MfMjj9J72gzFYRiYWV4NVjIRbvMAyAuC0+fFTYu0f8PWmDngK678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173240; c=relaxed/simple;
	bh=X42soYH10EkFeR8CQLCxqB2QQo3OoACnqFqRmipniZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6jxfusXrQdNCD/pDDqMRfMZogOAvJLJZOW24Oag6UOWUiHbaN1YeynLNawqYvJb/NoQu49vPEXotQfMo5WelfVQjBGabk4xyhPbZbZpbCrpWqhx4M8fexmgBfLQP3rzasOjL36Ew8VwNVyNrzdKeUNyIBjrrpQsTBimi+w4hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWdiCxcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWdiCxcU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 009DDC113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173240;
	bh=X42soYH10EkFeR8CQLCxqB2QQo3OoACnqFqRmipniZM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bWdiCxcUuZWodMc/W9HOSMighHb1xXsJz511Fd3I7lJpU/d+IVj4m9F0doUNV7w0U
	 Qr6ZfDtnYSfXTx0VlmabshFV5qF0H10dAFtB+RhS1wZ3NGq3su2Sot2h3rplE1XPHY
	 I3nUoYoj0VK1O1vo5eYlymhxCGL/T6PNn8HR+sBfNpoTTKa8kLmuOlzsvRsWYDMiGO
	 4WhasAylgGeqi99ubVF58YgqsrLwF7Ghhy7SZuHXfQ0lt10YbUKvfKOdw/qnm34k2d
	 BimJbuhGM3NMi2DXxYg74Patg53E2pIIyuEbZKGO6z1/GMYThugd7pOuVkU3Vup3cE
	 I0wyOlyQeljYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DC970C433DE; Mon, 15 Apr 2024 09:27:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Mon, 15 Apr 2024 09:27:18 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218726-62941-qjUUzPkNYl@https.bugzilla.kernel.org/>
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

--- Comment #3 from Warren Turkal (wt@penguintechs.org) ---
Created attachment 306153
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306153&action=3Dedit
6.9.0-rc4+logging after warm boot since boot

The dyndbg didn't seem to add many messages in this one. Maybe I have the w=
rong
kernel parm to enable the dynamic debugging messages?

After a warm boot, the bluetooth won't enable. This log includes everything
past trying to enable bluetooth twice in GNOME. After the second attempt to
enable bluetooth, I didn't see additional kernel logs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
