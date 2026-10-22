Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711416;
	b=X+NFPfUqoLaqjH+j35paGV3cL3iSqEApeyFffju3F1g7ucQQx5PucgGuQIB3g9dPbk8F
	 VW27uwvK5dFksd/Gvn7JiQrdrTH5rO7YpxqAZ95hf0dH7drLhkze67OF1AQWFQDaAvxWz
	 EwkiLB1dlWNwSIT7pEYGsT6wnZl9B/ivhfMj+SirzD+s87FSgqjMLXaMaj/HK2a5QPn+V
	 W6ki8ws6J4kKv+K5zdu/Pse6gLz5RpsFz2BgH8WOvvbOVUaT9wDzxpELuFQKvyoM704g0
	 5vqTpwd+Uh+MPEcZLx3l2+R0LWjrXUEHjYJbRZTvGxKM3NSDzR7DQhu8KbUjnQ2c5Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711416;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=6Vx4ebXF0tkiO/X4WqL2or6Fpg3v2ufDWlD/5ef9UZA=;
	b=ZsDkuKfkDG7RgymydF9DHJebqFn+QW6qScW8HSWUs9tVq+hRkATLfZIseehTLwl8vc7a
	 4euwPNEtr/a+BrCvnYOVSabTsENxy0+LcUStqUaeXs+JvaSEcDelopIkORP+rA5zR39PC
	 y0RYJCxO/+gqNlbjyGUXQdEiLZ+ntvHAI6QUej8wj6/DfThWJLNopKCXnjUBkjzHjbhjD
	 DKdPLYxcHN+jusJuLoZFqtEGHKWwl/mwKoCerq5C6cZkmib6fdGSHWpIdJnmYshW4PQUi
	 tkVALRFSVesH4UhdhexuX2s/Q/9hsGhELGs5PwXQ4ye0fc5xwa1QyO2mhOqDJ8VHd4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=poA5uC9H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BB606A31D
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Thu, 22 Oct 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=poA5uC9H
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4425771
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792711416; cv=none; b=VuPwpHmGHO45WML/n59ehXTgn2e+ydAPDQIFP1wpCa+4AFgTJmjNSdrCG+NYohVZ0i1/pwhqBaPqtFZ7E9hkTHY0D1wnuT6/U4lq3T2Q8Rrynox5SuWwDnbCG1LU6Y32B5Ny7wUtEuzRt0CWWc//2wXTouCMYc9Ua2WixSEMeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792711416; c=relaxed/simple;
	bh=eI5F1HZrkY1Lu0pnBXR3b5fBLkLsqKBUkXclRiD69F4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfgle8miTd9yIK5uMFnHXWJDoFAuCdm3q1KzrQ7zM6vGLGNWPTWa54wTPfXepCsnBJMpN6FZOftFUjkXAnJbEmCvY2PgXqF3O72srk9AVT5Vgo4kvDz6D9BKVQS/MHgWIPw0Ovvn1gmlbIXm/L73NDy347e8DmL1ARftYuamy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poA5uC9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13B89C2BD00
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 23:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792711416;
	bh=eI5F1HZrkY1Lu0pnBXR3b5fBLkLsqKBUkXclRiD69F4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=poA5uC9HDvXIa6b857eEE8kReJgDJfCdjWvb48XCNx3U6dtX5RndLcn+qKzh6Wnoi
	 q4s25cMZ9VkYPESNVjYfIq7Sa9GmeihZtctv5YiQZABWb9rzoGAaDA69FtgiP1MLjn
	 onAPLMfmMqxsX2Xt6IAJfP+XKt8Op8rTDXeXdC5DQlkchWDnyevENZqaKqq1ixw+Ps
	 l1YL+0bIOAYJFlv5XFqnhGQV9042dQ8vMYwqLNdQrk8+xbm0dNjFwAoGUi2KktttQG
	 jECYWS5bA0Uzf6DzOXYk/v8OOlo4WGRdYAX5Zq+h/nc0strtnA9h1FguwzNO/uYqNb
	 lV/WSBo/VItnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E1AB8C53BC7; Thu, 22 Oct 2026 23:23:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220344] Intel AX211 bluetooth randomly disconnects and
 reconnects, started after kernel update
Date: Thu, 22 Oct 2026 23:23:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: akshaym@leastaction.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220344-62941-ANEJMXA2iI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220344-62941@https.bugzilla.kernel.org/>
References: <bug-220344-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220344

Akshay (akshaym@leastaction.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |akshaym@leastaction.net

--- Comment #10 from Akshay (akshaym@leastaction.net) ---
I have been encountering the same issue and it seems to be due to how the I=
ntel
CNVi Bluetooth chips interact with headphones that have both BLE and BR/EDR
capabilities and how the kernel enabled L2CAP ecred and ertm by default.=20

Setting "ControllerMode =3D bredr" in /etc/bluetooth/main.conf and restarti=
ng=20=20=20
bluetooth.service completely and permanently eliminates all dropouts.

Here's a complete description (AI-assisted):

A recurring Bluetooth audio dropout issue affecting Intel CNVi Bluetooth
adapters (specifically the AX211, 8087:0033) paired with dual-mode (BR/EDR +
LE) headsets such as the Sennheiser Momentum 4.=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

    Below is the detailed bug report along with evidence from=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    btsnoop packet traces, root-cause analysis, and reproduction steps.=20=
=20=20=20=20=20=20=20=20


    1. ENVIRONMENT & HARDWARE=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    -------------------------=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    - Adapter: Intel Wi-Fi 6E AX211 160MHz CNVi (8087:0033, hci0)
    - OS: Fedora Linux 44 (KDE Plasma Desktop Edition) x86_64
    - Kernel: Linux 7.2.11-200.fc44.x86_64=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    - Firmware: ibt-1040-0041.sfi (both production and build 82200 tested)=
=20=20=20=20=20=20
    - Driver: btusb / btintel (Linux 6.11.x through 7.2.x, Fedora 44)=20=20=
=20=20=20=20=20=20=20=20=20
    - Audio Stack: PipeWire 1.6.9 + WirePlumber 0.5.18, standard A2DP=20=20=
=20=20=20=20=20=20=20=20=20
      (reproduced on SBC, AAC, and aptX HD)=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    - Headset: Sennheiser MOMENTUM 4 (80:C3:BA:4D:8A:F2)=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      (Also reproducible on other dual-mode BR/EDR+LE headphones)=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20


    2. PROBLEM DESCRIPTION=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    ----------------------=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    When streaming Classic A2DP audio from Linux to a dual-mode headset, th=
e=20=20=20=20
    stream suffers brief audible audio dropouts / glitches every 5.0 to 5.4=
=20=20=20=20=20
    seconds.=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

    In extended listening sessions, cumulative starvation events eventually=
=20=20=20=20=20
    trigger an internal controller watchdog crash:=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      kernel: Bluetooth: hci0: Hardware error 0x0c=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

    During each glitch, PipeWire logs:=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
      spa.bluez5.sink.media: Missing completion reports for packet:=20=20=
=20=20=20=20=20=20=20=20=20=20=20
      Bluetooth adapter firmware bug?=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20


    3. EVIDENCE FROM BTSNOOP TRACES=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
    ------------------------------------------=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    In Bluetooth Core Specifications, baseband time is partitioned into=20=
=20=20=20=20=20=20=20=20
    discrete 625-microsecond slots.=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20

    Converting the measured stall intervals from btsnoop packet captures=20=
=20=20=20=20=20=20=20
    directly into baseband slots proves the collision originates inside the=
=20=20=20=20=20
    controller's internal LE baseband scheduling loop:=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

    Metric               Measured in btsnoop   Baseband Calculation (625 us=
)=20=20=20=20
    -----------------------------------------------------------------------=
--=20=20=20
    Recurrence Period    5.118s - 5.122s       8,192 slots * 625 us =3D 5.1=
200s=20=20=20
    Single-Window Stall  138.7ms - 146.5ms       224 slots * 625 us =3D 140=
.00ms=20=20
    Double-Window Stall  281.2ms - 287.0ms       448 slots * 625 us =3D 280=
.00ms=20=20

    Trace Snapshot (Buffer Credit Depletion):=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      Frame 758 | t =3D 5.0456s | ACL_TX     | in_flight =3D 0=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      Frame 759 | t =3D 5.0589s | ACL_TX     | in_flight =3D 1=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      Frame 760 | t =3D 5.0722s | ACL_TX     | in_flight =3D 2=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      Frame 761 | t =3D 5.0856s | ACL_TX     | in_flight =3D 3 (BUFFER FULL=
: 0
credits)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      ---------- INTEL CONTROLLER CEASES ACKing FOR 145.6 ms ----------=20=
=20=20=20=20=20=20=20=20
      Frame 762 | t =3D 5.2312s | EVT_ACK(1) | in_flight =3D 2 (Controller =
ACKs)=20=20=20=20
      Frame 763 | t =3D 5.2313s | ACL_TX     | in_flight =3D 3 (Host sends =
next
pkt)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

    During normal streaming, ACL packet intervals are ~12.25 ms. Because th=
e=20=20=20=20
    Intel AX211 advertises an ACL buffer depth of only 3 packets (ACL max=
=20=20=20=20=20=20=20
    packets: 3), a radio pause of 140 ms requires at least 11 packets of bu=
ffer=20
    capacity. The 3-packet buffer fills in ~36 ms, blocking the host stack=
=20=20=20=20=20=20
    for the remaining >100 ms and starving the headset DSP buffer.=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20


    4. ROOT CAUSE ANALYSIS=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    ----------------------=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    1. When BlueZ boots in default "ControllerMode =3D dual", the kernel is=
sues=20=20=20
       HCI_OP_WRITE_LE_SUPPORT(1) to the controller.=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    2. Even with zero active LE connections, entering Dual-Mode activates a=
n=20=20=20=20
       internal firmware baseband routine (LE calibration / periodic backgr=
ound=20
       scan reservation) scheduled on an exact 2^13 slot cadence
       (8,192 slots =3D 5.120 seconds).
    3. When this timer triggers, the AX211 baseband arbiter grants the radio
       exclusively to the LE state machine for 224 to 448 slots (140 to 280
ms),
       completely halting BR/EDR transmission and packet acknowledgments.
    4. Older audio architectures (PulseAudio with 250-500 ms ALSA buffers)
       masked this radio blackout in software. Modern low-latency servers
       (PipeWire) operate with tight pacing (10-20 ms), making the baseband
       blackout directly audible.
    5. In pure BR/EDR mode ("ControllerMode =3D bredr"), BlueZ commands
       MGMT_SET_LE(0) -> HCI_OP_WRITE_LE_SUPPORT(0). The LE state machine
       remains completely dormant, and the 5.120s timer never runs.


    5. WORKAROUND & VERIFICATION
    ----------------------------
    Setting "ControllerMode =3D bredr" in /etc/bluetooth/main.conf and rest=
arting
    bluetooth.service completely and permanently eliminates all dropouts:
    - Gaps > 25ms: 0
    - Inter-packet interval: 12.25 ms +/- 0.08 ms
    - Audible stutters / dropouts: 0
    - Hardware error 0x0c resets: 0

    No kernel configuration changes (enable_ecred, disable_ertm), no PipeWi=
re
    buffer overrides, no codec changes, and no power management overrides
    were required. Pure BR/EDR mode alone fixes the issue.


    6. PROPOSED PERMANENT SOLUTIONS
    -------------------------------
    1. Intel Firmware (ibt-*.sfi):
       The AX211 baseband scheduler should prioritize active BR/EDR ACL aud=
io
       streams over internal LE background calibration/scanning, or preempt
       the LE routine so that BR/EDR transmission is never paused for more
       than 15-20 ms.

    2. Kernel Driver (drivers/bluetooth/btintel.c):
       If the firmware scheduler cannot be updated, btintel could provide a
       mechanism or quirk to temporarily throttle or mask background LE
       support/scheduling when high-throughput BR/EDR A2DP streams are acti=
ve
       on single-radio CNVi controllers.


    I can provide btsnoop packet captures if needed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
