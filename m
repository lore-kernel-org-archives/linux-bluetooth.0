Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAC1DCB10
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461894; cv=none; b=rMpe5JkLyk/r97J/HxfJKQAOHKd+t/zkyAye0VbDFhumJG2aAx+DNC5E6tfV7G6RdVsHgkLnB/c2zrkSeeWRzTNPh/EXw0OeImcN/X7zPkK0X7LkEFrK30C4ruvV41BhYj0SWLAzFqobm6orbMVQNoD6vkr9YUdW+pHGsUDigjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461894; c=relaxed/simple;
	bh=LWFIjPg/7q9Gw3vnHQf1VV0gvn+cH4y9lKja7jhMaJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gb+untnJNtsLN1hxcYoJRZev3yMAGxdaGDbazZ/tkM8kNlv5HnOQEljioyu3K6JXyMs0jJjSAbf28iud5MynwTFE6K5ekNj2mPeArOzwdcDnW+n1hP9DIGrRnPKA02hJgodz0LLWffxZoh3RRgWXg9JQq+BUFWxzU1bCRg5JKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUb6HpNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUb6HpNa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C099C4CECA
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461894;
	bh=LWFIjPg/7q9Gw3vnHQf1VV0gvn+cH4y9lKja7jhMaJI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eUb6HpNazBp+xoZW6AFdTyUZ0AqanRLkb7+ZHipE31WGpkPz6cEPzLiQR5L+y8qvs
	 YJzN5NWjE4QOOo7WHzTrU3zyoGi9+v4+MKOZGPwNExjJJ1qRS5Ukd1RgPP3nA6Tvj9
	 uvGShCYjUJviAvCo5WRIR0Rdb9cwdsXCsD9te2gz6T6n8Mirig/JpAGKSwg+INJUdW
	 thl931MKE/z+6kJk0ldI09SF1OLbp+xffbbAp4nva0vOJ++39R/FU6P+yAwkpooUgy
	 8BhW6rMklb0btAg5BNoGWU6jdmCctf6KXzEIZLvde+JJ1iJq3p2AEJ63sGbOcqUIzx
	 jEVeUlQ/m72aQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2DD0BC53BC3; Wed,  4 Sep 2024 14:58:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219233] Bluetooth: hci0: Failed to load Intel firmware file
 intel/ibt-18-16-0.sfi (-2)
Date: Wed, 04 Sep 2024 14:58:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219233-62941-kXuff7vHpX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219233-62941@https.bugzilla.kernel.org/>
References: <bug-219233-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219233

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
-2 is ENOENT so the firmware file is missing, perhaps you haven't installed
linux-firmware package?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
