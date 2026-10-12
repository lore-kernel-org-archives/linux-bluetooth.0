Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B73D5640
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799353; cv=none; b=pOjyv/yG+iXCscsicBr0Fmh6h1yeZp129njF4vXRIACSbi83jx48GSi51myN5U8sJSpx9E7rB6Rx9rguBV0tOpP66NitZzwJ3N4wosEa5EVEojxTHPctL1INffkWU3THWp/KwUncB+UUMFsXEp7wsfZNcjtAPcq0trqD7wkHaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799353; c=relaxed/simple;
	bh=vz4XB6ECs5NjPbE0paCAYmIysj8w4KhBpZWhpYkhdYQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hAh+eC1uEdKr3SrQnidQHgPPmyol5tKxFIZ02KMVn8/bC2yq1e3CGBXyc3kvcWDeye1PacEtQ356s0uyDwFesXNVUF4GqU7rchSL1HsKSnff35skWr5HVpzA7XqVTr2qyrcVIqsNyUrJcGv3OizjRZlVZxL4SLyhUnLNn8XEiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCGVcnqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCGVcnqr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B54C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791799352;
	bh=vz4XB6ECs5NjPbE0paCAYmIysj8w4KhBpZWhpYkhdYQ=;
	h=From:To:Subject:Date:From;
	b=rCGVcnqrdCEbAg5WxsA/iLrbvNPajBDSOEXfxbAeVWeM6RUiCLozi+3eiu2hLRYAL
	 S1Dw4QYR6SofIEx/Ia8ZfRayivQMTqvlATCxbH396lMUKYHtdE4fNKdqu5Ux8s+1Em
	 xhEPOxIQNqs/Ch4BTGkULdslEYgfPsI1J208ZgC1+wB16fnBu8PJCaBCdNNhn4Py6M
	 oxO65f1MWNxI39lpXGdTt7Qtpw/Dcg2moyj7edmiCrBe4sBE0Q1a/fbXGxXB3uKySi
	 J7lZK3MSgbI38kC8ieCC7xr8WB1g1HlnMfbVpUatZ4NXuDWHyzgG+FvMdQl3fHiRnd
	 ZdciIYeVGBdGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5FE33C3279F; Mon, 12 Oct 2026 10:02:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222120] New: Intel CNVi: Wi-Fi roam drops active Bluetooth
 audio, ACL stays up (8086:e440 / 8086:e476)
Date: Mon, 12 Oct 2026 10:02:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nanericwang@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222120-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222120

            Bug ID: 222120
           Summary: Intel CNVi: Wi-Fi roam drops active Bluetooth audio,
                    ACL stays up (8086:e440 / 8086:e476)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nanericwang@gmail.com
        Regression: No

Hardware
  00:14.3 Wi-Fi      [8086:e440] iwlwifi
                     firmware 106.c88d33af.0 sc-a0-wh-b0-c106.ucode (iwlmld)
  00:14.7 Bluetooth  [8086:e476] btintel_pcie
  Headset: EDIFIER ClearCall 200, 0C:AE:BD:D3:B9:40
           A2DP (SBC XQ) and HFP. The device stayed connected.

Software
  Linux 7.2.9-2-cachyos (CachyOS build of tag cachyos-7.2.9-2)
  BlueZ 5.87, PipeWire 1.6.9
  Bluetooth firmware: intel/ibt-00a0-01a1-pci.sfi
    version 214-29.26, timestamp 2026.29 build 96982, SHA1 0x239ed887

Audio was playing. Wi-Fi roamed. The A2DP and SCO transports went idle.
bluetoothd logged nothing. btintel_pcie logged nothing. PipeWire then
printed:

  spa.bluez5: Failure in Bluetooth audio transport .../sep1/fd0
  pw.node: (bluez_output....) running -> error (Received error event)

That PipeWire line is what it prints when an A2DP sink that was already
running leaves the active state.

Local time 2026-10-12, UTC+8. wlp0s20f3 lines are
"disconnect from AP <bssid> for new auth to <bssid>", all under 20:df:73.

  16:00:38  roam
  16:00:54  A2DP sep1/fd0 dies
  16:00:55  roam
  16:01:12  roam
  16:01:32  SCO fd49 dies
  16:01:38  A2DP sep1/fd0 dies again
  16:01:46  roam

From 15:44 to 16:02 the same ESS roamed nine times. Those three audio
failures are inside that window.

btintel_pcie has no path that tears down A2DP or SCO because iwlwifi
roamed. The ACL stayed up. The controller dropped the audio channel
while Wi-Fi was using the radio.

Boot log, separate from the drop. DSBR was applied. Bluetooth still
came up. The .ddc file is 16 bytes. The first record is ID 0x0128,
value 0x18. btintel_load_ddc_config() sends HCI 0xfc8b and returns on
the first error, so ID 0x0126 is never sent. The caller ignores the
error.

  Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
  Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-00a0-01a1-pci.ddc
  Bluetooth: hci0: Failed to send Intel_Write_DDC (-95)

This is not Launchpad 2088151. That one is Write_DDC -16, then hardware
error 0x0f, on intel/ibt-0093-0291.ddc.

Same PCI id, different bug: kernel bug 221346 is a shutdown hang in
synchronize_irq().

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
