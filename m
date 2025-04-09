Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DF228CA5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192351; cv=none; b=CxUbpfdKE0H2AmO5F1KaYbeIafDzdnQR7ximBb3V14vVA1olpRFmp7HAOxpX6hxvMfhdI3cJDL/Z2k2+y860pkRnJKFow4y1noKn/LKEmHHXESPSvXkpyjHWYqv4x4opKQrgqSQnd12A8ea636i/7f+AV64lzIELYaJ1fmhvzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192351; c=relaxed/simple;
	bh=0k0G1bgamt7qS9xgzPHjyFb7A/pA5qbQcT0Dgnz8d6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pv8r3ZVBuWqR3JFjg30BQVte8xKSVbj+/uXKiW9jT4A5Cg6dwTl7xuy06kWkoM23ACiKXaPzbtYMNUY1X8bljfTu1cErJn6S7AX/1h51ENG0tW/ij1+jNm6nE0TDry6JXHXSrslzF22b5otk42LTp0Njuro3np1p4ZXfvgLBb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVmxV3Yk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVmxV3Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 943C9C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192350;
	bh=0k0G1bgamt7qS9xgzPHjyFb7A/pA5qbQcT0Dgnz8d6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oVmxV3YkUJH9ojyS/q4DsT0Tt0XQG1SPdLiiK6B94UFE8Hfm+N4198+r92vcwcKgg
	 WXpUo1nJ2jF1DoJ/rzaeGt+IGUpGOBzdz/F7xvUOTF1aWUX34UtswY9cncRQqa05wS
	 hGRDsVPmmg0kdleNi16SZ3CnZyS8cualYS4Fi6jWML8q310bSIQ7jHt4azB0KqJenm
	 J9QiBoIMYQlc0dPqXxw3B2kEMaKK42PXGmKZGwTeO3uAdpWvIorPmpTUUxv5sK55YC
	 Hll3vIE4sHnE8QFt0dc2kQwUEVPB0wE+4xJBSg7MZZAt1P2YS3SkbkXNwgSJpFz/JA
	 4UXVJvIM9quaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8123DC53BC7; Wed,  9 Apr 2025 09:52:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219997] [rtw89] Headset unusable because of delays and stutter
Date: Wed, 09 Apr 2025 09:52:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219997-62941-e7Jut8oKgM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219997-62941@https.bugzilla.kernel.org/>
References: <bug-219997-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219997

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Is this a regression? If it is, could you bisect?

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
