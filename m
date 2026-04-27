Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99413D667C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307521; cv=none; b=EITWFM9siRRwF76aITeOj2CO9Pb9oqpjt0U4uC31srb6+B7oCsPImriTpyPzwEYHbNBYsA2cekMwMtS9Pz/B84muWxqvWShyJQOYr2r58/qX9seMvy5T/nWW2tSrrlBWHQAko43D9xss7k6gcuRSpNy+t4C2h+jCnosbcM7obmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307521; c=relaxed/simple;
	bh=xA3261KH6wJMPXiZOqI/spbkuvwXsbK85jJVs9yGOEE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hUcHcpLBxM1x6iN/U1ioVUQLVZspcciS9mV7vJ/7+qLxKkP18JJbuRyRUNH/VWRKtw4UEhvm+h9eMdki6HtI247JWDHqg7anoTGS3BbO8/aVbGsgz1kwKUVwof6aKoxItm9NIlGafWHg+adSphsL53L7nM8u3vc10Ba48kL1nSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I05/mq4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I05/mq4F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56FBFC19425
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777307521;
	bh=xA3261KH6wJMPXiZOqI/spbkuvwXsbK85jJVs9yGOEE=;
	h=From:To:Subject:Date:From;
	b=I05/mq4FwY+NjCX51kkYIaX+WD+e0r4KitrRcb+1zyFXAmqrrYxUIRrsC+85UU8lS
	 q75Wa+weogfopv1L4pYO2rt7B70/g7/fflSrLI/XD/we0KQvGbT5aTH7pYlBI7kx4U
	 p/unnvEau2ZNa1p56vKQPiKvlc5UoN+vVBo8T/qYJPB4UDj1C1J3j4OH2KiZPL5/sz
	 3rWdSLlEst1JxjVihwscLzhS0Bye8f1bbdI/6NkUKW9K9UlhLtiZRSoTkFaiiNwSL/
	 Ap01l5VuTLZHuXHYozSvf//kTMvEIVJ4yEjfX2bQPvj8I498KxM7TyLh1mWLdco5zI
	 UxIHoRiHRITtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46594C4160E; Mon, 27 Apr 2026 16:32:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] New: Intel AX211 Bluetooth hci0 hardware error 0x0c
 with HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 16:32:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cristi@ieee.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

            Bug ID: 221426
           Summary: Intel AX211 Bluetooth hci0 hardware error 0x0c with
                    HID/HOG failures on 6.19.14-zen
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: cristi@ieee.org
        Regression: No

Created attachment 309973
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309973&action=3Dedit
Log highlights

# AX211 Bluetooth HID instability report

## Summary
Intel AX211 Bluetooth on this system intermittently fails with kernel hardw=
are
error 0x0c and repeated BlueZ HOG profile failures. User-facing symptom is =
that
BLE mouse and keyboard become difficult or impossible to connect while Chro=
me
is open; closing Chrome often allows reconnect.

This appears to be a kernel or controller stability problem, potentially
amplified by power management settings and high USB activity.

## Environment
- Distro: ArchLinux rolling
- Kernel: 6.19.14-zen1-1-zen
- Bluetooth controller: Intel AX211 Bluetooth (USB ID 8087:0033)
- Devices affected: Logitech M720 mouse, Logitech K850 keyboard (BLE HID)

## Reproduction
1. Boot system normally.
2. Ensure Bluetooth service is active.
3. Open Chrome and use system normally.
4. Attempt to connect or keep connected BLE keyboard and mouse.
5. Observe failures, reconnect loops, or failed writes.
6. Close Chrome and retry; connection usually succeeds.

## Expected behavior
BLE mouse and keyboard should remain stable regardless of Chrome state.

## Actual behavior
BLE HID profile operation intermittently fails; reconnect loops occur and
controller errors are logged.

## High signal evidence
From kernel log:

    Bluetooth: hci0: Hardware error 0x0c
    Bluetooth: hci0: Retrieving Intel exception info failed (-16)

From bluetooth service log:

    profiles/input/hog-lib.c:output_written_cb() Write output report failed:
Request attribute has encountered an unlikely error
    Wrong size of start discovery return parameters

Power-management related state on this host:

    /sys/module/btusb/parameters/enable_autosuspend=3DY
    /sys/module/usbcore/parameters/autosuspend=3D2

## Attachments
- System snapshot: ax211-bt-system-2026-04-27.txt
- Log highlights: ax211-bt-logs-2026-04-27.txt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
