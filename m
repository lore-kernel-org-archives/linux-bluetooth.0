Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF87E573
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911138; cv=none; b=cd7dcFJAUp4lzMH7qRY0F2fufdVIk/yeoyNdnHLmv6vwwDn4G1GeeyxcFh8LHA4jN3KxrzY2LFUcAJKoQtTEejVFrcKt1kxcgMAUEmefrjLU03Ge0taElwgZIey2X8t798Mp94Nk1WdjATsaDAXRqMb+vOpgYBrVsan3cw/Pcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911138; c=relaxed/simple;
	bh=l/0D6639KqNsA7xGMPXJzVRl9EHCsd4oyiNKzZIIQyQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BxWsJg4LjvIbQe+QdV9KOroQSpyJvmoK23+vuZsRxc1+BRHuuVDd6P13JbnGZDX6mO3u4TvMGZ3WzR7YBcVsYe+75J1e8WHPjjW4uljGeMePkLDQpDWXzZL/Mt2PaWKxtJAZpg/JLWxH5ZFe4i9ixd2R6AyunfyZoh1+jjOLeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE4Bh/ct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE4Bh/ct"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B866C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775911138;
	bh=l/0D6639KqNsA7xGMPXJzVRl9EHCsd4oyiNKzZIIQyQ=;
	h=From:To:Subject:Date:From;
	b=KE4Bh/ctOKiwdxdbU2V2uYj7DA46cL82BMi71SGl44qtk23AtGnXkyYCCnwbrORCO
	 6gvSP9vso8W+V6uiXSbFaIx7VwtHDPYdFucrCYX5y9eGDKXKguLDfZLQ/bnTOdDrqM
	 UyyUUQ/2b8kvgtBzlIIUxu9G8H+z9Zq49Oyi1djRdXmcLwjKyyCjRfbktTcrYcLbTB
	 j/M5pZxc589YkARDwKzIbqE8ARMJLJa9LQiKpTCH4WKriQ9+ecgEVaym0pcD/T65f4
	 A0e+S7aqKszXvYZ8Gio+2bHsN6EDlajE6Gai+W4Wdx55LBDtNRlxXngvzeWPY16dnW
	 T7iwW4gPFLE7Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E71CC433E1; Sat, 11 Apr 2026 12:38:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] New: Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Sat, 11 Apr 2026 12:38:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

            Bug ID: 221346
           Summary: Bluetooth: btintel_pcie (8086:e476) may hang in
                    shutdown path (synchronize_irq) during reboot stress
                    test
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: zhangzhigang1996@gmail.com
        Regression: No

On a system with Intel Bluetooth device [8086:e476] using the btintel_pcie
driver, the system intermittently hangs during reboot or shutdown, especial=
ly
under stress test conditions (continuous reboot cycles).

During shutdown, systemd-udevd is observed to be stuck in D state. Kernel
stack traces show the task blocked in the driver removal path, waiting in
synchronize_irq() after free_irq() is called.

The relevant call trace is:

  btintel_pcie_remove()
    =E2=86=92 free_irq()
    =E2=86=92 synchronize_irq()
      =E2=86=92 __synchronize_irq()
      =E2=86=92 wait for IRQ handler completion (never returns)

This indicates that the interrupt handler associated with the device may not
be properly quiesced before free_irq(), leading to a deadlock during teardo=
wn.

The issue is reproducible and disappears when the btintel_pcie module is
unloaded or blacklisted, suggesting the problem is specific to the btintel_=
pcie
driver.

No firmware loading errors are observed, and the device is otherwise functi=
onal
during normal operation.

This may indicate incomplete interrupt shutdown handling in the btintel_pcie
driver.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
