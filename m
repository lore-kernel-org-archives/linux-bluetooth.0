Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B846EF64
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425861; cv=none; b=F1juloD5Vry5ltrWFEuWaaJ+6yXwlqLiFw9GF+Kkb7oXAKyrV6CX4ZAAWNrJzTyfu+lNJTA3NxaZIgIKDb34p1YuhfdauELxkEhTiCsS1/1ta4PsrgqAHIiTUBB224l/Ay7wDyx39NoBA4QSpRvaDFvouWiQJd7didnVOMu3vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425861; c=relaxed/simple;
	bh=pgeOFzcupLGGiDstzVSfkTksDu/jLNTjQAQ91cq1pNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dV9q88FetZ+3zW+ZM/DUjxu7lG78i8GA4ku8+4EVyjjrL/yys2eZT23P6x+L+0qjCA6EIYD76x+KZ525qLZm+bmys/lAvAXjLk1iBuoe6peNjQYpMnygxxx2U+P6epg+waCCqr/jUe1JLPASMO4xQsATGV4YCYlFgMeL7wHCcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qtasPrsI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qtasPrsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788425855;
	bh=pgeOFzcupLGGiDstzVSfkTksDu/jLNTjQAQ91cq1pNE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qtasPrsIJQV3gowA22po+CseoWQ2qm1OUpJxcnaS49biJhWt5hJm1eA5q3+Fa+xAg
	 cgSLh0i4zyTWjkHTpmi8G9jSPF88g3uYTpCOxULjbxNNGPsXN5OpYGzv2t2zlhqTv2
	 OuptNbnWzzxOzYV1cR3YRs5sMQ3S7HZbDXMwIwtxzeh2spNxJCgTnr+PWwkhQRgJ5w
	 4/l4WCdP7vLEAA/7posXI0dNsBMg/uCM+QSBBGw23ksFtvesVs7q52g4wid/YX9zyp
	 uWl7L/9k7W0Lzpecr6Z9waZ+kmUmNS+D+FsQFzD/oKSYP4qdE3JUb/QgTGF9gJBtiq
	 shWYHkOaUs2fA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4DA2317E07DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 10:57:35 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] doc/qualification: Add BAP/UCL tests
Date: Thu,  3 Sep 2026 10:57:15 +0200
Message-ID: <20260903085716.741578-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903085716.741578-1-frederic.danis@collabora.com>
References: <20260903085716.741578-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Raghavendra Rao Sidlagatta <raghavendra.rao@collabora.com>

---
 doc/qualification/bap-pts.rst | 778 ++++++++++++++++++++++++++++++----
 1 file changed, 694 insertions(+), 84 deletions(-)

diff --git a/doc/qualification/bap-pts.rst b/doc/qualification/bap-pts.rst
index e85c35ed4..2f81e2ad5 100644
--- a/doc/qualification/bap-pts.rst
+++ b/doc/qualification/bap-pts.rst
@@ -361,6 +361,60 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/SCC/BV-016-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.presets /local/endpoint/ep1 48_6_1              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - accept the pairing request.                                           |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart Wireplumber                                                   |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
 | BAP/UCL/SCC/BV-019-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
@@ -585,6 +639,60 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove the rule in 'wireplumber.conf.d/bluetooth.conf'                |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/SCC/BV-050-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.presets /local/endpoint/ep1 48_6_1              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - accept the pairing request.                                           |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart Wireplumber                                                   |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
 | BAP/UCL/SCC/BV-054-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
@@ -745,6 +853,60 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove the rule in 'wireplumber.conf.d/bluetooth.conf'                |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/SCC/BV-082-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.presets /local/endpoint/ep1 48_6_2              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - accept the pairing request.                                           |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart Wireplumber                                                   |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
 | BAP/UCL/SCC/BV-093-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
@@ -809,7 +971,7 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove the rule in 'wireplumber.conf.d/bluetooth.conf'                |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
-| BAP/UCL/STR/BV-535-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+| BAP/UCL/STR/BV-523-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
 |                              |          |        |       |                                                                         |
@@ -825,48 +987,40 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
-|                              |          |        |       | is set to the PTS device.                                               |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | and audio input are set to the PTS device.                              |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
-| BAP/UCL/STR/BV-543-C         | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | - Remove PTS device:                                                    |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+| BAP/UCL/STR/BV-526-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - WirePlumber is stopped                                                |
+| BAP/UCL/STR/BV-526-C_LT2     |          |        |       | - Remove PTS devices:                                                   |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - Create data file:                                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       |   - dd if=/dev/zero of=/tmp/bap.data bs=512 count=1                     |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       | - Two PTS applications are running and connected 2 dongles              |
 |                              |          |        |       +-------------------------------------------------------------------------+
 |                              |          |        |       | Run 'bluetoothctl':                                                     |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
-|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       | On demand:                                                              |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
-|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
-|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
-|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
-|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
-|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
-|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr1>                                      |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr2>                                      |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
-|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | and audio input are set to the PTS devices.                             |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-527-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
-|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
-|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
-|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
-|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
-|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
-|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# scan on                                                  |
 |                              |          |        |       |                                                                         |
@@ -874,81 +1028,250 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | After transport Desynchronized properties are displayed:                |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | - [PTS-BAP-FE56]> transport.desync \                                    |
-|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0 on                        |
-|                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
-|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0                           |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-528-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | After transport has been acquired:                                      |
+| BAP/UCL/STR/BV-528-C_LT2     |          |        |       | - Remove PTS devices:                                                   |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
-|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_source0/fd1                         |
-|                              |          |        |       | - [PTS-BAP-FE56]> transport.send \                                      |
-|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0 /tmp/bap.data             |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | Click OK on "After processed audio stream data, please click OK"        |
-|                              |          |        |       | request.                                                                |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       | - Two PTS applications are running and connected to 2 dongles           |
 |                              |          |        |       +-------------------------------------------------------------------------+
-|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
-|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       | On demand:                                                              |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - Restart Wireplumber                                                   |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr1>                                      |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr2>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
-| BAP/UCL/STR/BV-546-C         | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+| BAP/UCL/STR/BV-529-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - WirePlumber is stopped                                                |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | - Create data file:                                                     |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       |   - dd if=/dev/zero of=/tmp/bap.data bs=512 count=1                     |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
 |                              |          |        |       +-------------------------------------------------------------------------+
 |                              |          |        |       | Run 'bluetoothctl':                                                     |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
-|                              |          |        |       |   0x06                                                                  |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | .. code-block::                                                         |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
-|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
-|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
-|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
-|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
-|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
-|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
-|                              |          |        |       |   0x06                                                                  |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | .. code-block::                                                         |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
-|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
-|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
-|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
-|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
-|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
-|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
-|                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# scan on                                                  |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | On demand:                                                              |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
 |                              |          |        |       |                                                                         |
-|                              |          |        |       | After transport Desynchronized properties are displayed:                |
-|                              |          |        |       |                                                                         |
-|                              |          |        |       | - [PTS-BAP-FE56]> transport.desync \                                    |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-530-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+| BAP/UCL/STR/BV-530-C_LT2     |          |        |       | - Remove PTS devices:                                                   |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr1>                                     |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr2>                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       | - Two PTS applications are running and connected to 2 dongles           |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr1>                                      |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr2>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-535-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-537-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-538-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-543-C         | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Create data file:                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - dd if=/dev/zero of=/tmp/bap.data bs=512 count=1                     |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | After transport Desynchronized properties are displayed:                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.desync \                                    |
+|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0 on                        |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
+|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0                           |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | After transport has been acquired:                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
+|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_source0/fd1                         |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.send \                                      |
+|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_sink0/fd0 /tmp/bap.data             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on "After processed audio stream data, please click OK"        |
+|                              |          |        |       | request.                                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart Wireplumber                                                   |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-546-C         | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Create data file:                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - dd if=/dev/zero of=/tmp/bap.data bs=512 count=1                     |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | After transport Desynchronized properties are displayed:                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.desync \                                    |
 |                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_source0/fd1 on                      |
 |                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
 |                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_source0/fd1                         |
@@ -972,6 +1295,158 @@ for which we know the test passed.
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Restart Wireplumber                                                   |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-552-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-553-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-554-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-555-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-556-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-557-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-558-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-559-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
 | BAP/UCL/STR/BV-568-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
 |                              |          |        |       |                                                                         |
 |                              |          |        |       | - Remove PTS device:                                                    |
@@ -1010,3 +1485,138 @@ for which we know the test passed.
 |                              |          |        |       | If nothing occurs after connection and pairing, check that audio input  |
 |                              |          |        |       | is set to the PTS device.                                               |
 +------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-570-C         | PASS     | 6.14   | 5.87  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - WirePlumber is stopped                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep0] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep0] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep0] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep0] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep0] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb \ |
+|                              |          |        |       |   0x06                                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | .. code-block::                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Auto Accept (yes/no): y                         |
+|                              |          |        |       |   [/local/endpoint/ep1] Max Transports (auto/value): a                  |
+|                              |          |        |       |   [/local/endpoint/ep1] Locations: 1                                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Supported Context (value): 3                    |
+|                              |          |        |       |   [/local/endpoint/ep1] Context (value): 3                              |
+|                              |          |        |       |   [/local/endpoint/ep1] CIG (auto/value): 0                             |
+|                              |          |        |       |   [/local/endpoint/ep1] CIS (auto/value): 0                             |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | After transport properties are displayed:                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [PTS-BAP-FE56]> transport.acquire \                                   |
+|                              |          |        |       |   /org/bluez/hci0/dev_<BD_ADDR>/pac_source0/fd0                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | Click OK on "After processed audio stream data, please click OK"        |
+|                              |          |        |       | request.                                                                |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Post-condition:                                                         |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove local endpoints:                                               |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep0                |
+|                              |          |        |       |   - [bluetooth]# endpoint.unregister /local/endpoint/ep1                |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Restart Wireplumber                                                   |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-575-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-577-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-578-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
+| BAP/UCL/STR/BV-579-C         | PASS     | 6.14   | 5.85  | Pre-condition:                                                          |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - Remove PTS device:                                                    |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       |   - bluetoothctl remove <pts_addr>                                      |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - PipeWire And WirePlumber are running                                  |
+|                              |          |        |       +-------------------------------------------------------------------------+
+|                              |          |        |       | Run 'bluetoothctl':                                                     |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# scan on                                                  |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | On demand:                                                              |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | - [bluetooth]# connect <pts_addr>                                       |
+|                              |          |        |       |                                                                         |
+|                              |          |        |       | If nothing occurs after connection and pairing, check that audio output |
+|                              |          |        |       | is set to the PTS device.                                               |
++------------------------------+----------+--------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

