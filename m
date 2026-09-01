Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936833B14B7
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273271; cv=none; b=tjzV762wKoHbYLjpW+ckBEnHugpkFz37G1qpDyZ617geVtTRB/HJJwTqlnWhCMkcgxGgzQyadmKROLrr2vq+uGHQFAnkmnqaq3U71I66z+v7Mz2BQuu5bp0yRsZ9BX/TwKr5TTVK2VrVjiMQqFtck6rTaMlwPotN6V6KAQwI1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273271; c=relaxed/simple;
	bh=SW7FEOCSeajxrd5jHBYXDtxhOLCasvkGRKfs3rU+l+I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pjpqseOI3B+QU1/u5ubp95S3j3dDWh5ev3XonYF9yHWEYIeZSMqp8UF70W4h0Ub0gtBeIrxYmfTRXi2Xjtwy9A8WJMjLDbwfzWi3OPs+aVH50o4eLq1/OuMAStxBzySQbToWjg3pUrUSjFjoNKC1tF1hf10+TMwheefF23Oju8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLEtLE+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLEtLE+J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DF0EC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788273271;
	bh=SW7FEOCSeajxrd5jHBYXDtxhOLCasvkGRKfs3rU+l+I=;
	h=From:To:Subject:Date:From;
	b=CLEtLE+JnhvwZhfW5KgusbdBdVWGUH0DYGDvDNFnG/X4jaEVLWwSkpGSAg1oz3BwI
	 d3ZTKuq3D0t+0VyiZ2I8UCy5QqyXOpK82wBDJUACRfIzEgEaPb2jiUg/58cNVOgX4y
	 nZ3semiFKkq76kGdnsMvys4tZGrUQLrr99cTa8LUA08kb+th20XZNLk/nQyL5JgFmb
	 w+O+hDOpTrEbApe6sPBEP+KzhLqNkoHjDT9luJyTT5RIjTw4pdjv28odj8UkuT7gk8
	 wIaRQOHCRFMdV6KS0TC+QGmU8mIv3v6gVe7dEz6LhCwnP6bFaim1WwHrH9DxZ07Bk4
	 ewXMjqtU9H0oA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 29A9BC433E1; Tue,  1 Sep 2026 14:34:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221952] New: btintel lacks firmware dependencies for several
 versions
Date: Tue, 01 Sep 2026 14:34:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jarl.gullberg@visar-systems.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221952

            Bug ID: 221952
           Summary: btintel lacks firmware dependencies for several
                    versions
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jarl.gullberg@visar-systems.com
        Regression: No

I have a system with an Intel bluetooth card that requires the
intel/ibt-17-16-1.sfi firmware to properly initialize.

lsusb: Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
Jefferson Peak=20
(JfP)

The firmware is available in the kernel tree and loads fine if it is presen=
t on
module load, however, it is not declared as a dependency of btintel in
btintel.c.

This appears to be the case for several other firmware versions as well, wi=
th
the only ones listed at time of writing being

MODULE_FIRMWARE("intel/ibt-11-5.sfi");
MODULE_FIRMWARE("intel/ibt-11-5.ddc");
MODULE_FIRMWARE("intel/ibt-12-16.sfi");
MODULE_FIRMWARE("intel/ibt-12-16.ddc");

Ordinarily, this would not be an issue, but I am using mkosi-initrd which
utilizes the embedded firmware metadata for the kernel module to identify w=
hich
files it needs to copy into (or retain) in the initrd. Because the firmware
version required by this card is not listed, mkosi-initrd does not include =
it
in the final initrd. This causes the card to not load properly on boot,
requiring an rmmod/modprobe after the system has fully booted which lets it
load the firmware file from main storage instead of the initrd.

dmesg in the initrd:
[    5.765232] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 20=
15
[    5.766307] Bluetooth: hci0: Device revision is 2
[    5.766315] Bluetooth: hci0: Secure boot is enabled
[    5.766320] Bluetooth: hci0: OTP lock is enabled
[    5.766324] Bluetooth: hci0: API lock is enabled
[    5.766327] Bluetooth: hci0: Debug lock is disabled
[    5.766331] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    5.766367] bluetooth hci0: firmware: failed to load intel/ibt-17-16-1.s=
fi
(-2)
[    5.766385] bluetooth hci0: firmware: failed to load intel/ibt-17-16-1.s=
fi
(-2)
[    5.766404] bluetooth hci0: firmware: failed to load intel/ibt-17-16-1.s=
fi
(-2)
[    5.766411] Bluetooth: hci0: Failed to load Intel firmware file
intel/ibt-17-16-1.sfi (-2)
[    5.767287] Bluetooth: hci0: Reading supported features failed (-56)
[    5.767296] Bluetooth: hci0: Error reading debug features
[    5.767303] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.

dmesg on the host after boot and rmmod/modprobe:
[ 3825.660321] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 20=
15
[ 3825.661260] Bluetooth: hci0: Device revision is 2
[ 3825.661276] Bluetooth: hci0: Secure boot is enabled
[ 3825.661284] Bluetooth: hci0: OTP lock is enabled
[ 3825.661290] Bluetooth: hci0: API lock is enabled
[ 3825.661295] Bluetooth: hci0: Debug lock is disabled
[ 3825.661300] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 3825.665645] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[ 3825.665743] Bluetooth: hci0: Boot Address: 0x40800
[ 3825.665745] Bluetooth: hci0: Firmware Version: 201-12.24
[ 3827.420681] Bluetooth: hci0: Waiting for firmware download to complete
[ 3827.421351] Bluetooth: hci0: Firmware loaded in 1714560 usecs
[ 3827.421559] Bluetooth: hci0: Waiting for device to boot
[ 3827.435417] Bluetooth: hci0: Device booted in 13654 usecs
[ 3827.435607] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-17-16-1.ddc
[ 3827.437363] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 3827.438337] Bluetooth: hci0: Firmware revision 0.1 build 201 week 12 2024
[ 3827.440365] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its
usage is not supported.

I am not entirely familiar with how the module firmware metadata is used, b=
ut I
assume that the lack of entries for this (and other) firmware is not
intentional. In total, there are over 40 versions of the ibt firmware not
listed in btintel.c.

This behaviour was observed on kernel version 6.12.107, but the latest comm=
it
on the kernel is still missing the applicable MODULE_FIRMWARE entries.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
