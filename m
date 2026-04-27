Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC62D3733
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320533; cv=none; b=hZGdA7HcBuBmHtV6TG6GLxlxUmCUeZ/U7LNP7xi1qvbhomCYW/svPQw0xim5ZQJ9bhWofSSeKtWo0rC0BrVoV2lMIWBuh9QF3Jgi/e3aQsJm6xFa/4RjUwM9xdEkT/s8IWa0so6GXLGjoiTiZIt5NwsIblwPEq08odVG+BsuV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320533; c=relaxed/simple;
	bh=xEhi9eqZkZIdeEfgrBm6NXIrpWjjVIIYiGrQrM42QIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7NWAJr9K/gBgQ/xymbdKrPrKVLu16qfgM4qp6rH1NFeCN9fko+AVSXBNRlNQodw51FCUUxmuiZCZgB01us0qHxDJzbMAfwaalA0omNq7PVNRcROEraKvbQY/UioTLIxXsWn5Mv/7w3/a64D9eK/TrNJGzolqYFML+7tArM66LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHwnHHqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHwnHHqz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A225C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320533;
	bh=xEhi9eqZkZIdeEfgrBm6NXIrpWjjVIIYiGrQrM42QIM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bHwnHHqzDFeOf4/w3cpTgIFwAIMaG65Wkn+kAh3b7e8xY8wdo0rfnaJRG1oA9F9Ln
	 xDhh12GHsuniqADaEP0L94kObMHX8oJbfW5S1ymtkaFNJbfBUJMEt3Zcu8iYOdrRqC
	 EcfvGwE8//qbJdo6Lu6m9CYYIpccLJm/J5S/JhBXsgfhxShNd3fGtb8YGP7vl3ZFBh
	 CAZ9AWF2hPQ8qLu0lyD4BCPhGV+VN7Mc0I2rqsbDrNOlRAfUhJOJtYNx/OVsv3xebV
	 2YykIQRUR7PeKJ6l5VasTWv2H2vZJhNvW0uXLhs0icTkIpD449qXzpJfotlcIwrP//
	 JkxYyGQLw/EwA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E0E1C4160E; Mon, 27 Apr 2026 20:08:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 20:08:53 +0000
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
Message-ID: <bug-221426-62941-jxo29Ilh2h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

--- Comment #4 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
(In reply to Cristian Cocos from comment #3)
> (In reply to Paul Menzel from comment #2)
> > Thank you for your report. Do you know if it=E2=80=99s a regression, th=
at means,
> did
> > it work with earlier Linux versions?
>=20
> I do not recall this issue's happening with the previous Linux kernel
> (6.19.13), hence very likely no regression.

Sorry, that is a contradiction, if I am not mistaken. Which not/no is wrong?
;-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
