Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4E2248B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792427; cv=none; b=WWs3J2pef29SfE/yZKD+VqTcaJRWc+c+4heg81IAVD3cTmuuMuFupiXjH0V1GICEGmPqw6nwbOnJV+a8EchQG9TFSVv1uC65QvHC2M+JfklXg2U2/yfkhj2tJ0XYCFBSHctgIuAVDMUoQqqwthCPvHP/UGKt71ERe7hA5Rn65Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792427; c=relaxed/simple;
	bh=QoLS39mU9esYSoVhvb1g19rM1QA6nImzi7vvTUTdzeI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMogEnXlcJJBc95IpkkS2bD5TsxFvk5eJ0DTpWHlOanc3dRN7wUT/upAYcMZdu+Yc3Frcd03ho0Jl1VY4XIpa5JEncvOr31BumN9nlusmjzI1gEvnedcqkYlStHt40lJx17LYEz+ascvALxNWcSTqc6aHTbZVRSJOYEl/GtfNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMif9G3Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMif9G3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 868BCC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752792425;
	bh=QoLS39mU9esYSoVhvb1g19rM1QA6nImzi7vvTUTdzeI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mMif9G3Y+BIR9jBn4NHhSSra9qzNBAvTQDMPVu8mh72CuMmvxw8Akk3qW9B7oq11r
	 5ap8BM2VZdzPd964hMguTlvBPNP8k5H+cIwI1sOd5RXlmP6fIqkmeNVMzOg4LeYdvD
	 EdLRc0yJygKt2AASn1Wh3Wa6N0oeg180lQOngKIc0C+iqNkA69XF4v+j9nMokShU3U
	 0rlslEc+di2lsJEmv2k11fY82lIlk3bMhbXzPhpLtGOUBii9kHsSbQaYU/CxTQxIjX
	 D9xNB7O9hbLJ7AcBX+yuWIeqlDjVlT3SP3Z32pqqOxvgWyLj+M1Gs7Ap4cYd6Z7Y5A
	 9QUs+aowdcayA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77062C433E1; Thu, 17 Jul 2025 22:47:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Thu, 17 Jul 2025 22:47:05 +0000
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
Message-ID: <bug-220341-62941-o39FEdRz89@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #13 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
Bug 220344 ([URL][1]) looks like the same problem.

If the developers do not respond, I guess you need to bisect the issue to f=
ind
the culprit.


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
