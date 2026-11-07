Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087975;
	b=sshdrHdIdLBCazF/CpIxDy3S8ftJhGjrQHmzFFbgHmYADEpYDnnSQNVhcAGXW8Zll8Of
	 cal+7qgPqorlmO9m4RmREsQbKyHDEYy8NrZuJ5e3Hp0ohiEx3IaMEay09fbOYjIc8nmeQ
	 ee/oitXfWff1qny9NilgMQlysFsXoNgphckdbku4UlJmTWQR/yydH+F9b/eDQYIxzDMjh
	 J1+ZsWP8WFCeinThMkgV0H25TtJEiACqs0KaV/UivpADF51QDhFtRxDbri2x/rKlXZqSr
	 IX9CmypYPsv7Bl8Z1Ltr/jHhwLCMuiZWnlmr94NOUtSt85JOi2ZrPgZR/+6PSk+DxKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=naWTz6lsmUxkvluRaUfd2ncwkVHh0ckB679ByCBdvOU=;
	b=dtvHqFRknWFDg/qt3F5QHv1qT0SqUD5BZaM907xSVfS+3+JHVbS/GcKFKXvZkJFDLonu
	 sy8tW4dT5KFGKA5PibYE37t61BMlIfD1qk0AM9Xy4LaDwyJrR/es7eotwPfxljo6DbV8U
	 0wy/QeriGl8iGSvZkIUzsFNH0/uP3+KRmx8VdcbH4KFFHuDRivDUSmzNhyHFsVqnXlKQA
	 gDlAAq4N8eXfsC7rzPeUBLiaBqGMmZLN8AFR2jP5OfHBdJ+mmEyAv1x+wG9TLDOOdwY31
	 na7jrOQKhuz/GqGqe20LAvYGs4G5Obc2U+ZMLzjdGUfaE8IU/SOk/OH88er+4qBiINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au8mpuF1;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F957606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F957606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au8mpuF1
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso26928e0c.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794087974; x=1794692774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=naWTz6lsmUxkvluRaUfd2ncwkVHh0ckB679ByCBdvOU=;
        b=au8mpuF1M9ELxPn/CxJdui58wa3UrR2Sg8Ou04ZgoN9jro7YMnUqYwx+QhRCq7qJ3A
         0HlgaXnYvZ931AkyLPmHT2uvrOn1WRQ44QS17WPfmJY/yt5e+Rhamkw0RcorI8Ea5XQh
         rL9Whz2zjFGbqKFAZW67n+Yz4/Qzl97mpPpqK45+DqY4YSynvXP/4tNmSwSE/AjYm9BN
         RU8eLdUCywWIudcgg9jATBbPB9k/uk1ixLkrrep1n74stXiCaPvWt759wMsaeWkRJYpW
         KhTHVH5shBKns2pBDVLwDQPHhuG2szKhNDTzA2NHzL4BizBR00lvvnYdiz2dSmuVPWMZ
         DFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087974; x=1794692774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=naWTz6lsmUxkvluRaUfd2ncwkVHh0ckB679ByCBdvOU=;
        b=AZY/xWXYu9ZsskpHgt8TTI39sQllOZkNCXDR+mSxRO+yI42cEtdKlLguxHCs6MyQol
         PSCmJlpZ5+kbtVnj/p4vT044+OsPGtYUXXs0g94NdKLY6z9f8egyhwKXRAA3GZ58AOJ2
         /xogUbF5sER86icjXzLEsITSY+HQPcP5uKh3+7FSdBY7H+W4vEAo7QxjMkHS93yBJMMl
         TXx+j0BTPftnBuRyt5MEBGPzpw7X9Fj8NGaDnOYS2vs8MihPIfzzEFJvXcSP25J7oA8x
         BWzpD24jj4QXW6JPDGI9f5YVndm613+mxsvrDeSic5tqUgS74sMTpSGihK9TximXt+P4
         27JQ==
X-Gm-Message-State: APuU4Z8vkPhArPeB0hsw6GRXSWeAMd3evMdAGww8peK4WignBgHOk45B
	DbsUgGt0rOlw8ym0VNAQ2qlZqZ54LmY+mgUVbsrsMSetY3F82LWmqBIzotSZSQ==
X-Gm-Gg: AYBFou01xEB8BaBJHF3m0j20ce6hyaUUMNZYLHcr4kMOZztWMR54YnBuKqr4xY7IgvJ
	uCfn0jQNO/sxP3TNlW8wf45KyOQapdTy/487HGYhSIwT8QgKURXhODW3LRuyvlWrd2XiYJ92lun
	o33INBWh+kj9Tax8lnXTvNQ/GbjY11y+XRE+Te3GwmVxRah2ba/e2JoTzMwNPb/N95uweY6CXG3
	yXcYYphWmaGQ8ZLjBoFciCJyToXC4VpX6uvD9rWd+sztMuOqTYVU74h6y1imrfqFC5d1sMOUKbO
	L4qAyI4iZtkZW8451lKaXIOkgjn4s6mmtou9kPx+bO4jixsRwh8FTf06h5UcHmNjqqMfowtaJtT
	X6Re69UhlkHIDgRDRHB3CiEv54i5WyhJtrOk8lfXbCQ+PZ8Nj2Dg6IFozf90Skr0SLQbP0svtfn
	4uTtAPPaGwb/vvMs1Qp+MHw3jdq2/73p9KJzkYjc5/szNIzABddR/Ao8ZaiwsVvSBJqHqt2EZEr
	mYinJQHQ7BqlCOLRBnCUDjbZQSx98yRSF4R3HFqxVLKSV2/Xb/Wx5Q9XP6+DdHce2EM+U6bi8qK
	pETud5PVPOkXGeFQKLfCkUTO0g/jArbEv4Uq+TKR4h2bmenixKcAqMkz9S+ZKkzBSUeAkPFSuYK
	evOity0m0NmyM5l242V1YpEIAYyLE3CXQO/LawLRFhsltRMWUbGoytU7rocyOtW2IZW/UApjN0+
	k40sI=
X-Received: by 2002:a05:6122:e16b:b0:5ea:c11b:431a with SMTP id 71dfb90a1353d-5ece72321bemr55152e0c.9.1794087974083;
        Sat, 07 Nov 2026 13:46:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm382617e0c.13.2026.11.07.13.46.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:46:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 00/11] Add support for HDT and EKS
Date: Sat,  7 Nov 2026 16:45:59 -0500
Message-ID: <20261107214611.388705-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c                     |  998 +++++++++++++--
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
 src/shared/gatt-server.c             |   56 +-
 tools/3dsp.c                         |    4 +-
 tools/bluemoon.c                     |   24 +-
 tools/iso-tester.c                   | 1418 +++++++++++++++++++++-
 tools/l2cap-tester.c                 |  942 ++++++++++++++-
 tools/l2test.c                       |  156 ++-
 tools/mgmt-tester.c                  |  218 ++++
 unit/test-gatt.c                     |  101 ++
 40 files changed, 6777 insertions(+), 817 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

