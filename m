Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555F49C4AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340593; cv=none; b=qiDq+FS8S5n+t4OqhoeOqqjco2Ip5FCHPoiLegkDFbg0iOI93MO8QhengWXJJmnBThNa/UrtJazCpOYfi81eavmthLXnp6ToD0aOdvvzydJOclyeON6YmlqD+0/51jjDjF+6y8PS7ojZpJJsC0oYUsRBj0apzyvQbr5W+ahzSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340593; c=relaxed/simple;
	bh=aYS3YmxDjWUBZ/yJ38WqQSl6cZ9DW7dKKkftnZeBTUg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZdpyQRhH29zxVuXgnfR/lpzpl1mgjguxJFbNAhZHmmzj98B4YR/sn26vs6T3m9a050ZD7OowILqoYcpXCNIHCh4VEMSw6i8goceKfqLM6wTvyg4Vczq/tVoNiw8tSuD1M1153dTbSHWpC0Rg8WWnWzNPxZxPeVDVDsgBIlAvDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CVVysbX/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CVVysbX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790340587;
	bh=aYS3YmxDjWUBZ/yJ38WqQSl6cZ9DW7dKKkftnZeBTUg=;
	h=From:To:Subject:Date:From;
	b=CVVysbX/WxgAYIbv/87xkrQtryoqVXSfjdNK+bXlhyZfTnB7FLhPUEry6zElosJq8
	 fzDFkcN3hQV82TCpAeQGnQjxyfH47fCPu6jqGC9i6QTiKdawXKOH+K354gJi3advzN
	 Dd29ks/PgLMLL0wknXUC+OpcZghfKlKIzRXIQ8rZio2UBTriZhlgoLHX/iLJ3RCyCp
	 +0DiTdKC0pEYfEtSyF78HjCrJkBF8zZMrfuPGWhT3q+4lULdMXiAhZok8ts5AY9uGK
	 jEPi2ELTfHfV/6FvvrK7+Kd4xZER4xsMxxkgqaXu/rnBaaUtyOCgjTb9w9Hb6CvhVt
	 PuKJ3zRVGP74g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C9A9C17E05F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:49:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/qualification: Add MCP/MCS PICS files
Date: Fri, 25 Sep 2026 14:49:41 +0200
Message-ID: <20260925124942.3347628-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 doc/qualification/mcp-pics.rst | 569 +++++++++++++++++++++++++++++++++
 doc/qualification/mcs-pics.rst | 513 +++++++++++++++++++++++++++++
 2 files changed, 1082 insertions(+)
 create mode 100644 doc/qualification/mcp-pics.rst
 create mode 100644 doc/qualification/mcs-pics.rst

diff --git a/doc/qualification/mcp-pics.rst b/doc/qualification/mcp-pics.rst
new file mode 100644
index 000000000..dc7503410
--- /dev/null
+++ b/doc/qualification/mcp-pics.rst
@@ -0,0 +1,569 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+=====================
+Media Control Profile
+=====================
+(TCRL pkg103, MCP.ICS.p4)
+
+Roles
+=====
+
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_1_1     | x        | Media Control Server (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_1_2     |          | Media Control Client (C.1)                   |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Transports
+==========
+
+**Table 2: Transport Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_2_1     |          | Profile supported over BR/EDR (C.1, C.3)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_2_2     | x        | Profile supported over LE (C.2, C.3)         |
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded for this Profile IF CORE 41/2 "LE Core Configuration" OR CORE
+  40/1 "Core-Controller".
+- C.2: Excluded for this Profile IF CORE 41/1 "BR/EDR Core Configuration" OR
+  CORE 40/1 "Core-Controller".
+- C.3: Mandatory to support at least one.
+
+Media Control Server role
+=========================
+
+**Table 3: X.Y Versions (Media Control Server)**
+
+Prerequisite: MCP 1/1 "Media Control Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_3_1     | x        | MCP v1.0 (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 5: Service Requirements**
+
+Prerequisite: MCP 1/1 "Media Control Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_5_1     |          | Media Control Service (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_5_2     | x        | Generic Media Control Service (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_5_3     |          | Object Transfer Service (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_5_4     | x        | LE Extended Advertising (M)                  |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+**Table 6: GAP Requirements (Media Control Server Role)**
+
+Prerequisite: MCP 1/1 "Media Control Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_6_1     | x        | LE security mode 1 (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_2     | x        | Bondable mode (LE) (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_3     | x        | Bonding procedure (LE) (C.1)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_4     | x        | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) with LE Secure Connections Pairing  |
+|                  |          | only (C.6)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_5     | x        | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) with LE Secure Connections Pairing  |
+|                  |          | only (C.6)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_6     | x        | LE security mode 1 level 4 (C.6)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_7     | x        | Minimum 128 Bit entropy key (LE) (C.3)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_8     | x        | Derivation of LE LTK from BR/EDR Link Key    |
+|                  |          | (C.8)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_9     |          | Security mode 4, level 2 (C.2)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_10    |          | 128-bit encryption key size capable (BR/EDR) |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_11    |          | Derivation of BR/EDR Link Key from LE LTK    |
+|                  |          | (C.7)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_12    |          | BR/EDR Secure Connections (C.7)              |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_13    | x        | LE Secure Connections (C.8)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_14    |          | Out of Band (LE) (C.8)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_6_15    |          | Out-of-Band (BR/EDR) (C.7)                   |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF MCP 2/2 "Profile supported over LE", otherwise not
+  defined.
+- C.2: Mandatory IF MCP 2/1 "Profile supported over BR/EDR", otherwise not
+  defined.
+- C.3: Mandatory IF MCP 6/4 "Unauthenticated Pairing (LE security mode 1
+  level 2) with LE Secure Connections Pairing only" OR MCP 6/5 "Authenticated
+  Pairing (LE security mode 1 level 3) with LE Secure Connections Pairing
+  only", otherwise not defined.
+- C.6: Mandatory to support at least one IF MCP 2/2 "Profile supported over
+  LE", otherwise not defined.
+- C.7: Mandatory to support at least one IF MCP 2/1 "Profile supported over
+  BR/EDR", otherwise not defined.
+- C.8: Mandatory to support at least one IF MCP 2/2 "Profile supported over
+  LE", otherwise not defined.
+
+**Table 8: OTP Requirements (Media Control Server)**
+
+Prerequisite: MCP 5/3 "Object Transfer Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_8_1     |          | Object Server (M)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 9: OTS Characteristics Requirements (Media Control Server)**
+
+Prerequisite: MCP 5/3 "Object Transfer Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_9_1     |          | Object ID Characteristic (M)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_9_2     |          | Object List Control Point (OLCP) (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_9_3     |          | Object Changed Characteristic (M)            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 10: OTS Feature Requirements (Media Control Server)**
+
+Prerequisite: MCP 5/3 "Object Transfer Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_10_1    |          | OACP Read Procedure (M)
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_10_2    |          | OLCP Go To Procedure (M)
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Media Control Client role
+=========================
+
+**Table 11: X.Y Versions (Media Control Client)**
+
+Prerequisite: MCP 1/2 "Media Control Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_11_1    |          | MCP v1.0 (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 13: Media Control Service Support**
+
+Prerequisite: MCP 1/2 "Media Control Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_13_1    |          | Discover Media Control Service (C.1)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_13_2    |          | Discover Generic Media Control Service (C.1) |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_13_3    |          | Discover Object Transfer Service (C.2)       |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+- C.2: Mandatory IF MCP 14/20 "Search Results Object ID Characteristic" OR
+  MCP 16/20 "Search Results Object ID Characteristic" OR MCP 14/10 "Current
+  Track Segments Object ID Characteristic" OR MCP 16/10 "Current Track
+  Segments Object ID Characteristic" OR MCP 14/11 "Current Track Object ID
+  Characteristic" OR MCP 16/11 "Current Track Object ID Characteristic",
+  otherwise Optional.
+
+**Table 14: Media Control Service Characteristic Support Requirements**
+
+Prerequisite: MCP 13/1 "Discover Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_14_1    |          | Media Player Name Characteristic (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_2    |          | Media Player Icon Object ID Characteristic   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_3    |          | Media Player Icon URL Characteristic (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_4    |          | Track Changed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_5    |          | Track Title Characteristic (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_6    |          | Track Duration Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_7    |          | Track Position Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_8    |          | Playback Speed Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_9    |          | Seeking Speed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_10   |          | Current Track Segments Object ID             |
+|                  |          | Characteristic (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_11   |          | Current Track Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_12   |          | Next Track Object ID Characteristic (O)      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_13   |          | Parent Group Object ID Characteristic (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_14   |          | Current Group Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_15   |          | Playing Order Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_16   |          | Playing Order Supported Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_17   |          | Media State Characteristic (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_18   |          | Media Control Point Characteristic (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_19   |          | Media Control Point Opcodes Supported        |
+|                  |          | Characteristic (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_20   |          | Search Results Object ID Characteristic (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_21   |          | Search Control Point Characteristic (C.1)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_14_22   |          | Content Control ID Characteristic (O)        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF MCP 14/20 "Search Results Object ID Characteristic",
+  otherwise Excluded.
+
+**Table 15: Media Control Point Procedure Requirements**
+
+Prerequisite: MCP 14/18 "Media Control Point Characteristic"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_15_1    |          | Play Current Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_2    |          | Pause Current Track Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_3    |          | Fast Forward Fast Rewind Procedure (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_4    |          | Stop Current Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_5    |          | Move Relative Procedure (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_6    |          | Move to Previous Segment Procedure (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_7    |          | Move to Next Segment Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_8    |          | Move to First Segment Procedure (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_9    |          | Move to Last Segment Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_10   |          | Move to Segment Number Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_11   |          | Move to Previous Track Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_12   |          | Move to Next Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_13   |          | Move to First Track Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_14   |          | Move to Last Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_15   |          | Move to Track Number Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_16   |          | Move to Previous Group Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_17   |          | Move to Next Group Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_18   |          | Move to First Group Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_19   |          | Move to Last Group Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_15_20   |          | Move to Group Number Procedure (O)           |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+**Table 16: Generic Media Control Service Characteristic Support Requirements**
+
+Prerequisite: MCP 13/2 "Discover Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_16_1    |          | Media Player Name Characteristic (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_2    |          | Media Player Icon Object ID Characteristic   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_3    |          | Media Player Icon URL Characteristic (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_4    |          | Track Changed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_5    |          | Track Title Characteristic (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_6    |          | Track Duration Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_7    |          | Track Position Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_8    |          | Playback Speed Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_9    |          | Seeking Speed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_10   |          | Current Track Segments Object ID             |
+|                  |          | Characteristic (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_11   |          | Current Track Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_12   |          | Next Track Object ID Characteristic (O)      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_13   |          | Parent Group Object ID Characteristic (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_14   |          | Current Group Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_15   |          | Playing Order Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_16   |          | Playing Order Supported Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_17   |          | Media State Characteristic (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_18   |          | Media Control Point Characteristic (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_19   |          | Media Control Opcodes Supported              |
+|                  |          | Characteristic (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_20   |          | Search Results Object ID Characteristic (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_21   |          | Search Control Point Characteristic (C.1)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_16_22   |          | Content Control ID Characteristic (O)        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF MCP 16/20 "Search Results Object ID Characteristic",
+  otherwise Excluded.
+
+**Table 17: Media Control Point Procedure Requirements**
+
+Prerequisite: MCP 16/18 "Media Control Point Characteristic"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_17_1    |          | Play Current Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_2    |          | Pause Current Track Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_3    |          | Fast Forward Fast Rewind Procedure (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_4    |          | Stop Current Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_5    |          | Move Relative Procedure (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_6    |          | Move to Previous Segment Procedure (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_7    |          | Move to Next Segment Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_8    |          | Move to First Segment Procedure (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_9    |          | Move to Last Segment Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_10   |          | Move to Segment Number Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_11   |          | Move to Previous Track Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_12   |          | Move to Next Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_13   |          | Move to First Track Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_14   |          | Move to Last Track Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_15   |          | Move to Track Number Procedure (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_16   |          | Move to Previous Group Procedure (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_17   |          | Move to Next Group Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_18   |          | Move to First Group Procedure (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_19   |          | Move to Last Group Procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_17_20   |          | Move to Group Number Procedure (O)           |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+**Table 18: GAP Requirements (Media Control Client)**
+
+Prerequisite: MCP 1/2 "Media Control Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_18_2    |          | LE security mode 1 (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_3    |          | Bondable mode (LE) (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_4    |          | Bonding procedure (C.1)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_5    |          | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) with LE Secure Connections Pairing  |
+|                  |          | only (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_6    |          | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) with LE Secure Connections Pairing  |
+|                  |          | only (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_7    |          | LE security mode 1 level 4 (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_8    |          | Minimum 128 Bit entropy key (LE) (C.5)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_9    |          | Derivation of LE LTK from BR/EDR Link Key    |
+|                  |          | (C.6)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_10   |          | Security mode 4, level 2 (C.2)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_11   |          | 128-bit encryption key size capable (BR/EDR) |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_12   |          | Derivation of BR/EDR Link Key from LE LTK    |
+|                  |          | (C.7)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_13   |          | BR/EDR Secure Connections (C.7)              |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_14   |          | LE Secure Connections (C.6)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_15   |          | Out of Band (LE) (C.6)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18_16   |          | Out-of-Band (BR/EDR) (C.7)                   |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF MCP 2/2 "Profile supported over LE", otherwise not
+  defined.
+- C.2: Mandatory IF MCP 2/1 "Profile supported over BR/EDR", otherwise not
+  defined.
+- C.5: Mandatory IF MCP 18/5 "Unauthenticated Pairing (LE security mode 1
+  level 2) with LE Secure Connections Pairing only" OR MCP 18/6 "Authenticated
+  Pairing (LE security mode 1 level 3) with LE Secure Connections Pairing
+  only", otherwise not defined.
+- C.6: Mandatory to support at least one IF MCP 2/2 "Profile supported over
+  LE", otherwise not defined.
+- C.7: Mandatory to support at least one IF MCP 2/1 "Profile supported over
+  BR/EDR", otherwise not defined.
+
+**Table 18a: GATT Requirements**
+
+Prerequisite: MCP 1/2 "Media Control Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_18a_1   |          | GATT Client over BR/EDR (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_2   |          | GATT Client over LE (C.2)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_3   |          | Discover All Primary Services (C.3)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_4   |          | Discover Primary Service by Service UUID     |
+|                  |          | (C.3)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_5   |          | Find Included Services (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_6   |          | Discover All Characteristics of a Service    |
+|                  |          | (C.4)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_7   |          | Discover Characteristics by UUID (C.4)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_8   |          | Discover All Characteristic Descriptors (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_9   |          | Single Notification (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_10  |          | Read Characteristic Value (M)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_11  |          | Write Characteristic Value (C.5)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_12  |          | Write Without Response (C.5)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_13  |          | Read Characteristic Descriptor (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_18a_14  |          | Write Characteristic Descriptor (M)          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF MCP 2/1 "Profile supported over BR/EDR", otherwise not
+  defined.
+- C.2: Mandatory IF MCP 2/2 "Profile supported over LE", otherwise not
+  defined.
+- C.3: Mandatory to support at least one.
+- C.4: Mandatory to support at least one.
+- C.5: Mandatory to support at least one.
+
+**Table 20: OTP Requirements (Media Control Client)**
+
+Prerequisite: MCP 13/3 "Discover Object Transfer Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_20_1    |          | Object Client (M)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 21: OTP Procedure Requirements (Media Control Client)**
+
+Prerequisite: MCP 13/3 "Discover Object Transfer Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCP_21_1    |          | Object Discovery - Discover All Objects (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_21_2    |          | Select Object - Select by Object ID (M)      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCP_21_3    |          | Read Object - Read Object Contents (M)       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
diff --git a/doc/qualification/mcs-pics.rst b/doc/qualification/mcs-pics.rst
new file mode 100644
index 000000000..4119170ad
--- /dev/null
+++ b/doc/qualification/mcs-pics.rst
@@ -0,0 +1,513 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+=====================
+Media Control Service
+=====================
+(TCRL pkg103, MCS.ICS.p5)
+
+Service support
+===============
+
+**Table 0b: Service Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_0b_1    |          | Media Control Service (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_0b_2    | x        | Generic Media Control Service (C.1)          |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+MCS versions
+============
+
+**Table 0: X.Y Versions**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_0_1     |          | MCS v1.0 (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 0a: X.Y.Z Versions**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_0a_1    |          | MCS v1.0.1 (O)                               |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+MCS transports
+==============
+
+**Table 1: Transport Requirements**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_1_1     |          | Service supported over BR/EDR (C.1, C.3)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_1_2     |          | Service supported over LE (C.2, C.3)         |
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded for this Service IF CORE 41/2 "LE Core Configuration" OR CORE
+  40/1 "Core-Controller".
+- C.2: Excluded for this Service IF CORE 41/1 "BR/EDR Core Configuration" OR
+  CORE 40/1 "Core-Controller".
+- C.3: Mandatory to support at least one.
+
+MCS Service requirements
+========================
+
+**Table 2: Media Control Service Requirements**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_2_1     |          | Media Control Service (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_2     |          | Object Transfer Service (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_3     |          | Media Player Name Characteristic (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_4     |          | Media Player Name - Read Long Support (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_5     |          | Media Player Icon Object ID Characteristic   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_6     |          | Media Player Icon URL Characteristic (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_7     |          | Track Changed Characteristic (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_8     |          | Track Title Characteristic (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_9     |          | Track Title - Read Long Support (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_10    |          | Track Duration Characteristic (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_11    |          | Track Position Characteristic (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_12    |          | Playback Speed Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_13    |          | Seeking Speed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_14    |          | Current Track Segments Object ID             |
+|                  |          | Characteristic (C.2)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_15    |          | Current Track Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_16    |          | Next Track Object ID Characteristic (C.2)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_17    |          | Parent Group Object ID Characteristic (C.2)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_18    |          | Current Group Object ID Characteristic (C.2) |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_19    |          | Playing Order Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_20    |          | Playing Order Supported Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_21    |          | Media State Characteristic (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_22    |          | Media Control Point Characteristic (M)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_23    |          | Media Control Point Opcodes Supported        |
+|                  |          | Characteristic (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_24    |          | Search Results Object ID Characteristic (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_25    |          | Search Control Point Characteristic (C.3)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_2_26    |          | Content Control ID Characteristic (M)        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF MCS 2/5 "Media Player Icon Object ID Characteristic" OR
+  MCS 2/14 "Current Track Segments Object ID Characteristic" OR MCS 2/15
+  "Current Track Object ID Characteristic" OR MCS 2/16 "Next Track Object ID
+  Characteristic" OR MCS 2/17 "Parent Group Object ID Characteristic" OR MCS
+  2/18 "Current Group Object ID Characteristic" OR MCS 2/24 "Search Results
+  Object ID Characteristic", otherwise not defined.
+- C.2: Mandatory IF MCS 2/15 "Current Track Object ID Characteristic",
+  otherwise Excluded.
+- C.3: Mandatory IF MCS 2/24 "Search Results Object ID Characteristic",
+  otherwise Excluded.
+
+**Table 3: Media Control Point Opcode Requirements**
+
+Prerequisite: MCS 2/22 "Media Control Point Characteristic"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_3_1     |          | Play (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_2     |          | Pause (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_3     |          | Fast Rewind (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_4     |          | Fast Forward (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_5     |          | Stop (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_6     |          | Move Relative (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_7     |          | Previous Segment (C.1)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_8     |          | Next Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_9     |          | First Segment (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_10    |          | Last Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_11    |          | Goto Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_12    |          | Previous Track (C.1)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_13    |          | Next Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_14    |          | First Track (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_15    |          | Last Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_16    |          | Goto Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_17    |          | Previous Group (C.1)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_18    |          | Next Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_19    |          | First Group (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_20    |          | Last Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_3_21    |          | Goto Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+**Table 4: Media State Requirements**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_4_1     |          | Play (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_4_2     |          | Pause (C.2)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_4_3     |          | Seeking (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_4_4     |          | Inactive (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF MCS 3/1 "Play", otherwise Excluded.
+- C.2: Optional IF MCS 3/2 "Pause", otherwise Excluded.
+
+MCS GATT requirements
+=====================
+
+**Table 5: GATT Requirements**
+
+Prerequisite: MCS 0b/1 "Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_5_1     |          | Write Without Response (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_5_2     |          | Single Notification (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_5_3     |          | Write Characteristic Descriptor (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_5_4     |          | Read Characteristic Descriptor (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_5_5     |          | GATT Server over BR/EDR (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_5_6     |          | GATT Server over LE (C.2)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF MCS 1/1 "Service supported over BR/EDR", otherwise not
+  defined.
+- C.2: Mandatory IF MCS 1/2 "Service supported over LE", otherwise not
+  defined.
+
+MCS SDP requirements
+====================
+
+**Table 6: SDP Requirements**
+
+Prerequisite: MCS 1/1 "Service supported over BR/EDR"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_6_1     |          | SDP record present for MCS (M)               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+GMCS versions
+=============
+
+**Table 20: X.Y Versions**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_20_1    | x        | GMCS v1.0 (M)                                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+GMCS versions
+=============
+
+**Table 20a: X.Y.Z Versions**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_20a_1   |          | GMCS v1.0.1 (O)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+GMCS transports
+===============
+
+**Table 21: Transport Requirements**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_21_1    |          | Service supported over BR/EDR (C.1, C.3)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_21_2    | x        | Service supported over LE (C.2, C.3)         |
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded for this Service IF CORE 41/2 "LE Core Configuration" OR CORE
+  40/1 "Core-Controller".
+- C.2: Excluded for this Service IF CORE 41/1 "BR/EDR Core Configuration" OR
+  CORE 40/1 "Core-Controller".
+- C.3: Mandatory to support at least one.
+
+GMCS Service requirements
+=========================
+
+**Table 22: Generic Media Control Service Requirements**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_22_1    | x        | Generic Media Control Service (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_2    |          | Object Transfer Service (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_3    | x        | Media Player Name Characteristic (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_4    |          | Media Player Name Read Long Supported (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_5    |          | Media Player Icon Object ID Characteristic   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_6    |          | Media Player Icon URL Characteristic (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_7    | x        | Track Changed Characteristic (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_8    | x        | Track Title Characteristic (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_9    |          | Track Title Read Long Supported (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_10   | x        | Track Duration Characteristic (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_11   | x        | Track Position Characteristic (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_12   |          | Playback Speed Characteristic (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_13   |          | Seeking Speed Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_14   |          | Current Track Segments Object ID             |
+|                  |          | Characteristic (C.2)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_15   |          | Current Track Object ID Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_16   |          | Next Track Object ID Characteristic (C.2)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_17   |          | Parent Group Object ID Characteristic (C.2)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_18   |          | Current Group Object ID Characteristic (C.2) |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_19   |          | Playing Order Characteristic (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_20   |          | Playing Order Supported Characteristic (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_21   | x        | Media State Characteristic (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_22   | x        | Media Control Point Characteristic (M)       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_23   | x        | Media Control Point Opcodes Supported        |
+|                  |          | Characteristic (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_24   |          | Search Results Object ID Characteristic (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_25   |          | Search Control Point Characteristic (C.3)    |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_22_26   | x        | Content Control ID Characteristic (M)        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF MCS 22/5 "Media Player Icon Object ID Characteristic" OR
+  MCS 22/14 "Current Track Segments Object ID Characteristic" OR MCS 22/15
+  "Current Track Object ID Characteristic" OR MCS 22/16 "Next Track Object ID
+  Characteristic" OR MCS 22/17 "Parent Group Object ID Characteristic" OR MCS
+  22/18 "Current Group Object ID Characteristic" OR MCS 22/24 "Search Results
+  Object ID Characteristic", otherwise not defined.
+- C.2: Mandatory IF MCS 22/15 "Current Track Object ID Characteristic",
+  otherwise Excluded.
+- C.3: Mandatory IF MCS 22/24 "Search Results Object ID Characteristic",
+  otherwise Excluded.
+
+**Table 23: Generic Media Control Point Opcode Requirements**
+
+Prerequisite: MCS 22/22 "Media Control Point Characteristic"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_23_1    | x        | Play (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_2    | x        | Pause (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_3    | x        | Fast Rewind (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_4    | x        | Fast Forward (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_5    | x        | Stop (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_6    |          | Move Relative (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_7    |          | Previous Segment (C.1)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_8    |          | Next Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_9    |          | First Segment (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_10   |          | Last Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_11   |          | Goto Segment (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_12   | x        | Previous Track (C.1)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_13   | x        | Next Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_14   |          | First Track (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_15   |          | Last Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_16   |          | Goto Track (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_17   |          | Previous Group (C.1)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_18   |          | Next Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_19   |          | First Group (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_20   |          | Last Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_23_21   |          | Goto Group (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+**Table 24: Media State Supported Requirements**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_24_1    | x        | Play (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_24_2    | x        | Pause (C.2)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_24_3    |          | Seeking (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_24_4    | x        | Inactive (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF MCS 23/1 "Play", otherwise Excluded.
+- C.2: Optional IF MCS 23/2 "Pause", otherwise Excluded.
+
+GMCS GATT requirements
+======================
+
+**Table 25: GATT Requirements**
+
+Prerequisite: MCS 0b/2 "Generic Media Control Service"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_25_1    | x        | Write Without Response (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_25_2    | x        | Single Notification (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_25_3    | x        | Write Characteristic Descriptor (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_25_4    | x        | Read Characteristic Descriptor (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_25_5    |          | GATT Server over BR/EDR (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_MCS_25_6    | x        | GATT Server over LE (C.2)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF MCS 21/1 "Service supported over BR/EDR", otherwise not
+  defined.
+- C.2: Mandatory IF MCS 21/2 "Service supported over LE", otherwise not
+  defined.
+
+GMCS SDP requirements
+=====================
+
+**Table 26: SDP Requirements**
+
+Prerequisite: MCS 21/1 "Service supported over BR/EDR"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_MCS_26_1    |          | SDP record present for GMCS (M)              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
-- 
2.43.0

