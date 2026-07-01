Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A3362138
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921058; cv=none; b=QWQJNVu1pqp6X2mP1wwVYmiULU0LDt0spZ1CJ38lP/jnaL+nS6q/895wdu8nwrK7LAE5zElOvBrYUeBBgkj9fs08awINoTaUrLIkgZ5xjQ16jwSKXFxvVePhCL4DcHOqp156INfEH5DcKTw/l1InfdEKWuAUduc3tf1QPmxLeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921058; c=relaxed/simple;
	bh=PiKpTyCzFW6oJJGuzNRLv3EmmD8yxaD5dhBkqXjJZrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlyFMrAf+sEHrvC0pE8W3ptxXf7F+smSBISMdbqxBUozlT7+kEYghu+CV052QXOWG4xFhsvwHkYB5MHPBoRRj8MEWxnYJy4vejFGgN5s+VtBiMQDZjacK5VwTEQDCy20VK3eQWdMXr6q/dJRVPzC5EfacSjsiomVb8ESdQRc0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBbQ24iw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBbQ24iw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C7B3C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782921058;
	bh=PiKpTyCzFW6oJJGuzNRLv3EmmD8yxaD5dhBkqXjJZrs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZBbQ24iwb1ecSdcTYkWeNK3lbB7RvUMmReoN5anKv7OAfVx+EUxK8mFGvBjfV19b/
	 2XbFyIB50IJo+WdtJwdftSlz3ZfsRzj+9odLzGsxReLs23YHLRUZ2SWBazCCcX9psm
	 iLw49f7VgHTskWdwivRH+YnFzhUyBOc1i1i8aPPqhIr5AzNOMLovKPqod2zyLbVzv5
	 k9e/wtBbahmvtJBVh0WmwHikt0ul5aC0gFpOoCUKwxpkme47PSmi4mxKr0c/bZgUNz
	 PbRpAkAL+1qTmaevN3rx/hbgL2y1uQtEFO/Q493ONNhYcwWJ3sI1mzbz6M08bk6H2K
	 1gjzWx/vYEymw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5ACEDC53BC7; Wed,  1 Jul 2026 15:50:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 15:50:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-DRHGuMeyjL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #14 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Thank you! Which Linux kernel is it? Full output of `dmesg` would be nice to
have.

Did it work flawlessly in the past for you?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
