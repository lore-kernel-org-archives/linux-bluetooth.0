Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3E367B8E
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239945; cv=none; b=FDANXwNQs5xyu79c38to+Ksz2F6R5Ymu5WFIRf7EwD00333Qp4G0redcnSW1RRRWzbFg2pHNifUtpG+sVTJtTOslCACAv8uJgXlRyRt3fxbPzOlLQaayHMEasyy85nQr29k+eOA+gEiBgG1dQ38xCCVq2Ghjc40aJTOAGmNG46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239945; c=relaxed/simple;
	bh=Pwxk9u4hpEvRSfHD9UCa5x7rmqIvgfWirBh2dW/c6xg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9nKBAIT8A6n24glGEE6w09f81vlzBM1BMuYyldyIFqzI+Zc25DqR6BaYgIQ4CFhodR43WW/3B8AJGssyYF1cDyGglZxr1OZGB699fWkhBfRJuXcIQ9TvOq/KSOmuiA2N1ExuK4QHL+EzJznUcGNvIeFDKrCeGEts1AmaXhYxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QipH3+CW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QipH3+CW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7FE5C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783239944;
	bh=Pwxk9u4hpEvRSfHD9UCa5x7rmqIvgfWirBh2dW/c6xg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QipH3+CWmoNprTbgAiLaYedfVkG2ou8eSJxzAXGUlhGhvi/X1Q11aZ9pBGItNH1kI
	 bkxJIXIBCIrisaIYV9ntc0tw2ow18ZAA/cCTuZlANjVUNx/xYI9GLQXQ8PemMH9i3I
	 cwz9TocyCEhWENJWeYn9WIin0LOprZO/UZbmBwCwiPXVp4WXkSuKwLqHX2+BuSUdwA
	 qhymH7yyxPm0i6hiWfN3xm6B8KZr/dH68d5JgRIe+qVZRd131vVbWB43jsO9XklXwh
	 DbTh14cUCk5c6Dtnf1J9lzAdFGW8jUs0bmIU/yVODoEf9mCVFM+G+OO1WaqGonLxWd
	 uTuom32vg0KWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ADE2EC41614; Sun,  5 Jul 2026 08:25:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221724] RTL8852BE Bluetooth (0bda:b853) fails to initialize -
 hci0 stays DOWN
Date: Sun, 05 Jul 2026 08:25:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221724-62941-V43juA4dzt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221724-62941@https.bugzilla.kernel.org/>
References: <bug-221724-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221724

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Please attach the output of `dmesg`.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
