Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E189745FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424931; cv=none; b=GWLq6kT2YYi9+9NIo8Y7HgMWzCVKHjRjmjlfiYCK/PXiN5x8W8sHP0V/VdHcWMslDITUGsajw2LE9++eN5+dk8aWEAfk8Zdh4ZEm8At0fu8eALuX0wwLnvgrSho57uue4veuk83MtrjNy4vupNFQFZUadQdbMTzcvLNktaDdOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424931; c=relaxed/simple;
	bh=O9fR3Mj/CBdCdCOrPgb9AcXpJMP1yrMhIdRY7Zk+9aE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVM2hmjin5kMAcmH3SjRWr9bdwvFIlIHbvL5P9s5c0sbCq9qROOy056xNVtlJpv5L682IdXyeYi/nTVVlafO1VFmUWLh3oxTyg75tgrgKkMOMSVVv5pKmTZjbB1NGchI/SVAHbEAgkba9YGJ324At6QauoimxuT2Jghz9BSPQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8PC1tFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8PC1tFU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B828C113CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713424930;
	bh=O9fR3Mj/CBdCdCOrPgb9AcXpJMP1yrMhIdRY7Zk+9aE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C8PC1tFUPExhI83/5qpgMDYrc53oznCzC7ZSA2wbDlCmknz+40PJNkC0P97mWQ91p
	 IC44iGwZqFVXOQTnx9wfY1GN+ehALkqkOZHVbrReO5A3y3HMqxccn4O52i0eC29fE+
	 lKrzUGT4m0cqg9tHsCpPq1Unk9z+j4R34+pA+hZAY6snHEYXg6dITx9rNmY/ViiUXw
	 XZ70k1R6TkODLaMa4svMFpQ5myTjJW1ONTJVZxNPah349pe26oNGmZv45YmfdGyBxY
	 x9yZoxf6thBJ2tYaHpx+/I3MsSzUZ9tp7SYA0dnclZRzLqKMev20NVFH9frT9ikPc1
	 6wgufdKFFDuEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 670ACC433DE; Thu, 18 Apr 2024 07:22:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 07:22:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-6VzqEPUvKV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #37 from Wren Turkal (wt@penguintechs.org) ---
It would be hard for you to rock more. This seems to fix everything. Cold b=
oot
and warm booting with mutliple disable/re-enable cycles work. I am now not
getting any errors in my kernel logs when performing these actions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
