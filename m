Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27B364EAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072238; cv=none; b=d1K6Nl22LlSE9ttWOK/+8Cwi6sJd9TXM7GK/YwMeKLaKbMcBHDuZPUF72IIc9xWVCLI6jBAhjcvZccmfyGNzZlkkMFgcbKQayCeOKIZI1y2pw8ETZ7eQoL/4KB27nV0+Je/ms7WUwlevNE6CrgA2OKvuj0qwPgoHsYwwChFMghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072238; c=relaxed/simple;
	bh=F5Cc1ei+bG7IsJ9NgBu8RlDQcV70rMA75Ndp5vEqo7g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FyRK0Hvwz4/0eDaVll3orcxEB9dnSD7HhLBOq4qcG9p9Lv4HqqxZANX7CPOlQeQpOTUysKGB/yIVOz5J0wjDEOoxfrjig9sXkNBYIbbQq8poLNyYjS7npK0sl5ch45I+4mByRdUtWGBHHOiybJa5P6+wRPs8yxCb9WKvqkDC4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0nKhri3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0nKhri3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5062C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777072237;
	bh=F5Cc1ei+bG7IsJ9NgBu8RlDQcV70rMA75Ndp5vEqo7g=;
	h=From:To:Subject:Date:From;
	b=N0nKhri3brUlZU1kyxIVnklO3Jqlb/+RcTAWfBL276wIa93xTqc+jKjBT19evRkus
	 uBjXpTcmDRfzRY47hRGrRjekZ8xHuhBPCnFcditfgIlnYmIfK/xGcQoML/XhmCXh+K
	 2q2pdcgAY5OBwN5JTcqP2TsNPZG18SlEQTBYcp/bU2zl723yHueZyb8tDWNv2rXejI
	 yy/aBwnfoySY7lHgHDjrGLoWwWpmmigfsO2JwJ1+BtNRtxpohDCMqWAcCvO4gK4Jcz
	 y6wneC2qpuAlVqZ68YPH/4VwnU+6ycIJaxnjtkjPrQacyoSw8x0LxV4K2aYv3v1+q+
	 Bua5cM4e1uCIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 93BDEC433E1; Fri, 24 Apr 2026 23:10:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221411] New: 9460/9560 Jefferson Peak (JfP) can't detect
 certain bluetooth devices
Date: Fri, 24 Apr 2026 23:10:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel.dinner750@simplelogin.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-221411-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221411

            Bug ID: 221411
           Summary: 9460/9560 Jefferson Peak (JfP) can't detect certain
                    bluetooth devices
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.0.0-1-cachyos
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kernel.dinner750@simplelogin.com
        Regression: No

The Star Labs StarLite MkV (https://linux-hardware.org/?probe=3Dd332f0271b)=
 which
uses the 9460/9560 Jefferson Peak (JfP) for Bluetooth, can't detect Keychro=
n K1
QMK Wireless Mechanical Keyboard (ISO Layout) - Version 6. But, it pairs and
connects with my Sony WH-1000XM3 and Pixel 9a running GrapheneOS just fine.

My Desktop (https://linux-hardware.org/?probe=3D1c5f5e5534) can pair with t=
he
keyboard and works without issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
