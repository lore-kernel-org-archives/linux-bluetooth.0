Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C6125A9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433296; cv=none; b=XvPrgIQ+VAZL/x42Q+9SOJmTXc25cm23xm+gez3OHv7Ix4eGhlGcTS+V3/d/dcDrVBlC9AqpoVUnd5xZNWcxPPcTS430b9gJ2qwggkgMYDhlmN8DNUYNUV4gBz44gslJ/11jYKxlOZVQ2mgHukFIYTwhgor94/8pmN1z71n9QEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433296; c=relaxed/simple;
	bh=vpsLm97pWxcfcjeCjG17kINBmFdZ7HJlgZeyikCvNUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iF+pux9tZMA5NDoBV64gZLdN6QPFmL5epobNovIhJ7pafj91GWguNZT9Zao+VbApB/sswiPhP59Nqn0FLakt5F+k9T4x7JbXlTm2XWvp66XqACigzmLtYkBTWsAlZsJDNoIoqyMpTl1FojS+sO37cVanWFFeI7hgYrTGK463ZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czvEYZXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czvEYZXs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E869CC4CEF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754433295;
	bh=vpsLm97pWxcfcjeCjG17kINBmFdZ7HJlgZeyikCvNUk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=czvEYZXsYV0skX43NDDOuZkrMyg33VaThCCwnbrD13Wp2kIbHPa0708mYIObqBJLv
	 Y6cc/W9blDHpCjHojqT/UYfeMuSTfO0SXsUaM3J/iKx6uyvogJ5lOtKaVtp0PC6tOK
	 KHQ96QljisiK0qWdFdY16UEcHVhDV8zANZUSd7+x6JY2AhUJaNF9QYK7iGmnCVBZ9y
	 jrD7VhaolV5ab9rVq4K9Fsn6Mpfg4fbsKAild+jswHGSRrfTt6vek1MiGTQoe8zGkm
	 OH5nSLYcOg9BxNmGWcHWkIifF+FhVaXDJ9qKfgSP5xF3wm3MZ9GXhVkW64fQlX0qPa
	 +0y3ikAA+khaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA82CC3279F; Tue,  5 Aug 2025 22:34:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220419] Bluetooth stops working on Intel BE201 a few seconds
 after connecting a BT peripheral
Date: Tue, 05 Aug 2025 22:34:55 +0000
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
Message-ID: <bug-220419-62941-RGSAkKgpIo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220419-62941@https.bugzilla.kernel.org/>
References: <bug-220419-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220419

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
As far I know BE201 still use btusb, not really sure why a change to
btintel_pcie would have any effect on a device over btusb but perhaps there=
 is
something changed that affect btintel which is shared between both.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
