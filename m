Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB417314A84
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776748049; cv=none; b=s5h1bKH0CsvhXIHoaTSc6TYA/SDYKsAXodxZd1IliEuHKlEVFCxTdZK3G3XbfhN303u8zKnUfALYAE8ismSCM5WiRfPE0zCzQxzoCfc0JVpUBR4+ite8t+E9SJKk1VUMkVw3+poooPOYNNedOIvCi2OWcYnfRc0Avuap4uiTJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776748049; c=relaxed/simple;
	bh=WiKia4OKcMzIEksjbpZmnvGjRx+6jKyt3SNUlC1yIM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BY/ZprbTplwPkeN9bmQdeI3lm0gVZXjL+KhmHvjpNg2vMnkufpbM1uTQONWacAPWq8jhkjQ9BjhsL5YqWQR9IhO9a7wSpcJd7+TWgmBOGDeJrcgyc+1hZrTm/XmfasyHP5anJAIVVVpmnBOk9qO4MTrvpXmataQQLP5xD3Njzss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p668BIVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p668BIVf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45142C2BCB5
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 05:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776748049;
	bh=WiKia4OKcMzIEksjbpZmnvGjRx+6jKyt3SNUlC1yIM8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p668BIVfCswQltFpGsXJBDwdZXOsc7AO/6jgjsAghox8/Xa23UAGDNbBW1cI5TmQT
	 ghCEirQqkuzU4CXhJWsnYn7NWfYrlW08CXEqnA8iEp2RjQqDJc8vXL6jHRDC18J1OZ
	 yf1hjVQUT+xL6Jq2Si0K9cXXxVcTgZXCRmY+k+9KbTjwHgqmS4nWZyvaSgHBBKA07J
	 VgR5pXf+4RR5G/zGUSH2tjk9Z/LC0ocXKvgFIc9LfNvqI1D1Bf/ffK0RMBKTT0id7H
	 S6SLxq0/AVnJFlIAvq9Rj+d/4S534qKvLH55yBPdmdBcbeA2c5073tkLE5WuC1DSI6
	 8IAd22ISG+BpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39B90C4160E; Tue, 21 Apr 2026 05:07:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Tue, 21 Apr 2026 05:07:28 +0000
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
Message-ID: <bug-221339-62941-vnregIgkvN@https.bugzilla.kernel.org/>
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

--- Comment #12 from Kiran (kiran.k@intel.com) ---
Hi Thorsten Leemhuis,

Sorry for the late reply. I will look into this issue.

Thanks,
Kiran

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
