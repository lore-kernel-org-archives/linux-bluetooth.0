Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B23242A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535538; cv=none; b=ObHa4bWKGXrOtn5RuQFUbVL7uYFmh+kNww7J43TiybRbIQIct9ZUPsPfAUDyOuuLdZAT4T8y7QZxiUZJ4d20fzyIgYQ++rOuxUQ2zVhuxshlrkJ69oFiQrCiXij1vPfMX7lccjaKjKKchMgV3LmTibGygpUKyVjYaredEpfe/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535538; c=relaxed/simple;
	bh=i+wp1+ObUlM67tr4VX3INezo3CPBvyJ/OFKqfP721bo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMewxFvdiOFtYeNXWFQ547QFYAXUx/2MjLcURs4iozOz/+wBBSN177+DxU5DyzAqxKBoFPDU5w6wOeTjj8RDMEPYeTMckfHtSDqBx1HlwtQMh+22f7abd15jymP1LXGX72nxuW9NFu1nG2uf5XbP6teN5fvTB+zQZYUZ4fLUMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e3Pk0ErJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e3Pk0ErJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769535530;
	bh=i+wp1+ObUlM67tr4VX3INezo3CPBvyJ/OFKqfP721bo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e3Pk0ErJ1gqgTLBRhukJwDafQy0F9uApqJjXqb7iDGUCnKwRsV2TfMtwEJ88bWYB7
	 GPeX/5gVZWcBdR9PCayrC6dDqgr+cND+B90FHUOgJ8XeszTBVfs+OxDcFBpZlqi0Os
	 82N6nnQ6Kd4E55pe3I/VcinDhgeLp1/ouwyLvrq4tUvyI9xwKujLgIrtpQAp0nbF3c
	 1jWFKESwVpMLsP/pkZq01AxCZ2SjzwwISl2qF9fLDpEzCMQJv2k1kENZOAP+Edyjoh
	 kh8AgQBtT0zWTZE8uW3DmsOaq67WnkBoAV9AMWKwPGF/J/9qmTBrbQe8Y2fWvRwZTI
	 rqA4HCY99RW2g==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-871c-6E70-D798-Dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8034B17E157E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:38:50 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/13] doc/qualification: Add PICS and howto for the SPP qualification
Date: Tue, 27 Jan 2026 18:38:38 +0100
Message-ID: <20260127173841.153747-10-frederic.danis@collabora.com>
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
 doc/qualification/spp-pics.rst | 127 +++++++++++++++++++++++++++++++++
 doc/qualification/spp-pts.rst  |  35 +++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 doc/qualification/spp-pics.rst
 create mode 100644 doc/qualification/spp-pts.rst

diff --git a/doc/qualification/spp-pics.rst b/doc/qualification/spp-pics.rst
new file mode 100644
index 000000000..44fbec590
--- /dev/null
+++ b/doc/qualification/spp-pics.rst
@@ -0,0 +1,127 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==================
+Serial Port Pofile
+==================
+(TCRL 2023-1, SPP.ICS.p9)
+
+
+Versions
+========
+**Table 0: X.Y Versions**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_0_2     | x        | SPP v1.2 (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Core Configuration
+==================
+**Table 0a: Core Configuration Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_0a_1    | x        | Profile supported over BR/EDR (C.1, C.3)     |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_0a_2    |          | Profile supported over LE (C.2)              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded for this Profile IF CORE 41/2 “LE Core Configuration”.
+- C.2: Excluded for this Profile.
+- C.3: Mandatory for this Profile.
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
++ Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_1_1     | x        | Device A (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_1_2     | x        | Device B (C.1)                               |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Support of SPP Service
+======================
+**Table 2: Serial Port Service Support**
+
++------------------+----------+----------------------------------------------+
++ Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_2_1     | x        | Support of SPP as a standalone profile (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_2_1a    | x        | SPP as a standalone profile - Device A (C.2, |
+|                  |          | C.3)                                         |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_2_1b    | x        | SPP as a standalone profile - Device B (C.2, |
+|                  |          | C.4)                                         |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.2: Mandatory to support at least one IF SPP 2/1 “Support of SPP as a*
+  standalone profile”, otherwise Excluded.
+- C.3: Optional IF SPP 1/1 “Device A”, otherwise Excluded.
+- C.4: Optional IF SPP 1/2 “Device B”, otherwise Excluded.
+
+Application Procedures
+======================
+**Table 3: Application Procedures**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_3_1     | x        | Establish link and set up virtual serial     |
+|                  |          | connection (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_3_2     | x        | Accept link and virtual serial connection    |
+|                  |          | establishment (C.2)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_3_3     | x        | Register Service record for application in   |
+|                  |          | local SDP database (C.3)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_3_4     |          | No release in Sniff mode. Sniff mode enabled |
+|                  |          | in the Link Manager (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_3_5     |          | No release in Hold mode. Hold mode enabled   |
+|                  |          | in the Link Manager (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_3_7     |          | No release after Master/Slave switch. M/S    |
+|                  |          | switch enabled in the Link Manager (O)       |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF SPP 1/1 “Device A”, otherwise Optional.
+- C.2: Mandatory IF SPP 1/2 “Device B”, otherwise Optional.
+- C.3: Mandatory IF SPP 2/1b “SPP as a standalone profile – Device B”,
+  otherwise Optional.
+
+Service Discovery Protocol
+==========================
+**Table 4: SDP Dependencies**
+Prerequisite: SPP 2/1b “SPP as a standalone profile – Device B”
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SPP_4_1     | x        | ServiceClassIDList (M)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_4_2     | x        | ProtocolDescriptorList (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_4_5     | x        | ServiceName (O)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_SPP_4_6     | x        | BluetoothProfileDescriptorList (M)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Note: If more than one Serial Port Profile Service is available, more than one
+SerialPort SDP record can be registered
diff --git a/doc/qualification/spp-pts.rst b/doc/qualification/spp-pts.rst
new file mode 100644
index 000000000..8fd995d18
--- /dev/null
+++ b/doc/qualification/spp-pts.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+SPP test results
+================
+
+:PTS version: 8.5.2 Build 5
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+Tests
+=====
+
+The kernel and BlueZ versions represent the oldest version without backport
+for which we know the test passed.
+
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| Test name                    | Result   | Kernel  | BlueZ |                                                                         |
++==============================+==========+=========+=======+=========================================================================+
+| SPP/DEVA/APP/BV-01-C         | PASS     |     6.1 | 5.69  | Run 'rctest -n -U spp <BD_ADDR>' before starting the test               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Kill rctest upon request                                                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SPP/DEVB/APP/BV-02-C         | PASS     |     6.1 | 5.69  | Run 'python ./test-profile -u spp -s -C 10'                             |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/SPP-DEVA/SFC/BV-24-I | PASS     |     6.1 | 5.69  | Remove PTS device from Bluetooth devices                                |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Run 'rctest -n -U spp <BD_ADDR>'                                        |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Kill rctest upon request                                                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

