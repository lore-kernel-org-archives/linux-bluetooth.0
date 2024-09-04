Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A437635
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446732; cv=none; b=DRlaeQmm50g/KUy/m28rK1KmHyxAeLnbXo6JmCtNLRZdYaE1d5IHrZpExN/5YwNYuMbfv1B85Sp/YSdSTxNpFg/TO3KgK5up4rK6BB9rTwhc0YL+MtzzlandOxIptwH9a4eUv0Mf4kB7MSDDpBK3bTkRBX/bK+PNr53yQdjkHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446732; c=relaxed/simple;
	bh=x4BV8jcMCCP0mjhwDnMocJXnGJBawK1FbEltTBjEmwE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sDJ5h9OZDz0GJNF2FYDrjfB8v4Qs0h2M+8ngDS0Urv6wZ6oDxcBC28E1zpBzXwJ4Z8Iy+CBB8V8X4EX+vDB2saEYOEshN0a0/lruQc/n0PLEnCVLBT6vDVmYu6kBpsN3V2perLm8WaEXpDOPJvQ7gDn8xCPZMhacy2/tW6oeIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewm9m+1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewm9m+1L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0873EC4CEC2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725446732;
	bh=x4BV8jcMCCP0mjhwDnMocJXnGJBawK1FbEltTBjEmwE=;
	h=From:To:Subject:Date:From;
	b=ewm9m+1LnZkswbZ9FzGXAUPaGBaM2+ucraO54L6fvnCisv8v6zWAGl8RsDp8Ti2gY
	 0PymzomavBn6NAZBmpqdLAflOW3CvdrP/SnERirYwczHHTTBtq2ysVZfxgbDbomduJ
	 gpJ3H3u+VeceTMpzgVZm8bujTZ+RB8LOOI7YNc2zl9dzEPZS6QLA9ojODbMINbb/vC
	 2mKhilLkhtLGA2YPWK3C70qYJDCs1L78h59mnCHtgiarxd283EhifaY9ZbLDXpmeGy
	 3VcLVP+VeylSOS7glV7FLEvoG4rU2lWVeW6Zw5Q5S5u1tgf1S00qaF2T2BDYfsdYl6
	 yIPLMI7gWXC4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6203C53B73; Wed,  4 Sep 2024 10:45:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219234] New: btusb: regression in rtl8761bu firmware
Date: Wed, 04 Sep 2024 10:45:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219234-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 219234
           Summary: btusb: regression in rtl8761bu firmware
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alexander@tsoy.me
        Regression: No

First of all, sorry if this is incorrect place to report firmware issues.

Since commit [1] communication between rtl8761bu and Xbox Series X controll=
ers
is very unstable. There are frequent reconnects that makes the rtl8761bu
controller unusable. Reverting mentioned commit fixes this issue.

Xbox Series X controller is tested with several latest BLE firmwares. There=
 are
no any errors in the kernel log.

This issue was also reported to xpadneo driver [2]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3D1de22a39246513ce431de0971a6376093a94c5c1
[2] https://github.com/atar-axis/xpadneo/issues/492

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
