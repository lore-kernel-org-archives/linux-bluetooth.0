Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F33806C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869065; cv=none; b=Svk2M4m+QveGAiqxCAgD+ReLVORN0Xbo/2HVnv+ghAHwu/Z9He1yejRnIR0ddULessqEwKns+maHSn0Af/F1CAHro82dE6jyqohOL8pGiPQ6tAJNu+Ud1p3/4iSxvDl5bnqYiHlZhaeYNyUh1SRyCGoM1uVx9w0kYRm9iZoQmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869065; c=relaxed/simple;
	bh=2d0oY6dZwzrhKWoL2cZKrX5jbt3ZqVWRJ0rJF/YHxdc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOaYG65/h8WBde8a2PXadjnMF3GQKuHxcvU/504vvuTV7yGcjgBXsMJtsSgzcFeqrjPPqJektAteEaJRSVfuRYLKse1QoQRSuJuP6yQs7D2fxBZCdjw5k7+qrFdSZIRdcz/UQPLsK+VIhrlYihqFYGlamFnwsbuY2Sdsw3LFwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFcLFmCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFcLFmCM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60F51C2BCC9
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781869065;
	bh=2d0oY6dZwzrhKWoL2cZKrX5jbt3ZqVWRJ0rJF/YHxdc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WFcLFmCML20RmxjDpulE2qlAbZQKtOIlXKw7k2ptqGr/+QFjC9i90SwwWOx9abr7c
	 i9XjNd7gDymB+C6oir2IcDBZ6BqLCB5uwusdF7DjxsY+OeabT9V3BwlqAZWPqS/7j2
	 Tkl2XPsbsxq60tJBNdQf/G16licT6ZpCqL+mYJsnj7U4V34obQsOpmL8gYNsICNqKl
	 18ANbY8hJKpHvgWg1QLF60eHQCBwk+dffDaQSyhW6Tx+rPk75PNhJpYNFPZqKi+EQa
	 zlomO04sgmzNz1aknCl/J0qPZBbPG7ihh1c5Xg121KCE3i3v9cDjx0zE4+uI+c5UrV
	 wfuD32pW/qwig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 538B4C41614; Fri, 19 Jun 2026 11:37:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Fri, 19 Jun 2026 11:37:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: webcapcha@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220564-62941-A0H2vyfcMg@https.bugzilla.kernel.org/>
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

webcaptcha (webcapcha@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |webcapcha@gmail.com

--- Comment #8 from webcaptcha (webcapcha@gmail.com) ---
I have the same constantly error messages in logs. I would say every 20-60
seconds the same error

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
