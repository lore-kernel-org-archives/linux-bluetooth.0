Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15723374A15
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498388; cv=none; b=KRzFqErZT5WW9y5nk6SAqZTwT6uB+SCbFKA674fltVC8IFbxfTapCLU2D4McTel8f3fTKD8FPFUtV6HRnAgD7uzRE8cWvxtPMwQLkTEn5w7POnk/H7tZeReBCTOWHZ/JKfCPxJ26S+erCCiJJnryj36U01Sb3OA4CnhEakfFmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498388; c=relaxed/simple;
	bh=dEirExXd959aBYn1GVe7yY58ywtlCkSmeaK52oB2XNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E57PH8g/J4zQonTCIcLjPmRhobD6nkBk3z/Xo3oMuKZg4AzgXwoyY/CVjFDZuKME8XLCOViA7Swqnbo1hFdc0bXJRYL380J6uS1wcIFzpYb5SQ+FIuOjcQP7BdohfJjEHywAD9HGHIY5/GgEBN7E0ymxuNtS/i9uYaFl1wPlNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6B9gAOs; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6B9gAOs"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535daddac2so46150eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498385; x=1792103185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldRJte3vB6VVucBFu4+QSS1Ms5Y1xCD2y5pVwawXBy8=;
        b=B6B9gAOsRuAjZFaJhYSuEUXdsMtjBOdO/YgklA1LAlrPvLylAFw2FOnsZEZZDW+wb7
         3K8l5DHhoNR5Gkf9JTvFy5rxb8vfUrLmyaw2TplSD11i+hhe0P6EvoqscRmZOCYmc5QX
         4l+Cjg5bdWiV4qohP2zSu9S9YaxoAi5RSu3qCVbS6ZXDTpN1Ro0BA0E2k66FOZcvnQMd
         +nFu7GjOPZAyl98TBe8F7yoHOr5PohpSd6DhxgdVd6xuiuMORjjJTHbO7d9LDKqDd7N5
         /n3WMZ7vBrVs8Pa61SWP/tw4CUI6LG+bDG32gWTL0yxi/R8Rvn/j9WVW0sJ768jls/8J
         z7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498385; x=1792103185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldRJte3vB6VVucBFu4+QSS1Ms5Y1xCD2y5pVwawXBy8=;
        b=E7lfU452l22sKcCtebbXUPGb4cctbAS5BSq9c7hbbDyVScH6HqhXAxY6TRckDeMBhJ
         CPGTxExzxBKC1tsJhuVUyy6Cg+m8gOID1/i5iOf7GQm9rQ483miCXDTDvMuvojeM6nSt
         rC6z/NeT36hD6DYkW9x62xgCVyJTUvyZMmDLeyYfgFTxf4RZZFApa3Bj6/u02rF+zrey
         R9i9pEpg2ooRgED6q1m+/c2O5/VhfnoYIK9poIJJqYhRWiSslKN/ZaH6Fpn1ZtuaxIWW
         Z6o6xnRE4I5ruTY9/BMFmH76zh+3EsRjexy7s00bMmrFlXrmNBDT2KpziStJuBbJmZAg
         QNPQ==
X-Gm-Message-State: AFq9FYKqeh79XjIV7p3hzx8+bWFuoR9klXv2Hb+9FUjVZjayqU2U6fvx
	04IapRzGk7NBlD4MZS8WqOWBLffzP9ilKzkpGEFLFC08zrfHeaIjql6Llk83dB058bY=
X-Gm-Gg: AYBFou1kDcG7m6k2UKL0oAFi6EuunV+NbGd4LmGAj+cVbLodh74H56OritdqOXxqiYN
	fAiOLF7bmPfYe8svgRFmYkA9/aR+VVZHIVCwsjirphLiRiN+1gHFxpFa8qUeK1s3rB2xxDQxWHk
	zsLYIerccKk3KBUNruPCuxFbR/X+hMx3pXhPPula5+77MdF6DVQo8ygv31TI22zHak/ouvOh3qy
	eWylDxM/Ek5fH9+OFRXDpfGTPFLHkqpIF6CZVYyOEdVDY2Md47pPJtzqoKgui9KqH1LD3lkzdNv
	Hpwh2W7mc0f8iCmLiX867/SvZ0bggMPNTo9Ke6VbdpsBTuQUS7678piVlCkhMnImFVnEiWZlIAg
	IgVOdEZBXGhQE166qf3rEFAz/0y6CIzqkr+GnzkMaqpRfP+NDI6H2LezczK5q0UgnWngwcbhL/1
	UD51tWhdI64iKMYKjMem/3MCo1IaZbfiDoTf/TBZEE70ooZrGdQ3EdR+I0TiaSL0ox81tekuND7
	r4NeKt/lI16M7sJ143pNhqdIil9iqTkPaML0KywhQ==
X-Received: by 2002:a05:7301:b0e:b0:351:664e:1595 with SMTP id 5a478bee46e88-3537df834bemr562741eec.2.1791498384899;
        Thu, 08 Oct 2026 15:26:24 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm985148eec.24.2026.10.08.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:26:24 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v3 0/6] Bluetooth: Fix SCO setup failures after an abandoned setup
Date: Thu,  8 Oct 2026 18:26:10 -0400
Message-ID: <20261008222616.2780570-1-enghitalo@gmail.com>
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

 3. Nothing takes it over, or it is a second link for a connection
    that is already up: the link stays up in the controller with no
    connection for it, and the controller rejects every further setup
    for the device until the ACL drops (patch 4).

Patches 3 and 5 make links that complete for an aborted connection be
disconnected in general, as Luiz suggested, not only SCO ones. Patch 3:
a link (ACL, SCO/eSCO or LE) that completes while its connection is
being aborted, which then refuses the handle since 16e3b6429159
("Bluetooth: hci_conn: Fix modifying handle while aborting") and, for
LE, 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique").
Patch 5: an incoming ACL connection aborted after it was accepted,
which is deleted before its link completes. Patch 6 stops notifying
the driver of the air mode of a SCO link that did not come up: with
btusb, that notification and the one for the connection's deletion
right after could stop the audio of another SCO connection. btusb can
still do that when a SCO link that was up goes down while another one
stays up; that is not changed here.

In 1 and 2 the new connection keeps the link of the abandoned setup,
with the parameters of that setup: the completion event does not say
which setup it belongs to. Its Air_Mode would show a change between
CVSD and transparent data, but the series does not act on it. An
abandoned setup that fails after a new connection was made, in Command
Status or in its completion event, is likewise applied to that
connection. Before a13f316e90fd both happened in another way, as the
next socket reused the pending hci_conn.

If a controller answers the setup of a SCO_LINK connection (only SCO
packet types allowed, e.g. with the disable_esco parameter of sco.c)
with an eSCO link, that link was ignored, so the connect timed out and
the link stayed up. Patch 4 now lets the connection take it, as an
eSCO connection already takes a SCO link.

Changes in v3:
- Patch 4: a SCO_LINK connection takes an eSCO link that answers its
  setup, instead of the link being ignored and left up (Sashiko). T6
  now checks that the connection gets the link.
- Patch 1: the commit message notes that a Command Status does not
  tell which setup failed, which the patch does not change (Sashiko).
- Rebased on bluetooth-next 97a128698d9d, without conflicts.
- Tests for BlueZ's sco-tester and l2cap-tester that abort a connection
  while its connection complete event is pending, as Luiz asked:
  https://lore.kernel.org/linux-bluetooth/20261008215756.2710812-1-enghitalo@gmail.com/
- v2: https://lore.kernel.org/linux-bluetooth/20261008151238.2138665-1-enghitalo@gmail.com/

Changes in v2:
- New patch 3, following Luiz's review: disconnect any link that
  completes while its connection is being aborted, on Connection
  Complete, Synchronous Connection Complete and LE Connection Complete.
  It replaces the SCO-only handling of that case in v1's patch 3, and
  covers the ACL and LE cases Sashiko pointed out.
- Patch 4 (v1's patch 3) uses the helper of patch 3, and also
  disconnects a second SCO link that completes with Connection Complete
  for a connection that is already up (Sashiko).
- New patch 5: disconnect an ACL link that completes after its
  connection was aborted and deleted (an incoming connection).
- New patch 6: notify the driver of the air mode only of a SCO link
  that came up (Sashiko).
- The disable_esco case is described as what it is: a controller
  answering a SCO-only setup with an eSCO link.
- New tests T5b, T7, T8 and T9.
- v1: https://lore.kernel.org/linux-bluetooth/20261007154353.148223-1-enghitalo@gmail.com/

Patch 2 relies on hci_enhanced_setup_sync() taking hdev->lock, since
024e05f73a4c ("Bluetooth: hci_conn: Lock parent access during enhanced
SCO setup"); a backport to a kernel without that commit needs the lock
taken around the new checks.

Testing:

- QEMU/KVM, bluetooth-next at 97a128698d9d and with each patch applied
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
  T5b an incoming SCO connection is up, and a second SCO link to the
      device completes with Connection Complete (A only)
  T6  disable_esco set, and the emulated controller answers the
      SCO-only setup with an eSCO link (L and E): the connection gets
      the link, receives SCO data and disconnects it when closed
  T7  an ACL connect to another device is aborted while paging, and
      the page succeeds as Create Connection Cancel arrives (cancel
      answered 0x0b)
  T8  with an emulated LE-only controller: an L2CAP LE connect is
      aborted while LE Create Connection is pending, and the connection
      completes as LE Create Connection Cancel arrives (cancel answered
      0x0c); also with the cancel succeeding in time, where nothing may
      be disconnected
  T9  an incoming ACL connection is aborted with MGMT_OP_DISCONNECT
      after it was accepted; Create Connection Cancel fails with 0x02,
      then the link completes

  In T1c the cmd_sync queue waits for a Read RSSI (from mgmt Get
  Connection Information) that the emulator leaves unanswered; in T2b
  it waits for an ACL connection to another device, whose Connection
  Complete the emulator holds as during a page.

                  T1   T1b  T1c  T2   T2b  T5   T5b  T6   T7   T8   T9
  bluetooth-next  FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
  + patch 1       pass FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
  + patches 1-2   pass (*)  pass FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
  + patches 1-3   pass (*)  pass FAIL pass FAIL FAIL FAIL pass pass FAIL
  + patches 1-4   pass pass pass pass pass pass pass pass pass pass FAIL
  + patches 1-5   pass pass pass pass pass pass pass pass pass pass pass
  + patches 1-6   pass pass pass pass pass pass pass pass pass pass pass

  T0, T3, T4 and the LE connect cancelled in time pass on every row.

  The results are the same on L, E and A, except (*): pass on L and E,
  FAIL on A, where the abandoned link is not taken over by a connection
  that has not started its setup, and stays up until patch 4.

  Without the series, the new socket gets EINVAL in T1 (the emulator
  rejects with 0x12) and EMLINK in T1b and T1c (its duplicate setup is
  rejected with 0x0a), the next connect gets EMLINK in T2 and T2b, and
  the second links in T5 and T5b and the ACL and LE links in T7, T8 and
  T9 are not disconnected (they stay up until the ACL drops, or for
  good); in T6 the connect times out and the link stays up. With it,
  the new sockets and the connection in T6 receive SCO data and no
  Create Connection Cancel is sent for SCO; the links that nothing
  takes over (T1b on A, T2, T2b, T7, T8, T9) and the second links in T5
  and T5b are disconnected as soon as they complete, and T4 and the LE
  connect cancelled in time send no Disconnect. No kernel warnings.
  Patch 6 is not covered here, as hci_vhci has no notify callback.

- BlueZ testers (master 866b0b8 with the new tests) in the same VM, on
  the debug kernel below plus CRYPTO_USER_API_{HASH,SKCIPHER}, run
  twice: with the series sco-tester (31), l2cap-tester (113) and
  iso-tester (141) pass, and without it only the three new tests fail.
  mgmt-tester has 8 to 10 LL Privacy failures of 506 per run, with and
  without the series.

- Real hardware, with v2 (v3 only changes what happens when a SCO_LINK
  connection gets an eSCO link, which does not occur there): a MediaTek
  MT7921 (USB 04ca:3802, legacy Setup Synchronous Connection because of
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
  DEBUG_OBJECTS{,_WORK,_TIMERS} enabled: all pass on the three paths
  and with the LE-only controller, with no lockdep, KASAN or
  debugobjects reports, also while the BlueZ testers ran.

The patches, the commit messages, this letter and the test programs
were prepared with an AI assistant (see the Assisted-by tags), which
reproduced the report in the emulator and wrote and tested the fixes;
the real-hardware runs were done on my laptop with my headset.

Hitalo Souza (6):
  Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
  Bluetooth: hci_conn: Don't set up a SCO link that is already up
  Bluetooth: hci_event: Disconnect links that complete while being
    aborted
  Bluetooth: Don't leave abandoned SCO links up in the controller
  Bluetooth: hci_event: Disconnect an ACL link that completes after its
    abort
  Bluetooth: hci_event: Notify the driver only of SCO links that came up

 net/bluetooth/hci_conn.c  |  24 +++++++-
 net/bluetooth/hci_event.c | 124 ++++++++++++++++++++++++++++++++------
 net/bluetooth/hci_sync.c  |   8 +++
 3 files changed, 135 insertions(+), 21 deletions(-)


base-commit: 97a128698d9dcacb9a15cdc5080718a644b12637
-- 
2.55.0

