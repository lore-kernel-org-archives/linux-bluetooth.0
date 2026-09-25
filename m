Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFC446BEF
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340233; cv=none; b=KzNwCXdV5Nk5fdnqW07gANR8IeNymvA7BC449G7wwLLyrqTu8rI385yAZdnsMpZVkb2OQIut2AkxEd05WKB7GOFJ6A/qouk9EgG7Z3urR1YsbBZohr1bTiocGyWpyofE5D9BKc+vSzqFMUY03+zntSTPNq+GbZCSgVYB7EpQXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340233; c=relaxed/simple;
	bh=xlURD/J1mR3NdnqLfmcYJpkW3MM6n/3QDHL/FjEI74c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDid9l3COPxoHdZap5CFR99yw1nTp5N65RKFi6KyjaN7aUccSNvtSW6UryyRcGqPERKH35Iq5GDMythArGRyYqCLe3CSZ+zeb4TgjhjFgPiqsayWnzoCuzxDu38nIix4ZPE6+N6E0SX5pOs09971mxAzScKj31+Jk5bNk3O7Qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VgvA0oTP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VgvA0oTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790340229;
	bh=xlURD/J1mR3NdnqLfmcYJpkW3MM6n/3QDHL/FjEI74c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VgvA0oTPR4dw2z0soYYfSFbm27JnHpZRnZsHdCToJYxxjK2oS946liPu8Zl2iCAEF
	 Z7mOjKUbe9zeIdKEMd10qlMvTRThTfdpDvWbSxKuVXJYEllEOQ/y2g0/VgAlDYTCdv
	 7HYkpLPlIKBrDYgjs9BskWmC1P7zVezT0zfIlzQevxN1Qkj1sHFKMBnKoPhuD4+pib
	 s/lXsrnfTbeesS+ihXLGqLxCZGif75Wz2JCYK5o1F8L4lANqp5k3rrOpH6hgaB5MKR
	 GSkDC4DCeWSx38CAsBJ8nzisJ/sp3Q1PCJRoMiDt8FuHO5+SuWZvqpqmNjW9gCb3qv
	 BppRIsYw0en/w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 793A217E0B59
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:43:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/qualification: add VCP PTS tests documentation
Date: Fri, 25 Sep 2026 14:43:43 +0200
Message-ID: <20260925124343.3344864-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925124343.3344864-1-frederic.danis@collabora.com>
References: <20260925124343.3344864-1-frederic.danis@collabora.com>
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
 doc/qualification/vcp-pts.rst | 287 ++++++++++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 doc/qualification/vcp-pts.rst

diff --git a/doc/qualification/vcp-pts.rst b/doc/qualification/vcp-pts.rst
new file mode 100644
index 000000000..659f1a976
--- /dev/null
+++ b/doc/qualification/vcp-pts.rst
@@ -0,0 +1,287 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+================
+VCP test results
+================
+
+:PTS version: 8.12.0 Build 5
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
+| VCP/VC/CGGIT/CHA/BV-01-C     | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
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
+| VCP/VC/CGGIT/CHA/BV-02-C     | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
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
+| VCP/VC/CGGIT/SER/BV-01-C     | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| VCP/VC/SPE/BI-05-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Volume Control Point'                |
+|                              |          |        |       | to handle 0x00DA:                                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
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
+| VCP/VC/SPE/BI-06-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Volume Control Point'                |
+|                              |          |        |       | to handle 0x00DA:                                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
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
+| VCP/VC/SPE/BI-15-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Volume Control Point'                |
+|                              |          |        |       | to handle 0x00DA:                                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
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
+| VCP/VC/VCCP/BV-05-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Volume Control Point'                |
+|                              |          |        |       | to handle 0x00DA:                                                       |
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
+| VCP/VC/VCCP/BV-06-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Volume State':                        |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [GATT client]# select-attribute <handle>                              |
+|                              |          |        |       | - [GATT client]# read                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Volume Control Point'                |
+|                              |          |        |       | to handle 0x00DA:                                                       |
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
-- 
2.43.0

