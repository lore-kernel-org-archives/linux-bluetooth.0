Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5940DFC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847479; cv=none; b=sUcFwGRbj7C0d/m653qw8WlAOPol+67JF7BU4lONpRg2gvFUQAEkbO9w0i7+evS1f0dfC3hQhvgLYRvknedhKFSvyICV8+NStAHVT53JE6K69ffiJAVc44QxAD3+mNQxMSnXD4PYLRetsDFMIV4p3m2PjsU+Rw5vmiQXZDS4Qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847479; c=relaxed/simple;
	bh=/vtzwwa1f8LuGJRn6BFsmc9MQgxVBL3RUEwVIZTVECQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBuSHGaM3DB7mIM+Sg8n+o/faZcEhWmnyo8lxZGHgv8dPeuuFHAOdiw6K5xN9Mg6CtID54HNLblmNtGyPAJyeuo+V/x3uB9freD4YmtFPJtf0YraMdVgf6fmOEKi1vOGYl4y5yXLBuvhfGZ/AZiKGp/zEHifmUkHPIVupiDGbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coUcRCXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coUcRCXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07E28C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776847479;
	bh=/vtzwwa1f8LuGJRn6BFsmc9MQgxVBL3RUEwVIZTVECQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=coUcRCXZebqTki/E6J3/k5S1plMVVT/93eEk7HoYgfyd4nSsfDE7vLhlxXHwMV1zv
	 3FC/5J7OnuM2ZDS0VVsE4gEm6lyXrP/l8zmiCFc9z+x2tmPUU0Hiez181uta0epGRv
	 ER7XdA4tmBcWUeqjRc5Wmd1K6fioYBEca+aMublgx81OyjrHzwXRtRUj0z8Wbvt5jZ
	 M+nFuEnbyloaasPAlJImCZMjfq3qIsszlNdEbaBYDJiiVx1XPKYW/DQnQWUdg81+r3
	 vpXPI1zN+19PW44oiNj3W9bp9N5q+iWkTnPWB8vSuNEdoyTFRvFcShnCIg6wRjbQRC
	 HlNfuCejD0C4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1675C53BBF; Wed, 22 Apr 2026 08:44:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Wed, 22 Apr 2026 08:44:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kiran.k@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-zBDUCutudD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221339-62941@https.bugzilla.kernel.org/>
References: <bug-221339-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221339

--- Comment #13 from Kiran (kiran.k@intel.com) ---
Raised PR to revert the faulty commit.
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1011

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
