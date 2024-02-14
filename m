Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE545D912
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929142; cv=none; b=bdKNmLOoc4YHh0PHcVhjJYk2btwwLYnalXo7Je18RE5+gd0YT9Zk1r+B8PysYOpMrO55XTGv1Ro7hf3GqsFJcr5yQbjGXtB6baTIZeM5YfK9hLcgiEeb/tIohdVGiouQfhVSkua2mZxgmgiqWPUO+m9IfcoCj70ivfeMGRn51yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929142; c=relaxed/simple;
	bh=eYBOqNJfPHmIRYQXr6eFF6mnyzCptKQdghLFLzrvFEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBmklz5Nw86yZLrYf2F+v8IuPtDLe2FdLp9dcpYif8DjCX9RW3lM7FQDjVHoBRM5UpS7YZsi6dKjP5DuL5Emzn5hOtbtoBwbvXGXlEDxNfpyzm8+AUMX0Jfp9JqCAXRBWTBBzf2BDSna4sSKZg79tHhvUTdv+5H4W/yUfiPGSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw9SKmRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw9SKmRq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14645C433C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929142;
	bh=eYBOqNJfPHmIRYQXr6eFF6mnyzCptKQdghLFLzrvFEY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fw9SKmRqNGkryUu2BjLCBFJMF22vyWpadwCJKTETxdeDZ8b+X67zXMVbYhNNRV1tK
	 ykOjETU+kTrjmkgdA3Tsasi/38fnHRM0zoFHPrttuuzYE5jCWtOx4ki6IulOFgSmhY
	 A/07yr5nAPx51/uFoL/qUGtjk8ONzHEtLxXMJr0gl36ADpkLbPH1yRZt4I97s5GamY
	 g5UAQwzpn/gc8ppy3SnM2UiW7TQ5oEs747W0W9NR5ZKVXEf2SVwVTBkTDqBjmfJVzz
	 fo54seQVKtavXArIC0ShxZBbdXuAgdBUgaqIigjKBj0acOAA6vP2q5W/X+/bs6QZmF
	 EeO2jplSSUaIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 03179C4332E; Wed, 14 Feb 2024 16:45:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218494] btrtl/rtl8761bu: RFCOMM is not working
Date: Wed, 14 Feb 2024 16:45:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manio@skyboo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218494-62941-qSikENYqbV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218494-62941@https.bugzilla.kernel.org/>
References: <bug-218494-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218494

--- Comment #3 from Mariusz Bialonczyk (manio@skyboo.net) ---
Created attachment 305870
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305870&action=3Dedit
good: dvbsnoop

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
