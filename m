Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AA49C4B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340594; cv=none; b=ewRy8SwtZGwfy+vt9rEmiWtE0BdwWdIeNixWK3Yd1iWRdrVwFI6uycfL01YUs8XyLwUwkOQ16Tjc8vWet+nHg6e09HEvO/pwiZkpci8R7rT3upQ7ZNzpFlwCWcjUtt6Ha/fPsRQwEC8im7Jk2D3bQ9DFGBJPGi7YLdbf3Z0qHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340594; c=relaxed/simple;
	bh=YY5+MU6Wdorbt1f5e8HBYj48aa287Y3wJ7fW9LIk6Yc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvKEK4CWoi47fxbGb0kH5l8B2EjQRxuBGoFpf8wzTenI3gSiglfgQved7zqgO1XmMY4kWwmbngU9bwmbJPrJ8yFyC06ONI70ufFf1BdOcCWTvfgDYWAzkOhqwACSVZacO3D742vkUYjcc5CVFrSGan5jFOmhcxerQUQxSUTD3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dImdrZfP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dImdrZfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790340587;
	bh=YY5+MU6Wdorbt1f5e8HBYj48aa287Y3wJ7fW9LIk6Yc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dImdrZfPWHhZx8dg/kqTUQMvU7Y62CmVsmI+EMhOGFwrS3YYUmcS1QgQFyo6zdHv1
	 mq6KmmQZS4Y//3EcsHa8g5aI1RXRHfkGXqY/hNUAdkgNmZA3WCvn6xj+Wyg3A293Yp
	 ulfu5d+uT5OXQA8G1PH5Kz1ACUiuEnKbo4ttnIrwcouh1o89T0wkuFIQWStOV8U28z
	 nTt6oD5b4Q1kFvV0xUP2VLmpO0kHzlbG3bxOG0E4K99OgxS7VcnHvf5+DS5b1FnpQ7
	 mIPHZDdGAaGdNAe5tqL3OoK/SE3cuGzPLiUFFioHO6sqBzQNtvSjGjc0XHJBd82yQ6
	 Rcy000s8YnawA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D33F17E06DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:49:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc/qualification: add MCS tests documentation
Date: Fri, 25 Sep 2026 14:49:42 +0200
Message-ID: <20260925124942.3347628-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925124942.3347628-1-frederic.danis@collabora.com>
References: <20260925124942.3347628-1-frederic.danis@collabora.com>
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
 doc/qualification/mcs-pts.rst | 977 ++++++++++++++++++++++++++++++++++
 1 file changed, 977 insertions(+)
 create mode 100644 doc/qualification/mcs-pts.rst

diff --git a/doc/qualification/mcs-pts.rst b/doc/qualification/mcs-pts.rst
new file mode 100644
index 000000000..9cacd3e78
--- /dev/null
+++ b/doc/qualification/mcs-pts.rst
@@ -0,0 +1,977 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+================
+MCS test results
+================
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
+| GMCS/SR/SGGIT/CHA/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-04-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-05-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-06-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-07-C    | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/SGGIT/CHA/BV-17-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-18-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-19-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/CHA/BV-22-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/SGGIT/SER/BV-01-C    | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/MCP/BV-01-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
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
+| GMCS/SR/MCP/BV-02-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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
+| GMCS/SR/MCP/BV-03-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
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
+| GMCS/SR/MCP/BV-05-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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
+| GMCS/SR/MCP/BV-06-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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
+| GMCS/SR/MCP/BV-07-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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
+| GMCS/SR/MCP/BV-08-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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
+| GMCS/SR/MCP/BV-09-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
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
+| GMCS/SR/MCP/BV-10-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
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
+| GMCS/SR/MCP/BV-30-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Ok On 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes On 'Please confirm that Current Track is the same             |
+|                              |          |        |       | or has been moved to the Previous Track after Media Control Point       |
+|                              |          |        |       | Procedure with Previous Track Opcode.'                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-31-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Ok On 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes On 'Please confirm that Current Track is the same             |
+|                              |          |        |       | or has been moved to the Previous Track after Media Control Point       |
+|                              |          |        |       | Procedure with Previous Track Opcode.'                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-33-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/MCP/BV-34-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Ok On 'Please configure that current track set to the next to the |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes On 'Please confirm that Current Track                         |
+|                              |          |        |       | has been moved to the Next Track after                                  |
+|                              |          |        |       | Procedure with Next Track Opcode.'                                      |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-35-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Ok On 'Please configure that current track set to the next to the |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click Yes On 'Please confirm that Current Track                         |
+|                              |          |        |       | has been moved to the Next Track after                                  |
+|                              |          |        |       | Procedure with Next Track Opcode.'                                      |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-37-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/MCP/BV-70-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
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
+| GMCS/SR/MCP/BV-71-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure an initial state to Inactive state'       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-72-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure an initial state to Inactive state'       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-73-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure an initial state to Inactive state'       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/MCP/BV-74-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure an initial state to Inactive state'       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/SP/BV-02-C           | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/SP/BV-03-C           | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | When PTS waits, run 'connect <pts_addr>'                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/SPE/BI-01-C          | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Reset PTS to previous configuration:                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'FALSE' in IXIT Tool window of PTS         |
+|                              |          |        |       |                                                                         |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| GMCS/SR/SPE/BI-07-C          | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
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
+| IOPT/GMCS/SR/GATTDB/BV-01-I  | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Force PTS to perform pairing:                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - Set 'TSPX_delete_ltk' to 'TRUE' in IXIT Tool window of PTS          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run Lollypop audio player and play an audio file                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Run tools/mpris-proxy in other terminal                               |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl'.                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand accept the pairing request.                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on 'Please configure that current track set to the Second      |
+|                              |          |        |       | Track'                                                                  |
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

