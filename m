Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6628F538
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523330; cv=none; b=tPZT+BAMOtau/gdg4fbVnaLfj4t9cz1PPiS54z8jRWu5ETbxTogANZ/pEWXcmhAUbNruRQ+3a+WtPFq/Xa1U/NnosHpLvrfsIqCPicgJr+GVa8ITGefmWbq5VlYTGaPbHqKo1GMmXhAEOSbvwRD695OLKssCp4RINuAMJlJLevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523330; c=relaxed/simple;
	bh=kM2xPfZrkFzasZsfw2P6ov5P4Av3NpMgv3zy4RADZ3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fci7kBQMwjUFdVjWNMHw9y13KjSHSdpb0U/YxDZhrfj/kZJ8FFbi/rE2EE6DrpWGeNkF0AMPUvXn9sFrpuqQJpGVcd+zUkZ2iX3fgjJ7qI8qKhQtMJpEfixNw4hJ/VlzSK5dPNXu32Ddh3Se1HCPcrLCyhgRsSwd8v36Yad2cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooaAUw8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooaAUw8h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6843C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745523329;
	bh=kM2xPfZrkFzasZsfw2P6ov5P4Av3NpMgv3zy4RADZ3I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ooaAUw8hAUadctFKWC4Loa5nc+hN6krrWqF4IrGHbJaOUCk0oVMW88wZEAwdCPMyN
	 X60U8tVOLTYnSVCVsqqvMFo4R7nXvsNSog9oLfLch+S4OUtN4ahvwJlQyHRykjojDb
	 Q5I1MYoMzUgkZ8/rNk432PSOfaEXLLNkpuJmfloIbrN7O8SWlafCbnXnfNU3SoH7a/
	 Ve9cyC9yJSV+OGBB00bhgw8/Un7cjNV4ypTa8lEcu+5arFVQUKPNMCB1xjo2p/byZb
	 WFiLf0EIUZAj1u3nYtjxmzuj6IUQ6pgRvFejkDe/r+ilDp+7Mdj1bHP77J3QBQhrgP
	 RCOyMH9wl/+qw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C64C1C4160E; Thu, 24 Apr 2025 19:35:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219854] Bluetooth devices can't connect after toggling
 Bluetooth unless they are re-paired
Date: Thu, 24 Apr 2025 19:35:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linux-bugzilla@ericswpark.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219854-62941-ap4F5XCRB5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219854-62941@https.bugzilla.kernel.org/>
References: <bug-219854-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219854

Eric Park (linux-bugzilla@ericswpark.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #2 from Eric Park (linux-bugzilla@ericswpark.com) ---
I tried different kernel versions today to see if this was a regression, but
after changing through kernels 5.15.x, 6.1.x, 6.12.21, and 6.13.9, I was un=
able
to reproduce the issue. In fact, after switching back to the latest kernel
version available on NixOS (6.14.0) the same two headsets that I used conti=
nue
to connect properly, even when toggling Bluetooth power and suspending the
entire laptop. Closing as the bug cannot be reproduced anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
