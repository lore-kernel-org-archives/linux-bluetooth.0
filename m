Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0F30EF86
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775674; cv=none; b=C/wM0QEXvg6y1CEtN0QYYtMNtg0yseOI2Vpozn/ctlzvRuF7HV4HoHh9HrfOttlGx0fQJ6oJ/AHbqg2ry8tEiSfcMaAXM8zOJvX5uLbKLLeYpCjV8b52jvK6ixrIORyUcqWSuauSHRKr2Fm3Eco8DIlFrerIAMkj580/CLg1m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775674; c=relaxed/simple;
	bh=ih/qpJaK/MyC7KtulxNZ5/Pk7GQeac3CQnV0nkUwhXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK8EQCxIMYM6l8/vUpO1jEAkvWX3hsTwaMblXZbFCOE54/Swjm3BWn/+ylC4wHXExdJ/aeFa7udaIKsqC1MV2qtZ8LVR64YhYF7YztzKkoBBQk9+dXTHPpiTq+bQSe82Mh2oAlsXdxE3mHTJgbwkFsNm8TUL0mgCMkz+S2CflGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqnOowSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqnOowSG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31173C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775674;
	bh=ih/qpJaK/MyC7KtulxNZ5/Pk7GQeac3CQnV0nkUwhXI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uqnOowSG+dZa8pt+sj0T5TnhV/M+KWBAPFABK+i5glCwuWOMNjZWlSzGCmYYezEm7
	 iBxUaXDlhvbSAHZNLDKwFi7eXOY6AXkB3NaS2PAeHGosJrT/f1PrmvQ5nk6d2Wn71V
	 1R/krCgXCldhmPn0Tn22iHlC7nTS0O7RYzLCAqoX6mud8hULsF6xDisW1GQNaexeCF
	 a4E6g6xbaNa6zJ9j5GuO4gG8UfaS2+k0AmMCydVBc/Dih9AjfCZ8CxfiaG+DTGobYB
	 is5gZc1wkrrYjhtGpZ+HKnyMWRM9a+Y+ftkYjv+jbb9rIZ79RpdZnEKNIGlOVg5MPq
	 hcAFfkQ7RnHYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F2A1C3279F; Thu, 14 May 2026 16:21:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] MT7925  7.1 rc does not work, but it works in kernel
 7.0
Date: Thu, 14 May 2026 16:21:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: erpumper@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221511-62941-lk0QbZ7Muy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221511-62941@https.bugzilla.kernel.org/>
References: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

--- Comment #3 from erpumper@gmail.com ---
none

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
