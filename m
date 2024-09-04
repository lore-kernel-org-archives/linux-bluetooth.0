Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A81CE6E1
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447173; cv=none; b=mJnuhNoK51XDEPQSNl+7LjCXkieVnP9Y5helZXOMYlo2apLdxTQDyeCPFHU2mswrainjwKkRvYpYqqh+jiO9ewNa4d9unCvkU7AY63HxPa0wOfZH6MMSzeNq5kZo6/4aJY3JexyBVdd5Hb6NL5HXCom8AxwVElNL7P0RgviGfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447173; c=relaxed/simple;
	bh=PRobZXQA8iJO43Vz/XDWhm8dtTWuC0AhqJWSSg8MuPI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6SecPq37cRFrT2FoAMjE4PQoPwLLX5wnE2vArmidLpVWQU/GYyXrVlq4D1WzlxaBU7J1Dejo3zikFANnsFHTyyhiDbdOFM+KFnrVy9Uv1wZphZf9dFJjNa+Ny67YdLWzqSe1flpd4bnG+0gjj2LWsHT06sMJXaDd/dof3DzGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci2XiSjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci2XiSjG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F34C4CEC2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447173;
	bh=PRobZXQA8iJO43Vz/XDWhm8dtTWuC0AhqJWSSg8MuPI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ci2XiSjGqw/ufsvoASLQltEChiFiYTM56Sbx3vFeghIiv+pBqwcT+u87QSi7EpK+Z
	 ZiKwBi1n19gBPz/pjI4r9lQmBdrgMEcUOf/l+y09F3KmPQeU5jGEQJz4Ed9ZrKFtM9
	 E5neKqeFt+vuwEyLWD2l+4zlSJRDb3jab+aOg1Kc5y6nacKHGCwMYMayrkHradj+iS
	 Sf+K2wK90lC9g9hbQ3/m45nrOubNQ8yqIZ5FKeFPSrCLbD8NVO4Cf9D+ReofKJu7os
	 2OLxu30xIPjc2YelHDuDGagHYa5Y+jtWpOVwOtbg0p8juUkAm3PqLULNbqBDQMi9jw
	 9EqYiULIthxPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EA7BBC53B73; Wed,  4 Sep 2024 10:52:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219234] btusb: regression in rtl8761bu firmware
Date: Wed, 04 Sep 2024 10:52:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexander@tsoy.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219234-62941-M6bDx4S7H7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219234-62941@https.bugzilla.kernel.org/>
References: <bug-219234-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219234

--- Comment #1 from Alexander Tsoy (alexander@tsoy.me) ---
The device in question:
Bus 005 Device 089: ID 0bda:8771 Realtek Semiconductor Corp. Bluetooth Radio

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
