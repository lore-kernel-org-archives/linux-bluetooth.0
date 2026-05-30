Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5272603
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154291; cv=none; b=hc3pK7lLBsif6byidF6pCuh5uFagSCsyq0FBJHdlyjlKPkLhV7vvJsTD6tjWtVgHfvJ5nuwcXYeMT5X2Jv/N15il6DSgqPBHtC7n1B9p2m1OyYvKgKdIle/UuecAt6LBgMHnX5OdQVSGPfSHFNC9eQHJcX3kICAuT3SOKG1DVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154291; c=relaxed/simple;
	bh=srkXpMtC7TI+65DqN97fZmDaIf0xOdiLkXAqYUsdmzU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LsImOgglf2t0zM9wCuhaNDiSHzDmf5zWv0aflxZb8P8KLGz5GRKPKk2T+OGM+aFFPI4Rgm27WFnJdEp+wtFTQ19VtSdnhMETdzh4kEo73rmgbSVHb/2hE0wW28m4vjF/NWWozGpDMqDFfputt0s/7kA8J3CQvjliMRbxlmB4Un8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+lMzROR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+lMzROR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC00CC19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780154290;
	bh=srkXpMtC7TI+65DqN97fZmDaIf0xOdiLkXAqYUsdmzU=;
	h=From:To:Subject:Date:From;
	b=I+lMzRORO8P/qBKLjUX7oeYR0Dp4B6Ay37vjzEPagS7y593tBpozwKVcIzzWKnCTK
	 GNofnN30V8U1/zpv/6o65uwGv6duW0rTDDAPGLNhSNk3/uT5mdpIioMQJtiyGpgkvZ
	 t3fGHwiNWTMIPRWwUFFsUmIThP6lQHeVDeQKrrC89fMYGSQfx3E1XjhepiEfJUCOau
	 6O78WRilNAS1rTAwR3/XZh7L/hjYPYJEAz08iZfWBHyfJQnevYGbTiBGN3WbknKdjN
	 RVDNZuI7JZRmmUsiWE9+kYAnL96CpmYNlqeejzHvv99xssKIyskdYRQre30Mn9GMxl
	 1THtYlwt0nikA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AFCEBC3279F; Sat, 30 May 2026 15:18:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] New: Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:18:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

            Bug ID: 221598
           Summary: Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
                    microphone stutters with bursty SCO RX delivery
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.12.90+deb13.1-rt-amd64, 6.12.90+deb13-amd64,
                    6.19.10-300.fc44.x86_64
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: apocarteres@gmail.com
        Regression: No

Created attachment 310210
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310210&action=3Dedit
btsnoop captures and report draft

I am seeing severe HFP/mSBC microphone stutter with a Realtek RTL8821C
Bluetooth USB controller on Linux. The same PC and the same Bluetooth heads=
ets
work correctly under Windows 11.

The problem reproduces on both Debian and Fedora live systems, so it does n=
ot
look specific to one distribution audio stack.

### Hardware

Bluetooth controller:

```
Bus 003 Device 007: ID 0bda:c821 Realtek Semiconductor Corp. Bluetooth Radio
Negotiated speed: Full Speed (12Mbps)
```

Controller details from Linux:

```
hci0: Type: Primary  Bus: USB
BD Address: 64:57:25:4C:4E:BA
HCI Version: 4.2 (0x8)  Revision: 0x75b8
LMP Version: 4.2 (0x8)  Subversion: 0xf098
Manufacturer: Realtek Semiconductor Corporation (93)
```

Kernel log during initialization:

```
Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c lmp_ver=3D08
lmp_subver=3D8821
Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
Bluetooth: hci0: RTL: cfg_sz 10, total sz 34926
Bluetooth: hci0: RTL: fw version 0x75b8f098
```

Headsets tested:

- JBL TOUR ONE M2
- Jabra headset, exact model unknown

Both headsets show the same problem on Linux and work normally on Windows 1=
1 on
the same machine.

### Software tested

Debian:

```
Linux dev 6.12.90+deb13.1-rt-amd64 #1 SMP PREEMPT_RT Debian 6.12.90-2
(2026-05-27) x86_64 GNU/Linux
bluez 5.82-1.1
pipewire 1.4.2-1
wireplumber 0.5.8-2
firmware-realtek 20250410-2
```

The same issue was also reproduced on the non-RT Debian 6.12.90 kernel.

Fedora live:

```
Linux version 6.19.10-300.fc44.x86_64
Bluetooth subsystem version 2.22
```

The Fedora capture was made from a live Fedora Workstation 44 system.

### Actual behavior

In HFP/mSBC mode the microphone audio has severe stutter, dropouts and "jer=
ky"
timing. Applications receive very poor audio. PipeWire/WirePlumber logs
repeated mSBC decode failures:

```
wireplumber: spa.bluez5.source.sco: decode failed: -3
```

Switching to CVSD avoids the mSBC decoder errors but the microphone still
stutters and the audio quality is too low to be useful.

### Expected behavior

The HFP microphone should work without dropouts, as it does on the same mac=
hine
and the same headsets under Windows 11.

### eSCO / mSBC negotiation

The btsnoop captures show eSCO with transparent air coding and 60 byte RX/TX
packet lengths. Example from the Fedora capture:

```
Setup Synchronous Connection:
  Tx/Rx bandwidth: 8000
  Max latency: 13
  Air Coding Format: Transparent Data
  Retransmission effort: Optimize for link quality

Synchronous Connect Complete:
  Link type: eSCO
  Transmission interval: 0x0c
  Retransmission window: 0x06
  RX packet length: 60
  TX packet length: 60
  Air mode: Transparent
```

The actual SCO packets in the captures are 72 byte packets:

```
SCO Data RX: Handle 2 flags 0x00 dlen 72
SCO Data TX: Handle 2 flags 0x00 dlen 72
```

### Capture timing summary

The relevant pattern is that incoming SCO packets are delivered in bursts:
about 20% of RX inter-arrival times are below 1 ms, followed by regular long
gaps above 15 ms. This is visible on both Debian and Fedora. TX timing is m=
uch
smoother and does not show the same sub-1 ms burst pattern in most captures.

Timing was computed from `btmon -r <capture>` timestamps for `SCO Data RX/T=
X`
lines.

```
Debian, bt-sco-bad.snoop:
  RX n=3D1765 dlen=3D72 avg=3D9.003 ms min=3D0.001 max=3D20.154 lt1ms=3D20.=
0% gt15ms=3D10.0%
gt20ms=3D5.2%
  TX n=3D1765 dlen=3D72 avg=3D8.998 ms min=3D0.022 max=3D21.657 lt1ms=3D9.2=
%  gt15ms=3D8.1%=20
gt20ms=3D4.9%

Debian, bt-sco-bad1.snoop:
  RX n=3D3069 dlen=3D72 avg=3D9.000 ms min=3D0.001 max=3D20.166 lt1ms=3D20.=
0% gt15ms=3D10.0%
gt20ms=3D4.2%
  TX n=3D3066 dlen=3D72 avg=3D9.000 ms min=3D0.024 max=3D21.590 lt1ms=3D3.8=
%  gt15ms=3D12.7%
gt20ms=3D2.2%

Debian, bt-sco-bad2.snoop:
  RX n=3D1943 dlen=3D72 avg=3D8.996 ms min=3D0.002 max=3D20.136 lt1ms=3D20.=
2% gt15ms=3D10.2%
gt20ms=3D6.0%
  TX n=3D1942 dlen=3D72 avg=3D8.999 ms min=3D5.016 max=3D16.256 lt1ms=3D0.0=
%  gt15ms=3D16.2%
gt20ms=3D0.0%

Debian, bt-sco-bad3.snoop:
  RX n=3D1850 dlen=3D72 avg=3D9.000 ms min=3D0.001 max=3D20.102 lt1ms=3D20.=
3% gt15ms=3D10.3%
gt20ms=3D1.8%
  TX n=3D1850 dlen=3D72 avg=3D8.997 ms min=3D3.788 max=3D16.241 lt1ms=3D0.0=
%  gt15ms=3D16.2%
gt20ms=3D0.0%

Debian, bt-sco-bad4.snoop:
  RX n=3D5600 dlen=3D72 avg=3D9.000 ms min=3D0.001 max=3D20.159 lt1ms=3D20.=
0% gt15ms=3D10.0%
gt20ms=3D5.3%
  TX n=3D5597 dlen=3D72 avg=3D9.000 ms min=3D4.876 max=3D16.386 lt1ms=3D0.0=
%  gt15ms=3D16.2%
gt20ms=3D0.0%

Fedora live, fedora.cap:
  RX n=3D2089 dlen=3D72 avg=3D8.249 ms min=3D0.001 max=3D18.447 lt1ms=3D20.=
0% gt15ms=3D10.0%
gt18ms=3D10.0%
  TX n=3D1914 dlen=3D72 avg=3D8.998 ms min=3D6.215 max=3D15.234 lt1ms=3D0.0=
%  gt15ms=3D10.6%
```

### Things already tested

- Same Bluetooth adapter and headsets work correctly on Windows 11.
- Reproduced with two different Bluetooth headsets.
- Reproduced on Debian 6.12 and Fedora live 6.19.
- Disabled USB autosuspend for `btusb`:

```
/sys/module/btusb/parameters/enable_autosuspend =3D N
```

- Unloaded/blacklisted the Wi-Fi side of the combo device (`rtw88_8821ce`):=
 no
fix.
- Disabled nearby USB audio/camera devices on the same USB bus: no fix.
- Tried Debian PREEMPT_RT kernel: no fix.
- Tried `btusb force_scofix=3D1`: worse.
- Tried `btusb disable_scofix=3D1`: worse.
- Tried `btusb reset=3D0`: no durable fix.
- Tried disabling eSCO with `bluetooth.disable_esco=3D1`: microphone became
unavailable.
- Tried PipeWire/WirePlumber SCO/mSBC workarounds, including CVSD and hardw=
are
offload experiments: no useful fix.

Current relevant module parameters:

```
/sys/module/bluetooth/parameters/disable_ertm =3D N
/sys/module/bluetooth/parameters/disable_esco =3D N
/sys/module/bluetooth/parameters/enable_ecred =3D Y
/sys/module/btusb/parameters/reset =3D Y
/sys/module/btusb/parameters/force_scofix =3D N
/sys/module/btusb/parameters/disable_scofix =3D N
/sys/module/btusb/parameters/enable_autosuspend =3D N
```

### Possibly related upstream reports / patches

This looks related to the Realtek SCO/WBS path in `btusb`/`btrtl`.

A very similar Realtek patch was posted but does not appear to be merged:

```
[PATCH v5] Bluetooth: btusb: Work around spotty SCO quality
https://patchew.org/linux/20221226074829.8682-1-hildawu%40realtek.com/
```

That patch targeted other Realtek USB IDs (`0bda:8771`, `0bda:8773`,
`0bda:8871`, `0bda:8873`), not `0bda:c821`, but the symptom family is close:
Realtek USB Bluetooth, WBS/SCO, spotty SCO quality, and packet handling aro=
und
WBS.

Possibly related Bugzilla entries:

```
Bug 219997 - [rtw89] Headset unusable because of delays and stutter
https://bugzilla.kernel.org/show_bug.cgi?id=3D219997

Bug 219992 - Linux logs warning `Bluetooth: hci0: SCO packet for unknown
connection handle 3`
https://bugzilla.kernel.org/show_bug.cgi?id=3D219992
```

These do not seem to be exact matches for this controller (`0bda:c821` /
RTL8821C), but they may be related to the same SCO/WBS area.

### Attachments available

The following captures are available and should be attached:

```
/home/apocarteres/bt-sco-bad.snoop
/home/apocarteres/bt-sco-bad1.snoop
/home/apocarteres/bt-sco-bad2.snoop
/home/apocarteres/bt-sco-bad3.snoop
/home/apocarteres/bt-sco-bad4.snoop
/opt/fedora.cap
```

Recommended minimum attachments:

```
/home/apocarteres/bt-sco-bad4.snoop
/opt/fedora.cap
```

`bt-sco-bad4.snoop` is a longer Debian capture. `fedora.cap` demonstrates t=
hat
the same bursty SCO RX pattern also happens on Fedora 6.19.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
