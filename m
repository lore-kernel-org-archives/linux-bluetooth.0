Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328496;
	b=NqskyNVzbSPxVbU+1AqVW22gLSA8ZlVI1iFjkyJi7qopImGFrWDdk4AXrfLSEfuHdLfc
	 Ji6aG+bJoDt6361uxuhU7RW8GXASFpve+yRru4uTDbU5JJmkUOdNji4MWeEj+JukZvbDK
	 xu7qBYBdFctVziAPZyPQM3ZbL8TRSaeP81Hhlw7pKGq9KHa1iQHabYBnQAOkm0gcT9bIJ
	 HgnsEQMElFmTh4T8ImrAcUk9BtYfmw71tTMsooBo3Ex1+H6VghbbS9QRZJyKjAnnu2+1N
	 Jzlf1fyg+8ypqqhVLhaD9fNqSonvqdt+NEOmGifnm1mv/OLVGoqOa1RLEZDWQHZPOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UcFWFLSuOnlTMju5UcIZhSORGIqN17L0nyOiWiswUzQ=;
	b=HmyzfIr2Cs7R6TJ7BZXEhQyy3ujdYcC2AegjtkVMjMOumq2EaF4F/hkgO8mtUYACC/Cr
	 L4IeGbVDYsCf9h1PRd+KbhxBEzLsqGXt6HCJrFQ8HSk/2lGohWQkgmtrsavNJUudJMUNO
	 L1LfgS9mwxizHHcef2qP7OZbKGJCqdagIz9iERk6xryvPsfkpN0mQCyvmv0ga4yKKQpkj
	 TsLeI9ecdEMGRTu3z6QnwsJs+wz9i+NeygmGHfu1pUseNPAveLOo8QQdNIKrMAWsZakzl
	 T65mkEjQQlaxrezbHiQ59kt92IZEyIRBU4c/aLZ0DgV7QBs2pdLXKsjBn+AxMNLFMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E2jcXG+h;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71E606A228
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A71E606A228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E2jcXG+h
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1589365137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328495; x=1794933295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcFWFLSuOnlTMju5UcIZhSORGIqN17L0nyOiWiswUzQ=;
        b=E2jcXG+hYOsu6F/aFfF5yrrM21AtOu5oUUWCk/fLXQJ4itEwWKIYnA9Hk2UdwMTuWP
         /qqG2p5zehF0TtR7qyi2QheSuTWfEVAJNrJalvwXvW2NlVd0kjQydprffJNSwvhgPb5o
         L4h3VdrDvAp54X1uCEc1Q6n9DGaSWdPFYueF8GYV6Z2JxBIKiwjqToe/5+HNKHPs+LQJ
         dw94gX4fIJYJIh+Oqo+Y0n27mF0LIWCLwyKjFDdyW4FB/fX78zUI37Rj8Z/oevauGNKL
         rp3Jfl0lshnB8bgKNDiO93oaxPQyc8foNMt/A9QSBC5XrkQjNczIR+aqizqVMaugLet0
         11lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328495; x=1794933295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UcFWFLSuOnlTMju5UcIZhSORGIqN17L0nyOiWiswUzQ=;
        b=A+AvhIlOZ9xB1xSeuNMZJ66yKV6lymgo8U7RZQm/LtHp3fQZ8Q0v9YPC2iUW+uuFnt
         /6sMRQ5Hn1y1sy9mON97a+cyoPVVVKUWFNtbtZ1VOoK8SoA1ml95trQmLCTdvIh/gCoO
         UWimpI3pVDxX0EiQg8NQ9mhf0JPKtz36OpZAGpZ79v+8H96ZVGaC9/TPEoVXHkmeJO7f
         +lT0WJ1tI8u5mpTxGIfcjhMHvGG9TeOExJXHK80l9RPm07ltrHCj2+rsRHjog0AvsDQq
         QR/B0fKanxkKQd6ujk+660FPVmppJeFQc+UuB3C8YdTuwlLSCw5sR4875n2vEDjq8Ugs
         pXZg==
X-Gm-Message-State: APuU4Z9P00EKgfwVNmvwV7RL6ukOjnfilvijXLPVv3nnWRiPKyFtHrqy
	QZrI3zcNKFWJb3eKiLKZOMTAkxv3qK11rm7X43kUv6o+K9feq4bjSMOucML7Hg==
X-Gm-Gg: AYBFou0pV9yeCI85ZC0aZcGwlIE8MFKMMibi6UmgP99LdmULJuGNroLMjtrsqMM8jKU
	NA8p2bcex4F3cj7c4cVf4TvxtfAcUAePVLnfZ2+/z5CWcEiGEjnj0ihTNXqcSQUJoafPVwgn3TH
	hYmlwyVh8C+BZRq++Ba1uNWS/Pzja6hIwIxwMfK5cPkRmINMuKssc3L4pm717vHokqMnqF9Iwlr
	TuHgLTHlMmPnaZDdGazmF/cAgNGOTj2ynKNmw0rVDQAb9dwItBvko5oWZ+Eh7g2xwyev71gLn4N
	ug54hyICsaJzbkMPCYcN28uQjSjZcQ3QoFddSVF0Bb5o2+ftVSAhJ15zNfbPRgwqiuD14WBNWIx
	jEE31Om/x1sAH3SBcBv04FR1NyrCYK0g8WRLa37ZnD6qhx3PNqfPuax4dUB02NUwdbnH8VT2mCM
	TFuJgGh+tj1JqDsMJOMyDU4CsBniCyyf6q0FGv/WpluRHW9K7K9uO1w/2YxhQ+QI1KcCcYOTXVj
	4L0sR8Gevq4ra7IAWsaJC47X3BnpZkbRhe0rq9nqb3vw2X9M85P/YxqNbVZRkIKae7tw+WN254c
	Cba0ClNgUD4e0Ew1Rn9Jd/70RgrSdGmF7+EwP7SfXrZWFRZMjlLAQhOB+8GBjtr7CYOLQz+JZK6
	dhaXcKougw8ckNaaxskVXjhK6kDDhoUbb5TqpkE5TW8rtrS4r3Kh9t5SswHPqC3ixb0q/SQa7un
	ggPNc=
X-Received: by 2002:a05:6102:b13:b0:7d2:ed1c:da62 with SMTP id ada2fe7eead31-7d30118ddd4mr1184575137.28.1794328494453;
        Tue, 10 Nov 2026 08:34:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.34.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 00/11] Add support for HDT and EKS
Date: Tue, 10 Nov 2026 11:34:40 -0500
Message-ID: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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
 emulator/vhci.c                      |    4 +-
 lib/bluetooth/bluetooth.h            |  119 ++
 monitor/att.c                        |    3 +
 monitor/bt.h                         | 1672 ++++++++++++++++----------
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  281 ++++-
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
 tools/mgmt-tester.c                  |  218 ++++
 unit/test-gatt.c                     |  130 ++
 40 files changed, 6970 insertions(+), 831 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

