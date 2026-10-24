Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841094;
	b=oIjvi67YlTsbY2nRHZNSYwZhLZR7xEe58iNFoAoIzy06aA64HJwsM9p8cxWoeqLoZn0h
	 Wq5p8moX7HphLtggbHhohEbMERk0Ji54o2Rqiib+8CMK5ZvRln8kS/Wspmkjvwq8ZkwRg
	 kDUoPjzNm1gbFj+e4f7+KriBIgmRx9XDeWucEY1Q8f2zuG2iQnmTdRI8uvoDUQu1//T00
	 JFCAiayOv9cnwkk+1ZrdzUJuag5ptShjzLhekfkCeh0sH/MJf0qmbAAvgRkxE3hMFD/oP
	 eyjEsYhRwH38iOVEzN6Cm/ZQGgTwbvvV4SL60vdV0e8zm9uyheViUFpMVe1ItFP4EZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ccO4w1k+Y3EfC/WaeLq+OkapA+2qhEUyNI9orMrY3f0=;
	b=iVZ5+bt2U7RgrOnL2uHhxkLgaa751qprhV7dN2UGj8pV238/PANP9zUWfufU6WIBRvzy
	 oSzwLzfJtpZRUUpydR2AXJcPtg1jJvfNyWr8V9yHNiGuSKeysS3DtjhdFcUY5NohgEjew
	 z+/WZkIk5HL8kT3D2RiPDo5fZWJwdfpjlOjZ2nz47xa9AVbdwDPNCndZHh45Kp6y+EPvN
	 o34SGzZhyIK9ej2xreXCiqXYjUs2yV+JK89vNyIS3hYVDi2PEUTeTwUoDz3lDfX2UD+hP
	 OOL+JyMS7LrsDGQmiA4NQf/931DZL7n725ingmOA+5p4ArrArFBHDebnsqu/qgR2rRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KKDNcwZ+;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A86606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A86606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KKDNcwZ+
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6767d92cde6so1624932d50.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841093; x=1793445893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccO4w1k+Y3EfC/WaeLq+OkapA+2qhEUyNI9orMrY3f0=;
        b=KKDNcwZ+jdvpv7WeLf27oreEM5jf3kzsC7ztePC9mz2stXoAOlK1zLhW4jJlpBIAoz
         I2bBj3LEnREMlWpM7Ou1W2rXZFvFIB0LqCDimbzn1MUOQtrqZBoFLmegG8CW7wrc3s4I
         favF9uDICrpD9rxd6/dzmxf/8p1/kBHEaopKHNrP6x3tWozW6sNSr277FJ9qo1kjmYec
         89icqK1ux4DBMbcGbBY+H4pAKucS1hp4bpJupSf/yBtsySB6swF/OcX/Krn++MGGBpLd
         KtXcVcDJCKnxRoYBHEI7TLs/4+wrwnK+ANxmUQSaGDzDOdUeLDTqoz+DokN4fmuoBEfh
         fg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841093; x=1793445893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccO4w1k+Y3EfC/WaeLq+OkapA+2qhEUyNI9orMrY3f0=;
        b=VRTZiTAZkxojSw/tqkROAbPovNFZ2j6GuzNxe+tHVz0CCIISwgICeryh/vb1fNfU9b
         ViNFC0hh7zZ1ZzTcdx/kn2cNh/558AxG91ho47chrVl/r1GP5//tp7htxFwFlskZD01w
         oRxMDjtzgeQ15A5RR/zA5/VY4JMTuAMvY2+JZFMLf/E+mxnppPKFqZjBGnKWgMOmTKEv
         JMbum598aBLMdOIyH5rixEfjkaejHuw5xyxp802Kj3h/sG8izQZrUeiqpLNPXem1GOfJ
         Ag7fB8VHdE7+QVTH+h7q78nvnq+IrOw5N59TdLBJSZCMuRlQNLXtKyneu3UnNbzMBuFe
         jiUg==
X-Gm-Message-State: AFq9FYJ7ThIhGTrm+7FywZZYGXHwVHsUWLaOc4UsBawxxdyhjGCDKRvo
	PP7IMqJnHpJzLgDty2vRM8HT5zn/mGcbd0eCyy35Ds+mryA4R8j2azdDgz1bIZEVTdk=
X-Gm-Gg: AYBFou3pkA0+DOaaqxP74J1fHTy7Tz3z36PV4K/4WYfLGj6da4PICzL6YE96sx6lHgV
	R/W122vn8//N0LhG+WwuEoPA7duQgF8yOOlbLtw9+9RPPz3YkM/9iKQds9h2O7wHXuQaAQbvTin
	QCIvL5maHMIu2JeP3iTWBawCgvfm5VnOFPzgtmHiBKLuYD/MG9FTHYHCmMEJfzWoOEr0pv5idPJ
	S5X/SQj7ZtFQGBjfSZ9CsfAFQxXXLUS1fdisgM2mpbd+fuUAPsenVfsBRDQmnj8YFVVvgaQR7Ey
	+414XIEFY+C6eIqQFJ4uu0+jCUdvlHq3DWqw4bd01yIk+EOn32JTB3XVi+SvMjZaKAfG6isaELb
	90S7LNezLjocBCATMZsQb+0KEXzIl4N1QXx5KJcmaNEZD+evW2ggGQTHe5VhsCWj722TWZwnnYd
	KqgBGh4xsJ6FxSIVYyu4jpMiVLbVH4lbwTM9TTg12D/RbHQ8Ypl39FYm7LYsRSxuSWScD1OByIn
	PjkppRQuKXiGE65toKsMnVSN3qZ9aQthxDFFrULRHti4qs=
X-Received: by 2002:a53:ac8f:0:b0:679:a650:a09a with SMTP id 956f58d0204a3-67a45188986mr1404995d50.6.1792841092733;
        Sat, 24 Oct 2026 04:24:52 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4626cbb4sm855725d50.16.2026.10.24.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:24:52 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH 0/2] Bluetooth: SMP: distribute the identity address when bonding
Date: Sat, 24 Oct 2026 07:24:33 -0400
Message-ID: <20261024112435.247650-1-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Microsoft Surface Slim Pen 2 bonds with the host through its dock
(LE legacy pairing with out-of-band data) and afterwards only advertises
to reconnect, when its button is pressed, if the host distributed its
identity during pairing. Linux only distributes its identity with
privacy enabled, and with privacy the host scans and connects from
resolvable private addresses while the pen directs its advertisements at
the host's public address, so a pen bonded by Linux never reconnects.

Patch 2 makes Linux offer its identity key whenever it bonds over LE.
Without privacy that is an all-zero IRK, which the specification defines
as "no valid resolvable private address", and the public or static
identity address. Patch 1 comes first so that Linux, as a receiver, does
not store the all-zero IRKs that other Linux hosts then send.

Patch 2 changes the Pairing Requests that smp-tester checks: four client
tests expect the old initiator key distribution. "[PATCH BlueZ 1/2]
smp-tester: Expect the identity key in Pairing Requests" updates them,
and "[PATCH BlueZ 2/2] smp-tester: Add identity key distribution tests"
adds a test for each patch. Until those are applied, smp-tester in CI
will report the four client tests as failed.

Choices a reviewer may ask about:
- Why not distribute a real IRK without privacy? The host then never
  uses a resolvable private address, so there is nothing for an IRK to
  resolve, and the all-zero IRK is the specification's way to say so.
- Who now learns our identity address? Every LE device we bond with that
  asks for it. Without privacy that is the address we already advertise
  and connect from, so nothing new is disclosed.
- Devices that do not want our identity key do not get it: the Pairing
  Response masks the initiator key distribution down to what the
  responder accepts.
- Why drop an all-zero IRK instead of storing it and skipping it during
  resolution? Treating the peer as one that distributed no identity key
  keeps the key out of both host resolution and the controller's
  resolving list, where it could only mean "accept the identity
  address", which the controller does for a peer without an entry too.
- No Fixes tags: patch 1 is hardening and patch 2 a change of behaviour;
  neither is meant for stable.
- If you would rather keep the current default, patch 2 can instead be
  an opt-in setting that bluetoothd enables; I am happy to rework it
  that way.

Testing:
- On bluetooth-next 47d4d9f67e92 under QEMU (arm64, TCG) with KASAN,
  PROVE_LOCKING, PROVE_RCU and DEBUG_ATOMIC_SLEEP, with the BlueZ
  patches: smp-tester passes 10/10 tests in each of 10 runs; without
  these patches the four updated client tests and both new tests fail.
  mgmt-tester (514 of 515, "Set powered on - Blocked by rfkill" skips
  itself as the test kernel has no /dev/rfkill) and l2cap-tester
  (111/111) give the same results with and without them. No KASAN,
  lockdep or RCU reports. sparse and W=1 are clean for smp.o;
  checkpatch --strict is clean. The emulator runs used the same code
  before a comment in patch 1 was reworded.
- Hardware: both patches have run on a Surface Pro 11 (X1E80100,
  WCN7850) since 2026-10-13, backported to 7.2.8 and 7.3. The Slim Pen 2
  reconnects on a single click, double click and press-and-hold, and the
  Surface Pro Flex Keyboard pairs over its out-of-band path, accepts our
  identity key and reconnects.
- Other LE devices, on the same Surface Pro 11 with privacy off, each
  bonding over LE from scratch: a Corne keyboard running ZMK (Zephyr), a
  Logitech Lift mouse, a Samsung Galaxy Z Fold8 and an iPhone, the two
  phones once with each side initiating (nRF Connect and LightBlue
  advertising or connecting). All of them accepted our identity key, all
  but the Corne sent their own IRK, which was stored, and all bonded with
  no Pairing Failed. The Corne reconnects on its own, the Lift after a
  power cycle and the Fold after its Bluetooth is turned off and on, and
  the keyboards, mouse and pen after bluetoothd restarts, all with their
  stored keys. The phones also derived the BR/EDR link key as before,
  and the Fold connected over BR/EDR with it.

This is not a security issue: patch 2 discloses only the address already
used on air, and the all-zero IRK in patch 1 only lets a device pose as
a peer that uses its identity address in the clear anyway.

Tool use: the patches, their changelogs and the BlueZ tests were written
with an AI coding assistant (Claude Code, Claude Opus 5.5) in a session
that I directed: working out from HCI traces of Windows and Linux why
the pen did not reconnect, writing the patches and tests, and running
the emulator and hardware tests above. A review of the first version
found that Linux stored the all-zero IRK it would then receive from
other Linux hosts, which patch 1 fixes.

I found this with my own Slim Pen 2 and ran the device tests above myself,
pairing each of those devices with my Surface Pro 11. I have read both patches
and understand why patch 1 has to come first, and why sending an all-zero IRK
only shares the address we already use on air.

Brandon Williams (2):
  Bluetooth: SMP: ignore an all-zero IRK
  Bluetooth: SMP: distribute the identity address when bonding

 net/bluetooth/smp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
-- 
2.56.0

