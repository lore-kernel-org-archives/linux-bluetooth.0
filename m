Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC142E6F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893987; cv=none; b=GD5RrXe2+xAlNwfde3YYdWwpMdaM8Zl9x+XiiLd7XDITVSFiAEwykyMJRoKFkcG0KyirJjyhhw4q1dd7Du8qCu1ddVl3uP88Q9aDAlw3tvo3sKiDfQprPetcPwgaLKwpWIz2O0nTx3bjaMvP5Jb3omODointjMf+atutCFbbq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893987; c=relaxed/simple;
	bh=V8hq41l36Yp1Ot16uaszW4OXgiPf+gJ0p+4TK43nE2w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rg66pD9hH5tONijkTuRZDLe/5i6UeaGUG0l/07rtBZj9cxtzCM7eUFsZ5dBrwpy/xb2LH+GNfeWv4zd+6tC9jYGqQhD1FhtGLdRvgL7ZySxZmXejC1GksK+bBN7YFaq6azvdE+00nroN/xQ7Kglz9UXCv/SFMT3L++Sl4+T5lTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYnUfdSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYnUfdSX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC53C4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728893986;
	bh=V8hq41l36Yp1Ot16uaszW4OXgiPf+gJ0p+4TK43nE2w=;
	h=From:To:Subject:Date:From;
	b=oYnUfdSXMJM4jYCT0gzBnHKjJe0ulj51gX8fmxMDFlUGzVG4RSs2cde7XJhxiKUTo
	 drhA+G8jQSPTr8OHVX22H2wLNI0ctcTJwI0Y0OLhXOTTaGEct5yw03nL9vhW4ciUOA
	 c7BjsaOD/qHYuD11Wr8xpBs4XzDDPKAReteb1Jkax0TrSyIsEpI8ptzIU+HrTrEo9W
	 bCXFwhhDFYtDwJOU0+Cvo2/LgVBTtZ5G2ktCFE9cgLX1p0vgWlJ7YtpA20ZHt816jB
	 aBnQE3lM/asIIkN/nZeMndvm83mPSBUx4/yHzYmfXphnsbJ/OUh8JuKAB/gpmIkYm9
	 CR0WFMKcwN2xg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A95CC53BBF; Mon, 14 Oct 2024 08:19:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] New: BT mouse can not be found and/or connected in
 6.12-rc3
Date: Mon, 14 Oct 2024 08:19:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mark.herbert42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

            Bug ID: 219385
           Summary: BT mouse can not be found and/or connected in 6.12-rc3
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mark.herbert42@gmail.com
        Regression: No

Installsed 6.12-rc3 and lost connection to BT mouse. Deleted it in blueman =
and
tried to pair again - scan shows some devices around but not mice (tried
alternative mice - huawei CD23 and Lenovo) with the same result.

Reverted        610712298b11b2914be00b35abe9326b5dbb62c8  - Bluetooth: btus=
b:
Don't fail external suspend requests

with this commit reverted mouse is available again with no issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
