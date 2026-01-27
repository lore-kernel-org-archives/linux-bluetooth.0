Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56516322B7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535537; cv=none; b=jS8W2eD8fBmqKyEL7I2eFUUk0pqPA24ZNuTq/6XL/wEahoqn48L9wlTTxu4Fz2kn4BT6QJVwyymj4dyl5G55IqrEiaoTIFrehxwW4Hyt/VU5z6zA/2HHvx9dwZHgtHnR6MqOpUYf5UP7HS+hwJL47vMKSp6LNYWUhX54SI+2o8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535537; c=relaxed/simple;
	bh=kV5udwBkQJVnEbCepc18MKAWUlx7TLNLsj+u6M4dvKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PINvkPqAF8ptdlZsncVxLvgO6Zqo0VW6USGMn950b82wYnJ+km6HwUUvu1xdlW6fCMweWXLBtJBb1A2yoXjwRgpQmWKobvViy1GVUjEOsU2MblcrRnMjfVF12SAbO2YPaelJFBKVfAqkAzWb/0ccgeE6ZEgZTW7tjzRlJit6BzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V/QmI6j/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V/QmI6j/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769535530;
	bh=kV5udwBkQJVnEbCepc18MKAWUlx7TLNLsj+u6M4dvKU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V/QmI6j/BycEOx3V/45mgqy3oHeY3gwmf75Yf3tp1q8kmxQeR3rhArlkImA837hIQ
	 GfQjbf5HLQUqCkCQkQ3qlx0PiZa4P3HGaoQDhJrJU9qkQFF5AIPsls5nApof1lPS25
	 v7a+np1K89E5QTAtvmUYXf2ZfBQe6H8XqWGGQpnN6Umso7XwF55L0TCzNIxTptBwBr
	 bukNRlWwxCvKVWaVM5HLc1tlnIV7c7xaOQE+1Rl2v6W3O/cl1QH5QR7jvin295G0SB
	 6+DDqgE0+evKd8834LE5fCaaZXsTZoSB8mLKKFVuncenm1exBmfS7d9ODJW49FIWBl
	 OpkQ5AxxVGxMg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-871c-6E70-D798-Dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E13A117E1523
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:38:49 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/13] doc/qualification: Add PICS and howto for the ScPP qualification
Date: Tue, 27 Jan 2026 18:38:36 +0100
Message-ID: <20260127173841.153747-8-frederic.danis@collabora.com>
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
 doc/qualification/scpp-pics.rst | 166 ++++++++++++++++++++++++++++++++
 doc/qualification/scpp-pts.rst  |  31 ++++++
 2 files changed, 197 insertions(+)
 create mode 100644 doc/qualification/scpp-pics.rst
 create mode 100644 doc/qualification/scpp-pts.rst

diff --git a/doc/qualification/scpp-pics.rst b/doc/qualification/scpp-pics.rst
new file mode 100644
index 000000000..d1024427b
--- /dev/null
+++ b/doc/qualification/scpp-pics.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=======================
+Scan Parameters Profile
+=======================
+(TCRL 2023-1, SCPP.ICS.p2)
+
+
+Versions
+========
+**Table 0: Major Versions (X.Y)**
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_0_1     | x        | SCPP v1.0 (M)                                        |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_1_1     |          | Scan Server (C.1)                                    |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_1_2     | x        | Scan Client (C.1)                                    |
++------------------+----------+------------------------------------------------------+
+
+- C.1: Mandatory to support at least one of SCPP 1/1 "Scan Server" OR SCPP 1/2 "Scan Client".
+
+Transports
+==========
+**Table 2: Transport Requirements**
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_2_1     |          | Profile supported over BR/EDR (C.1)                  |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_2_2     | x        | Profile supported over LE (M)                        |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded for this Profile.
+
+Scan Server Role
+================
+**Table 3: Services - Scan Server Role**
+
+Prerequisite: SCPP 1/1 "Scan Server"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_3_1     |          | Scan Parameters Service (M)                          |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+
+Scan Server Role
+================
+**Table 4: GAP Requirements - Scan Server Role**
+
+Prerequisite: SCPP 1/1 "Scan Server"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_4_1     |          | Peripheral (M)                                       |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+
+Scan Client Role
+================
+**Table 7: Discover Services and Characteristics - Scan Client Role**
+
+Prerequisite: SCPP 1/2 "Scan Client"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_7_1     | x        | Discover Scan Parameters Service (M)                 |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_7_2     | x        | Discover Scan Parameters characteristic: Scan        |
+|                  |          | interval Window (M)                                  |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_7_3     | x        | Discover Scan Parameters characteristic: Scan        |
+|                  |          | Refresh (M)                                          |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_7_4     | x        | Discover Scan Parameters characteristic: Scan        |
+|                  |          | Refresh - Client Characteristic Configuration        |
+|                  |          | Descriptor (M)                                       |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+
+Scan Client Role
+================
+**Table 8: Features - Scan Client Role**
+
+Prerequisite: SCPP 1/2 "Scan Client"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_8_1     | x        | Write Scan Interval Window characteristic (M)        |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_8_2     |          | Configure Scan Refresh characteristic: Client        |
+|                  |          | Characteristic Configuration characteristic          |
+|                  |          | descriptor with (O)                                  |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_8_3     | x        | Notify Scan Refresh characteristic (M)               |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Scan Client Role
+================
+**Table 9: GATT Requirements - Scan Client Role**
+
+Prerequisite: SCPP 1/2 "Scan Client"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_9_1     | x        | GATT Client over LE (M)                              |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_3     | x        | Discover All Primary Services (C.1)                  |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_4     | x        | Discover Primary Services by Service UUID (C.1)      |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_5     | x        | Discover All Characteristics of a Service (C.2)      |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_6     | x        | Discover Characteristics by UUID (C.2)               |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_7     | x        | Discover All Characteristic Descriptors (M)          |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_8     | x        | Write without Response (M)                           |
++------------------+----------+------------------------------------------------------+
+| TSC_SCPP_9_10    | x        | Notifications (M)                                    |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory to support at least one of SCPP 9/3 "Discover All Primary Services" OR SCPP 9/4 "Discover Primary Services by Service UUID".
+- C.2: Mandatory to support at least one of SCPP 9/5 "Discover All Characteristics of a Service" OR SCPP 9/6 "Discover Characteristics by UUID".
+
+Scan Client Role
+================
+**Table 10: GAP Requirements - Scan Client Role**
+
+Prerequisite: SCPP 1/2 "Scan Client"
+
++------------------+----------+------------------------------------------------------+
+| Parameter Name   | Selected | Description                                          |
++==================+==========+======================================================+
+| TSC_SCPP_10_1    | x        | Central (M)                                          |
++------------------+----------+------------------------------------------------------+
+
+- M: Mandatory
diff --git a/doc/qualification/scpp-pts.rst b/doc/qualification/scpp-pts.rst
new file mode 100644
index 000000000..d61c60ff0
--- /dev/null
+++ b/doc/qualification/scpp-pts.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=================
+ScPP test results
+=================
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
+| SCPP/CL/CGGIT/SER/BV-01-C    | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SCPP/CL/CGGIT/CHA/BV-01-C    | PASS     |     6.1 | 5.69  | Cancel 'Please take action to discover the Scan Interval Window …'      |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SCPP/CL/CGGIT/CHA/BV-02-C    | PASS     |     6.1 | 5.69  | Cancel 'Please take action to discover the Scan Refresh caracteristic…' |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SCPP/CL/SNPF/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

