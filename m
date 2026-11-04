Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830860;
	b=g49sPuOjeI+TlG60pU0E8XXhimG/7K6ZJ4sbv3zNpvzLO7Jhx7VXCrKt8gRoseEO5Vrk
	 O0B1Kal+4S1ITAFbHQHYI4hdtSjrdVUiuY3soJNBa8b47AJwCbZ7NpZt4sCcD+SBy9pUg
	 kwrP8rbZqWLMk40V+QZamOnr6OvnGSx1PV7Wznf8AIH08nk9ss+KCxD4Tehc/1ASR1UXj
	 K7x/NWA6wkwBAqyYzqD0VHParwzAvYyKJUuToa7qT5vY87VXw1rPsmh/XXrZVmZGbyVSy
	 e7/ct2H74T4yse63R65XNkvojHojJ8sPsV67gw8i8tnaE7fpvOeJ6xOAKqKqDWg2dTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H7ZNYFZ9CKWosTiE0EB+tAf/qjRH5vG7VMk0sLEEmEw=;
	b=zh4Sa9fpSoNYVQegnSknfoahLLHx0lY5KN4TWD4F0xh6zgrGcrTeW1h4Hxazech0is+l
	 6KJU8wJ+t/omN2AVeMOHQGcR6X3gFwqWc1M76wSZH2IqNNUlBNeSdN9Vi5vsNEZQIORN7
	 PqzjL0lyQujn8IEOA6BzXW6yS4vNxSUechS2idyjCKnN8I0FOBnxvddONHOjZHuSdeocZ
	 VbL7SCxanM+SwpCa+pSofp59u9lcP71jPTT2RPRH6e+7OZkOydVjcXZAkTbS0r08Dnai1
	 Iwx+oMGky2PiOs5AfoGJ10s48XNjP74ZSmwETsBqz8HuyFUTEM5t0PSGHF/gUrVMdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylb+CB23;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EE606CA39
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3EE606CA39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylb+CB23
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so890628e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830858; x=1794435658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7ZNYFZ9CKWosTiE0EB+tAf/qjRH5vG7VMk0sLEEmEw=;
        b=ylb+CB23YZSaA1Ap/R3Q/gP9XGY9o1csLVgb5fQslcpYtP2vhSnHfIRHevLAZYS+rV
         la+l8w0lEd8cgdP1wJfUBgq0lAiPYEDen641b/aZa1UMFk3N4fnASTtvNgkAWMW+lvZs
         rG7SDxR0Z0LB6PlmJvn30iUrIhClrvwFtTJu44TcembVKHMlm9WUvvYoOkddLuRXIVj+
         ztH5yXmIkgJsOGsQPCikNrhhiadntIPsIws5CWei+mK6RiK1KSBaGb1ygxgwfxRjZ9jK
         K0k4JTuukVr+8D++Y0WmdyWaOzkbz8QinsiLKAxs6LXIlZEbJqgyQl/y8ZPhaz8Y4TQA
         iXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830858; x=1794435658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7ZNYFZ9CKWosTiE0EB+tAf/qjRH5vG7VMk0sLEEmEw=;
        b=UIvCsS9fcZHpeQV1BIOD4fCdunQ0lB4RvYXBqiypfL0YR+tp5IKsjlpLaIl/d3Idx0
         do4U2gQi2qcVRROjCkwHwZ6WLuLQG/FC86bIiVM/HkTZfuT5sCF4bLkTOcb0ehSagOFN
         jnWS3KCVcKDVnwQhikSfORchYgpZmpk80dwR9mWcRvK36jxw9Ho+SXAAEo9dyZmUmm6Y
         3Ttcm2qhu7qnHwl7cR60t984dtREnGy6ffy3aB42mu/apOOX4lbj1g9e3K7RPygvKE58
         nSWIgSiEcaXqUY2ScXLbI+BGF+sk+c9vdsQXCOTIY8XHEyYcYqVGxTRdiLa6ybW4bZ4d
         5/tg==
X-Gm-Message-State: APuU4Z/O30koDH+ODZX2JZXwIPnPTH6L0skv2zFnB3sQfHjggVM+mFBQ
	g2f5Lp5/2XwsfATDgSDfJCxywA7LjegvuigiD3SIAXrHoW2xiRYZrQBHXTkxeg==
X-Gm-Gg: AYBFou0dKuCA5WMXtfnQwrCTLmpb5hSrBlQaUBCxWJRI55H+WRjapUGy2dqr4r4k8Xp
	VJmj0CuRJGB4gyY8EA992ofNuFQC3GWC1wWY78c+lQ8i12T1hjJX05eMX5S+b0gRuhOrVZUKy1a
	zsioEXA9W06lUazyhDeTTvvLGiNyR6fBgaAJaO5H+/KuHP8cYuWKrbZt6aXGWzOE76Vk4GE8c7z
	yUdhDNM623JO42PVNc3s8EAaOm7KEGOzj0d6b1TBWPMgSCnLGrriHNtOifQuRESSDIFs7QpJXWR
	yTL9Kmlkw6rLBO38DUwQ/eBBrk4WesNCF5j4p2CLGTshX4S45EQlbikeeeZjBz1NDbaz6XuobNc
	jdNr83X17LQau4aK8ju4KEk9SBTsfnt2eL9YdoMSEE4Cy7zJwpVkzh+4NvODHwxpEt17wuBPFJf
	xK4VM7yg/jbPsYlM9uLAncDQxwzh2+UGqBPoupC0Kps6ohwLd4KaWMSIY5ReHmaZL4W78hEQiaS
	6rougsfv9s3+5hajghCxE3WysVwXEVXWHhtfRNFApDsJikstbQ/t4BJoTLPXqrowvHjfaOHLI1H
	1zCpay2vflnh4Fu8Q9lGSyYNMU8yHFY/sGkNphlXej1u0AZ/btNbcYb/IV+gMJBCLDQ07KyF3hV
	7edcZ/GSzIqUtx8TTWWzzP4uEQppc9v0u4bjp7niFtYXVgGbr424WcS3N6/kjeq0sfeTpzX3xij
	rpCDc=
X-Received: by 2002:a05:6122:1b05:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec6895329amr8333207e0c.7.1793830857451;
        Wed, 04 Nov 2026 14:20:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.20.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:20:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 00/10] Add support for HDT and EKS
Date: Wed,  4 Nov 2026 17:20:44 -0500
Message-ID: <20261104222055.1207928-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (10):
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
 doc/iso-protocol.rst                 |  205 ++++
 doc/l2cap-protocol.rst               |   42 +-
 doc/mgmt-protocol.rst                |    3 +
 doc/org.bluez.GattCharacteristic.rst |    4 +
 doc/org.bluez.GattDescriptor.rst     |    4 +
 emulator/btdev.c                     |  926 ++++++++++++--
 emulator/btdev.h                     |    1 +
 emulator/bthost.c                    |   99 ++
 emulator/bthost.h                    |   14 +
 emulator/hciemu.c                    |    3 +
 emulator/hciemu.h                    |    1 +
 emulator/main.c                      |    5 +-
 lib/bluetooth/bluetooth.h            |  100 ++
 monitor/att.c                        |    3 +
 monitor/bt.h                         |  378 ++++++
 monitor/l2cap.c                      |    6 +
 monitor/ll.c                         |  215 +++-
 monitor/packet.c                     | 1321 ++++++++++++++++----
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
 tools/iso-tester.c                   | 1662 +++++++++++++++++++++++---
 tools/l2cap-tester.c                 |  928 ++++++++++++++
 tools/l2test.c                       |  153 ++-
 tools/mgmt-tester.c                  |  170 +++
 unit/test-gatt.c                     |  101 ++
 37 files changed, 6085 insertions(+), 501 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

-- 
2.56.0

