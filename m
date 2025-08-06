Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779020297B
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754462352; cv=none; b=a8Z+54NuTSvzBYkjeOSDAKuIkVqx2PwIvgI065oT4KwwdpACyQ/pxZ7TMbBjsQtXXUvE7LsdFi/3svkiFQ4ZWfbt9vbEQ66kZSz/6ZRNl5w+1YoWXMQ354O5mkDDEtEHyjrF2r5zvUi9xJx3RO79T/j8K+1I8X/MKSuIM7lTulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754462352; c=relaxed/simple;
	bh=EH5ts4Y2DilLocpGmLBJNJh2WQHiOcTbYfUH6coK+hE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djJKfvlYGYttPHSGu8E3bVHKiIphto1r7giX0NsE8IcY5VHScK9amBkTJ25OjN8jCP0IJP8y9KNRshsgOCyyyUB76ijwEJdo8AVX2rSX7Qn5vd5BZhUOUZNWG6ltIT1dsTkhZKxlzmu0M03vQSHiPXTpLHDOOcMZlyYESDASJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDwwmHv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDwwmHv+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE17AC4CEFA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754462351;
	bh=EH5ts4Y2DilLocpGmLBJNJh2WQHiOcTbYfUH6coK+hE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YDwwmHv+CnFy8CdD4ClptsA7AEj3fw/WUt+BLHJwPnBONgKhFzGGNZiF8A8OrSXrg
	 nQH1IlDYfo0moH0oN4JIiCuloDHBkoCNZ3Q6ynZPYY/bZYPRe9YG6UHtmyU5S1NJ9x
	 uoHE4UtgREjpfbAQcB9nuayJD4KAJ1km01Phlx+079taWVLW/57d58QvU+OExCQQS2
	 FkKjGrPg5pjlLsSO4rDCIsAmEwXIYIWt8kLP97MwizBYp70XpOtWNGWqE2Mh/sQa6A
	 KKkKoOPAfV++yQGR5nLhxU1YzebAz/dQ5gOmlC/i0LFUq2VNm5XvNEwWza7sEbQlOK
	 bPUg88CI1xVzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B1E9DC433E1; Wed,  6 Aug 2025 06:39:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220419] Bluetooth stops working on Intel BE201 a few seconds
 after connecting a BT peripheral
Date: Wed, 06 Aug 2025 06:39:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220419-62941-HZ0WhyKH38@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220419-62941@https.bugzilla.kernel.org/>
References: <bug-220419-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220419

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Details for the bisected commit [1]:

$ git describe 6ed83047389c63a8d7712b0bf19eb38a6e4dc68e
v6.14-rc7-1458-g6ed83047389c
$ git show 6ed83047389c63a8d7712b0bf19eb38a6e4dc68e
commit 6ed83047389c63a8d7712b0bf19eb38a6e4dc68e
Author: Kiran K <kiran.k@intel.com>
Date:   Tue Feb 25 17:13:10 2025 +0530

    Bluetooth: btintel_pcie: Setup buffers for firmware traces

    This patch allocates the host memory which is used by controller to dump
    the firmware traces. The memory needs to be shared with controller via
    context information.

    Co-developed-by: Vijay Satija <vijay.satija@intel.com>
    Signed-off-by: Vijay Satija <vijay.satija@intel.com>
    Signed-off-by: Kiran K <kiran.k@intel.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[=E2=80=A6]

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6ed83047389c63a8d7712b0bf19eb38a6e4dc68e

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
