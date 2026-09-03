Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6158415B67
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420606; cv=none; b=J0zsx6wuj8OoG958e9V8ytzIGV6lhqeqlA3AP9ELFcfgUgRoHsJx4qX3jFtM1QTR2nZPRd1eJLt3HLy/T1bhpDi+dtCztPjAdsc0lk7pUdK2ZzSU3nXY3561DobByzV0cFiJ6kwDKcdu9vjqlm9KUAvB6pyrrCE/Ra0vUb8YX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420606; c=relaxed/simple;
	bh=ePR3U2phOXuaUXXq9v8Qjs2hX4m4h2VBe1TFgYusgss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUpVX1WACTIjZfL2kc16KwyjfZxOkZhnS35u3UWHIjmCEKDZVib1liV7/V8usdjohnlr3WKifF95N3a4FKSjk8U1YLa/ADXvfRV9t3eokH8iDwVDZLDlFDHSq9buYVcg+eFnj+5eA1kmRjBfaQq6HSVk3HaApFogdCqv4UFZSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lyZMBFTO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lyZMBFTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788420594;
	bh=ePR3U2phOXuaUXXq9v8Qjs2hX4m4h2VBe1TFgYusgss=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lyZMBFTOUBOW7oTdsgowW4l5pBGL/r7xaU4HiSXhJ6dvAi22B81dyG4obofFQdLNN
	 9q5nTudlECt0agbpvb/QCc391k2ou24hWxpvhlWCQiVaT38G4AL8122Y6VF2JG6783
	 rwMe/5FFmXWQyQk1iId0e8dXg4R+xtjW06ja2FbYZgUgR5CZkYAsbRHE/LiP1rukBr
	 TDoj+0AXz5swOBRD3X85ASmVdB/tP8iRODI9avB2hzeC2B4TB9DcW5XceytckHQ+fM
	 WjQcDvFlHN1gBR8F6swKv5oxVMW0qelqNP4+adOd4C0aD309Unx0btNXJZP8kU6TPy
	 IUYEGRoTlVbgQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C54A17E0472
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 09:29:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/qualification: add ASCS PTS tests documentation
Date: Thu,  3 Sep 2026 09:29:48 +0200
Message-ID: <20260903072948.719744-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903072948.719744-1-frederic.danis@collabora.com>
References: <20260903072948.719744-1-frederic.danis@collabora.com>
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
 doc/qualification/ascs-pts.rst | 1262 ++++++++++++++++++++++++++++++++
 1 file changed, 1262 insertions(+)
 create mode 100644 doc/qualification/ascs-pts.rst

diff --git a/doc/qualification/ascs-pts.rst b/doc/qualification/ascs-pts.rst
new file mode 100644
index 000000000..d74ed9444
--- /dev/null
+++ b/doc/qualification/ascs-pts.rst
@@ -0,0 +1,1262 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+=================
+ASCS test results
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
+| ASCS/SR/ACP/BV-01-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-02-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-03-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-04-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-05-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-06-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-08-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-09-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-10-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-11-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-12-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-13-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-14-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-17-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-18-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-19-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-20-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/ACP/BV-31-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force BlueZ to perform security repairing in                          |
+|                              |          |        |       |   '/path/to/bluetooth/main.conf'::                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     JustWorksRepairing = always                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart bluetoothd, PipeWire and WirePlumber                          |
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
+|                              |          |        |       | - Reset BlueZ to previous configuration:                                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'JustWorksRepairing' to default in                              |
+|                              |          |        |       |       '/path/to/bluetooth/main.conf'                                    |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| ASCS/SR/SGGIT/CHA/BV-01-C    | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SGGIT/CHA/BV-02-C    | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SGGIT/CHA/BV-03-C    | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SGGIT/SER/BV-01-C    | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-01-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-02-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-03-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-04-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-05-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-06-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-07-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-08-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-09-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-10-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-11-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-12-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-13-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-14-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-17-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-18-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-19-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| ASCS/SR/SPE/BI-20-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
+| IOPT/ASCS/SR/GATTDB/BV-01-I  | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Add rule to force Targeted Announcement in 'monitor.bluez.rules' of   |
+|                              |          |        |       |   'wireplumber.conf.d/announcement.conf'::                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |     monitor.bluez.properties = {                                        |
+|                              |          |        |       |       bluez5.bap-server.ascs-announcement = "targeted"                  |
+|                              |          |        |       |     }                                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart PipeWire And WirePlumber                                      |
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
-- 
2.43.0

