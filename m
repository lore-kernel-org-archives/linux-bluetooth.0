Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3F314A67
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535531; cv=none; b=acKx4nBsl1zhjwZ2kD+k5IpFzIRoWnOIKfHg1ny3fnNPA9HEyQVsJ2gVWK7chqX/tlYPthM6mkWJjsRvkPXBC73ir66kG6rvMYg1PN7eo9ZyufexIhrQ1TjtKObgUlO2m70v5okZgGiHqZGk8B0+ai6Ic8FUfIdF1zPSX21gKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535531; c=relaxed/simple;
	bh=TIjx1LcQy8SvQbvTRxOQzI0VT+iUQmgg68jIIWVNRLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTg6Ty6GQLu10O8+lpJ5l/xZMD6J2iT7uJrqF0R4NYapzzUX4Q1OGpXE+nkW0vwdq3hpydp1HHkXO+XOgna6fZ8yj2+RaqflKbB/1EBqJiCEQfSlbLNQLvHcOuddPY1OuMMLjYRHh38XiJOL1Tq5PajTGqKTUWAKFmtE9cLogjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Aegx0dmx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Aegx0dmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769535528;
	bh=TIjx1LcQy8SvQbvTRxOQzI0VT+iUQmgg68jIIWVNRLI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Aegx0dmx/WJeB0HhhoeUR+8C6JB5FwnkGx8H41j6LadeSZ2N+JGKIprpUcFkxHIuE
	 A5IZ1yXUKjKaDGOKbEYnUmuFf8Ow6CE70Uz5dVBR0KzNo8L5VIpViUHrQ5kBVGxE7E
	 GRG+6zb8sqyL+p/aP1Wjn1ELQxvSqHHon3rRrKQu6f7X0IKDFlTBc3XOjb2JZdgnvz
	 Jf9CoShM8S0Ux/7qGDoCXUiS6KhH5S22J0yUxne6E6HjTMso5w7OEELW8De9YbD8H/
	 QUOeWq1fM5BZvYKzeQlWVfLBp5gfef1i0qv8WeZak8hgUvH+RkaaboQpkPQt0rTuuY
	 xjsZAry10VYTQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-871c-6E70-D798-Dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CF6F17E0E3F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:38:48 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/13] doc/qualification: Add PICS and howto for the AVCTP qualification
Date: Tue, 27 Jan 2026 18:38:30 +0100
Message-ID: <20260127173841.153747-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127173841.153747-1-frederic.danis@collabora.com>
References: <20260127173841.153747-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 doc/qualification/avctp-pics.rst | 116 +++++++++++++++++++++++++++++++
 doc/qualification/avctp-pts.rst  |  49 +++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 doc/qualification/avctp-pics.rst
 create mode 100644 doc/qualification/avctp-pts.rst

diff --git a/doc/qualification/avctp-pics.rst b/doc/qualification/avctp-pics.rst
new file mode 100644
index 000000000..6c08d692e
--- /dev/null
+++ b/doc/qualification/avctp-pics.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+======================================
+Audio/Video Control Transport Protocol
+======================================
+(TCRL 2023-1, AVCTP.ICS.1.4.2ed4)
+
+Versions
+========
+**Table 0: X.Y Versions**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVCTP_0_4   | x        | AVCTP 1.4 (M)                                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVCTP_1_1   | x        | Controller (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_1_2   | x        | Target (C.1)                                 |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Controller Capabilities
+=======================
+**Table 2: Controller Features**
+
+Prerequisite: AVCTP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVCTP_2_1   |          | Message fragmentation (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_2   | x        | Transaction label management (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_3   | x        | Packet type field management (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_4   | x        | Message type field management (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_5   | x        | PID field management (M)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_6   | x        | IPID field management (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_7   | x        | Message information management (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_8   | x        | Event registration for message reception (O) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_9   | x        | Event registration for connection request (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_10  | x        | Event registration for disconnection request |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_11  | x        | Connect request (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_12  | x        | Disconnect request (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_13  | x        | Send message (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_2_14  |          | Support for multiple AVCTP channel           |
+|                  |          | establishment requests (O)                   |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Target Capabilities
+===================
+**Table 3: Target Features**
+
+Prerequisite: AVCTP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVCTP_3_1   |          | Message fragmentation (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_2   | x        | Transaction label management (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_3   | x        | Packet type field management (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_4   | x        | Message type field management (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_5   | x        | PID field management (M)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_6   | x        | IPID field management (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_7   | x        | Message information management (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_8   | x        | Event registration for message reception (O) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_9   | x        | Event registration for connection request (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_10  | x        | Event registration for disconnection request |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_11  | x        | Connect request (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_12  | x        | Disconnect request (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVCTP_3_13  | x        | Send message (O)                             |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
diff --git a/doc/qualification/avctp-pts.rst b/doc/qualification/avctp-pts.rst
new file mode 100644
index 000000000..cb47eba0b
--- /dev/null
+++ b/doc/qualification/avctp-pts.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==================
+AVCTP test results
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
++----------------------+----------+---------+-------+-----------------------+
+| Test name            | Result   | Kernel  | BlueZ |                       |
++======================+==========+=========+=======+=======================+
+| AVCTP/CT/CCM/BV-01-C | PASS     |     6.1 | 5.69  |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/CT/CCM/BV-02-C | PASS     |     6.1 | 5.69  |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/CT/CCM/BV-03-C | PASS     |     6.1 | 5.69  |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/CT/CCM/BV-04-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/CT/NFR/BV-01-C | PASS     |     6.1 | 5.69  |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/CT/NFR/BV-04-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/CCM/BV-01-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/CCM/BV-02-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/CCM/BV-03-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/CCM/BV-04-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/NFR/BI-01-C | PASS     |     6.1 | 5.69  |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/NFR/BV-02-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
+| AVCTP/TG/NFR/BV-03-C |          |         |       |                       |
++----------------------+----------+---------+-------+-----------------------+
-- 
2.43.0

