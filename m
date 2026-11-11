Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414479;
	b=EtmhwH5z6GbP+ZUQienbtdF3aL3l+tTD/ouUnPU45NtN4hewORTXOmjR+9xPNgrDjW1J
	 V1DvnSoK46WAt1NpXGOQRz2wfYnjP4aAPIqYyGFEMMJsAv0yWPzT6x3V24HDjMiF/VKxW
	 xgZsmBv3DNYIm1ePh5l4XsxhZRW1knJk9oq6So6bf+docw9T6wlIeeSGu04ic416CgfLr
	 b3FaV2H+Fl3/4ecrRLQH7T771iY3VexOJaI6VqVV3YmlFpnG2VKvZMqIbxzdWDDq5aTrH
	 3oeYEUjpdjXYtpCEBrHbKvp5KCVNnCp4wu7YCuqc6X6l/QGpmLyj4/cRJnvuSoktoeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ISfmjEnS2tRbh4pBePKOGt75eCanw7w1zfaB18bh854=;
	b=x0EsFh/zMnXNp+MNJQiUGwdeLenMSD2v+PqWSNv5/47t5gdux/RbeM/aTX1oq1cg+bTQ
	 wNGCjIshhnfZD+FA+k8ux67z4qIvFV354OyxrnfvuvGvqnzcwoRwkLtgAubLJMvJUFRs3
	 kt6E45qCUgRdXcWsnaIDXuNZfkoZgLQTz9XQgP5I8w5btaNBqL5B02KeZ3XAWGTpMQdSD
	 YrZxmiTNtjpGM63qUHmUDPAa8rA7lEtyfzHQMOegOJF+CHcMVyRtYzb3cGHEDxzMOKa7g
	 e5XwMAS36I99O1ZzxB9BwrZoUdfHV1DASF4xfxVvbCQrCrAWn9+f6BlrarQPJVgbByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4mTOuRx;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE271606A33C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE271606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n4mTOuRx
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so2199782e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414477; x=1795019277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISfmjEnS2tRbh4pBePKOGt75eCanw7w1zfaB18bh854=;
        b=n4mTOuRx3gZao+2idrNJY0kq1Z4qg8laI6hjpILCnHxii41UQ2tH10oLcUbA7JL7v4
         QHaa67K41HPbGIub53nulooEXqIGvPb6ISPi3PqR1k9sPSNlveVKi4kIkbwsQ9DolKZc
         hTQjhQ2vgvIhQHtvDwcf1c6fpkKGIyNTdwHN/0/8y26qpcrlgGQCMB8V7o1obKXXgovb
         b75kb2bVW1enhZ6N1rQkmcbmnXyzYUcM6noakooF27TLjoNwcRdXVu0Lkx3irugMkoFo
         885SQEsrNLvZqY5h7B2ig1iw6IAa9oMeLlM2JO6rIMQ+5aY+mHB7zvdMs5xQhTIwTkRE
         d0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414477; x=1795019277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ISfmjEnS2tRbh4pBePKOGt75eCanw7w1zfaB18bh854=;
        b=1sc/C1zT7OsUKvSsYZY9pQptfs3eSu/ns2uMIvUwhabRCEACXBN4YEzUUfwYQa8qHH
         UxYegLfs2MxKaa+sEgUym6Ids3ja6A81pQuhsGyB/6RNrsRuM4JU0h/S8ie4IJDrJcQ5
         wInQdWgtava1or4qIcRzGRyL916mBkvKzXke9RreOHG2RFoPUcsGr+CYQbHGrjecxFGt
         PI6iZYOOERhBaqJk52bc6oN1FlI1+JVhl5j2nsra7v9bp67FW1X9dJwEiaQlx/BG2npB
         OtbkI+66FBXtgpjJll3utz8f5wiMNJdGMk2qYdwxiZbjagbO3L3LKi3XAO9Q9Y/4OzID
         D75Q==
X-Gm-Message-State: APuU4Z8fxFv6VNsN9eDLV2nko5d87XtlsuzxTZcotKnOD6a3l9Fze4Ud
	ERa+QmLVoG5s97DCtgXkmV8JZ/ZKPO9abI8OWwNmdGDGaSUOhWvHANzV83YUug==
X-Gm-Gg: AYBFou0OoPuoQz0wUEQpQWPTumMzTYyDC3HqjdqRnmdd0f19c+HoXeE48qFIGiSgVCj
	8AE/5b5IrYRGwQi3UKWM2+6uIokU/Zc2nLJtwscXjol41Z+PtDUA3zUiQPlXs5UftrEzk4l4mpJ
	d5ygg62P26LKwv8Tr7d3oZ3nPiHFmgU9coqID3f55wM9dgYdEXzVC5+GlG86aHoqpy50sANabAg
	jHBB+bJOX1x8hHR2llrhk9K7BAxSSlEXFXpYg/iTYLMxaWBh6cB+4WQ1Fydgcfm1fSSlhuvHLuY
	ghJonscHsdNEJ2qOXoH3MeZmQNtPsgDDhuaodv19NMK+7oYsb1HisocIpOl8M5ekLJuNcD/ENVq
	C+jXc/555Rk7CrI4KXSU31hiSL9OGQgZUa7EJuDhFNSvAWbxUh2rJmqHgrAkNSrHYJyyc5mJ3UN
	brZcPmIXH7C3WNOME33NrMoAYu/Fn3mdJcZhRhvIaO6GPFe+HSLgZz6CUHcpS4iSxAdWQBzQU4R
	RpXaLShSWWN53K2L6qY+nKYofES04qfdl0vZDEFzXHCdLsa1GpY58bvo1m1AaL5nYum6bqMIPZ3
	zo4sl9GCfUKEiPevbykuAaBUAGgmvRqq16XZ+Cl5YDfECynnCoOTNO7fci6j47n8kJStaTo4P9c
	fZi1YNb5NR2+PVMlUp1rl9SqCc6wMPEVDxQIZRNEIYyLEgnsHrI5Foq+3UDzEuoup4x05OerGxE
	l5OupN
X-Received: by 2002:a05:6123:2a:b0:5ee:1e74:3cad with SMTP id 71dfb90a1353d-5ee1e743fa8mr682485e0c.20.1794414477386;
        Wed, 11 Nov 2026 08:27:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.27.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:27:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 00/11] Add support for HDT and EKS
Date: Wed, 11 Nov 2026 11:27:43 -0500
Message-ID: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for the LE High Data Throughput (HDT) PHY and the
Encryption Key Schedule (EKS) introduced in Bluetooth Core 7.0:
definitions, btmon HCI and LL decoding, btdev/bthost emulation, GATT
MIC length permissions, main.conf options, tests in l2cap-tester,
iso-tester and mgmt-tester, and l2test options.

Changes in v9:
 - bthost: ignore a truncated LE CIS Established v3 event instead of
   reading past its payload.
 - bthost/smp: the keys are distributed once per pairing, so a later
   key refresh, such as with a new MIC length, doesn't send them again,
   while pairing over opportunistic encryption still completes.
 - monitor: LE_PHY bits of the LL PDUs are those of Table 2.24, where
   bit 2 is LE Coded, S=2 and S=8 being codings and not PHYs, which
   fixes decoding the rates of a CIS request for LE Coded.
 - mgmt-tester: give the opportunistic encryption test a reference
   command for the diagnostic dump, which dereferenced NULL on failure.

Changes in v8:
 - btdev: HDT is the PHY of both directions or of none, as the spec
   requires of a PHY change, so if only one direction would get it, both
   are selected again without it, for LE Set PHY and for the default
   PHYs. Otherwise the connection reported a 32-bit MIC.
 - l2cap-tester: test that a PHY request for HDT in only one direction
   never results in HDT in only one, checking the PHY Update Complete
   events.

Changes in v7:
 - shared/gatt: a MIC length permission implies an encrypted link, so
   without encryption the error is Insufficient Encryption rather than
   MIC Length Too Short, and the minimum key size is checked before the
   MIC length. The MIC length tests run on an encrypted link, and
   there are tests for the unencrypted one.
 - btdev: report a 32-bit MIC on the GFSK PHYs, tracking the PHY of the
   connection, and only the negotiated one on the LE HDT PHY.
 - btdev: refuse LE Enable Encryption for opportunistic encryption on
   an encrypted connection with Command Disallowed.
 - btdev: advertise LE Data Length Extension on 7.0 controllers only,
   the ones that emulate the data length commands.
 - l2test: reject a malformed or out of range -f MIC length.

Changes in v6:
 - mgmt-tester: add an SSP pairing test on a 7.0 controller, where
   Encryption Change v3 reports the BR/EDR key size.
 - mgmt-tester: test that a reserved HDT MIC length, packet format and
   rate set with the system configuration are rejected.
 - main.conf: DefaultMICLength only takes 0x01 (64 bits) and 0x02 (128
   bits), as LE Set HDT Default Parameters reserves every other value,
   32 bits being the one of the GFSK PHYs, and the controller rejects
   it, which failed powering on. btdev rejects it too.
 - monitor: decode PHY_Options as the spec defines it, the LE Coded
   coding and the HDT packet format being values, with the 64-bit MIC
   preference and the forced key refresh having their own bits, and
   show the payload window sizes of the HDT LL PDUs, which are encoded
   as one less than the size.
 - Quote the Core 7.0 specification where the code relies on it: the
   HDT default parameters, MIC length negotiation and values, the PHY
   and rate bits and their tables, the LL PDU fields, the key refresh
   and the Encryption Change fields, LE Enable Encryption with
   opportunistic encryption, the event version sent, the ATT MIC Length
   Too Short error and what Read By Group Type returns.

Changes in v5:
 - btdev: Create BIG Complete v2 reports NSE, BN and IRC of 1, as
   the BIGInfo does, rather than 0.
 - l2cap-tester: the MIC length tests only send their connection
   request once, not again when the link is re-encrypted.
 - doc/l2cap-protocol: document the MIC Length Too Short result of
   each mode (0x000C and 0x0010) and that it applies on the LE HDT
   PHY, and that an unset MIC length requests the default one.
 - iso-tester: test that reserved HDT rates, and HDT rates without
   the LE HDT PHY, are rejected.

Changes in v4:
 - lib, doc/iso-protocol: setsockopt(BT_ISO_QOS) on a socket that
   already has a connection fails if the type doesn't match.
 - Fix checkpatch errors and warnings: long lines, missing blank lines
   after declarations, a static initialised to 0 and a non-const
   option array; mgmt-tester uses struct
   bt_hci_cmd_le_enable_encrypt_v2 instead of a copy of it.
 - Add "monitor: Use __packed in bt.h and its users", defining __packed
   in monitor/bt.h and using it there and in the files including it,
   so new definitions are no longer flagged by checkpatch; the new
   structs use C99 flexible arrays.
 - monitor: the [v2] LL fields are reached past the fixed part of the
   PDU rather than with sizeof arithmetic on a void pointer (CodeQL),
   and little-endian HCI fields are converted before printing.
 - bthost: handle Encryption Key Refresh Complete, so pairing over an
   already encrypted link distributes its keys, and convert the CIS
   Established v3 handle.
 - btdev: reject the reserved PHY bit, select LE Coded when it is the
   only common PHY, and convert the little-endian fields of Create BIG
   Complete v2 and LE Set HDT Default Parameters.
 - l2test: an explicit -f 0 sets a 32-bit MIC requirement.

Changes in v3:
 - btdev: encrypting a link that is already encrypted, such as one
   with opportunistic encryption, sends Encryption Key Refresh Complete
   (v2 when unmasked) like a controller does.
 - l2cap-tester: add Opportunistic Encryption tests, connecting over
   an opportunistically encrypted link and pairing over it afterwards.
 - lib: struct bt_iso_qos_ext has a 16-bit version and a 16-bit type
   instead of rfu, and BT_ISO_PHY_* and BT_ISO_HDT_RATE_* are added.
 - doc/iso-protocol: document BT_ISO_QOS, the extended QoS and why it
   has version and type, with examples.
 - iso-tester: set the type of the extended QoS and test BT_ISO_QOS_ANY
   and a type mismatch.

Changes in v2:
 - Remove the values from drafts of the specification and use the ones
   from Core 7.0:
   - ATT MIC Length Too Short is 0x14; L2CAP results are 0x000C (LE
     Credit Based) and 0x0010 (Enhanced Credit Based); the HCI error
     0xFE is removed and btmon decodes the 7.0 errors 0x49-0x4B.
   - The draft LL PDUs are replaced by the versioned LL_PHY_REQ,
     LL_PHY_RSP, LL_PHY_UPDATE_IND, LL_CIS_REQ and LL_CIS_IND [v2],
     decoded by length.
   - 0x20AA is LE Set Data Length v2; LE feature page 0 bit 59 is
     removed; Set CIG Parameters Test v2 decodes
     Anchor_Update_Buffer_Time.
 - btdev: a 64-bit MIC is only used when both sides prefer it; the
   re-encryption tests now pair with Secure Connections and check the
   128-bit MIC is kept.
 - lib: struct bt_iso_qos_ext replaces bt_iso_qos_v2, BT_PHY_* without
   BIT().
 - btmon: Create BIG Complete v2 bounds the BIS handles and shows the
   MIC length, CIG Parameters Test v2 and Create BIG Test v2 are
   variable length, Data Length Change v2 checks its own size,
   PHY_Options S=8 is bit 1, Coded rates label S=2, LL window size
   fields are masked.
 - btdev: Create BIG v2 rejects an invalid Num_BIS without completing,
   opportunistic encryption reports key size 0 and EKS mode 2, the
   peer PHY Update Complete swaps TX/RX, fixes default PHY selection,
   BIS rates come from the PHY value, unknown handles return the v2
   opcode, and CIS Established uses the version the host unmasked.
 - shared/gatt: Read By Group Type checks every service before
   encoding it.
 - main.conf: DefaultRates is sent little endian.
 - Testers wait for the re-encryption result; iso-tester converts the
   extended QoS for the emulated remote.
 - l2test: the requested PHY is separate from the queried one and the
   MIC requirement keeps the requested security level.

Luiz Augusto von Dentz (11):
  monitor: Use __packed in bt.h and its users
  lib: Add HDT definitions
  doc/iso-protocol: Document BT_ISO_QOS
  monitor: Add HCI decoding for HDT
  monitor: Add LL decoding for HDT
  emulator: Add HDT support to btdev
  emulator: Add HDT support to bthost
  shared/gatt: Add MIC length permission checks
  main.conf: Add HDT configuration
  l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
  l2test: Add HDT options

 client/scripts/gatt-mic-128.bt       |    5 +
 client/scripts/gatt-mic-64-128.bt    |    7 +
 client/scripts/gatt-mic-64.bt        |    5 +
 doc/iso-protocol.rst                 |  207 ++++
 doc/l2cap-protocol.rst               |   50 +-
 doc/mgmt-protocol.rst                |    3 +
 doc/org.bluez.GattCharacteristic.rst |    4 +
 doc/org.bluez.GattDescriptor.rst     |    4 +
 emulator/btdev.c                     | 1092 +++++++++++++++--
 emulator/btdev.h                     |    1 +
 emulator/bthost.c                    |  137 ++-
 emulator/bthost.h                    |   14 +
 emulator/hciemu.c                    |    3 +
 emulator/hciemu.h                    |    1 +
 emulator/main.c                      |    5 +-
 emulator/smp.c                       |   11 +
 emulator/vhci.c                      |    4 +-
 lib/bluetooth/bluetooth.h            |  119 ++
 monitor/att.c                        |    3 +
 monitor/bt.h                         | 1672 ++++++++++++++++----------
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  278 ++++-
 monitor/packet.c                     |  939 ++++++++++++++-
 src/adapter.c                        |   28 +
 src/btd.h                            |    7 +
 src/gatt-database.c                  |   26 +
 src/main.c                           |   48 +
 src/main.conf                        |   27 +
 src/shared/att-types.h               |   17 +-
 src/shared/att.c                     |   39 +
 src/shared/att.h                     |    3 +
 src/shared/gatt-db.c                 |    9 +
 src/shared/gatt-db.h                 |    3 +
 src/shared/gatt-server.c             |   61 +-
 tools/3dsp.c                         |    4 +-
 tools/bluemoon.c                     |   24 +-
 tools/iso-tester.c                   | 1418 +++++++++++++++++++++-
 tools/l2cap-tester.c                 | 1008 +++++++++++++++-
 tools/l2test.c                       |  169 ++-
 tools/mgmt-tester.c                  |  224 ++++
 unit/test-gatt.c                     |  130 ++
 41 files changed, 6985 insertions(+), 830 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

