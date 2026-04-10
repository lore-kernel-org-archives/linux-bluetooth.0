Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926735A93B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806565; cv=none; b=h8k/V+1CNCCpm4nJq71psuw6uprLF06Y5nuaORmbaMOLH7i74mnA1m2RbrJki05PwWCC90PD7aO98i7yIFbAeAEJo5Q/pYeW2MBCoIKSjq2XQrtm9mAjzBH+fZMtWmN18v0Tnbtj7Ci/9OjjB3jY3AkAvORieiJDFUjOWvBTDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806565; c=relaxed/simple;
	bh=y3lpuEBnVFWanLRHq/JOqdZaabZVOhT9KTvgUghQp1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1VZ4il6wbz31vGo2vszzrv1wvy+6fWek7wfAz5YXXvbkkZrMzfyo4q+3pB7O54zM4tV14O10ZiXGARAikiErS7IGLhhEiqbFfs4rOwMNRjDMxkiB4qtZVJ6wIvArfjMsiA5q74tjXmxfMWlTBYKvAWL6/S530Gl/ACZykLsLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1/2Fgh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1/2Fgh7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67779C2BC9E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775806565;
	bh=y3lpuEBnVFWanLRHq/JOqdZaabZVOhT9KTvgUghQp1o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P1/2Fgh7esOwnjesbl3oFumOjjnjZeFOuiK+a4qBaU89oEGte7SdUo8ND/x/1Ygic
	 fs2ow3X7m+ZTs5POFOBcFoIqEdcE7hErDFXHByZxrqU1PnInHZc8dmvR0ZLlVykHTp
	 bmfpmQqXmg2vSv45mulGVLykHNE0sCQ/D33KxM2yOipUEb+53yOedw9M+KwleZpXmm
	 dFd/1BX3jcnNkE5OxJZ+PovodeWwurdfleqKvMb7ji24sLwofksC+WT6VVCBi6pEDw
	 S+QoyBbBgHAuqPqAMOPzywC2IpfPWh9mIDruiEtuC0j/hn+yHikTi/qwt/3dFsKULi
	 FblyNlrKd1lhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 56B07C41613; Fri, 10 Apr 2026 07:36:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221339] AX200 -19 errors on boot after firmware 20260313-1.1
Date: Fri, 10 Apr 2026 07:36:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tiwai@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221339-62941-TJlWeDIvYf@https.bugzilla.kernel.org/>
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

--- Comment #1 from Takashi Iwai (tiwai@suse.de) ---
FWIW, the original report on the distro bugzilla:
  https://bugzilla.suse.com/show_bug.cgi?id=3D1260599

20260313 corresponds to the linux-firmware commit 57303edc4101

- Update to version 20260313 (git commit 57303edc4101):
  * linux-firmware: Update firmware file for Intel Quasar core
  * Intel Bluetooth: Update firmware file for Intel Bluetooth AX201
  * linux-firmware: Add firmware file for Intel ScorpiusGfp2 core
  * linux-firmware: Update firmware file for Intel Scorpius core
  * linux-firmware: Update firmware file for Intel BlazarIGfP core
  * linux-firmware: Update firmware file for Intel BlazarI core
  * linux-firmware: Update firmware file for Intel BlazarU-HrPGfP core
  * linux-firmware: Update firmware file for Intel BlazarU core

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
