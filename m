Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466D388E59
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920357; cv=none; b=a+6NLohjZhX7XGQ9Jjaw1gwXFH1xRbQ8MJpvFsj2n5IeKMrigEx8vcA+ng0af7vKQ+Ce6SoFyLhQkGrAZfwPLtYEipOJa1satHmxeOrIegIRyX43OI8c4YHDiIhAOmcGSbqlqe2wT/VpD42xFU1Z+V4o9FM+YRtomO1bOpuXUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920357; c=relaxed/simple;
	bh=xfFnOWdfn2jwVExP26PVoON2pA4TIghYvfbmW/2yzMM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Rv+TUEVCxQJN1Fbeh3mJd12asr4DkTxhpm+GIvcBHr/deB6EetSrys9nvHMEKrbmMi30Ad69c+09Cc4YrTbL9IKepdMWeL61BFZJj+31Xx9qUmomwHHHB3goQCzOfxiz/nL9vUi2+8aW5Gt5AqHq9DaqUG2G5DyFTa9oVxXJE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2wy97rl; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2wy97rl"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf94664327so310307e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920355; x=1785525155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUApa3BZ8XuzRpfBLClOEfWTHKBZMZcbBHkwUd/zYJc=;
        b=A2wy97rlcaUR2a+reY+ezINyI/Ep/Ru2RIb43/RCO4AGhFDIebmwTervltQpxUACKd
         7166Dxt0wNVsEXzh1XgH3RODFj668YvN06qdHwlMhZZAAqpK6NUtNm0Xk2L8d0Oi34z4
         E6WBrQ/FW1stuaJnGLzC3AJ+ikfaxyieTZeO4HYaiZ3X7m67eusvrH2fvKRrE3dlQbus
         s4PgwZ/qy2nVd5Epo0xgbgt7/I1dZgHjh1LrZ15NWS7f8dxKKEoHhSXtT0SXnJGD1d7o
         0WNH4co1/TjsbTaxBS4cgnTz/i1lA3+7Mkop0JOoxli/XAzaGLZ79khNqaGTvnxNjOo7
         sPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920355; x=1785525155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eUApa3BZ8XuzRpfBLClOEfWTHKBZMZcbBHkwUd/zYJc=;
        b=V29sQLOQnvMCyNFjUwZH7YacsJ72jXCsy9AKwxetCY4UwcMIWrh8x4EObtLXSi49el
         s0QTyq8XTBbqZsgZ+j/S3K/shUHLy5Oa3x2l162FxrpRvHGk3z/ksRJCMIW/1/JFnGdh
         umWFp24753/p17HEexlCsFC1+srTPCB+t3WhAhmiODaij+bdJpiudu1VWLhm6BlLcLYO
         u4mKcAhaIaaxENI2czlmi0Uyoym3bjBk23UBtEVK2jspi8pHnZZSCDS13ulTS6AjYXYq
         OeoP1KPS5t0W5NiIKjj0lJhTTWStxBeDZI+olKrPlA+MHt7hXqXIpWYObskNADlWRpRa
         ke6Q==
X-Gm-Message-State: AOJu0Yzjsl+WLvjwd0zf6JMFpvXSrQLT7FBD+NALm7JDs14/uwGEFGmP
	p3ToaFnW/GhkyVO7ixKDiz72G6Tz7z7oplFXqSCExkz7hkt9TyxJUAipEiPtaGw7
X-Gm-Gg: AR+sD10+wSYVZYpsXmv6wlmvtPuum2eW80aVPWL8wgLiAtJB1oujelb+NeuSO9ncXzu
	ASD8tPnqrYatYLOoHiOEf3pqjv/KrKfufEhqvKdsvHMBQ/a5X58Rm3FVqH5NnWLnRxqeQeycom/
	JhmEMuygi67UcPZ17RQZ4hUyKrzVfgB3AyUu5M4tdU5/n2Hyz72LR4u07Bjuz+proRgSn1cSFZm
	eL33t3BIpzgy5v2v4sRijm2VzdB1xQH1Nz7K9vTJ7/O4va3sj8M+hfCK7GjTC240+TEq7if491U
	w15lzN7Ru1Vt+GcHLkUIUnbRT01lRn9GUQnrSgKYYM15FBATRbTpMxwrzDSeZIi5Lc5NOrd23D+
	Wp6TVrNyk+mgQwf5CMw1QDo2XUgChKpBGJ9dxHPQ03MIIlwv6d/vBdI2SgjNzIDvaLUrgiVHj4s
	gLfmXsOIP1LxExjUPVUHQbwI59R0D40qfLn/nFVxfYnZdyam6iaCDcAK/tliXuwqJRMJABvrg0
X-Received: by 2002:a05:6122:6991:b0:5bf:bb66:414f with SMTP id 71dfb90a1353d-5c2da1ad401mr4264802e0c.11.1784920355086;
        Fri, 24 Jul 2026 12:12:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/12] Add support for Shorter Connection Interval (SCI)
Date: Fri, 24 Jul 2026 15:12:13 -0400
Message-ID: <20260724191225.1815634-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This series adds support for the Shorter Connection Interval (SCI) feature
introduced in Bluetooth Core Specification 6.2 and used by HIDS 1.1 / HOGP
v1.2.

SCI allows an LE ACL connection to use very short connection intervals (as
low as 1.25 ms) combined with a subrating factor, so a device such as a HID
peripheral can achieve low input latency while keeping power consumption
manageable. The connection rate parameters (connection interval range,
subrate factor range, peripheral latency, continuation number and
supervision timeout) are negotiated with the LE Connection Rate Request
procedure.

The series covers the full stack:

- HIDS 1.1 GATT discovery: the HID SCI Mode (0x2C39) and HID SCI Information
  (0x2C3A) characteristics, and the SCI flags in the HID Information
  characteristic.

- Management interface: a new Shorter Connection Interval setting (bit 25) to
  advertise controller support, a Load Connection Subrate command (0x005C) to
  load per-device connection subrate parameters, and a Connection Subrate
  event (0x0033) to report rate changes. Parameters are persisted per device
  in the [ConnectionSubrate] storage group.

- bluetoothctl: a conn-subrate command in the mgmt submenu to load subrate
  parameters, pre or post connection.

- monitor (btmon) decoding for the new command, setting and event.

- Emulation and tests: btdev and bthost gain SCI command/event support, and
  mgmt-tester and l2cap-tester cover the setting, the Load Connection Subrate
  command and connections for each of the four HOGP v1.2 recommended modes
  (Fast, Default, Low Power and Full Range), on both the client (central) and
  server (peripheral) side.

The corresponding kernel support (HCI commands/events, the SCI feature init
sequence and the MGMT Load Connection Subrate command) has already been
submitted separately.

HCI reference for the feature this series builds on:

  Commands (OGF 0x08):
    HCI_LE_Connection_Rate_Request              0x00A1 (octet 48 bit 5)
    HCI_LE_Set_Default_Rate_Parameters          0x00A2 (octet 48 bit 6)
    HCI_LE_Read_Min_Supported_Conn_Interval     0x00A3 (octet 48 bit 7)

  Event:
    LE Connection Rate Change                   subevent 0x37

  Feature bits (LE feature page 1, via LE Read All Local Features):
    Shorter Connection Intervals                page 1 bit 8
    Shorter Connection Intervals (Host Support) page 1 bit 9

Luiz Augusto von Dentz (12):
  input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes
  emulator/btdev: Add emulation support for HIDS 1.1 SCI commands
  mgmt: Add Shorter Connection Interval setting and Load Connection
    Subrate
  mgmt-tester: Add tests for SCI setting and Load Connection Subrate
  adapter: Add support for loading connection subrate parameters
  monitor: Add decoding for Load Connection Subrate, SCI setting and
    event
  doc: Document ConnectionSubrate storage format
  client/mgmt: Add conn-subrate command
  mgmt-tester: Add HIDS recommended SCI parameter tests
  l2cap-tester: Add SCI mode tests for LE client connections
  emulator/bthost: Add LE Connection Rate Request support
  l2cap-tester: Add SCI mode tests for LE server connections

 client/mgmt.c             |  88 ++++++++++++++++++
 doc/bluetoothctl-mgmt.rst |  21 +++++
 doc/mgmt-protocol.rst     | 125 ++++++++++++++++++++++++++
 doc/settings-storage.txt  |  22 +++++
 emulator/btdev.c          | 107 ++++++++++++++++++++++
 emulator/btdev.h          |   1 +
 emulator/bthost.c         |  36 ++++++++
 emulator/bthost.h         |  14 +++
 emulator/hciemu.c         |   3 +
 emulator/hciemu.h         |   1 +
 lib/bluetooth/mgmt.h      |  31 +++++++
 monitor/packet.c          |  62 +++++++++++++
 profiles/input/hog-lib.c  | 106 +++++++++++++++++++++-
 src/adapter.c             | 172 ++++++++++++++++++++++++++++++++++++
 tools/l2cap-tester.c      | 181 ++++++++++++++++++++++++++++++++++++++
 tools/mgmt-tester.c       | 163 ++++++++++++++++++++++++++++++++++
 16 files changed, 1132 insertions(+), 1 deletion(-)

-- 
2.54.0

