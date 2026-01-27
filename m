Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41E324716
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535538; cv=none; b=XkPmmqexdnHBmv09HZr8q6fD7Q7DRT+Kvw78jRqzE3RQjPOVKhRgVoGoypuG4HXlAKO+ldRoksIxyRjsyhR9kJyGLcoixX/SHZYxw/IgxZTZPBKP03BDOv2eYHdap++KWP+5e4Y2vl1h7dNkq5zwRWXo1gX6rh5GkQub5SN9agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535538; c=relaxed/simple;
	bh=PelUspsn9uQ/pome5Ge4DRVs9Phi39AdUtiTIM7d6a8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeIOvrp/hu5gPeBqfmU58BNhSbZuKmXDow/Huno1ko4Qawby2OZNy0qw4kh1vnN6y9deaO8E9k5PXyUaONxbHRXzlKfa9HJDR4Pdelt5qxnyAotqoy+pg8yqDDz4XEKy5xF+X6Sza4mwFGZONYYjNsLu5s2GDxEcLtNupBujbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J3o3TNYK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J3o3TNYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769535531;
	bh=PelUspsn9uQ/pome5Ge4DRVs9Phi39AdUtiTIM7d6a8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J3o3TNYK5Aw2EngiF3hNUh6SaFVUNIb3CnrMn5xZQ7N9d0ZYSD/yIznwHOQy0J1us
	 FdPclf9i1swb/8WqH4nTbW295xhm+KynRXnEGJlIxJGOKZhxpP8OzAowjhbtEDvqn0
	 47WYmqhyZNyhAXQ74o1qxm+EwRXDVgajisQu9COplhBsUivw8NGxZcskk9jcY8WruN
	 F3QtSPwpdgGNn23M57L8c/WpZm+mGoM08SMYs13ODaKV/i+kQmGx3L5Ry1BPI5ijYg
	 iRkSsoswLmbjL7hu7iwFKutWH04jJN9TeHPMvhQt9U++PPyk6lTQHxwnZGiFFTXA9r
	 o6Nkpmp6Tcrzw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-871c-6E70-D798-Dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6AEB817E35C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:38:51 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/13] doc/qualification: Add PICS and howto for the IOPT qualification
Date: Tue, 27 Jan 2026 18:38:41 +0100
Message-ID: <20260127173841.153747-13-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127173841.153747-1-frederic.danis@collabora.com>
References: <20260127173841.153747-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 doc/qualification/iopt-pics.rst | 37 ++++++++++++++++
 doc/qualification/iopt-pts.rst  | 75 +++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 doc/qualification/iopt-pics.rst
 create mode 100644 doc/qualification/iopt-pts.rst

diff --git a/doc/qualification/iopt-pics.rst b/doc/qualification/iopt-pics.rst
new file mode 100644
index 000000000..2dab3c25d
--- /dev/null
+++ b/doc/qualification/iopt-pics.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+===========================
+Interoperability Test Suite
+===========================
+(TCRL 2023-1)
+
+Interoperability
+================
+**Table 1: Interoperability Test Specification**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_IOPT_1_1    | x        | Interoperability (M)                         |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Interoperability
+================
+**Table 2: Design Configuration**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_IOPT_2_1    | x        | BR/EDR (C.1, C.2)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_IOPT_2_2    | x        | LE (C.1, C.2)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_IOPT_2_3    | x        | BR/EDR/LE (C.3)                              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one transport.
+- C.2: Mandatory If IOP 2/3 "BR/EDR/LE" is Supported, otherwise Optional.
+- C.3: Mandatory if IOP 2/1 "BR/EDR" AND IOP 2/2 "LE" is Supported, otherwise Excluded.
diff --git a/doc/qualification/iopt-pts.rst b/doc/qualification/iopt-pts.rst
new file mode 100644
index 000000000..13f05d460
--- /dev/null
+++ b/doc/qualification/iopt-pts.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=================
+IOPT test results
+=================
+
+:PTS version: 8.5.3 Build 4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- In ICS select:
+
+  - TSPC_support_AdvancedAudioDistributionProfile_Sink
+
+  - TSPC_support_AdvancedAudioDistributionProfile_Source
+
+  - TSPC_support_AVRemoteControlProfile_CT
+
+  - TSPC_support_AVRemoteControlProfile_TG
+
+  - TSPC_support_HeadsetProfile_AG
+
+  - TSPC_support_SerialPortProfile_Service
+
+Tests
+=====
+
+The kernel and BlueZ versions represent the oldest version without backport
+for which we know the test passed.
+
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| Test name            | Result   | Kernel  | BlueZ |                                                                         |
++======================+==========+=========+=======+=========================================================================+
+| IOPT/SR/COD/BV-01-I  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Start '$ bluetoothctl'                                                |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# discoverable on                                        |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/SR/SDSS/BV-02-I | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Start '$ bluetoothctl'                                                |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# discoverable on                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run in a second terminal:                                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - python ./test-profile -u spp -s -C 10                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/SR/SDAS/BV-03-I | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Start '$ bluetoothctl'                                                |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# discoverable on                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run in a second terminal:                                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - python ./test-profile -u spp -s -C 10                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/SDR/BV-04-I  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Start '$ bluetoothctl'                                                |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | - Pair PTS device                                                       |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Check UUIDs in bluetoothctl: A2DP (110A, 110B), AVRCP (110C),         |
+|                      |          |         |       |   HID (1124), HFP (111E, 111F), HSP(1112), OPP(1105), SAP(112D),        |
+|                      |          |         |       |   SPP(1101)                                                             |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

