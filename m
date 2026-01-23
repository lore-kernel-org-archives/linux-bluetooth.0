Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367F33E7
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186865; cv=none; b=nN82rUjYvSVTyFuAJNliHHgGCm8MvC9dTNpdlVn1gOOGrQ0pfEREqomQNFL4SdavlysY2OdWOYyBn+JjlwIEELuXqIyJob89lwpGhmzzBY8EfBHZldfs0/RtI/f2oyFBFM9+shAzXnxFyKKIH1Jaod5/aMOQZ3mJ3VCCjSnzUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186865; c=relaxed/simple;
	bh=+Yf8/n2Kb1mZgcOzQeL7cAj430cqUiyF3qJw3cPtQiE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sy2ZBuecQSkpuBtI2egKCeQVnphQKrVPuGMJ72MT7aN7ODKK7rlD7HeoqEoJ1CHvvuEMUjm3DP3r+mOqiSyidLOc64UGYGHXQwyQJUKKsl8+2TXoDZ5ZY8PdFTQX43zn6wOd/jYQ0u9oS2k/otqWopREx0D1UKSpWm8t0RI7ZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d5cxAZxl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d5cxAZxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769186858;
	bh=+Yf8/n2Kb1mZgcOzQeL7cAj430cqUiyF3qJw3cPtQiE=;
	h=From:To:Subject:Date:From;
	b=d5cxAZxlF4bSJk4dfjeY1wOIaoAb8s5/NMCEFSxjbi+hvlWsD3aFNTAltjH7UURDH
	 8NfON6GgIPnHa6oKhrCXbKPOzlu7fldYYXSOgSl4L7Adw5AzjNhS9c3Qj0qZ5MrMiq
	 iY6onDx0SMqvtaa3oiuTtHunQGv/rDssb5Nyyjol+hdlVGEqs5aeCZhBnOcxAWn/M1
	 T+fbd3+B005xZao20aUtg3tBrffki0fcPma4Q9PssOkMyA3hgp6uIupOR9QHkPExab
	 fvqTIbzhAjfu4cIYFsDJzRanllYj3Ex6E359e3eRxnLirazGkw54GBcpGcewEH0CXk
	 UlE9M+ZzPSCOQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-0A83-3Cb6-e898-A29D.rev.sfr.net [IPv6:2a02:8428:af44:1001:a83:3cb6:e898:a29d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 204DA17E01E7
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 17:47:38 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] doc/qualification: Add PICS and howto for the SM qualification
Date: Fri, 23 Jan 2026 17:47:33 +0100
Message-ID: <20260123164733.855824-1-frederic.danis@collabora.com>
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
v1->v2: Fix trailing whitespace

 doc/qualification/sm-pics.rst | 205 +++++++++
 doc/qualification/sm-pts.rst  | 806 ++++++++++++++++++++++++++++++++++
 2 files changed, 1011 insertions(+)
 create mode 100644 doc/qualification/sm-pics.rst
 create mode 100644 doc/qualification/sm-pts.rst

diff --git a/doc/qualification/sm-pics.rst b/doc/qualification/sm-pics.rst
new file mode 100644
index 000000000..cbf375a03
--- /dev/null
+++ b/doc/qualification/sm-pics.rst
@@ -0,0 +1,205 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+Security Manager
+================
+(TCRL 2023-1, SM.ICS.p11)
+
+Roles and versions
+==================
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_1_1      | x        | Central Role (Initiator) (C.1)               |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_1_2      | x        | Peripheral Role (Responder) (C.1)            |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one of SM 1/1 "Central Role (Initiator)"
+  OR SM 1/2 "Peripheral Role (Responder)".
+
+Security properties
+===================
+**Table 2: Security Properties**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_2_1      | x        | Authenticated MITM protection (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_2_2      | x        | Unauthenticated no MITM protection (C.1)     |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_2_3      | x        | No security requirements (M)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_2_4      |          | OOB supported (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_2_5      | x        | LE Secure Connections (O)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF SM 2/1 "Authenticated MITM protection",
+  otherwise Optional.
+
+Pairing algorithms
+==================
+**Table 3: Encryption Key Size**
+
+Prerequisite: SM 2/1 "Authenticated MITM protection" OR
+SM 2/2 "Unauthenticated no MITM protection" OR SM 2/4 "OOB supported"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_3_1      | x        | Encryption Key Size (M)                      |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Pairing algorithms
+==================
+**Table 4: Pairing Method**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_4_1      | x        | Just Works (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_4_2      | x        | Passkey Entry (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_4_3      |          | Out of Band (C.1)                            |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory to support at least one of SM 4/2 "Passkey Entry" OR
+  SM 4/3 "Out of Band" IF SM 2/1 "Authenticated MITM protection",
+  otherwise Excluded.
+
+Key distribution and usage
+==========================
+**Table 5: Security Initiation**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_5_1      | x        | Encryption Setup using STK (C.3)             |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_5_2      | x        | Encryption Setup using LTK (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_5_3      | x        | Peripheral Initiated Security (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_5_4      | x        | Peripheral Initiated Security - Central      |
+|                  |          | response (C.2)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_5_5      |          | CT2 bit (C.4)                                |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF SM 1/2 "Peripheral Role (Responder)", otherwise Excluded.
+- C.2: Mandatory IF SM 1/1 "Central Role (Initiator)", otherwise Excluded.
+- C.3: Mandatory IF SM 2/1 "Authenticated MITM protection" OR
+  SM 2/2 "Unauthenticated no MITM protection" OR SM 2/4 "OOB supported",
+  otherwise Excluded.
+- C.4: Excluded IF NOT SM 8a/1 "Cross Transport Key Derivation Supported"
+  AND NOT SM 8b/1 "Cross Transport Key Derivation Supported", otherwise
+  Mandatory IF NOT SUM ICS 31/17 "Core v4.2" AND NOT SUM ICS 31/18
+  "Core v4.2+HS", otherwise Optional.
+
+Key distribution and usage
+==========================
+**Table 6: Signing Algorithm**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_6_1      |          | Signing Algorithm - Generation (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_6_2      |          | Signing Algorithm - Resolving (O)            |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+Key distribution and usage
+==========================
+**Table 7a: Key Distribution by Central**
+
+Prerequisite: SM 1/1 "Central Role (Initiator)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_7a_1     | x        | Encryption Key (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_7a_2     | x        | Identity Key (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_7a_3     |          | Signing Key (O)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+Key distribution and usage
+==========================
+**Table 7b: Key Distribution by Peripheral**
+
+Prerequisite: SM 1/2 "Peripheral Role (Responder)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_7b_1     | x        | Encryption Key (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_7b_2     | x        | Identity Key (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_7b_3     | x        | Signing Key (O)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+Key distribution and usage
+==========================
+**Table 8a: Cross-Transport Key Derivation by Central**
+
+Prerequisite: SM 1/1 "Central Role (Initiator)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_8a_1     |          | Cross Transport Key Derivation Supported     |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_8a_2     |          | Derivation of LE LTK from BR/EDR Link Key    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_8a_3     |          | Derivation of BR/EDR Link Key from LE LTK    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF SM 2/5 "LE Secure Connections", otherwise Excluded.
+- C.2: Optional IF SM 8a/1 "Cross Transport Key Derivation Supported",
+  otherwise Excluded.
+
+Key distribution and usage
+==========================
+**Table 8b: Cross-Transport Key Derivation by Peripheral**
+
+Prerequisite: SM 1/2 "Peripheral Role (Responder)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SM_8b_1     |          | Cross Transport Key Derivation Supported     |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_8b_2     |          | Derivation of LE LTK from BR/EDR Link Key    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_SM_8b_3     |          | Derivation of BR/EDR Link Key from LE LTK    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF SM 2/5 "LE Secure Connections", otherwise Excluded.
+- C.2: Optional IF SM 8b/1 "Cross Transport Key Derivation Supported",
+  otherwise Excluded.
diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
new file mode 100644
index 000000000..87fb0d7b6
--- /dev/null
+++ b/doc/qualification/sm-pts.rst
@@ -0,0 +1,806 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+===============
+SM test results
+===============
+
+:PTS version: 8.5.4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- In IXIT update "TSPX_iut_device_name_in_adv_packet_for_random_address" to
+  the IUT name
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
+| SM/CEN/PROT/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/JW/BV-05-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | 'Restart the wizard' on further connection requests                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/JW/BI-04-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/JW/BI-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/PKE/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/PKE/BV-04-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/PKE/BI-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/PKE/BI-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/OOB/BV-05-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/OOB/BV-07-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/EKS/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | On connection request, re-connect to PTS                                |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/EKS/BI-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | On connection request, re-connect to PTS                                |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/KDU/BV-05-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Enable privacy mode:                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power off'                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt privacy on'                                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power on'                                               |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Disable privacy mode:                                                 |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power off'                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt privacy off'                                            |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power on'                                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/KDU/BV-06-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | On connection request, re-connect to PTS                                |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/KDU/BV-10-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Enable privacy mode:                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power off'                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt privacy on'                                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power on'                                               |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Disable privacy mode:                                                 |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power off'                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt privacy off'                                            |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt power on'                                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/KDU/BI-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SIP/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCJW/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCJW/BV-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCJW/BI-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCPK/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run bluetoothctl                                                      |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - '[bluetooth]# agent off'                                            |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - '[bluetooth]# agent DisplayOnly'                                    |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCPK/BV-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCPK/BI-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection requests perform pairing with PTS                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Discard pairing dialog                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/CEN/SCPK/BI-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run bluetoothctl                                                      |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - '[bluetooth]# agent off'                                            |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - '[bluetooth]# agent DisplayOnly'                                    |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On connection request perform pairing with PTS                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | Disconnect on disconnection request                                     |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PROT/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/JW/BV-02-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/JW/BI-03-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/JW/BI-02-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PKE/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt                                                         |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PKE/BV-05-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - l2test -r -J4 -AES -V le_public                                     |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PKE/BI-03-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt                                                         |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/OOB/BV-06-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/OOB/BV-08-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/EKS/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/EKS/BI-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-02-C   | PASS     |     6.9 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# mgmt.privacy on                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power on                                               |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# advertise.name on                                      |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# mgmt.privacy off                                       |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power on                                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-03-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-07-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-08-C   | PASS     |     6.9 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# mgmt.privacy on                                        |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power on                                               |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# advertise.name on                                      |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# mgmt.privacy off                                       |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - [bluetooth]# power on                                               |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BV-09-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BI-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BI-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BI-03-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SIP/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | On request run:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - btmgmt pair -c 0x03 -t 0x01 <addr>                                    |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SIE/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt io-cap 3                                                |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCJW/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCJW/BV-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCJW/BI-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCPK/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCPK/BV-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |     - [mgmt]# io-cap 0                                                  |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCPK/BI-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - sudo btmgmt                                                         |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/SCPK/BI-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

