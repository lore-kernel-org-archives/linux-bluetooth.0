Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152E48F836
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340124; cv=none; b=uK5XFLlgzy9tek+FEXhDYWk62s9xVobKjceMNZf51DWZZgLAhKlr2EhnH9wlzkIWgleOE5iQWj6RryUU+p+rNsabnbQDYOoe9lmh8LykuPOvb4utLwIMxH5LsxYxp5MblkFlV2KUXnpv/J3CAHWWms6zTJipVgM4a0LGIk2EMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340124; c=relaxed/simple;
	bh=3jDrtViM/6pBndnrHd6kbjXhrfwaVdH+Dr2iVjnSYy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tap/QXWc+iCSiVH0APNtMlF8+KdONHw3JrMGbOUsZwN29G85frrAko74C6ONnD5/TPFDr/JIiMktaGjhBFMehHLa0wZKgO5dhhPOJvcbp9iWK7kZZWECcqs9cvveDmJi05cZnIwhjj4UnNKhvprfMz/N9p5l+E5TNxeFBORWlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BVdofFUF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BVdofFUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790340120;
	bh=3jDrtViM/6pBndnrHd6kbjXhrfwaVdH+Dr2iVjnSYy8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BVdofFUF81r1Camom6I45TTjsx2fr+2y6qUUHbch6BAMVBhcPmVM9TfTJQNR9Oij8
	 lNjViXLbLymv+bv6vYNBvB1sWgxv9XA85XcKRGEFUsKKVYv0dmp5OajkUISS0J7udU
	 yqluMlJmaJNIIur8njWOL4hTHadk+l5ZpJdR7GohgxSKagI3g6VVIEKIyKotdo9jJb
	 3cCeyLoM/+xiKU+OWOmvBb9lKztnN1uMBOhRxCCSJhNkSRiB6EgmAby3enjCaRUJvN
	 pNDmEyWzxKMGbIISlSEDCDaECLmlOjti2H2YsNcFTHY+0E8zXArrCNqskquq1ODht2
	 71qSkR/iNgDyQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0931717E0B59
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:42:00 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/qualification: add CSIP PTS tests documentation
Date: Fri, 25 Sep 2026 14:41:55 +0200
Message-ID: <20260925124155.3344025-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925124155.3344025-1-frederic.danis@collabora.com>
References: <20260925124155.3344025-1-frederic.danis@collabora.com>
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
 doc/qualification/csip-pts.rst | 483 +++++++++++++++++++++++++++++++++
 1 file changed, 483 insertions(+)
 create mode 100644 doc/qualification/csip-pts.rst

diff --git a/doc/qualification/csip-pts.rst b/doc/qualification/csip-pts.rst
new file mode 100644
index 000000000..c588f6ca3
--- /dev/null
+++ b/doc/qualification/csip-pts.rst
@@ -0,0 +1,483 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+=================
+CSIP test results
+=================
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
+| CSIP/CL/CGGIT/CHA/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+| CSIP/CL/CGGIT/CHA/BV-02-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Coordinated Set Size':                |
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
+| CSIP/CL/CGGIT/CHA/BV-03-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Set Member Lock':                     |
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
+| CSIP/CL/CGGIT/CHA/BV-04-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | On demand to read Characteristic 'Set Member Rank':                     |
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
+| CSIP/CL/CGGIT/SER/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+| CSIP/CL/SP/BV-01-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | Click YES on "Please verify that SIRK is not encrypted. Click Yes,      |
+|                              |          |        |       | if it is Plain Text otherwise click No."                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SP/BV-03-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-03-C_LT2       |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-03-C_LT3       |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to allow read-write permissions in                        |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     ExportClaimedServices = read-write                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr3>                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Three PTS applications are running and connected 3 dongles            |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d <pts_addr1>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr2>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr3>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Set Member Lock' to handle 0x0165:   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click YES on "Please verify IUT write to the Lock characteristic on PTS |
+|                              |          |        |       | in ascending order of the Rank characteristic value.                    |
+|                              |          |        |       | (LT1, LT2, LT3)."                                                       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'ExportClaimedServices' to default in                           |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SP/BV-04-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-04-C_LT2       |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-04-C_LT3       |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to allow read-write permissions in                        |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     ExportClaimedServices = read-write                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr3>                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Three PTS applications are running and connected 3 dongles            |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d <pts_addr1>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr2>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr3>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Set Member Lock' to handle 0x0165:   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click YES on "Please verify IUT write to the Lock characteristic on PTS |
+|                              |          |        |       | in descending order of the Rank characteristic value.                   |
+|                              |          |        |       | (LT1, LT2, LT3)."                                                       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'ExportClaimedServices' to default in                           |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SP/BV-06-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
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
+|                              |          |        |       | Click YES on "Please verify that decrypted SIRK is <SIRK_VALUE>.        |
+|                              |          |        |       | Click Yes, if it is Encrypted otherwise click No."                      |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SP/BV-07-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-07-C_LT2       |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SP/BV-07-C_LT3       |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr3>                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Three PTS applications are running and connected 3 dongles            |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr1>                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr2>                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr3>                                         |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on "Please create different workspaces and run this test case  |
+|                              |          |        |       | with 3 instances of PTS."                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand disconnect the PTSs.                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click YES on "Please verify the number of discovered Set Members is     |
+|                              |          |        |       | equal to 3."                                                            |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SPE/BI-01-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SPE/BI-01-C_LT2      |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+| CSIP/CL/SPE/BI-01-C_LT3      |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to allow read-write permissions in                        |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     ExportClaimedServices = read-write                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr3>                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Three PTS applications are running and connected 3 dongles            |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d <pts_addr1>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr2>                                          |
+|                              |          |        |       | - btgatt-client -d <pts_addr3>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Set Member Lock' to handle 0x0165:   |
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
+|                              |          |        |       |   - Set 'ExportClaimedServices' to default in                           |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SPE/BI-02-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to allow read-write permissions in                        |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     ExportClaimedServices = read-write                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Set Member Lock' to handle 0x0165:   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read any data:                                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'ExportClaimedServices' to default in                           |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SPE/BI-03-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to allow read-write permissions in                        |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     ExportClaimedServices = read-write                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to write Characteristic 'Set Member Lock' to handle 0x0165:   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - select-attribute <handle>                                             |
+|                              |          |        |       | - write <value that PTS expects> 0x00                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand to read any data:                                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - read                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'ExportClaimedServices' to default in                           |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| CSIP/CL/SPE/BI-04-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - btgatt-client -d  <pts_addr>                                          |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click YES on "Please confirm that IUT stopped the                       |
+|                              |          |        |       | Coordinated Set Discovery procedure. Click Yes, if stopped.             |
+|                              |          |        |       | otherwise click No."                                                    |
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

