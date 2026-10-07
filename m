Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E23B14D5
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387847; cv=none; b=ndBqrlCeU9jx9JuqFEU5eoiEdaxoB25dx5pZOIQ/OpNyOl/4vBGYDxVABWmzny/osrFJwX3+NyO/OGii5xXa64sFuiqQyTIIg7Pag68f3cXGxuNkK7PtzAfOccWEBT4Nr0Tq+4NJKz2E2aEmYJ/SipRV6qZYsjF3rwFpAO0Umjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387847; c=relaxed/simple;
	bh=kyp2muq7rArJ3VUDCmhltLyzhdwPMovmSwQCFyt6sUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnXl3YDvzfRy2ii7yqB6PvuxKFIpHaJOFvndKpAECK95vUKY8M18ghiqOlWXsRIqSPhStFJz5flPTs5MDsCuHA1VbzeiZbtIJK4jOHNhm1uwyjkSXNgPcY0LM5WoJX/qiy6AcOgruS6yzfl09m4pUmCVuOwr/YkCfHCHdwRgppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgfB50QJ; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgfB50QJ"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-35164c9597bso116758eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791387844; x=1791992644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=spjUlaBDxebTzZFLN0amHOEGrJuFIyLTkHqrPHrusBw=;
        b=SgfB50QJe5/a1Hf+fVvrOe6vSvXPrrpRbG4uOQHqWGBaavBkwZRN3r9DQtWPdoj4ci
         c67mkwPCEweNnmI4y3maHdgeFXR2NtKRK67P1kJ2oInqw2tCmm2PeDEnLd9T6m1VxgBA
         72MaXTT9g8+tFQ5mjEPI1Mlgs3ydCeGyGOEVosD1F0/brIZd6L28dyXsXANVbbhhgGSe
         6yDgzgR+TsxGLHnCzXiBifpSrhxhomg40tEWieFAsXr3AIysqda2BcKdyICY0hH9XXJx
         A+znePW4NTpKHwcEy+YwTYta+7Yhw0MdRXSArsETz0wTsA7sINOp1fYLNnPuskwKogGo
         uL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387844; x=1791992644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spjUlaBDxebTzZFLN0amHOEGrJuFIyLTkHqrPHrusBw=;
        b=dYAGMuYxaHrMGZ7kNpDkrVd2cmQB6RoSmumA38WnXB2HijSg/ezPr/e8bAFstToxFl
         2oZ5naWQE5+83Vaws1HrZqrt5dMUCBmyPYwAgNutGpJxxAgnJGkK4+ZCKW2jfBIdicWz
         2C63CSQtZ5/5ftLtYyJ5Rfs9IQ7QsGW6DQIrr+2iyhhIOWHK/rVejx5KbXDKzXkwukrh
         yIcSuzKZhV9yDJ7HbBPG9zBjCtG7CNoJmRzF/rDHN3jaIk07TipT5alPeX13F9JRH36U
         BUdUSmm76u3GJ3J6HIM12tsVJZR/5is+anSbW3xE8szjRBb7ufujeEamSiT/OdU3iL+i
         6Qbg==
X-Gm-Message-State: AFq9FYIuSe+BCsDoZTZYoyTfs1GQEEKDoAUfcCgTq38kq151uzzm0/7w
	a+IOahiJoQYa4ZRu4qRurEZG+omHPlrwoDwBFyW2JmbVkj+sLgPHUFldwJrfoBAmeuM=
X-Gm-Gg: AYBFou24c6MhRauBYB4qf0lorzFc/xeuHusHcA5s34WpHb4YzGWH/xFnyDPcQlJDtsG
	UmN5cMHmZvz5vG3XWnChSn3CWbSMwMdT+M+EKAMqzlgGLRB9CJNHm6XiJ4jLkRhvlApN0GnKrFt
	Yi8JHKdBk3KaLwKc5Nwo8xw3AfnGqNSdA9QQWkBdRK+pdtGyMZeBb5cbEoQDf6pqvvcuMunHFGl
	p2e5upyKVA1YXj7hBntfdwmJa5aqETCVtAYIa7WE0+nTeHxr6qUFOUG8TuQmooEHO6aVx6npF+Z
	XAu+vIiH4YaX2CLLgRrY0apBBU3d0bNYNFt+rkajVfyN0o2SdthPOmdQZbFPLrBfzlnLKZuQg68
	xKIT2wuos3HVcWZeaElr4QPTGUB5WUpplc5SCQvoe4r/0+xwhf3PoZA9UZ41xP5HWgOPHCVWgNJ
	4V+tlqkRc5cdVXWeJzevLOU5pqo0O3Uv3kDjojRGJI1azaEYsb53/fHwZ2ycUMds+jTWy1AjV0p
	cyrWz8cotbZxoMVvGrpmlMC3Z/CAvNYNi4Ae56S
X-Received: by 2002:a05:7300:3f11:b0:340:f698:fd56 with SMTP id 5a478bee46e88-3515dd83ba4mr4716331eec.2.1791387844231;
        Wed, 07 Oct 2026 08:44:04 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af7ab9fsm7876955eec.18.2026.10.07.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:44:03 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH 0/3] Bluetooth: Fix SCO setup failures after an abandoned setup
Date: Wed,  7 Oct 2026 11:43:50 -0400
Message-ID: <20261007154353.148223-1-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), closing a SCO socket while its setup is pending
deletes the hci_conn, after a Create Connection Cancel that cannot
cancel a synchronous connection. When a new socket connects right away,
e.g. PipeWire recreating the HFP transport after a codec negotiation as
in bluez/bluez#2562, the abandoned setup can still complete, and:

 1. It is matched to the new connection by address, the controller then
    rejects the new connection's own setup, and the rejection handler
    fails the first link on the ACL, which is now the connected one,
    without disconnecting it (patch 1).

 2. It is matched to the new connection before that connection's own
    setup was sent: Enhanced Setup Synchronous Connection goes through
    the cmd_sync queue, and any setup waits for the ACL to leave sniff
    mode. The setup is then sent anyway and rejected. This is the order
    of events in the report (patch 2).

 3. Nothing takes it over, it completes while its abort is still
    queued, or it is a second link for a connection that is already up:
    the link stays up in the controller with no connection for it, and
    the controller rejects every further setup for the device until the
    ACL drops (patch 3).

In 1 and 2 the new connection keeps the link of the abandoned setup,
with the parameters of that setup: the completion event does not say
which setup it belongs to. Its Air_Mode would show a change between
CVSD and transparent data, but the series does not act on it. An
abandoned setup that fails after a new connection was made is likewise
applied to that connection. Before a13f316e90fd both happened in
another way, as the next socket reused the pending hci_conn.

With the disable_esco parameter of sco.c, a SCO_LINK connection can get
an eSCO link, which it does not take: its connect times out and the
link stays up until the ACL drops. That predates a13f316e90fd and is
not changed here; patch 3 only makes sure such a link is not
disconnected while the connection waits for it.

Patch 2 relies on hci_enhanced_setup_sync() taking hdev->lock, since
024e05f73a4c ("Bluetooth: hci_conn: Lock parent access during enhanced
SCO setup"); a backport to a kernel without that commit needs the lock
taken around the new checks.

Testing:

- QEMU/KVM, bluetooth-next at c85976511aa9 and with each patch applied
  in turn, x86_64 defconfig + kvm_guest.config + BT=y, BT_HCIVHCI=y. A
  userspace program emulates the controller and the headset over
  hci_vhci; the controller allows one eSCO link per ACL and rejects
  further setups with 0x0a (0x12 in T1, as in the report), except in
  T5, where it allows a second one. Each case was run over Setup
  Synchronous Connection (L), Enhanced Setup Synchronous Connection (E)
  and Add SCO Connection (A, controller without eSCO):

  T0  connect, receive SCO data, close
  T1  close a socket with its setup pending, connect a new one; the
      first setup completes, then the new one is rejected
  T1b like T1, but the first setup completes before the new one is
      sent, which waits for the ACL to leave sniff mode
  T1c like T1b, but the new setup waits in the cmd_sync queue (E only)
  T2  close a socket with its setup pending, the setup completes
      afterwards, connect a new socket (cancel answered 0x0b and 0x02)
  T2b like T2, but the setup completes while the abort still waits in
      the cmd_sync queue
  T3  a setup rejected with 0x0d in Command Status
  T4  like T2, but the abandoned setup completes with 0x22
  T5  like T1, but the new setup completes too, with a second link
  T6  disable_esco set, the link comes up as eSCO (L and E): no
      Disconnect while the SCO connection waits for it (the connect
      still times out, with and without the series)

  In T1c the cmd_sync queue waits for a Read RSSI (from mgmt Get
  Connection Information) that the emulator leaves unanswered; in T2b
  it waits for an ACL connection to another device, whose Connection
  Complete the emulator holds as during a page.

                      T0   T1   T1b  T1c  T2   T2b  T3   T4   T5   T6
  bluetooth-next      pass FAIL FAIL FAIL FAIL FAIL pass pass FAIL pass
  + patch 1           pass pass FAIL FAIL FAIL FAIL pass pass FAIL pass
  + patches 1-2       pass pass (*)  pass FAIL FAIL pass pass FAIL pass
  + patches 1-3       pass pass pass pass pass pass pass pass pass pass

  The results are the same on L, E and A, except (*): pass on L and E,
  FAIL on A, where the abandoned link is not taken over by a connection
  that has not started its setup, and stays up until patch 3.

  Without the series, the new socket gets EINVAL in T1 (the emulator
  rejects with 0x12) and EMLINK in T1b and T1c (its duplicate setup is
  rejected with 0x0a), the next connect gets EMLINK in T2 and T2b, and
  the second link in T5 is never disconnected. With it, the new sockets
  receive SCO data and no Create Connection Cancel is sent; the links
  that nothing takes over (T1b on A, T2, T2b) and the second link in T5
  are disconnected as soon as they complete, and T4 and T6 send no
  Disconnect. No kernel warnings.

- BlueZ tools/sco-tester (master f8f352d) in the same VM, on the
  debug kernel below plus CRYPTO_USER_API_{HASH,SKCIPHER}: 30 of 30
  pass with and without the series.

- Real hardware: a MediaTek MT7921 (USB 04ca:3802, legacy Setup
  Synchronous Connection because of
  HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN) with a Sony WF-1000XM6, on
  v7.1.13 with the series built as the bluetooth module (patch 2 needs
  one change there, as hci_enhanced_setup_sync() does not take
  hdev->lock in that version; the other functions touched are the same
  as in bluetooth-next). With PipeWire 1.6.8 the abandoned setups were
  first seen there: Create Connection Cancel was answered with Unknown
  Connection Identifier, and the setup still completed afterwards.

  A SCO socket was closed 150 ms into its setup and a new one connected
  0.3 s or 2.5 s later, five times; each abandoned setup completed about
  0.2 s after it started, before the new connect. Without the series the
  first abandoned link after each ACL connect (two in the run) was left
  up, and from then on the controller rejected every setup, plain
  connects included, with Unsupported LMP Parameter Value (0x20) until
  the ACL was dropped. With the series no Create Connection Cancel was
  sent, each abandoned link was disconnected as soon as it completed,
  and every new socket and the plain connects after them received SCO
  data. An abandoned setup that failed (the headset rejects CVSD with
  0x20) caused no Disconnect. Between the groups PipeWire switched the
  headset from A2DP to HFP (mSBC) for a recording while I counted
  aloud: speech was recorded all three times, with and without the
  series. The cases of patches 1 and 2 did not occur there.

- W=1 builds of net/bluetooth/ and drivers/bluetooth/, no warnings:
  GCC 16.2.1 x86_64 allmodconfig and i386 defconfig, LLVM 22.1.8 arm64
  defconfig, arm multi_v7_defconfig, riscv defconfig and powerpc
  ppc64_defconfig (big-endian), with BT, BT_HCIBTUSB{,_MTK,_QCOM} and
  BT_VIRTIO.

- sparse v0.6.5-rc1 on the same directories: the same 16 reports with
  and without the series, none on the lines touched here.

- With the series, the same tests on a kernel with PROVE_LOCKING,
  PROVE_RCU, KASAN, DEBUG_ATOMIC_SLEEP, DEBUG_LIST and
  DEBUG_OBJECTS{,_WORK,_TIMERS} enabled: all pass on the three paths,
  with no lockdep, KASAN or debugobjects reports.

The patches, the commit messages, this letter and the test programs
were prepared with an AI assistant (see the Assisted-by tags), which
reproduced the report in the emulator and wrote and tested the fixes;
the real-hardware runs were done on my laptop with my headset.

Hitalo Souza (3):
  Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
  Bluetooth: hci_conn: Don't set up a SCO link that is already up
  Bluetooth: Don't leave abandoned SCO links up in the controller

 net/bluetooth/hci_conn.c  | 24 ++++++++++-
 net/bluetooth/hci_event.c | 85 ++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_sync.c  |  8 ++++
 3 files changed, 104 insertions(+), 13 deletions(-)


base-commit: c85976511aa95b5ba68b57b0b3c87c67f3cedcce
-- 
2.55.0

