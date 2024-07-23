Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4113D628
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763578; cv=none; b=D+FoucuY5G+xr/stQXZNZtBI0jIyJBqnQ3FXx++lck5fJKZ4Z9fs1rQMPqjRBTEOIR4zGIfZWjjfElMqwAG/m/YK4R4FMpIT8YbIdRnouLsobvfz2UM3R2sJHTXT/Vhr6faPyI7qznGSVmN+bQz0C9FcfyKUmU7lRU4sVF89grY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763578; c=relaxed/simple;
	bh=Ro7+a54yZww+SB2lk3mtJeFLEzajw5fDSn5TQefibTE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tfnkkiYWNqnk7xeYo/isYNnjdp6vrA1ELDNmoQPLoojzoaoHPfSs6rXx+pfUP5Cop+OUnvjrfiIEyOrGuojtwZTkBUA9+k9ykXtsLW8UjtEIZrcjXhZJNieTLhtdmZ62XyMXTIGZwpiziof+oG9r/ec6xuauhqFeR43TGSv7YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q82fN6W4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q82fN6W4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E8B5C4AF09
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721763578;
	bh=Ro7+a54yZww+SB2lk3mtJeFLEzajw5fDSn5TQefibTE=;
	h=From:To:Subject:Date:From;
	b=q82fN6W4PIHyZ+HJvOaDLktI3YJZTSEwZdrTuJx0IMVVGX1dMVIJ/NCxGeyBAhnoI
	 cfYCH37NxKfm/OZ6TloFEPMH+ZY8SXEKWTwIMqfX6d8DQKy+9c8s22qgNvraSUvVO0
	 rl0808al+YI0HspUrsOqpzEn2HDAkRCHWLgvAk6icsIQb5plZAQbsp2J83zXJ4lf18
	 HTpnRhMK1AbmMPeTzKyxKU0pplOI6fP0TVsWMT0VmV9K2aXWUp7ArDUF1ksLvS9Mpf
	 eP0WyBCjyl0oNal/LY84S7LbVKEBXA3Q0syG6+dOHhWHmli6ueuoQLgZz/tTQ2jw3u
	 eOL5C6wPdnzLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6000EC433E5; Tue, 23 Jul 2024 19:39:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] New: bluetooth scanning doesn't work in 6.10.0
Date: Tue, 23 Jul 2024 19:39:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

            Bug ID: 219088
           Summary: bluetooth scanning doesn't work in 6.10.0
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: eugene.shalygin@gmail.com
        Regression: No

With kernel 6.10.0 bluetooth scanning finds no devices (Intel AX210). 6.9.9
works.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
