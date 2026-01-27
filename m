Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CA25785D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533901; cv=none; b=MWMItLmGpfiTeEx7Zv3UrRQ5kWjbTSRNzGhBuGDyxZmyXixZH+LdPKFQladGpJPsIKingr8FBoq1jkEL2/WdF2Zf7kpR7ZyRx5Al5/CcIR6goZX2Trqr86FM7tx3owc/un/o5W0RcbSRF2mdVHUEl4B6LJa4IA5p4A230ikJkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533901; c=relaxed/simple;
	bh=6EJiWVi9Qm80zEaKNNCF+6onj3YEtWvKNEvychXexb4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQ/WsNF24Zx8RuFuMOtF87VGIhu+QAJjrEF9KVqq0VxkS6+tMpfb988oS3mlU7fA1+Mx3tE7AU/XyS5x/KoRRU0p0qRIIWuGcybjTBnFEYWESKLoSzTmOscT6chZROytFRc0Xrfq8gDs9PfLeVWRwzgD0o/kl47nvVC0wwk7Fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QkpYOXLx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QkpYOXLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769533898;
	bh=6EJiWVi9Qm80zEaKNNCF+6onj3YEtWvKNEvychXexb4=;
	h=From:To:Subject:Date:From;
	b=QkpYOXLxxNyP7iDvPpaoy8WFEaWCCl2OjpVyvg12V5ZkIL5cFVs9XtQF1ZN6zgEr9
	 dHdUUqQZswR7HG1LgJrjJw8N2m9ThVmOMTP7s+9xDedv0RTbnXJMB9++Ik20RBqFUD
	 3Svm86KuepCW4I4DaSNX5Gg0sMFQEGkM5OJMq5w5MpAKP2tOnCA7afOnrx5GSY6OP6
	 5BzzNlgbzbfF6FC3oUiPjoXP2oyVtDmhy20RrhTY5IGPCnwhKq6xebuXzSBc+qHr7C
	 w4UfeVPaW0fUywzJnjtWBSHhKNQMGdJ4S+X4QGqfUgwAhMQlRmmvMgyxc3TacUYZqh
	 m/TxTdHYWO9HQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-871C-6E70-D798-DFc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E478817E0679
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:11:37 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the GAVDP qualification
Date: Tue, 27 Jan 2026 18:11:33 +0100
Message-ID: <20260127171133.151134-1-frederic.danis@collabora.com>
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
 doc/qualification/gavdp-pics.rst | 170 +++++++++++++++++++++++++++++++
 doc/qualification/gavdp-pts.rst  |  33 ++++++
 2 files changed, 203 insertions(+)
 create mode 100644 doc/qualification/gavdp-pics.rst
 create mode 100644 doc/qualification/gavdp-pts.rst

diff --git a/doc/qualification/gavdp-pics.rst b/doc/qualification/gavdp-pics.rst
new file mode 100644
index 000000000..b1076c800
--- /dev/null
+++ b/doc/qualification/gavdp-pics.rst
@@ -0,0 +1,170 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+========================================
+Generic Audio/Video Distribution Profile
+========================================
+(TCRL 2023-1, GAVDP.ICS.1.3.2ed3)
+
+Versions
+========
+**Table 2a: GAVDP Initiator - X.Y Versions**
+
+Prerequisite: GAVDP 1/1 "Initiator"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_2a_3| x        | GAVDP 1.3 (M)                                  |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+
+Versions
+========
+**Table 3a: GAVDP Acceptor - X.Y Versions**
+
+Prerequisite: GAVDP 1/2 "Acceptor"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_3a_3| x        | GAVDP 1.3 (M)                                  |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_1_1 | x        | Initiator (C.1)                                |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_1_2 | x        | Acceptor (C.1)                                 |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_1_3 | x        | Delay Reporting Initiator (O)                  |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_1_4 |          | Delay Reporting Acceptor (O)                   |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory to support at least one.
+
+Initiator Capabilities
+======================
+**Table 2: GAVDP Procedures (Initiator)**
+
+Prerequisite: GAVDP 1/1 "Initiator"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_2_1 | x        | Connection Establishment (M)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_2 | x        | Transfer Control - Suspend (O)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_3 |          | Transfer Control - Change Parameters (O)       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_4 | x        | Start Streaming (M)                            |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_5 | x        | Connection Release (M)                         |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_6 | x        | Signaling Control - Abort (M)                  |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_7 |          | Security Control (O)                           |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_2_8 |          | Delay Reporting (O)                            |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Initiator Capabilities
+======================
+**Table 4: AVDTP Procedures (Initiator)**
+
+Prerequisite: GAVDP 1/1 "Initiator"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_4_1 | x        | Stream discover command (M)                    |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_2 | x        | Stream get capabilities command (M)            |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_3 | x        | Set configuration command (M)                  |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_4 | x        | Open stream command (M)                        |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_5 | x        | Start stream command (M)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_6 | x        | Close stream command (M)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_7 | x        | Abort stream command (M)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_4_8 | x        | Stream get all capabilities command (M)        |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+
+Acceptor Capabilities
+=====================
+**Table 3: GAVDP Procedures (Acceptor)**
+
+Prerequisite: GAVDP 1/2 "Acceptor"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_3_1 | x        | Connection Establishment (M)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_2 | x        | Transfer Control - Suspend (O)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_3 |          | Transfer Control - Change Parameters (O)       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_4 | x        | Start Streaming (M)                            |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_5 | x        | Connection Release (M)                         |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_6 | x        | Signaling Control - Abort (M)                  |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_7 |          | Security Control (O)                           |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_3_8 |          | Delay Reporting (O)                            |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Acceptor Capabilities
+=====================
+**Table 5: AVDTP Procedures (Acceptor)**
+
+Prerequisite: GAVDP 1/2 "Acceptor"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_GAVDP_5_1 | x        | Stream discover response (M)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_2 | x        | Stream get capabilities response (M)           |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_3 | x        | Set configuration response (M)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_4 | x        | Open stream response (M)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_5 | x        | Start stream response (M)                      |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_6 | x        | Close stream response (M)                      |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_7 | x        | General reject message (M)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_8 | x        | Abort stream response (M)                      |
++----------------+----------+------------------------------------------------+
+| TSPC_GAVDP_5_9 | x        | Stream get all capabilities response (M)       |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
diff --git a/doc/qualification/gavdp-pts.rst b/doc/qualification/gavdp-pts.rst
new file mode 100644
index 000000000..7b0b7e93b
--- /dev/null
+++ b/doc/qualification/gavdp-pts.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==================
+GAVDP test results
+==================
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
+| GAVDP/ACP/APP/CON/BV-01-C    | PASS     |     6.1 | 5.69  | It may need to pair the device from IUT during the test                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAVDP/ACP/APP/TRC/BV-02-C    | PASS     |     6.1 | 5.69  | It may need to pair the device from IUT during the test                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAVDP/INT/APP/CON/BV-01-C    | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAVDP/INT/APP/TRC/BV-02-C    | PASS     |     6.1 | 5.69  | Wait for device to disconnect then connect from IUT                     |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Wait on "Suspend the streaming channel"                                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

