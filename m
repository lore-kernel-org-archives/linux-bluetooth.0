Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989093;
	b=Ovd6IVJY0WQ5yoS/42DhC25IxYdY+g9+5L4TQzX48z1mH0+S6JddCeUZGz6xyob87mam
	 QnNuGEp1SavMzQ2KNtmMJh58q4pl8RDAwvTyOqV1Pmx6RTBOp59Xm7FoHHlqPLMXr3TH/
	 5OJTb/6wAdFICq9PY91Z8XMhB8KYgM9Qlu260quxIAdcKLTyavxQ/4OElfShhggEqc3b9
	 ICAa4uRJn4t4lsZ7DlSiFcn6iOGx/DpxYo6sNl47hNGe8VOqiZuJx297Xe+/Ewn1+R5xv
	 T0PMCi0FscFSSOmcDzZ+FJeWuDZrRLFbmQWZ5hxGKkpDtW2WnLIGkoRlY4NrJ3qRR7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OWk5JzckVugSkZaXKyjlxYauiKOaORYnZF6bM9FdFZo=;
	b=dimkJUCWsmP++Ob6T87SzaM52NmlnJDyPDhBnMD5eGNb6ZxtG7YMW3YoniL9R/N+0C6N
	 SajkcdvAPXopYKE+ZywcxF2KbVaLlDPrx8426MxNiPMJ6OLu+jz85feKH3ONYQwaY30R0
	 4PWse4wa0yCSYFaPmxrQHziMyn8SIICbk0Xg00P3kM/ucV4QqtzPp+y+phT4vsC+KXuOB
	 7dWYMIu3b4sRqeRgGjqr950qbEIUm55Q6zAudL+jlvcwnvYZTzS8KhUKwFbvLa3J4ty2Q
	 NdFmNorf0qso3PDctktQ7zeVu+9MrCDAlQ1WMtbMsy6tqKOouFdsvZx6FY6TLfR8x4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPHXAbtN;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7E606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA7E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPHXAbtN
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec6f271883so681649e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989092; x=1794593892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWk5JzckVugSkZaXKyjlxYauiKOaORYnZF6bM9FdFZo=;
        b=XPHXAbtNGg5bsAjVNQ507l6sJcgTk36KPXIo90pm4PMS7xNraWF3UnrbdgUgEEAIct
         4+GaNMXzV7xQhPua62rU04aDOQq98MLPliZrYIvmBH2WPD8HlqR7ni8JWY50Xp6KxC0J
         C6TjxDm9diqpIDnLbIdip8YQ9Dnma9HCR5dLUnYVkHY/Phd7vdiuwHSub36avTDhxbwF
         5GecPYdOGQSIsqQHguuhnUsizvQTnrx6dzY8mzubCqia4/L5Scm55Whb69O62cnYV9bW
         jTCGR1T+qBvq9W576lh7kkvx9aoukST6gl07kPAxmu193wEfrZ/RGVq3+uP6ohOi5gYf
         ju5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989092; x=1794593892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OWk5JzckVugSkZaXKyjlxYauiKOaORYnZF6bM9FdFZo=;
        b=f/sEAQF08T3pHCzhBw7eDHELUhO7xFBz3vV69/ghyidnHwGqF5caxY+JzrfOHCQX9y
         HwuAp1k2YwjP5K3VCwLGr89ZCALDfiFCVpu5oT2hFS13RP1H4J8HBitYEn0E9lHOR/7b
         sU94JAzj+2LmjdqPxKfiQgZYxmPAd3dtylj1DkRjLPVWMbnkk6Gr+RLfsnlljQgs/iig
         6axoxpxlAGKvnVkOmVdpHXd2Ypf9dUlYx94xGuZO1yJqeIRR/JW52DP5H8dfHQ0EV6xJ
         76Fm1tzypxshMgenWu+DFQd/bRS0w3bRF8KHGO3SyoXaqSXAE6UYqVI/RU3X1d7HH+Ct
         NIsg==
X-Gm-Message-State: APuU4Z/yJ/7hyqF/t5dIb0Yu/22n0LPSIYUnLsEw2+Sfo7tAIRG/dEri
	yqVVXEFDCRMCqVVmSzYdRzCgjBH1XxSCgH3DAK71n6qgFVxCaMvOsFsygw5+ZQ==
X-Gm-Gg: AYBFou0GdUpfl4qIjnObZzh/t88bmOHxlMzseAE0ZMXC3B8zFTKh5axcreMJTAsSKxu
	sngHKdS3i1U7jLBJtbbKwraqhX/Iwhz9PQbx2WvONkXTI8H/CJ8/t3v4/ZLXoanR42EK5ZPO/+i
	V3n8WXr3rkR0nmaUWCQ8bGVrXsjMfbb+lvh8qO8tKmLoMf8rYxtGLbDLVG0Vh1+rrpzpVhILHLQ
	JNgdYsKB7mn0XybTDaOQpB+JW+NHfJ3rdTAkvvZ1WSymG2svg1Xh0yup6QLZIw21FQO51Sa1F3z
	rHh/beGGMsxMhDVa+5fum4zmQqEHj8VuSlIaFd16zPA+FwO7Tuvve/98t4rLkEv8bBPd8UqnTcU
	FGalM5iFGvybd0EGVv6XovGJ7AS9shataNRgUK68HVYwAnx9cMZuxZ3MJUnmEX2wdTNf6mjXhEN
	AlTvoDHVSpwi8mnPsvlfzhz8Tv79qOaf9OKtE7VWvqJZwS7NTjjNpMBu0aoWdsQGfaswQpCvRXA
	byJSTXAQ27Vjk+GgevJfDJzHXDz9fT1YDzhO6x7SlEeb0nj4NC9CLsb35vJv5F3/ehFB8SJudDU
	Q/lakf/fnCU00x/74yBlSmrrBtPc02UTHHJuDE0TDrwdjUgl01SQkGqFT0y2XgklCwLPH6atd45
	y0aNXplzXsZeIBCVOoNdD4/5+VBjpWu0Q6C7IdjtuT9r+1go8+T1gHWQuQQBpN9vDcRKvo6M8YV
	DeaMM=
X-Received: by 2002:a05:6122:2495:b0:5e8:c908:d60a with SMTP id 71dfb90a1353d-5ecc43c02e6mr1738555e0c.9.1793989091275;
        Fri, 06 Nov 2026 10:18:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 00/11] Add support for HDT and EKS
Date: Fri,  6 Nov 2026 13:17:57 -0500
Message-ID: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c                     |  945 +++++++++++++--
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
 tools/iso-tester.c                   | 1414 +++++++++++++++++++++-
 tools/l2cap-tester.c                 |  934 +++++++++++++-
 tools/l2test.c                       |  156 ++-
 tools/mgmt-tester.c                  |  163 +++
 unit/test-gatt.c                     |  101 ++
 40 files changed, 6488 insertions(+), 821 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

