Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D14071C6
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780788305; cv=none; b=hkQvPYHb9rNznv0ct6qnHwNfVaTQF3tS+ShWkNEEY3zJe4GhrUxrtgMGafhu9B/9Vrplmgv35vfnResq/WpcBeY+SA00cmJbf5mJUWydg/07lngCmrGFEUIbGElULek6y0nPirFMAkj17tsaEvHR79EE7iUPGU5HZW8ddFfRT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780788305; c=relaxed/simple;
	bh=oGqFP+GhbUaNUpuyj+tSy0hbC8yVx7BJnEmIxAWLUxE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XyDc1nFqStv6VnJrzqzoilH4eKfiU9TXIC66vh1px6l0Pb68tVPvLBB3XfY3aOPPAssSv0fvnPNtSl5tf/f9IGFRqvyBzLbHLqWRvl+7CG4j5rM9Q3OQiesM4y1zZsgTKWT0soZ7V4+Qv+OpfnkUTfkeGVbkZ6bUvRkmrMXLTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzhwKK9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzhwKK9X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1B06C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780788304;
	bh=oGqFP+GhbUaNUpuyj+tSy0hbC8yVx7BJnEmIxAWLUxE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rzhwKK9XV+NX20bluUflQypC4Bo5mEU064NlojeuxTq2XAl3k1p8XSyxXdICqAwU8
	 CwMGsURX6huJ54lbpla/7HUQcckFWb5bmo7ikN6Ly0Ea/kC0J9A3cdSrVB/pvFwubm
	 QmZR7C5d21yk7a+6iBUGixrX1FgMVmfuLkgSQ4IlP2zAMFXiiMgye9N2CU6y/7glhF
	 UwNXbDf9LXKFHfe6r7rOJbMN5jBOGkAnb99y4Byr+hArZbrQllfYpRClfOYAdIC/O4
	 35KRsL6LQgUePLu4rlAWHpuGts4vuQ91jGenJ27n+9avdSrWmZqHHjaWZQb+oqykUe
	 cenKnu0qNdUgQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C536BC41614; Sat,  6 Jun 2026 23:25:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Sat, 06 Jun 2026 23:25:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: p@atiq.xyz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-k42rC1AY8w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

Solarized (p@atiq.xyz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |p@atiq.xyz

--- Comment #15 from Solarized (p@atiq.xyz) ---
repros on kernel 7.0.9 on Asus ProArt 7606WV (has mediatek wireless chip)

if you peak into kernel log using `journalctl` you will find this:

```plain
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.0: DSP1:
cirrus/cs35l56-b0-dsp1-misc-10431e63-spkid1-amp1.bin (v1): v3.11.16
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.0: DSP1: mis=
c:
C:\Users\gchen\Desktop\Asus_proj\CY24\MP\H7606W\240830\init\10431E63_240830=
_V1_A0-init.bin
Jun 06 13:19:30 kernel: Bluetooth: hci0: Failed to send wmt func ctrl (-22)
Jun 06 13:19:30 kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous
Connection command is advertised, but not supported.
Jun 06 13:19:30 kernel: zram0: detected capacity change from 0 to 33554432
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.1: Calibrati=
on
applied
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.0: Calibrati=
on
applied
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.1: Tuning PI=
D:
0x531116, SID: 0x201104, TID: 0x3c8830
Jun 06 13:19:30 kernel: cs35l56-hda i2c-CSC3556:00-cs35l56-hda.0: Tuning PI=
D:
0x531116, SID: 0x201004, TID: 0x3c8830
Jun 06 13:19:31 kernel: NVRM: testIfDsmSubFunctionEnabled: GPS ACPI DSM cal=
led
before _acpiDsmSupportedFuncCacheInit subfunction =3D 10.
Jun 06 13:19:31 kernel: NVRM: testIfDsmSubFunctionEnabled: GPS ACPI DSM cal=
led
before _acpiDsmSupportedFuncCacheInit subfunction =3D 11.
Jun 06 13:19:31 kernel: [drm] Initialized nvidia-drm 0.0.0 for 0000:64:00.0=
 on
minor 1

```
which indicates broken bluetooth mediatek driver.


And, service log, shows following

```plain
$ journalctl --boot --unit bluetooth.service
Jun 06 13:19:29 systemd[1]: Starting bluetooth.service - Bluetooth service.=
..
Jun 06 13:19:29 (uetoothd)[1329]: bluetooth.service: ConfigurationDirectory
'bluetooth' already exists but the mode is different. (File system: 755
ConfigurationDirectoryMode: 555)
Jun 06 13:19:29 bluetoothd[1329]: Bluetooth daemon 5.72
Jun 06 13:19:29 bluetoothd[1329]: Starting SDP server
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support csip plugin
Jun 06 13:19:29 bluetoothd[1329]: profiles/audio/micp.c:micp_init() D-Bus
experimental not enabled
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support micp plugin
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support vcp plugin
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support mcp plugin
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support bass plugin
Jun 06 13:19:29 bluetoothd[1329]: src/plugin.c:plugin_init() System does not
support bap plugin
Jun 06 13:19:29 bluetoothd[1329]: Bluetooth management interface 1.23
initialized
Jun 06 13:19:29 systemd[1]: Started bluetooth.service - Bluetooth service.
```

Related:
-
https://lore.kernel.org/all/81bcf9fd-2f07-4fc6-be90-da4e448379e4@leemhuis.i=
nfo/
-
https://www.reddit.com/r/linuxhardware/comments/1tfn5ev/mediatek_mt7921_blu=
etooth_not_initializing/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
