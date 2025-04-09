Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5525A339
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192002; cv=none; b=XwHyshPPNYCgRdaWk7PWOMgIUbGtfeoVtBNQtIq5UJ+p2ATiw8vKQwAYZswT7LwNFb3+oWrQFzCvTGmQO1GRdGfFZ2w+PagqnJyW9JRAgYKQG+x548TVxxaxueZ04iTb2hNAjCPXSeTr2kqnozWAZ+7YMuXwLQ3JF46MgWkbRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192002; c=relaxed/simple;
	bh=Ihfppt+YXGlBU+hlaKMgv8ZbV4D1i9qgKnpWBejuphg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6QTk5vPaLnN/T576J/REV31EpIqug/OTDUmFad19olIFh1PhRsGS1BRotfOjY3hTYXDBpkN2OWT3SX+t+hOZBjbYPYHVg2HoYMX6Huu5eBR7wXCAoqs+G/mveYHsXvqEWx+OIvGAyG60pyClrYUHtypH2qqhO9b2YYF6X826KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXopjLXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXopjLXw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B08B2C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192001;
	bh=Ihfppt+YXGlBU+hlaKMgv8ZbV4D1i9qgKnpWBejuphg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iXopjLXw5gEQyaZxQUp8B5puAqdvrgWvVzT3zg050BBThgEqCF/mQThI9BocXxfTX
	 m5d7rk+89IV84bfMirzOsEdRbqEOjpF37foUI/zaX4T5u2obfnexTpvt0ADp2mb7U2
	 uro2OHcTB25yLfbMnh9V2wr5z0TkHC+vg8fjUBMlLf9e9CkaA4UQM0B5JuntBU4/1C
	 Ho659vv4i7wVX7JAhyf3VphXNhZzw4H+ookhXsTfJGMoZiPODu86lql7q+xEfgD824
	 p+HVwPcUR6vQXy1+QWEtBSCbqYsqEBwLKUonug96whESGdmGNB10UjDIRlt/fxRJzV
	 a8NvACe91UYpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A84C5C41613; Wed,  9 Apr 2025 09:46:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219997] [rtw89] Headset unusable because of delays and stutter
Date: Wed, 09 Apr 2025 09:46:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: francois5537@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219997-62941-2MdqrkA7fW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219997-62941@https.bugzilla.kernel.org/>
References: <bug-219997-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219997

Francois (francois5537@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |francois5537@gmail.com

--- Comment #2 from Francois (francois5537@gmail.com) ---
$ uname -a
Linux 6.14.0-1-default #1 SMP PREEMPT_DYNAMIC Tue Mar 25 06:23:18 UTC 2025
(ab99d4c) x86_64 x86_64 x86_64 GNU/Linux

Bluez: 5.79-2.4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
