Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5A2770B
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711819622; cv=none; b=P62S3G5RIWdX4mMtEkFOLzKZwEczKmtUk49EBgnC5+uUlOXQ+iN36F5IQscItgjxMtdJSQ4Mcw4mCbObquzjH7H2lOXPHjwj8r/KKXNo4AmJ5MEpQM4UR8sy2vveAYinCIMbaZHHrQ5ExN2QDH4UNCeh4IsMC8juuqsJLopPD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711819622; c=relaxed/simple;
	bh=6x6Fyz/n77w7bjoP34q2UPKiQgOdfdFoyQ4uNKATtGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuEl91v2N+eHA0s7ZMO7k4PlFRQcnMZIFPouI75DeLXQMk84Gdec1OaraJ7lEQzFDmRonOVW0yA9gd/LPFhZ3oAUbEtUaPKWzw29/g9LEC9Qhnjc/AUERZtG7thtSu/i6dgy1hQRlblgrVQOpxEpJX5EOb4mhzR/HmWKUzD03FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5kV9tCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5kV9tCR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95A45C433F1
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711819621;
	bh=6x6Fyz/n77w7bjoP34q2UPKiQgOdfdFoyQ4uNKATtGI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q5kV9tCRa5bIrsttgUNHg/MEqe4OIwUTO58tJ84u5rb78SpKuS0MQ0tJx3WGbHbbS
	 p/lMHVjOHHr/TfDDffWjnRnJNenjzWtN2iKkiUJqMIVIjY6u8UFKS4KpXYGak1IGS+
	 mGv8nh93K+CPPTXNwDsBCIgodzFG54mdD3dOVbk40mvA8P3VCOtHIiTvuD7F7KXGIT
	 6asmZ6vV6DZYLaOgNPiq37W3fIwaw6BXlEIH9j2H+A0hdoDlFVq0GgU/81XD9wcBMQ
	 5z1FQP+KoWNvfqhUExKLACr/Oodgfp62nFiue6i3BOYb1ehpQurvNvrrrmcIp1PosC
	 8TIOtr854lpBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F90FC53BD2; Sat, 30 Mar 2024 17:27:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 17:27:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-kwKGlolbQ0@https.bugzilla.kernel.org/>
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

--- Comment #14 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
Fix now queued for the next release of all affected stable/longterm series

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
