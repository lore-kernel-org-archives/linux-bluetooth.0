Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16650258EDA
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803060; cv=none; b=l8Bky2zwMz7WFkG60ToTeryHgBEQ7SAk81TzlWmZaTJsMoIMJg72HXvB5iXZAOiwDI1bJm+tvh+atLQF8SA2JTYVABvTH8tpssLehgAY0svZamnVIP98faX2PqNpDUfrEYFTlH6LFaAMZ1Rt4JMUEBVV5lZansekX3SMr8cV3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803060; c=relaxed/simple;
	bh=wv3JlaWjG+XCHLmQ7+4V6foLU+2H2sG7M7jt0VCa5sk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1Bgz+YVXqgGVC/JTUTn5iLkzW0dUJKNR5+jEDI5MF5cZQ/AqUtwN87DxClE3tzYih6zV4/QMCTxXqjFbGbCWCIHhSVnWhCVfW704e5ViF0Fjs1uku8+z0wytEzOJlEcnIA8ikAb0KIV/wDU8VDsWEs95LvXgq8H14za4gOPDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLaUQ/Dr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLaUQ/Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70B4C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781803059;
	bh=wv3JlaWjG+XCHLmQ7+4V6foLU+2H2sG7M7jt0VCa5sk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NLaUQ/DrwKmjUQpLo9C3N8XzP8OHaph0VDSG6NbZQTn6j1tzxsgx7f/Zulu5INE93
	 78ruW62gdMdmjIeLrcFv3g1uIttYZQIlCQ69olHbEMs43NmZ5lkDXOxgcws71g3bSe
	 l747CdjgN1Ca9lbwQEE+VZi+1iVyCeFDkvBPZIX9S/dpyEWY/+KAjNi/rwAVEklnX0
	 JHi9YCNMvxiE9QKHNxJrZQjUamIXUeak0pU3HWToHl6f/NUDWYblHPEkJ3CeJG6R5w
	 G5YRIvvRp3poeWkB9KxSrLxKPs73m5V33yKYNsYK2Q01g1GtSEU8KcgW1VIZfGxjL9
	 9ReDX63SkvRTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 927BBC4160E; Thu, 18 Jun 2026 17:17:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221666] Regression in 7.1: Kernel Oops in
 hidinput_setup_battery (hid_microsoft) causing uhid deadlock when pairing
 Xbox controller
Date: Thu, 18 Jun 2026 17:17:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: intellq@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-221666-62941-XtRtpbBalF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221666-62941@https.bugzilla.kernel.org/>
References: <bug-221666-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221666

Delio S.Azeredo (intellq@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |7.1
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
