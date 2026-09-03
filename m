Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FC38398E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420605; cv=none; b=J8CVopy9tG6Bs3ECbf3hhvzfxlvJz4kDgVRjlS9IXxur2FlvPHViaiQnO8/mccjTPXD3TILSKbJplyjjEgkjxjoYvW7BDtTCGFtx5bSDYgodk7o06iPAzZccqdCtDTAZdeL5w/PjPs1pdRakuITd0YYxY+wWbByzdC/VM7CayHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420605; c=relaxed/simple;
	bh=jUCNYwgaBKLD/36mcLbduSKiiDlp47I/k5hwXXhkh/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SeJDQKR7hZ5o1zcsLO4Ag67I4zZfWHAYpdWdYwS9kyQTx5lSqYuQseIhk3TmfVEfZIyR8/nTlQ7339PkFFhP3ziLTD5Z3KjYoj5Cbc9WoJ0v9bR2e6Vhtvw58rWgGBE1vcj0cQWwOqmKBFSlc2iyl5NoOF+wfWzo3siNS6Hysdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JoRXqlwY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JoRXqlwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788420594;
	bh=jUCNYwgaBKLD/36mcLbduSKiiDlp47I/k5hwXXhkh/0=;
	h=From:To:Subject:Date:From;
	b=JoRXqlwYnhYdlIHzhw16Wqo1JH6RZDUux4aqzKWQvrXelnUId55eNEv23FIyxhtmb
	 qJCXzHRF1RtEHKCL+ANtTIJb4Z9JxseMrBu0oWm9aLqFxSgSVghsw4vDGIso6upMb1
	 uy5WvZYNqMgkhgpixi6frkE02hkHpe5+b1XgAzZvCKvZlFfRZD7TPIg/5jBjh1Ibcj
	 SAnAkfgmKAyzM8Dmmkh48JO21UuQV5Lyd+mgkgvYdILSiYCFz7XsWZbtxnVzK+3bCr
	 6cmYnrO4tftuQegmXJEi4SZjYiuBoLUnw+p+og1EKaoLrwgxjZYoPNstRKGYfk026k
	 rMjqdWE30SJHA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E04A17E03E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 09:29:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/qualification: Add ASCS PICS file
Date: Thu,  3 Sep 2026 09:29:47 +0200
Message-ID: <20260903072948.719744-1-frederic.danis@collabora.com>
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
 doc/qualification/ascs-pics.rst | 203 ++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 doc/qualification/ascs-pics.rst

diff --git a/doc/qualification/ascs-pics.rst b/doc/qualification/ascs-pics.rst
new file mode 100644
index 000000000..072123667
--- /dev/null
+++ b/doc/qualification/ascs-pics.rst
@@ -0,0 +1,203 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Collabora Ltd.
+
+============================
+Audio Stream Control Service
+============================
+(TCRL pkg103, ASCS.ICS.p5)
+
+Versions
+========
+
+**Table 0: X.Y Versions**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_0_1    | x        | ASCS v1.0 (M)                                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 1: X.Y.Z Versions**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_1_1    |          | ASCS v1.0.1 (O)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+Transports
+==========
+
+**Table 2: Transport Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_2_1    |          | Service supported over BR/EDR (C.1, C.3)     |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_2_2    | x        | Service supported over LE (C.2, C.3)         |
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded for this Service IF CORE 41/2 "LE Core Configuration" OR CORE
+  40/1 "Core-Controller".
+- C.2: Excluded for this Service IF CORE 41/1 "BR/EDR Core Configuration" OR
+  CORE 40/1 "Core-Controller".
+- C.3: Mandatory to support at least one.
+
+Features
+========
+
+**Table 3: Included Services**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_3_1    | x        | Published Audio Capabilities Service (M)     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+**Table 4: Features**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_4_1    |          | Support Multiple ASEs (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_4_2    |          | Support Multiple Sink ASEs (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_4_3    |          | Support Multiple Source ASEs (C.2)           |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF ASCS 4/1 "Support Multiple ASEs" AND ASCS 5/1 "Sink ASE
+  characteristic", otherwise Excluded.
+- C.2: Optional IF ASCS 4/1 "Support Multiple ASEs" AND ASCS 5/2 "Source ASE
+  characteristic", otherwise Excluded.
+
+**Table 5: Included Characteristics**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_5_1    | x        | Sink ASE characteristic (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_5_2    | x        | Source ASE characteristic (C.1)              |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_5_3    | x        | ASE Control Point characteristic (M)         |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory to support at least one.
+
+**Table 6: ASE Control Operations**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_6_1    | x        | Config Codec (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_2    | x        | Config QoS (M)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_3    | x        | Enable (M)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_4    | x        | Receiver Start Ready (M)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_5    | x        | Disable (M)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_6    | x        | Receiver Stop Ready (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_7    | x        | Update Metadata (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_8    | x        | Release (M)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_6_9    | x        | Released (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF ASCS 5/2 "Source ASE characteristic", otherwise Excluded.
+
+**Table 7: Server-Initiated ASE Control Operations**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_7_1    |          | Autonomous Config Codec (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_7_2    | x        | Autonomous Receiver Start Ready (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_7_3    |          | Autonomous Disable (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_7_4    |          | Autonomous Update Metadata (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_7_5    |          | Autonomous Release (O)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+**Table 8: ASE State Transitions**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_8_1    | x        | Released transition to Codec Configured state|
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_8_2    | x        | Released transition to Idle state (C.1)      |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+GATT requirements
+=================
+
+**Table 9: GATT Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_9_1    | x        | Write Without Response (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_2    | x        | Write Characteristic Value (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_3    | x        | Write Long Characteristic Value (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_4    | x        | Single Notification (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_5    | x        | Read Characteristic Descriptor (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_6    | x        | Write Characteristic Descriptor (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_7    |          | Enhanced ATT bearer (BR/EDR or LE) (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_8    |          | GATT Server over BR/EDR (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_ASCS_9_9    | x        | GATT Server over LE (C.2)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF ASCS 2/1 "Service supported over BR/EDR", otherwise not
+  defined.
+- C.2: Mandatory IF ASCS 2/2 "Service supported over LE", otherwise not
+  defined.
+
+SDP requirements
+================
+
+**Table 10: SDP Requirements**
+
+Prerequisite: ASCS 2/1 "Service supported over BR/EDR"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_ASCS_10_1   |          | SDP record present for ASCS (M)              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
-- 
2.43.0

