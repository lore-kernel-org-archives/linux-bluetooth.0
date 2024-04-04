Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE993C125
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205950; cv=none; b=DlADdLrwRYkdyhLY/9+LEztKvnzs6BEDjZjZSTto1cddw4V3UDfBfPUGZhEcVOZ6aLduc9ivV7jb1IY07Uy9VgDFBEpV6RszuGdpppMGqBbl/lL3XFYpMzPWEUGBrX6G3OVVgHrQZKsaMdYa7leT6JCmpURmgBdE5K0K3mtM8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205950; c=relaxed/simple;
	bh=828zZTd1iOMFFwT+OKvokH53faQevEKMYLCR58Aiyig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5ShvJvx4fkSXaiLLHcQocFgK1D4rsD5mPs1IU/CuWZ1t6ktyU5JGQRKI1gNesXZCLGd3ctOeGAO6VGzXyMlprAr6wh14a7aYVTbtP4R2JxFvC/2cfvO9GEm1OrKDzT4yrwhsvmiSoiekKPw6gKPfp2gTlEpiJSh5SZIgi4bGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1vGpFBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1vGpFBV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE4AC433B1
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 04:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712205949;
	bh=828zZTd1iOMFFwT+OKvokH53faQevEKMYLCR58Aiyig=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G1vGpFBV5e1Nvkm0wH5phnoYzj7DOWGrjdDjzCWM9nI0QdzwM4NydlsvOUFh0bvGc
	 XjlkcqMD0vLtFYqZHtm9JCYswQse1BFx738kl/vLbzXJ8onc0ApdSgwIjHb0dihxY7
	 Xhv7h/GmWnb7WBH764MpkOBMSjVz/er/7ws3/keP6ZkLdXCwedCYxF2nQe4MEdGfSb
	 04P1f4julz3PH6AtvCcFTo3IQZSSRYLjyopqcMdYOu+ffE5CiE/FBmmAWoMeiuEG3P
	 X8XqDcggdOjcWJsyxNNQ4nbthxWTudNQZHadcvE2y89vXITGgeVDlTFOOdrrufC1aE
	 G8zpkl0Eu55tA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 180F4C53BD1; Thu,  4 Apr 2024 04:45:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 04 Apr 2024 04:45:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-3mQda4frZN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #22 from jb (jb.1234abcd@gmail.com) ---
Tested stable 6.8.3, boot, lsusb -v - it is OK.
Will keep it open for a few days and then close if no problems.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
