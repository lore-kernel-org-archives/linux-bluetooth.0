Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240961;
	b=zA5/KRJ6TGvIdEpNMPcf/4R0PXhNtCefiel2gMnl7Bqu4BVUcqQiaByHz3CA7bgtqz3b
	 2ZR956iYeuJiMqDd/t/wJFvxkvG3PN0CxYEUrN4/VO4xdAH7k4RSt6FNV2hpyCp9pazco
	 4bK5QICl5hj9FaTBd+2pitNQzPCVDy3I9s8mi4zneDDYNQIFVfrQTmzWMuZMXvs/r2A+c
	 9tWpjbpzHKmICnNdOMFPmRLh+7esljbx46TJuTDNiMo5hNrWt5E1jCEU7PJGcTXHJeU1B
	 dJwUTuMtNasPR6M48HQV5QZwR194c8MsAYNFFwMpo4sRvbzgj9aGctp9eAs1qNsdjlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fGTsqMS1dRV3z9D6fmXFbxMUaqA+3PsfrWJBxO4gXRY=;
	b=evTfiA6TzjgxC5unJVDaQYRctc0eXlRAzJWKPsI5cNKa4+2gPdrW022D3EeF9+81ihtE
	 Sl1nF1O2C4jknl0ySxfh6Ofdof2RbHF7Y/V5cAVfcH84tQdCTTAZv+jFfMtt+6bZsJZ8I
	 Z8tmNh3sGu7eCsgQZhuYPXjiPnqaHL0WT/ujtAnYVLDUhhFSTrYMnmaiSb/ZTR5tHQvRR
	 7Yd+Pmk6ylbJKbivO+9uj1GjtSeSJ0Xq4OeM89e6GstAwC1GRQHGKZa5/jpd/V4Q92iwf
	 3PcWLnSCiYDtgTSSNuIgiiNNr5Wm6dTF7MV8sf20nHOVUYziiHaYuLP68jgew64j7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M613V62U;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63436606A331
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63436606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M613V62U
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so716030e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240960; x=1794845760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGTsqMS1dRV3z9D6fmXFbxMUaqA+3PsfrWJBxO4gXRY=;
        b=M613V62U+fvowndxXWlZMYju+SGC8PylwnNSPcPW/HrYlwHaPEynXPknK9wwPejBgY
         PQv5WwL4s0OiOqJvPchQUYORZ5sQ1cDz9JzGfO9wnY9SQ66BbW9IfM0Xj6eenKyul6BN
         wH/T0Fhh2buzCX5IFkJrWuSLf1LI0nmgmS6D92D+Hh271fMJMbvd0I3Gv1UBZf8ZEHT+
         NlvUAX+jmw6J2J3x0obrv39E5nhkvHbP8+Fk7GyiiUuQeguNILPM0j/DedWGMzxCpCK9
         wO7cFlZj+DYZ2srFIEUeqqHbkcpgU+nv258oQPivASnVwZv+mkPVN/rK8C8lh7ka94W5
         gbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240960; x=1794845760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fGTsqMS1dRV3z9D6fmXFbxMUaqA+3PsfrWJBxO4gXRY=;
        b=TJAREBvJvEdwnFbwSwlbUuCQrsyA3iQSWvlszxIKoKflr7SZV3h0tmvRB6+MaDFlB4
         Sa0qTzHdOJnSD09Yh86XbssDNYnxK0LusEPHayLHHEwzBqJBLhiEBoCBhjv7LcVxmUjo
         o6jQ2y6fswEhjtaAMBntzJfFkffUaqOLwiek/rA+lGcfO1+SM/PKNKDaJZde2HgX2Gag
         zYBb/bWkouoUV5mce6lYwPXs0Jo08tk3NGodEVzsj8OBUbIMR5BIMQ1eCmwZrEwJDbgf
         3hWLdxR1eYeievzKgKqvx1I5iZRo7vGYFxaMEDU7PVufo4Gr9MQKxocmRlGQwwdB4tcJ
         iASg==
X-Gm-Message-State: APuU4Z/pQn0k1Kh9O6uxiiPDAb6v9kNkGN9bUH1efQEO+DQ0i8J/VNsA
	EYfC+j8foWqUIXH2eH8hX+TBH64RBkIOqn23G0jQKUTU/NNoD2aBpAqVXytBNw==
X-Gm-Gg: AYBFou16WjiVOgcYYnuzK378MzruTdTOBa9RJI12Vioi8pn/0cduHTTYRay2K8C2qkS
	7hcntLF+9dWT9xDnn5yBuN+zN3+qYitUsSLaeqQbmaC8yDy5vfVkZPoutL/SLBiMETZeZNHtn3d
	zZZ/Qjq4WbpavapPAzGUJF+IKdN5ly1sae5isU+6WVtFCBVz1cqW7PTLo1SKCliH4rx+Gy4xcJ+
	9Yuf4OEm3jIaky0gTgm++oJxluzjZ/TErwGML+gV094NLEOqX4YMOfexHgONdmiPMCGTZr/7jZn
	tIFzm6ROqmUowxubBlERPnl1wnpTUIfi3uhOacfXnTGAPMjXfvZjPIcN35K9uvQyc74dHuFKSiw
	qTDusz1bFa6/DFTY/6c1VXWzeqiruyY5U5Fr1OD4SvzfMFXgW0FmxSZonvanR2LsoyeTXmYj3uP
	D8FJIb8b92OlibsSjUUprxoG4frI1GKZDg8mUbdTXmBQ7LiV/1ALiaAtIWxSm6Uh9xIxMB5eXIq
	bSWW3Z4l92z30hDTb73SQDju3OboJ9xYlyyMaR+FT54ydSP6kHBBin4ibe9ECt7Jtzr1d75kYxS
	k/PYIJiMOOfsgToTGuPmLgVHhVxSqvntVyBXS9Ka1zk+QWyNRYC5Tmw5kuObzYwrgN5pMOFV9b4
	ciiVYYUteRIIPYIBP7RZ9khmzUrK3kxXsE94SUSU/W49Uydqp6ceA72RJcgli9NpXIVuJu51DXJ
	x5XLY=
X-Received: by 2002:a05:6122:50b:b0:5cd:575f:9396 with SMTP id 71dfb90a1353d-5ece722f540mr1724310e0c.12.1794240955947;
        Mon, 09 Nov 2026 08:15:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.15.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:15:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 00/11] Add support for HDT and EKS
Date: Mon,  9 Nov 2026 11:15:40 -0500
Message-ID: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c                     | 1041 ++++++++++++++--
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
 src/shared/gatt-server.c             |   60 +-
 tools/3dsp.c                         |    4 +-
 tools/bluemoon.c                     |   24 +-
 tools/iso-tester.c                   | 1418 +++++++++++++++++++++-
 tools/l2cap-tester.c                 |  942 ++++++++++++++-
 tools/l2test.c                       |  169 ++-
 tools/mgmt-tester.c                  |  218 ++++
 unit/test-gatt.c                     |  140 +++
 40 files changed, 6875 insertions(+), 818 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

