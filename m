Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025A13AD22
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447156; cv=none; b=DB7M2hjE4NOhR5YZ4PkRUi7cH924Z25r8ebkcYRCm4V3tfD56flH8h1LJZnEVUUdV4vWXeSUlZXk0eAgLs+Z0Q74l6ZQIukeUaCbbH2g+Hnbv/nfhy3y5SMfxS7j1di6bOrw++IJeZLJ9ZrYfo6WYhKDSPx5WpdQ8U3P1QBPoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447156; c=relaxed/simple;
	bh=jaT5lhTyrAO4JT/2kpxgovmohZI8R/iieXRmSdau59s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmwR56kpZNaovjhnIkH10S2N8wOZMC+9xVwShBUF8kK10b8cbDRNX5wYMobTPPSKm2iacFnJhCBQn4+Jp3kxPoWfXwlTIbz0w3u+FnPYLtCAVC+0tOywfPy84RfzIagSqukuUtQAVUUMXGv44epD7baaYqoRaQN9B68QA9JFGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSrKTbTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSrKTbTe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E03EC4CEC2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447155;
	bh=jaT5lhTyrAO4JT/2kpxgovmohZI8R/iieXRmSdau59s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cSrKTbTe8hsyygVZB5yv2+k1BVM5IyYev6Ty0Hq0RZrOAf8KW61gSJwjGcllkC4dg
	 L6UvWPZIJYxgcIJfZcBZesErZqI+EWAws1taBTrRjVYYqKFLqwSYS19eUTOdCy3tno
	 B7wLrlZmthJTr/0PPdH0+S+WehQH/A2QxpGpWb2J5nPifQhw8878gOTT9MO5h5p4UC
	 IyvFtwGMRqkTlYd+G2LXvsjKKSXbXUz2wBtRfTG6u+eewXP3/11WUliNsqSBNZ6xPb
	 9hUVeySd5o3H9/8l8c6DRF+yTehS/xXkoHzTw4AKEmv9fLRZFGcGUoqR6WEhPvJsVR
	 FNi/BIvksDOqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64297C53BBF; Wed,  4 Sep 2024 10:52:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219233] Bluetooth: hci0: Failed to load Intel firmware file
 intel/ibt-18-16-0.sfi (-2)
Date: Wed, 04 Sep 2024 10:52:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219233-62941-4K4TTeq55m@https.bugzilla.kernel.org/>
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

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.0-rc6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
