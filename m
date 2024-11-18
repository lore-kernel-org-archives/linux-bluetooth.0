Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5FA54F8C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945198; cv=none; b=tcij5k+V1TFYnJf0VE7tnCMwCyxb9xzzGRBQ/QK0F3jPEJTVBKHZqts+ckuJOaRvF6AVwCKzsP39rXPNLFIXstg68iRhvfdyzlF2jcWLwIRSJ/aMqW5Txa0o6j70mxmmgXoV2UNEcgdn4paqQVn/UzbrqYyt82B3xXtkmZGrl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945198; c=relaxed/simple;
	bh=NxC9Ft6q1Tn8mwkGzg14d+u5Oib/8YMX2zUepERr6gM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCsHJdhAdHV9t0GC2UW2GnYWndA+JTUGHyXsaGeCYdydg0/txNa1D1vnOf7ISk78+jE3oTRXMVfH4YiI6WHxUBiD4pKohMakOaarm5p3sGCDPABHgtWFRDdG1r52NQHCOYAm48s3nMWPRkB1xmZ1UelJYNRGSELXgKrnzMRpVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrwwW0MX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrwwW0MX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21B92C4CED7
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731945197;
	bh=NxC9Ft6q1Tn8mwkGzg14d+u5Oib/8YMX2zUepERr6gM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WrwwW0MXKxJr47esN6UVT+RuzxePYU1ZCGeuIoAas+Osyf9gymopLAcch8zJGiCDp
	 JN0tjnqD/Qi1Ypfo4ilHMI5PiMqV/nmaEenCL9uPdtdOKXmUDFq9MsTjwXHla04qMo
	 bpM6wdDqcY3ANkMQ/wIjYVngPM02X4iou1W3QqpMbnWE4phwOlWtPpY8UTb/P13Fwq
	 tF0Agci7KlLS/RT2i11JxrffCutRbzF2gFIyXNN+sPxhKBcw6XILfq1YhPF5wRPeda
	 SFEs//zjDCyDx7Ogf5cYsaOklya3Ky0YRYhIc0KZ8NJWE3ef5vEYMhiZwh6qKQ/9xa
	 NbWfAESEUHUCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1526FCAB785; Mon, 18 Nov 2024 15:53:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Mon, 18 Nov 2024 15:53:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219458-62941-nbodXDkfeh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

Giuseppe Ghib=C3=B2 (ghibo@mageia.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #11 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
I've seen this patch is now included in 6.6.621, 6.11.9, 6.12.0. Thanks.
Closing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
