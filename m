Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0782EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810562; cv=none; b=krLx+oT+AEbsFZY56XNWc3Sc8oGO403lc4sncVa2GYDD/fy9kOuUmdPrusAS+hxHPSs/TdXLFH82RtMGe3/Qw4YrQScXsCQSNpXOnDQkAH6OnO2UaxlwVzTaJW9ATClskLszgUSmGLubUgv6OPAR864vIqW7p8HqCGSWZ76MkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810562; c=relaxed/simple;
	bh=kKEz9uHL5p8lva4iV3TeMl2Zx9xaPvD/5lLvSBLNPyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WDREpvjLQqDi7N4PrjSju0uSbjkMjzEjr0DJv5Ndtk6HS5s/uzSiOnEwHxIiCMZ/vhxE+9gmCi8dimmZ6bH4b5pYI9LxdFcQOw37vSugXmixM2v2a8xeqz/TXziOrSqWjPnih3o6HXeI+7ROCLst/y25hTlY25aPIYzsioEPts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc9UGSPC; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc9UGSPC"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eae7bb8018so824883137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810560; x=1770415360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnWziWRhKs2raRFCb6JFOCjsljcubfQrCJfcxNn/xNg=;
        b=Uc9UGSPCL46jtC5fmODyFLJlaOd27Oh4UimIYkRUpdXWX9RmZGs2kfCkU+bZ/cQzJB
         dkG1PxiCj2xGKM4RPJU2eD89QVGpF/E/dhF6S/MwwF/Mf/p6pThk6hCvli3SMWSae908
         DKWY6/Nm3FYd6iy3rTb+Aogl31b7CchbO0VCicagb80dYRoHtCiUsdgDpsQBtfsy4yeU
         vCuTiiY5YV4nJD2OdhqDsXVZzogVkpn8PRl/pnCNjwfo5KiZZSVpftp4oaUoJVGuO/8L
         uVx9t1WVs584sKvHfJ7+9dow52I1etg/LAszjp4/i2yLYxkla66LQOfGGBU1W9o2Xn7A
         COPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810560; x=1770415360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnWziWRhKs2raRFCb6JFOCjsljcubfQrCJfcxNn/xNg=;
        b=DldITOdGG///G/eh+Veq2MNqt+Hj1mCUdxqsgwO4AtkxZ5l1gZ+4Mb9zZWi9+29tCQ
         iyMglNWqwae6GjaMQKcV8ujc4TMORJuhrCUB3nAN3/3AfIkMJyWTL1ezVm6qK+sml11Y
         DewVnQ5MDe87OK61HiD9zLNKlVKc71ZKr+vfgfkzsdTR5YNbtJfzAxzuU7F2ZWoXzeHZ
         EKGzr6PlKQKBcBKG8ZdBwBs8sipAVAvd/yMiMpsz/dgbWrpPVTmhPy/f9eoMYMHYK/Ro
         1xNvpQpi/dXCC+P1JIR7X6iJvLQJBnfJufsEraaNo7syo0M8FPG6fT1wIophU86IXZBt
         eBPA==
X-Gm-Message-State: AOJu0YwCA/dsbJCNZsSjs5LN8t3i029PtJxjx6svp1b2SkYLIDSQK5ST
	on356+ZB2xSUdKCdsDmUsMD7hUpCc7EUw4FzEnjbOqs9f2jg6w35PZjQhjD2Mw==
X-Gm-Gg: AZuq6aJrzLE4Dh9qUByOu2YNTr4fNlrsLAn17paYS1sueGzHuGq30MUD48sHrAtdaSF
	qa1aZIZ64yHHptQtVxM/ixmnvxbyHAzXee+sUSWyp8KhdGkuxX8zDpRbBDNWOHB3pa9pq3JsEML
	vfdHsmFagfhLLLBqzo30BlMTr9gK55baTfUwslUDcPsbinZbrpJUXN2zaOks4zW5MhKRfCdQzUh
	lRSdU4yZo7YMdItoMXCvn3Qqt5rrXzN6wEUW9jXKjZmVNEj7IPNMRqkiJ0X9ZLrLjjVaAZmQ7cm
	2BWz1MTByQiWzJQ6TMqiwF4WRBpfw98KZyycxTVkCIWNDauNS/f15oCagU/DHmCEjNPIpzNGypg
	W+CuzDbaKsohA8PiVH/2BLuQIFYK28p7gnZSD8eiesfCX6JRF8EgOBf7Vacez18Hmv4+MMYTvbd
	/hz9YFlJjzT9uS4nAvoFPiQXxFxTHWjN4lnMxCXqx6wihQ0JEDDwdXu1+cGhA5DmNyHoZR3uaia
	ln0sQ==
X-Received: by 2002:a05:6102:32c3:b0:5ee:a0de:65ea with SMTP id ada2fe7eead31-5f8e25fcd99mr1314543137.38.1769810559806;
        Fri, 30 Jan 2026 14:02:39 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 00/37] doc: Add cross-references between bluetoothctl and D-Bus API docs
Date: Fri, 30 Jan 2026 17:01:51 -0500
Message-ID: <20260130220229.1346261-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch series adds cross-references between bluetoothctl man pages
and D-Bus API documentation to improve discoverability and help users
navigate between the command-line interface and the underlying D-Bus
APIs.

Changes include:

1. bluetoothctl documentation (patches 01-15):
   - Add :Uses: fields linking commands to D-Bus interfaces they use
   - Document command arguments with descriptions and examples

2. D-Bus API documentation (patches 16-37):
   - Add :Used by: fields linking interfaces to bluetoothctl man pages
   - Add Examples: sections showing corresponding bluetoothctl commands
     for both methods and properties

Changes in v3:
- Add Examples for properties:
  - org.bluez.Adapter: Alias, Powered, Discoverable, Pairable,
    DiscoverableTimeout
  - org.bluez.Device: Alias, PreferredBearer (Trusted, Blocked,
    WakeAllowed were already present)
  - org.bluez.MediaPlayer: Equalizer, Repeat, Shuffle, Scan
  - org.bluez.MediaTransport: Volume
- Add Examples for additional methods:
  - org.bluez.AdvertisementMonitorManager: RegisterMonitor,
    UnregisterMonitor
  - org.bluez.GattDescriptor: ReadValue, WriteValue
  - org.bluez.MediaFolder: Search, ListItems, ChangeFolder
  - org.bluez.MediaItem: Play, AddtoNowPlaying
- Add new documentation files:
  - org.bluez.MediaFolder: Add Used by reference and Examples
  - org.bluez.MediaItem: Add Used by reference and Examples

Luiz Augusto von Dentz (37):
  doc/bluetoothctl: Add :Uses: fields and document arguments
  doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments
  doc/bluetoothctl-admin: Add :Uses: fields and document arguments
  doc/bluetoothctl-advertise: Add :Uses: fields and document arguments
  doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
  doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
  doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
  doc/bluetoothctl-gatt: Add :Uses: fields and document arguments
  doc/bluetoothctl-hci: Add :Uses: fields and document arguments
  doc/bluetoothctl-le: Add :Uses: fields and document arguments
  doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
  doc/bluetoothctl-player: Add :Uses: fields and document arguments
  doc/bluetoothctl-scan: Add :Uses: fields and document arguments
  doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
  doc/bluetoothctl-transport: Add :Uses: fields and document arguments
  doc/org.bluez.Adapter: Add Used by reference and Examples
  doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
  doc/org.bluez.AdminPolicyStatus: Add Used by reference
  doc/org.bluez.AdvertisementMonitor: Add Used by reference
  doc/org.bluez.AdvertisementMonitorManager: Add Used by reference
  doc/org.bluez.AgentManager: Add Used by reference and Examples
  doc/org.bluez.Call: Add Used by reference and Examples
  doc/org.bluez.Device: Add Used by reference and Examples
  doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
  doc/org.bluez.GattDescriptor: Add Used by reference
  doc/org.bluez.GattManager: Add Used by reference and Examples
  doc/org.bluez.GattService: Add Used by reference
  doc/org.bluez.LEAdvertisement: Add Used by reference
  doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
  doc/org.bluez.Media: Add Used by reference
  doc/org.bluez.MediaAssistant: Add Used by reference and Examples
  doc/org.bluez.MediaEndpoint: Add Used by reference
  doc/org.bluez.MediaPlayer: Add Used by reference and Examples
  doc/org.bluez.MediaTransport: Add Used by reference and Examples
  doc/org.bluez.Telephony: Add Used by reference and Examples
  doc/org.bluez.MediaFolder: Add Used by reference and Examples
  doc/org.bluez.MediaItem: Add Used by reference and Examples

 doc/bluetoothctl-admin.rst                    |  28 +-
 doc/bluetoothctl-advertise.rst                | 356 ++++++++-
 doc/bluetoothctl-assistant.rst                |  24 +-
 doc/bluetoothctl-bredr.rst                    |  25 +-
 doc/bluetoothctl-endpoint.rst                 | 217 +++--
 doc/bluetoothctl-gatt.rst                     | 249 +++++-
 doc/bluetoothctl-hci.rst                      | 112 ++-
 doc/bluetoothctl-le.rst                       |  26 +-
 doc/bluetoothctl-mgmt.rst                     | 743 +++++++++++++++++-
 doc/bluetoothctl-monitor.rst                  |  79 +-
 doc/bluetoothctl-player.rst                   | 118 +++
 doc/bluetoothctl-scan.rst                     | 126 ++-
 doc/bluetoothctl-telephony.rst                |  75 +-
 doc/bluetoothctl-transport.rst                |  78 +-
 doc/bluetoothctl.rst                          | 250 +++++-
 doc/org.bluez.Adapter.rst                     |  41 +
 doc/org.bluez.AdminPolicySet.rst              |   5 +
 doc/org.bluez.AdminPolicyStatus.rst           |   1 +
 doc/org.bluez.AdvertisementMonitor.rst        |   1 +
 doc/org.bluez.AdvertisementMonitorManager.rst |   9 +
 doc/org.bluez.AgentManager.rst                |   9 +
 doc/org.bluez.Call.rst                        |   9 +
 doc/org.bluez.Device.rst                      |  39 +
 doc/org.bluez.GattCharacteristic.rst          |  21 +
 doc/org.bluez.GattDescriptor.rst              |   9 +
 doc/org.bluez.GattManager.rst                 |   9 +
 doc/org.bluez.GattService.rst                 |   1 +
 doc/org.bluez.LEAdvertisement.rst             |   1 +
 doc/org.bluez.LEAdvertisingManager.rst        |   5 +
 doc/org.bluez.Media.rst                       |   9 +
 doc/org.bluez.MediaAssistant.rst              |   5 +
 doc/org.bluez.MediaEndpoint.rst               |   5 +
 doc/org.bluez.MediaFolder.rst                 |  13 +
 doc/org.bluez.MediaItem.rst                   |   9 +
 doc/org.bluez.MediaPlayer.rst                 |  45 ++
 doc/org.bluez.MediaTransport.rst              |  21 +
 doc/org.bluez.Telephony.rst                   |   9 +
 37 files changed, 2622 insertions(+), 160 deletions(-)

-- 
2.52.0

