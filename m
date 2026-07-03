Received: from fluid8.de (fluid8.de [152.53.155.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F820247291
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.155.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104806; cv=none; b=sI9wAo7bIKU+tlJC5TGn9kh3obC/3HNrKZI/YYyVbEsfqdZpscg2ncTwMORtx6ytf4bas28ZZ44T0i2UnpNqFHNU3tFuXPjdKCD/jrOsiNSRYvXnxclVGbBNuOB0BE837uo6rx/Hean93h6U0UO+RvYXoHuX6xV+5Wx3MSDhClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104806; c=relaxed/simple;
	bh=J69/fD4hLwcXMvT1LziHTJToP7lyVSLF7vxDNEkroWM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VqO3bZYIc1gEqIGeEP4ES1W9x1So3EWId4OVRNhq09HRolZCCHDyJWQZD3QUyXxDpYch5aQV9q9BtgJm+YYeOkZMd6cpVakOmPrYbQsVzD6k581vxbbV2wecSKX4+UmxUFkzz4MFVK7TYBUtHPiqLOV/DMn8Pxh1PcTcj6ghoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluid8.de; spf=pass smtp.mailfrom=fluid8.de; dkim=pass (1024-bit key) header.d=fluid8.de header.i=@fluid8.de header.b=vI1QzaJ5; arc=none smtp.client-ip=152.53.155.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluid8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluid8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluid8.de header.i=@fluid8.de header.b="vI1QzaJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fluid8.de; s=mail;
	t=1783104252; bh=J69/fD4hLwcXMvT1LziHTJToP7lyVSLF7vxDNEkroWM=;
	h=Date:To:From:Subject:From;
	b=vI1QzaJ5K+g2gWo6g+ENFpCLZr40oL4aIKPFkFJwJk9+4OvywkRA3ihoHVf8M+aff
	 PaF6PtN2hhPf05PV9TrDPb1bA7GEWWXw9gGtL1oFrmSFcxPIWfH26JmL1JuEqK1+Ra
	 gvjiEzmHogsTQkRnkloTg/SyEbE1Fk/ib0UwM9Do=
Message-ID: <11453504-20db-45d0-87e0-ce5582dcbab4@fluid8.de>
Date: Fri, 3 Jul 2026 20:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB, de-DE
To: linux-bluetooth@vger.kernel.org
From: Jochen <dev@fluid8.de>
Subject: =?UTF-8?Q?Outdated_Intel_BT_firmware_ibt-hw-37=2E7=2E10-fw-1=2E0=2E?=
 =?UTF-8?Q?1=2E2d=2Ed=2Ebseq_=28patch_0x27=29_breaks_all_HFP/SCO_audio_?=
 =?UTF-8?Q?=E2=80=94_Windows_driver_ships_working_patch_0x2b?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hello everybody,

this is my first e-mail to a linux kernel list. Claude.ai to find the cause of this problem and created this text.

# Outdated Intel BT firmware ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq (patch 0x27) breaks all HFP/SCO audio — Windows driver ships working patch 0x2b

## Summary

The legacy Intel Bluetooth firmware `intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq`
in linux-firmware carries RAM patch **0x27 (39)** and has not been updated
since 2014. With this patch level, the HFP/HSP microphone path (SCO/eSCO,
CVSD) of the affected controllers is completely unusable: the decoded audio
is a constant full-scale buzz unrelated to microphone input, and the kernel
log floods with `Bluetooth: hci0: corrupted SCO packet`.

Intel's own Windows driver package for the same hardware ships RAM patch
**0x2b (43)** for the same firmware variant. Loading that patch on Linux
(extracted from the Windows driver, converted 1:1 — the embedded blob is
already in bseq format) **fully fixes HFP audio**: clean, intelligible
microphone audio and zero corrupted SCO packets, on both eSCO and basic SCO.

Since firmware submissions must come from the vendor, this is a request for
Intel to submit their final patch level for the ibt-hw-37.7.x legacy
(Wilkins Peak) firmware files to linux-firmware.

## Hardware

- Intel Dual Band Wireless-AC 3160 combo card
- BT controller: USB `8087:07dc`, "Legacy ROM 2.5 revision 0.0 build 1 week 45 2013"
- Loaded firmware file: `intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq`
- Distro/kernel: Ubuntu, kernel 7.0.0-27-generic, linux-firmware 20260319
- Headset used for testing: Jabra Evolve 65 (BT), PipeWire/WirePlumber 0.5.x, native HFP backend, CVSD

## Symptom with current linux-firmware (patch 0x27)

- HFP microphone capture is a constant full-scale roar: peak = 32768,
   RMS ≈ 29400, RMS envelope flat at maximum for the whole capture,
   completely uncorrelated with speech. (Typical CVSD delta-decoder railing
   on a desynchronized/garbage bitstream.)
- Kernel log: thousands of `corrupted SCO packet` messages per 10 s capture
   (btusb SCO reassembly desyncs on the controller's bursty/corrupted
   eSCO-over-USB stream).
- Independent of: eSCO vs. basic SCO (tested via forced HV3), xHCI vs. EHCI
   routing, alt-setting, autosuspend. A2DP is unaffected.
- Long-standing reports of the same symptom on this chip family, e.g.
   Ubuntu bug #1310558 (2014, fixed back then by a firmware patch update),
   Linux Mint discussion #662 (2024, kernel 6.8, unresolved).

## Fix: patch 0x2b from Intel's Windows driver

Source (publicly available from Intel): `BT_21.10.1_64_Win8.1.exe`.
The package embeds the RAM patch for each firmware variant inside the
driver binaries, already in bseq format (identical HCI cmd/event record
stream as consumed by btintel's legacy patching):

- Header for fw variant 1.0.1.2d in linux-firmware:
   `018efc0a 00010008 0004012d 0d27` → patch **0x27**
- Header in the Windows driver (identical blob in all driver builds
   20.91.3.1 … 20.100.5.1 contained in the package):
   `018efc0a 00010008 0004012d 0d2b` → patch **0x2b**
- Extracted blob: 22627 bytes, 191 well-formed cmd/event records,
   same first command (0xfc8e) and same final command (0xfc60) as the
   linux-firmware file; sha256 `7a0ca9155e0ec489…` (full hash on request)

Result after installing this blob as
`/lib/firmware/intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq` and cold-booting
(the controller keeps the old RAM patch across warm reloads;
`Intel BT fw patch 0x2b completed & activated` confirmed in dmesg):

- eSCO (stock kernel, CVSD): clean intelligible microphone audio,
   0% clipping, speech-correlated RMS envelope, **0 corrupted SCO packets**
   during 15 s capture (previously ~2600 per 10 s). Some later runs show a
   small residue (~18 per 15 s) with no audible impact.
- Same result with basic SCO.
- Bonus: the USB autosuspend instability we saw with 0x27 (controller
   drops off the bus under SCO load) is also gone with 0x2b — verified
   with default runtime-PM settings including a real suspend/resume cycle.

## Comparison of all 37.7.10 variants

| linux-firmware file | patch in linux-firmware | patch in Windows driver |
|---|---|---|
| fw-1.0.1.2d.d.bseq | 0x27 | **0x2b** |
| fw-1.80.1.2d.d.bseq | 0x2a | **0x2b** |
| fw-1.0.2.3.d.bseq | 0x56 | 0x57 |
| fw-1.80.2.3.d.bseq | 0x57 | 0x57 (current) |

The `.2d` variants are the outdated ones; `1.80.2.3` already matches the
final Windows level.

## Request

Could Intel please submit the final patch level (0x2b) for the
`ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq` (and `fw-1.80.1.2d.d.bseq`) files —
and generally the last released patch levels for the 37.7.x legacy family —
to linux-firmware? The blobs already exist in bseq format inside Intel's
Windows driver packages; only a licensed re-release is needed.

I can provide full captures (WAV), btmon/usbmon traces, exact extraction
offsets, and full hashes on request.

kind regards,
Jochen

