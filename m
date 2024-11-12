Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA12040A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377430; cv=none; b=HXk79vLe0lYohJ4HREm97eJVRmV9+PHAzD5bg0QYySMNZGSYDErQhTyUYnCoOUscU0y8a1FOJOz3I4gltYMe3Isks33l1ugrz1YOmcSeUsNfGt989EPnydMfZOaKj540YuTTDH9kYdq4HKfrkbSuaQ/NzkJys3uHsj3MHEaArls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377430; c=relaxed/simple;
	bh=V7ziUw3EI8uib/lA8Qh6r8GnqcsI5Rzp8nm6q92uLuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jai9C61s+aawqm6EL+tdigKeWsamkFJJw9yrmbjhYtrzhUX8CCJXC1z5IHee3i4nGz3eyi+5y3irJrk4FB06NSAJuxBCWi7IwrdNavdjtlCdGgf+yKD8SND1ITO0fqiRMHudebdeoc+EogOEi9RBxOrdc1oJYUkxkdLcr2mg2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWTe7RHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWTe7RHE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A7AC4CED7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731377429;
	bh=V7ziUw3EI8uib/lA8Qh6r8GnqcsI5Rzp8nm6q92uLuE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AWTe7RHEXMpNv+BnALIdTvmjvVkmLY2IbV9Od9dB07Xbsv1uvobrJqunNNjUvXVal
	 Wly2yrjuBdFGN7M5ypGspVGT3jsoV4N3z+mZWZCCBoAjHK//ZlFWy1B84yrMyMC/DP
	 OufebMVCaTndFVz7DjeNqbpBvZwJRnAaWf70qMXxt/a9xNIDshJ6MeZeRGYbCvgxSp
	 ckxgAW+B/9N45ULVGzZmFTHc6IoTpkqIYER1WY7Qill9rc9cMd9d5emvCMPZbRVbpi
	 TVFuxpxfcAfT6TtilB3oD12+N6ViKj36T1PWKONc55rDh+x+Jmb1CgcWrL9SEvbFF1
	 HrMnxdr/4mz4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5F9D9C53BC2; Tue, 12 Nov 2024 02:10:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Tue, 12 Nov 2024 02:10:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shaoran@sakuranohana.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219458-62941-5UTMK10rFL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #9 from Pablo Yanez (shaoran@sakuranohana.org) ---
Hi Luiz

Like Guiseppe, on 6.6.58 I didn't revert the original commit and applied the
patch (thus removing only the if clause and the mgmt_device_connected call)=
 and
it seems that the problem is gone.

I was able to connect and disconnect multiple times in succession, I was ab=
le
to remove my USB-Bluetooth device and insert it again and was able to conne=
ct
again, I tried that several times and it always worked. Now it seems fine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
