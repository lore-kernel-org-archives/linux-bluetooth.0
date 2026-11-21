Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273562;
	b=HkMayy2+QvTOK6rBnu18usSaVmUcO87rwpWyZo5ibHR8OqPCEnsJONr8rEwbza1Z8IuJ
	 l4yEWGO64z9nSopRkqOFR4U1ELQf/Bx7fdNiMNjnCDq31CTnmrgHrqfPPJpuK0s/jcphq
	 abvAlD8hahkpbWfcwGaQa1w+m3+/v8Pw3rQ0RBbynVAP6qD+UVTnYXDBSrMI0+2isAWYM
	 etDMUATTPSkdUTQoy3mT4IvNHOQefeOCw8wRDEECLW7J6WZbp+MJKKiscUbuT7KTiQyOf
	 6bUGyzrYCFLiiv1PBr1seksIrcZFSZYGnO3r3dxjI2WZUEvibY9xiJwGg4aHrqVhYiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273562;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=yyXjyfWpfhoqAQrENm/P9PHRrLqFgvThMJB3vRvoriQ=;
	b=s6SgpsSLZpXz1TvrurjbOfKcEyvpX1TgwZ3vFaSSm3OPfQavnmP/tNFJ4cKDEFV7tSQF
	 RqwvCknOCcUJFmRBBUff7lIqv+ZsU3vfEDIhjTxZHndDBzaIK7G9UUhQnBYWBgXMJVMzI
	 6iNV+/lQMhXxau//gJAwzou9X4FdC8pSA9hzz7TMSz8gq88fMiU7ZY+9QT3blp8MuxR4E
	 ArKsdggZciMiLPpOut26bvRKR+7sMXjPkcp7P0FoyN4KtWo+KgIa+ONQl34ZxZNp5Ei+x
	 3obMcibYf5KxKRGhx97QUt0/fkaWtyh38sidWSsFLpp2LCiBUvqF9sqhEnurM4uhITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsc5ZzYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F025606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsc5ZzYd
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8A101F000C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795273561;
	bh=yyXjyfWpfhoqAQrENm/P9PHRrLqFgvThMJB3vRvoriQ=;
	h=From:To:Subject:Date;
	b=lsc5ZzYdXR7p1B+qTCM/NKq2DyhZ29V4vEa5xnaEOT2SmXWcPxBSNs8aUel6JEj9h
	 JcoDGeIFuJiE41ThDuzGhFYRatdVur+3j53tCI38PxmGGq4FmOc3pNHOG0XveeJqqM
	 LEOsjVMJ6pQTWdusqtfcBcNpZ/ZepMuxf9QU63CRs4fTKja7lV9rAPO9g4vPpbOCQ/
	 OBwE2PhUWF3R9VtOa7hoase+kUy/FCtOyq+LOp77WabdaP28CBgI0lUqnQ3e9BHRDo
	 ym897h4jqjeI2r3KdyLzXd1lTFjbztcUVVW+dUfy74Hy7+ZTnq0lIL5gcf5n10httt
	 +G0fTLeOkT6Ug==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id C5952240040C; Sat, 21 Nov 2026 15:06:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222310] New: [Intel Panther Lake][btintel_pcie] Bluetooth A2DP
 playback stalls; HCI packet completion warnings
Date: Sat, 21 Nov 2026 15:06:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222310-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222310

            Bug ID: 222310
           Summary: [Intel Panther Lake][btintel_pcie] Bluetooth A2DP
                    playback stalls; HCI packet completion warnings
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

Bluetooth A2DP audio playback fails on an Intel Panther Lake system using t=
he
`btintel_pcie` driver.

The Bluetooth speakers pair and connect successfully. BlueZ reports an
established connection, and PipeWire/WirePlumber correctly discover the dev=
ice
and create an A2DP output sink using the standard SBC codec.

However, no audio is heard. PipeWire playback clients become stuck: `pw-pla=
y`
starts but never completes playback of a short WAV file and must be interru=
pted
manually.

During the failure, `pw-top` shows both the Bluetooth output sink and the
playback client in the RUNNING state, but neither processes audio:

```
S   ID   QUANT  RATE  WAIT   BUSY   W/Q  B/Q  ERR  FORMAT
R  152       0     0  0.0us  0.0us   ???  ???    0  S16LE 2 48000=20
bluez_output...
R  265       0     0  0.0us  0.0us   ???  ???    0  S16LE 1 48000  pw-play
```

Other audio devices operate with nonzero quantum and rate values.

WirePlumber also logs repeated Bluetooth transmission-completion warnings:

```
spa.bluez5.sink.media: Missing completion reports for packet
Bluetooth adapter firmware bug?
```

A Bluetooth codec-switching attempt also produced:

```
spa.bluez5: media codec switch ... failed (org.bluez.Error.Failed)
spa.bluez5.device: failed to switch codec (-19)
```

The symptoms suggest a failure to establish or advance the A2DP media
transport. A problem involving `btintel_pcie`, controller firmware, or
Bluetooth transport handling is suspected, although a PipeWire/WirePlumber =
or
BlueZ issue has not been ruled out.

## Hardware

- Platform: Intel Core Ultra Series 3 (Panther Lake), HP OmniBook 7
- Bluetooth controller: Intel CNVi Bluetooth, PCI ID `8086:e476`, revision =
`01`
- Subsystem: `8086:0011`
- Kernel driver: `btintel_pcie`
- Bluetooth firmware: `intel/ibt-00a0-01a1-iml.sfi` and
`intel/ibt-00a0-01a1-pci.sfi`
- Firmware version reported during loading: `19-36.26`
- Running firmware timestamp: `2026.36`, build `102163`
- Bluetooth speakers: SVEN MC-30, Bluetooth Classic A2DP, SBC

## Software

- Distribution: Fedora 45
- PipeWire: 1.6.11
- WirePlumber: 1.6.11
- BlueZ: bluez-5.88-1.fc45.x86_64
- Kernel: 7.3.4-300.fc45.x86_64

## Steps to reproduce

1. Boot the system and connect the SVEN MC-30 speakers over Bluetooth.
2. Confirm that BlueZ reports the speakers as connected.
3. Confirm that PipeWire selects the standard SBC A2DP profile (`a2dp-sink`=
).
4. Set the Bluetooth output sink as the default audio output.
5. Attempt playback:

   ```
   pw-play --target <bluetooth-sink-name>
/usr/share/sounds/alsa/Front_Center.wav
   ```

6. Observe that no audio is heard and `pw-play` does not finish.
7. Run `pw-top` while playback is stalled.

## Expected behavior

The speakers should play audio using the standard SBC codec. PipeWire should
process audio normally, and `pw-play` should terminate after the WAV file
finishes.

## Actual behavior

- Bluetooth pairing and connection succeed.
- The standard SBC A2DP profile is available and active.
- The Bluetooth audio sink is created and selected.
- Playback is silent.
- `pw-play` never finishes until manually interrupted.
- During the stalled playback, the Bluetooth sink and `pw-play` show `QUANT=
=3D0`,
`RATE=3D0` and no processing activity in `pw-top`.
- WirePlumber has reported missing Bluetooth packet-completion notification=
s.

## Additional observations

- Disconnecting and reconnecting the speakers through `bluetoothctl` succee=
ds
but does not resolve the problem.
- Changing sink volume and unmuting the output have no effect.
- Switching from standard SBC to SBC-XQ causes the speakers to become
unresponsive, with their Bluetooth indicator turning red. SBC-XQ may be
unsupported or incorrectly handled by the speakers; this is not necessarily
related to the original failure.
- Returning to standard SBC restores the reported Bluetooth connection and
audio sink, but playback remains broken.
- Intel firmware initialization appears successful in the boot log, includi=
ng
`Fseq status: Success (0x00)`.
- This is the first attempt to use these speakers with this computer, so no
previously working kernel version is known.
- A clean-boot retest and a cross-device speaker test have not yet been
reported.

## Diagnostic assessment

The problem does not appear to be caused by ordinary application-level audio
routing, volume, or mute configuration.

The Bluetooth output is recognized and the playback client is created, but =
its
PipeWire processing graph does not advance.

The `Missing completion reports for packet` warnings may indicate a Bluetoo=
th
controller or firmware transport problem. However, these warnings alone do =
not
prove that the PCIe Bluetooth driver is responsible.

Further investigation may require tracing A2DP media transport acquisition =
and
HCI packet completion handling in the Intel PCIe Bluetooth driver.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
