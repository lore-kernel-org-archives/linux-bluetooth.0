Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898753;
	b=0BnMJ6qO2SjHy+TudZPE23fGGiyfHgmBOcH6Iuy4m+wnAkmWuNTg3fr5gj9ti22hr/6V
	 8Z16307vSn+zF59fE0Jf5BkQ8hox4SonU7XiZ9GH9xMUJtlaCRBRqwq+egqrGXXqiPjFc
	 orLwy9PoQE07hvZC0UK0EnHPpp/5iUiH6OpUozsSol5IL4e6z91wLSu4nWDMlfBM/jMqj
	 wMNnwMLNOWL4fIzv9j/bE3y28448JiGGFt5tnBGeVrzi9DqEidi6W/KX/5g9XpCQavr76
	 BHmvP5tvZ814bFnYP2lfAXEADnwIgrztwYg/PBG6vNNO9QZnJ6PDH8w8/D5fEVnazCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gf7qZ0Uj4Mz9pFlKJWCcunf/lC/bYSGh/k0xjom9+Xw=;
	b=mUvQ48dbu6BFkn46TgtqxJrIuGRojl+a1Tywd8nKzUI7ZA66m+NrF+k7pMQK1mZWsVBV
	 UvZgocczYISeJ4OHzrRlGgyW8WHk/PLuRepE0zfkA9i3Q3H80TA+7t39XUCd6tZYXxkwW
	 OjsvFH498zMjtaW5DgEt77K3fCYN9SZ9ZOzpZtADM13bxv8dtbtLCxxw/CQ+ctFkEJYTa
	 7FktQK9c625pxiat6dW6dcn5x/DB6zBcul7exJ6/dsfI0/8kLi9zu+hS3PBBldGZJK8CW
	 5voAPrB4SkZmrh2aK2HR9oKzzCV6Gi48UVMRyH4fVL4BDfP6XGdYKSifpKYHnf0MMUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GobmaR7a;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588E606A338
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D588E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GobmaR7a
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99ac154431bso174847241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898752; x=1794503552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gf7qZ0Uj4Mz9pFlKJWCcunf/lC/bYSGh/k0xjom9+Xw=;
        b=GobmaR7aDOIhsxScqku4DjgVSbaV2q8YOl0EBN0PnvrFk126RPD5e7y8u5SGJ92xBy
         BpnYEpr0a5el9TjHYWlz3hAvpwKOtdql33INIw8nHOKHf/WAec17Bwn+MhwamtCftgCk
         EABXkklMT+oEoiYM7LZLpnB51bDMsbxTMTKnciciP/lg9t5/sIVObeUor9P8UaZF3SeB
         G9pe+3iN5NXj8nNaefwIv4Js2mCr9lQJp9DCoxzWKJmZP51NYrhpJxIY/G2YmTeN+LqD
         UqJ7f5VuSCupHWTGO91JHgH2ocpSImckM81HC9Cg71f1hPpoNnxAf0mnYkRqDypJJ6GL
         6yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898752; x=1794503552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gf7qZ0Uj4Mz9pFlKJWCcunf/lC/bYSGh/k0xjom9+Xw=;
        b=l6JRXNuFVZWzlE9DUmVzhwtiH6aQXOrVvqx/oq6Lw5SoDtSGupEMGT5K0Wm7+lWWqs
         /Bpk9l6fWkm6LST8uQu4ZkLKBF4UtUqwGNTiUDawiO6Gq0F9UL6sk0tQh7eit6TaLb7o
         6h22HTJoApNoppYCT342omJbGMPnx4rXZEqUczMDr4v2ukZOwjTTgfBfn5jppiDRwCJI
         poyrLFs2XGZoOnixgq5vFbFMDXtctkw/XwoGGPEqI1E2yp8uTDWAbRBgPJ4EhziMzkE5
         ZJsN2baRMD5Nl/hYA1Dey4wTarmZGZE/N423va6W+DKTaCIzVo7Ckiynysf89z8cP4ZZ
         7x7Q==
X-Gm-Message-State: APuU4Z9gyT6jWSZyMNgXcL/Q5RJcN71niTGuZnM/LucFmzxNTjzPZxmS
	4q0fUeALNT6lXqLunjTFbTJb4+1UjOhcCfsj7QsDheJjQT5BWIIiUAvedH0JeA==
X-Gm-Gg: AYBFou3/H9DqC3IghmdYilDeTcUBeDUqjZUzUKjsb7WGgWv8Wzkh6HqW7de/PQ5qyWW
	C0dnSD8bK9YLdLX1KI4xCKvpYTIpaY1JQz8BBxHKzkBWVGtxTFBVCqBvQE/JW8LK7xAdcYNFclD
	Z27ESbVUSlGnjMxAaTrtSZTGUs5KB1FX0xlFRGr1R77EatWICgc4VkEHRQ/7tIWRvGhlMwInGsI
	0j7x7ulIRoe1QXxULt6aygk7m3zHYldU/u9B2ta/eiztMDPmqh1wjyHGEo1pGLN0L3zEH0IWfjs
	FMVG00ZeiY+EGncvqF+LT4P39lI3KG9841O0t4zZrOyz/PGgco1O9t7/ujfUNv60La8QTak76yv
	3t97Ay/nRPDS9+1BKV53W29sQ+8glQht6k0ZgaZMH5svRz7GzINWcxbeWzjapLkAe0jAzSu8G73
	YSopkS6uSFLkOwlyyB6QC/FduLEP0N4CmVd6SUepSZRUdRqToxb7+QRXw9Ix500WmX5WWspq9qN
	+YN27X2FflRpXVAnQmHxmzbwePkdRUxsULjwKphHI+9LC+sBAjq4rTdkM1hv3pNayhKOPqD1Vo6
	4ezc7rKNRuR1u5hy40bwgyBrR7nUJmfO9i5ebn+8D/p7gZOFNLtSX3lfhpv+tLhyhvPByNrVLMt
	mORwpc3XB9XT97fhDk5WchGGqjMETC1IuSNtW61T0aT9isHI2QJlooOWv5BHm8dLU+eyBu9Mpda
	qe7B0=
X-Received: by 2002:a05:6102:50a4:b0:7c1:bc57:c7f5 with SMTP id ada2fe7eead31-7d2a152413dmr179991137.12.1793898751569;
        Thu, 05 Nov 2026 09:12:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 00/11] Add support for HDT and EKS
Date: Thu,  5 Nov 2026 12:12:12 -0500
Message-ID: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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
 doc/l2cap-protocol.rst               |   42 +-
 doc/mgmt-protocol.rst                |    3 +
 doc/org.bluez.GattCharacteristic.rst |    4 +
 doc/org.bluez.GattDescriptor.rst     |    4 +
 emulator/btdev.c                     |  941 +++++++++++++--
 emulator/btdev.h                     |    1 +
 emulator/bthost.c                    |  137 ++-
 emulator/bthost.h                    |   14 +
 emulator/hciemu.c                    |    3 +
 emulator/hciemu.h                    |    1 +
 emulator/main.c                      |    5 +-
 emulator/vhci.c                      |    4 +-
 lib/bluetooth/bluetooth.h            |  101 ++
 monitor/att.c                        |    3 +
 monitor/bt.h                         | 1672 ++++++++++++++++----------
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  221 +++-
 monitor/packet.c                     |  890 +++++++++++++-
 src/adapter.c                        |   28 +
 src/btd.h                            |    7 +
 src/gatt-database.c                  |   26 +
 src/main.c                           |   33 +
 src/main.conf                        |   27 +
 src/shared/att-types.h               |   17 +-
 src/shared/att.c                     |   39 +
 src/shared/att.h                     |    3 +
 src/shared/gatt-db.c                 |    9 +
 src/shared/gatt-db.h                 |    3 +
 src/shared/gatt-server.c             |   33 +-
 tools/3dsp.c                         |    4 +-
 tools/bluemoon.c                     |   24 +-
 tools/iso-tester.c                   | 1395 ++++++++++++++++++++-
 tools/l2cap-tester.c                 |  930 +++++++++++++-
 tools/l2test.c                       |  156 ++-
 tools/mgmt-tester.c                  |  163 +++
 unit/test-gatt.c                     |  101 ++
 40 files changed, 6453 insertions(+), 821 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

