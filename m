Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45598443E56
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340528; cv=none; b=VA8Vs+lfIHfs7P3Wga3e7uhzmGapm7YNW2xOnx0RoAfkfrg/1oay+7KwFLb1BA3InXgDnx/dwD+stx22UXtwNR10figfAgfyfSIgYNxVIGr8CzsDipI90yqUd8vyI1U+i9pho5gBEm4qbjsRmJpB/du7zbgVPi4Ns5yjqNV11vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340528; c=relaxed/simple;
	bh=VP766v8IK6GCC/2hn98nmGhoNMbNhhyE9yFbZHBAHFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ8zWfzdPsjD5aajXUEi0RXb9JeAlBTB6fn2VXhVWJ/uN2o2C2BbaNxCu5dL6vZBngsO/ZvP3SspCUJNgTsZSgleJkeiuZNs9tbAg8I2r9j9DItk5iwexOpCHcVFFkDquGOPOQhiqntRb2+VBiorRJ5q9Zcuys0Yuw7znpN0Iyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UTDxDHPu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UTDxDHPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790340524;
	bh=VP766v8IK6GCC/2hn98nmGhoNMbNhhyE9yFbZHBAHFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UTDxDHPu++vD+FyL9UvjgPZM8JhGXuhzEgoOqvcO0Tzv8f9525xNNmn1bnWb/eKaW
	 0WIyktBWKpslY3smHFhR/39Bd+z4cs+lr31JKuhS0IejLYEVeKRl3TpH//JYwcaKHp
	 X8+YttOQLVb7DaC8JyWYtICdzsYyQd18z1CZ1Ew3dqm6yA5IBIGBLdE7bt1vVy9jVB
	 1xL2WuY0znjyYnvp4ghEXrjEyiGshi4toTcjBdyJD5ZpEvV5yr+DKxEPrInyI5/8r0
	 o5k0pXo9h6D0YJYef8ydZXlgoKdrpv74NOzNoeNkkyG+w9OS/w39fXyf9aE9qWcWUg
	 apNBvQ6g22H4Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F1C517E06DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:48:44 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/qualification: add MICP tests documentation
Date: Fri, 25 Sep 2026 14:48:38 +0200
Message-ID: <20260925124838.3346980-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925124838.3346980-1-frederic.danis@collabora.com>
References: <20260925124838.3346980-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

---
 doc/qualification/micp-pts.rst | 373 +++++++++++++++++++++++++++++++++
 1 file changed, 373 insertions(+)
 create mode 100644 doc/qualification/micp-pts.rst

diff --git a/doc/qualification/micp-pts.rst b/doc/qualification/micp-pts.rst
new file mode 100644
index 000000000..647f26d6d
--- /dev/null
+++ b/doc/qualification/micp-pts.rst
@@ -0,0 +1,373 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+=================
+MICP test results
+=================
+
+:PTS version: 8.12.0 Build 6
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
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| Test name                    | Result   | Kernel | BlueZ |                                                                         |
++==============================+==========+========+=======+=========================================================================+
+| MICP/CL/CGGIT/CHA/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Mute':                                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/CGGIT/CHA/BV-02-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Audio Input State':                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/CGGIT/CHA/BV-03-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Gain Setting Properties':             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/CGGIT/SER/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes On 'Please verify that for each supported characteristic,     |
+|                              |          |        |       | attribute handle/UUID pair(s) is returned to the upper tester.Mute:     |
+|                              |          |        |       | Attribute Handle = 0x00D2.'                                             |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/CGGIT/SER/BV-02-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes on 'Please verify that for each supported characteristic,     |
+|                              |          |        |       | attribute handle/UUID pair(s) is returned to the upper tester.Audio:    |
+|                              |          |        |       | Input State: Attribute Handle = 0x00F1.'                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/CP/BV-01-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Audio Input State':                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write request to handle 0x00FC                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/SPE/BI-01-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write request to handle 0x00D2                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F1                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write request to handle 0x00D3                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/SPE/BI-02-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to Client Characteristic Configuration Descriptor             |
+|                              |          |        |       | of Audio Input State characteristic to enable notification              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - notify on                                                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00FC                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write request to handle 0x00F2                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F2                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/SPE/BI-07-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to Client Characteristic Configuration Descriptor             |
+|                              |          |        |       | of Audio Input State characteristic to enable notification              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - notify on                                                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F2                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Audio Input Control Point with the                   |
+|                              |          |        |       | Set Gain Setting Op Code value of 0x01, the Gain Setting parameters     |
+|                              |          |        |       | set to a random value greater than 100 and Change Counter parameter set |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Audio Input Control Point with the                   |
+|                              |          |        |       | Set Gain Setting Op Code value of 0x01, the Gain Setting parameters     |
+|                              |          |        |       | set to a random value less than -100 and Change Counter parameter set   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F2                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| MICP/CL/SPE/BI-08-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to Client Characteristic Configuration Descriptor             |
+|                              |          |        |       | of Audio Input State characteristic to enable notification              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - notify on                                                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F2                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write request to handle 0x00FB                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read the handle 0x00F2                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

