Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B403376A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165636; cv=none; b=movsNlEqCnfk+bpsdKrenPJx/9BFJkTQDbIx6V+Xv3WoGVLxz95HoIHz3BItdCYOmMbjwHlRTavoVaYHsK6K8ksRFCntidy8YwwVx0Ft8qLSr33MUnw/4iqotUFySCkohzPGYoFGctz5QYy2dpx0UmBUBfeSvfinayZFt1O6zA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165636; c=relaxed/simple;
	bh=3WMQgbpfwmH6/eDbMsmVCp6kGUbQbGGJnQtPFn70xh0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EM4jxGrYG/QV08LMxgWsSH7qr9fqGKDTHtweJVP4xAn7AP/eB7dC7uNBqy4o3/Ueds56CaOYxjfXrL6nlQlgV067zJmvEGnIqKl++RazDEZu4CyT8giQDteMbno29am3sz3IxGtoVLn1ROYXIY9mapaPdAbeu9NqReib/T5HZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V9eQc6Fn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V9eQc6Fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769165623;
	bh=3WMQgbpfwmH6/eDbMsmVCp6kGUbQbGGJnQtPFn70xh0=;
	h=From:To:Subject:Date:From;
	b=V9eQc6FnbxuBjFZiL4BQYEIgSKc3Hcsd9W3ct2E7rKvRSKeyt3OFpgxMtI20WzPsN
	 xrI4hhjDX3a/kJcYyZf/kxToWlM4Wr6yTGIA2hfo+Pi2Ru6RgX83UpXP75lyj5E7C9
	 mr23cmvJEQK9b9leOkcjh5gW7zznO5maoQ1ZPDuHgiiS12Mi4xfDjwh9YyCzWPc+R9
	 Tqd/RZ5IjtcddVzeRH7DtYeExI4vagDi2NlO7la7pyD0Xi98sVfkN/y7ggBqqc8ncl
	 kfHR6TRKmljYzM9RV8Q38b0p0vO8iKBde1MM1zZmMQyb7LQSZfHEsLZZK0PWB+A+jw
	 ShwtgFOteUn5g==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-0A83-3Cb6-e898-A29d.rev.sfr.net [IPv6:2a02:8428:af44:1001:a83:3cb6:e898:a29d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D49A17E12E5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:53:43 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the GATT qualification
Date: Fri, 23 Jan 2026 11:53:38 +0100
Message-ID: <20260123105338.677646-1-frederic.danis@collabora.com>
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
 doc/qualification/gatt-pics.rst |  538 +++++++++++++++
 doc/qualification/gatt-pts.rst  | 1151 +++++++++++++++++++++++++++++++
 2 files changed, 1689 insertions(+)
 create mode 100644 doc/qualification/gatt-pics.rst
 create mode 100644 doc/qualification/gatt-pts.rst

diff --git a/doc/qualification/gatt-pics.rst b/doc/qualification/gatt-pics.rst
new file mode 100644
index 000000000..4de4c52a2
--- /dev/null
+++ b/doc/qualification/gatt-pics.rst
@@ -0,0 +1,538 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=========================
+Generic Attribute Profile
+=========================
+(TCRL 2023-1, GATT.ICS.p17)
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_1_1    | x        | Generic Attribute Profile (GATT) Client (C.1)|
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_1_2    | x        | Generic Attribute Profile (GATT) Server (C.1)|
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Transports
+==========
+**Table 1a: Transport Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_1a_1   | x        | GATT Client over LE (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_1a_2   |          | GATT Client over BR/EDR (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_1a_3   | x        | GATT Server over LE (C.2)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_1a_4   |          | GATT Server over BR/EDR (C.2)                |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one IF GATT 1/1 "Generic Attribute
+  Profile (GATT) Client", otherwise Excluded.
+- C.2: Mandatory to support at least one IF GATT 1/2 "Generic Attribute
+  Profile (GATT) Server", otherwise Excluded.
+
+Transports
+==========
+**Table 2: Attribute Protocol Transport Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_2_1    |          | Unenhanced ATT bearer over BR/EDR (C.1)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_2_2    | x        | Unenhanced ATT bearer over LE (C.2)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_2_3a   |          | Enhanced ATT bearer over LE (C.4, C.3)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_2_3b   |          | Enhanced ATT bearer over BR/EDR (C.1, C.3)   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_2_4    | x        | Attribute Protocol Client (C.6)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_2_5    | x        | Attribute Protocol Server (C.7)              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one IF GATT 1a/2 "GATT Client over
+  BR/EDR" OR GATT 1a/4 "GATT Server over BR/EDR", otherwise not defined.
+- C.2: Mandatory IF GATT 1a/1 "GATT Client over LE" OR GATT 1a/3 "GATT Server
+  over LE", otherwise not defined.
+- C.3: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1", otherwise
+  Optional.
+- C.4: Optional IF GATT 2/2 "Unenhanced ATT bearer over LE", otherwise not
+  defined.
+- C.6: Mandatory IF GATT 1/1 "Generic Attribute Profile (GATT) Client",
+  otherwise not defined.
+- C.7: Mandatory IF GATT 1/2 "Generic Attribute Profile (GATT) Server",
+  otherwise not defined.
+
+GATT Features
+=============
+**Table 3: Generic Attribute Profile Feature Support, by Client**
+
+Prerequisite: GATT 1/1 "Generic Attribute Profile (GATT) Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_3_1    | x        | Exchange MTU (C.11)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_2    | x        | Discover All Primary Services (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_3    | x        | Discover Primary Services by Service UUID (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_4    | x        | Find Included Services (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_5    | x        | Discover All Characteristics of a Service (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_6    | x        | Discover Characteristics by UUID (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_7    |          | Discover All Characteristic Descriptors (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_8    | x        | Read Characteristic Value (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_9    | x        | Read Using Characteristic UUID (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_10   | x        | Read Long Characteristic Values (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_11   |          | Read Multiple Characteristic Values (O)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_12   | x        | Write without Response (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_13   |          | Signed Write Without Response (C.11)         |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_14   | x        | Write Characteristic Value (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_15   | x        | Write Long Characteristic Values (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_16   |          | Characteristic Value Reliable Writes (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_17   | x        | Notifications (C.7)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_18   | x        | Indications (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_19   | x        | Read Characteristic Descriptors (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_20   | x        | Read Long Characteristic Descriptors (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_21   | x        | Write Characteristic Descriptors (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_22   | x        | Write Long Characteristic Descriptors (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_23   | x        | Service Changed Characteristic (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_24   |          | Configured Broadcast (C.2)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_25   |          | Client Supported Features Characteristic     |
+|                  |          | (C.4)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_25a  |          | Enabling Robust Caching (C.12)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_26   |          | Database Hash Characteristic (C.4)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_27   |          | Read and Interpret Characteristic            |
+|                  |          | Presentation Format (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_28   |          | Read and Interpret Characteristic Aggregate  |
+|                  |          | Format (C.6)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_29   |          | Read Multiple Variable Length Characteristic |
+|                  |          | Values (C.9)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3_30   |          | Multiple Variable Length Notifications (C.10)|
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.2: Optional IF GATT 3/14 "Write Characteristic Value", otherwise Excluded.
+- C.4: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0", otherwise Optional.
+- C.6: Optional IF GATT 3/27 "Read and Interpret Characteristic Presentation
+  Format", otherwise Excluded.
+- C.7: Mandatory IF GATT 2/3a "Enhanced ATT bearer over LE" OR GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Optional.
+- C.9: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1", otherwise
+  Optional.
+- C.10: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1", otherwise
+  Mandatory IF GATT 2/3a "Enhanced ATT bearer over LE" OR GATT 2/3b "Enhanced
+  ATT bearer over BR/EDR", otherwise Optional.
+- C.11: Optional IF GATT 1a/1 "GATT Client over LE", otherwise Excluded.
+- C.12: Optional IF GATT 3/25 "Client Supported Features Characteristic",
+  otherwise Excluded.
+
+GATT Features
+=============
+**Table 3a: GAP Role Requirements for GATT Client**
+
+Prerequisite: GATT 1a/1 "GATT Client over LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_3a_1   |          | Peripheral (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_3a_2   |          | Central (O)                                  |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+GATT Features
+=============
+**Table 4: Generic Attribute Profile Feature Support, by Server**
+
+Prerequisite: GATT 1/2 "Generic Attribute Profile (GATT) Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_4_1    | x        | Exchange MTU (C.6)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_2    | x        | Discover All Primary Services (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_3    | x        | Discover Primary Services by Service UUID (M)|
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_4    | x        | Find Included Services (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_5    | x        | Discover All Characteristics of a Service (M)|
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_6    | x        | Discover Characteristics by UUID (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_7    | x        | Discover All Characteristic Descriptors (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_8    | x        | Read Characteristic Value (M)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_9    | x        | Read Using Characteristic UUID (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_10   | x        | Read Long Characteristic Values (C.12)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_11   | x        | Read Multiple Characteristic Values (O)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_12   | x        | Write without Response (C.2)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_13   |          | Signed Write Without Response (C.6)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_14   | x        | Write Characteristic Value (C.3)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_15   | x        | Write Long Characteristic Values (C.12)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_16   |          | Characteristic Value Reliable Writes (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_17   | x        | Notifications (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_18   | x        | Indications (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_19   | x        | Read Characteristic Descriptors (C.12)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_20   | x        | Read Long Characteristic Descriptors (C.12)  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_21   | x        | Write Characteristic Descriptors (C.12)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_22   | x        | Write Long Characteristic Descriptors (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_23   | x        | Service Changed Characteristic (C.14)        |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_24   |          | Configured Broadcast (C.5)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_25   | x        | Execute Write Request with empty queue (C.7) |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_26   |          | Client Supported Features Characteristic     |
+|                  |          | (C.9)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_27   |          | Database Hash Characteristic (C.8)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_28   |          | Report Characteristic Value: Characteristic  |
+|                  |          | Presentation Format (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_29   |          | Report aggregate Characteristic Value:       |
+|                  |          | Characteristic Aggregate Format (C.10)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_30   |          | Read Multiple Variable Length Characteristic |
+|                  |          | Values (C.13)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4_31   |          | Multiple Variable Length Notifications (C.13)|
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GATT 4/23 "Service Changed Characteristic", otherwise
+  Optional.
+- C.2: Mandatory IF GATT 4/13 "Signed Write Without Response" OR GATT 2/3a
+  "Enhanced ATT bearer over LE" OR GATT 2/3b "Enhanced ATT bearer over
+  BR/EDR", otherwise Optional.
+- C.3: Mandatory IF GATT 4/15 "Write Long Characteristic Values" OR GATT 2/3a
+  "Enhanced ATT bearer over LE" OR GATT 2/3b "Enhanced ATT bearer over
+  BR/EDR", otherwise Optional.
+- C.5: Optional IF GATT 4/14 "Write Characteristic Value", otherwise Excluded.
+- C.6: Optional IF GATT 1a/3 "GATT Server over LE", otherwise Excluded.
+- C.7: Optional IF (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS")
+  AND (GATT 4/15 "Write Long Characteristic Values" OR GATT 4/16
+  "Characteristic Value Reliable Writes" OR GATT 4/22 "Write Long
+  Characteristic Descriptors"), otherwise Mandatory IF GATT 4/15 "Write Long
+  Characteristic Values" OR GATT 4/16 "Characteristic Value Reliable Writes"
+  OR GATT 4/22 "Write Long Characteristic Descriptors", otherwise Excluded.
+- C.8: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0", otherwise Optional.
+- C.9: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0", otherwise Mandatory IF GATT 4/23 "Service
+  Changed Characteristic" AND GATT 4/27 "Database Hash Characteristic",
+  otherwise Excluded.
+- C.10: Optional IF GATT 4/28 "Report Characteristic Value: Characteristic
+  Presentation Format", otherwise Excluded.
+- C.12: Mandatory IF GATT 2/3a "Enhanced ATT bearer over LE" OR GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Optional.
+- C.13: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1", otherwise
+  Mandatory IF GATT 2/3a "Enhanced ATT bearer over LE" OR GATT 2/3b "Enhanced
+  ATT bearer over BR/EDR", otherwise Optional.
+- C.14: Mandatory IF service definitions on the server can be added, changed,
+  or removed, otherwise Optional.
+
+GATT Features
+=============
+**Table 4a: GAP Role Requirements for GATT Server**
+
+Prerequisite: GATT 1a/3 "GATT Server over LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_4a_1   |          | Peripheral (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_4a_2   |          | Central (O)                                  |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+SDP requirements
+================
+**Table 6: SDP Interoperability**
+
+Prerequisite: GATT 2/1 "Unenhanced ATT bearer over BR/EDR" OR GATT 2/3b "Enhanced ATT bearer over BR/EDR"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_6_2    |          | Client (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_6_3    |          | Server (C.2)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_6_4    |          | ProtocolDescriptorList (C.2)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_6_5    |          | BrowseGroupList (C.2)                        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF GATT 1a/2 "GATT Client over BR/EDR", otherwise not defined.
+- C.2: Mandatory IF GATT 1a/4 "GATT Server over BR/EDR", otherwise not defined.
+
+GAP requirements
+================
+**Table 7: GAP Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_7_2    | x        | LE security mode 1 (C.2)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_7_3    | x        | LE security mode 2 (C.2)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_7_4    | x        | Authentication procedure (C.2)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_7_5    |          | Connection data signing procedure (C.2)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_7_6    |          | Authenticate signed data procedure (C.2)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_7_7    | x        | Authorization procedure (C.2)                |
++------------------+----------+----------------------------------------------+
+
+- C.2: Optional IF GATT 2/2 "Unenhanced ATT bearer over LE", otherwise not defined.
+
+Multiple Bearer Support
+=======================
+**Table 8: Multiple Simultaneous ATT Bearers**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_8_1    |          | Support for multiple simultaneous active ATT |
+|                  |          | bearers from same device - ATT over LE and   |
+|                  |          | ATT over BR/EDR (C.1)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_2    |          | Support for multiple simultaneous active ATT |
+|                  |          | bearers from same device - ATT over LE and   |
+|                  |          | EATT over LE (C.2)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_3    |          | Support for multiple simultaneous active ATT |
+|                  |          | bearers from same device - ATT over BR/EDR   |
+|                  |          | and EATT over BR/EDR (C.3)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_4    |          | Support for multiple simultaneous active ATT |
+|                  |          | bearers from same device - ATT over LE and   |
+|                  |          | EATT over BR/EDR (C.4)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_5    |          | Support for multiple simultaneous active ATT |
+|                  |          | bearers from same device - ATT over BR/EDR   |
+|                  |          | and EATT over LE (C.5)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_6    |          | Support for multiple simultaneous active EATT|
+|                  |          | bearers from same device - EATT over BR/EDR  |
+|                  |          | and EATT over LE (C.6)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_7    |          | Support for multiple simultaneous active EATT|
+|                  |          | bearers from same device - EATT over BR/EDR  |
+|                  |          | (C.7)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_8_8    |          | Support for multiple simultaneous active EATT|
+|                  |          | bearers from same device - EATT over LE (C.7)|
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF GATT 2/1 "Unenhanced ATT bearer over BR/EDR" AND GATT 2/2
+  "Unenhanced ATT bearer over LE", otherwise Excluded.
+- C.2: Optional IF GATT 2/2 "Unenhanced ATT bearer over LE" AND GATT 2/3a
+  "Enhanced ATT bearer over LE", otherwise Excluded.
+- C.3: Optional IF GATT 2/1 "Unenhanced ATT bearer over BR/EDR" AND GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Excluded.
+- C.4: Optional IF GATT 2/2 "Unenhanced ATT bearer over LE" AND GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Excluded.
+- C.5: Optional IF GATT 2/1 "Unenhanced ATT bearer over BR/EDR" AND GATT 2/3a
+  "Enhanced ATT bearer over LE", otherwise Excluded.
+- C.6: Optional IF GATT 2/3a "Enhanced ATT bearer over LE" AND GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Excluded.
+- C.7: Optional IF GATT 2/3a "Enhanced ATT bearer over LE" OR GATT 2/3b
+  "Enhanced ATT bearer over BR/EDR", otherwise Excluded.
+
+ATT requirements
+================
+**Table 9: Attribute Protocol Client Requirements**
+
+Prerequisite: GATT 1/1 "Generic Attribute Profile (GATT) Client"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_9_1    | x        | Exchange MTU Request (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_2    | x        | Find Information Request (C.2)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_3    | x        | Find by Type Value Request (C.3)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_4    | x        | Read by Type Request (C.4)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_5    | x        | Read Request (C.5)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_6    | x        | Read Blob Request (C.6)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_7    |          | Read Multiple Request (C.7)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_8    | x        | Write Request (C.8)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_9    | x        | Write Command (C.9)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_10   |          | Signed Write Command (C.10)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_11   | x        | Prepare Write Request (C.11)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_12   | x        | Handle Value Notification (C.12)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_13   | x        | Handle Value Indication (C.13)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_14   |          | Read Multiple Variable Length Request (C.14) |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_9_15   |          | Handle Value Multiple Notification (C.15)    |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF GATT 3/1 "Exchange MTU", otherwise not defined.
+- C.2: Mandatory IF GATT 3/7 "Discover All Characteristic Descriptors",
+  otherwise not defined.
+- C.3: Mandatory IF GATT 3/3 "Discover Primary Services by Service UUID",
+  otherwise not defined.
+- C.4: Mandatory IF GATT 3/9 "Read Using Characteristic UUID", otherwise not
+  defined.
+- C.5: Mandatory IF GATT 3/8 "Read Characteristic Value" OR GATT 3/19 "Read
+  Characteristic Descriptors", otherwise not defined.
+- C.6: Mandatory IF GATT 3/10 "Read Long Characteristic Values" OR GATT 3/20
+  "Read Long Characteristic Descriptors", otherwise not defined.
+- C.7: Mandatory IF GATT 3/11 "Read Multiple Characteristic Values", otherwise
+  not defined.
+- C.8: Mandatory IF GATT 3/14 "Write Characteristic Value" OR GATT 3/21 "Write
+  Characteristic Descriptors", otherwise not defined.
+- C.9: Mandatory IF GATT 3/12 "Write without Response", otherwise not defined.
+- C.10: Mandatory IF GATT 3/13 "Signed Write Without Response", otherwise not
+  defined.
+- C.11: Mandatory IF GATT 3/15 "Write Long Characteristic Values" OR GATT 3/16
+  "Characteristic Value Reliable Writes" OR GATT 3/22 "Write Long
+  Characteristic Descriptors", otherwise not defined.
+- C.12: Mandatory IF GATT 3/17 "Notifications", otherwise Optional.
+- C.13: Mandatory IF GATT 3/18 "Indications", otherwise not defined.
+- C.14: Mandatory IF GATT 3/29 "Read Multiple Variable Length Characteristic
+  Values", otherwise not defined.
+- C.15: Mandatory IF GATT 3/30 "Multiple Variable Length Notifications",
+  otherwise not defined.
+
+ATT requirements
+================
+**Table 10: Attribute Protocol Server Requirements**
+
+Prerequisite: GATT 1/2 "Generic Attribute Profile (GATT) Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GATT_10_1   | x        | Exchange MTU Request (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_2   | x        | Read Blob Request (C.2)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_3   |          | Read Multiple Request (C.3)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_4   | x        | Write Request (C.4)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_5   | x        | Write Command (C.5)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_6   |          | Signed Write Command (C.6)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_7   | x        | Prepare Write Request (C.7)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_8   | x        | Handle Value Notification (C.8)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_9   | x        | Handle Value Indication (C.9)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_10  |          | Execute Write Request with no pending        |
+|                  |          | prepared write values (C.10)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_11  |          | Read Multiple Variable Length Request (C.11) |
++------------------+----------+----------------------------------------------+
+| TSPC_GATT_10_12  |          | Handle Value Multiple Notification (C.12)    |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF GATT 4/1 "Exchange MTU", otherwise not defined.
+- C.2: Mandatory IF GATT 4/10 "Read Long Characteristic Values", otherwise not
+  defined.
+- C.3: Mandatory IF GATT 4/11 "Read Multiple Characteristic Values", otherwise
+  Optional.
+- C.4: Mandatory IF GATT 4/14 "Write Characteristic Value" OR GATT 4/21 "Write
+  Characteristic Descriptors", otherwise Optional.
+- C.5: Mandatory IF GATT 4/12 "Write without Response", otherwise Optional.
+- C.6: Mandatory IF GATT 4/13 "Signed Write Without Response", otherwise
+  Optional.
+- C.7: Mandatory IF GATT 4/15 "Write Long Characteristic Values" OR GATT 4/16
+  "Characteristic Value Reliable Writes" OR GATT 4/22 "Write Long
+  Characteristic Descriptors" OR GATT 2/3a "Enhanced ATT bearer over LE" OR
+  GATT 2/3b "Enhanced ATT bearer over BR/EDR", otherwise Optional.
+- C.8: Mandatory IF GATT 4/17 "Notifications", otherwise Optional.
+- C.9: Mandatory IF GATT 4/18 "Indications", otherwise Optional.
+- C.10: Mandatory IF GATT 4/25 "Execute Write Request with empty queue" AND
+  SUM ICS 31/19 "Core v5.0", otherwise Optional.
+- C.11: Mandatory IF GATT 4/30 "Read Multiple Variable Length Characteristic
+  Values", otherwise Optional.
+- C.12: Mandatory IF GATT 4/31 "Multiple Variable Length Notifications",
+  otherwise Optional.
diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
new file mode 100644
index 000000000..447cf4a66
--- /dev/null
+++ b/doc/qualification/gatt-pts.rst
@@ -0,0 +1,1151 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=================
+GATT test results
+=================
+
+:PTS version: 8.5.3 Build 4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- Uncomment and set "[GATT] KeySize" entry to 16 in /etc/bluetooth/main.conf
+
+Tests
+=====
+
+The kernel and BlueZ versions represent the oldest version without backport
+for which we know the test passed.
+
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| Test name              | Result   | Kernel  | BlueZ |                                                                         |
++========================+==========+=========+=======+=========================================================================+
+| GATT/CL/GAC/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <pts_addr>                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GATT-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service00c0/char<handle - 1>           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - e.g. for PTS device 00:1B:DC:F2:24:10 and handle "00CD":            |
+|                        |          |         |       |     /org/bluez/hci0/dev_00_1B_DC_F2_24_10/service00c0/char00cc          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# gatt.write \                  |
+|                        |          |         |       |   "11 22 33 44 55 66 77 88 99 00 12 34 56 78 90 12 34"                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# disconnect                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAD/BV-01-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On "Please send discover all primary services command to PTS":          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# search-all-primary-services                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - repeat on demand                                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAD/BV-02-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-service <uuid>                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - repeat on demand                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAD/BV-03-C    | PASS     |     6.1 | 5.72  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - repeat on demand                                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAD/BV-04-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - repeat on demand                                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAD/BV-05-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - repeat on demand                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-02-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-03-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-04-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <pts_addr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GATT-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service0001/char0003                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service0020/char0022]# gatt.read 0                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service0020/char0022]# disconnect                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BV-03-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics 0x0001 0xffff <uuid>          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - repeat on demand                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-06-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-07-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-09-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-10-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-11-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# search-characteristics <start_handle> <end_handle> \ |
+|                        |          |         |       |     <uuid>                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - 128-bits UUID should be of the form                               |
+|                        |          |         |       |       0000a00c-0000-0000-0123-456789abcdef                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BV-04-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - repeat on demand                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-12-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-13-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0x<offset>                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-14-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-15-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-16-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-17-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <pts_addr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GATT-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# gatt.read 0                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# disconnect                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BV-06-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BV-07-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-long-value 0x<handle> 0                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAR/BI-35-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Application error: 0x80 - 0x9F                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value --without-response 0x<handle> 0          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BV-03-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-02-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-03-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-04-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-05-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-06-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <pts_addr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GATT-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# gatt.write 0                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# disconnect                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BV-05-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-07-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-08-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-09-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0x<offset> 0             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-11-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-12-C    | PASS     |     6.1 | 5.73  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-security-retry n                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-13-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <pts_addr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GATT-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# gatt.write \                  |
+|                        |          |         |       |   "11 22 33 44 55 66 77 88 99 00 12 34 56 78 90 12 34 56 78 90"         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [Test:/service<xxxx>/char<handle - 1>]# disconnect                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BV-08-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BV-09-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-33-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 1 2                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAW/BI-34-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-long-value 0x<handle> 0 0 1 2 3 4 5 6 7 8 9 \  |
+|                        |          |         |       |     10 11 12 13 14 15 16 17 18 19 20 21 22 23 24                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# register-notify 0x<handle - 2>                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# register-notify 0x<handle - 1>                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAI/BI-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# register-notify 0x<handle - 1>                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - repeat on demand                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAT/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# read-value 0x<handle>                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/CL/GAT/BV-02-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value 0x<handle> 0                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAC/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-server'                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - repeat on demand                                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-04-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAD/BV-06-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "0010" on handle request                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-04-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA secure-read          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA encrypt-read         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-03-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-06-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "AAAA" on UUID request                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-07-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "BBBB" on UUID request                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-08-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-09-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "AAAA" on UUID request                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-10-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA secure-read          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "AAAA" on UUID request                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-11-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA encrypt-read         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "AAAA" on UUID request                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-04-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-server'                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - expected value is : 56 65 72 79 20 4c 6f 6e 67 20 54 65 73 74 20 44   |
+|                        |          |         |       |   65 76 69 63 65 20 4e 61 6d 65 20 46 6f 72 20 54 65 73 74 69 6e 67 20  |
+|                        |          |         |       |   41 54 54 20 50 72 6f 74 6f 63 6f 6c 20 4f 70 65 72 61 74 69 6f 6e 73  |
+|                        |          |         |       |   20 4f 6e 20 47 41 54 54 20 53 65 72 76 65 72 00                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-12-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4' when prompted                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-13-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-server'                                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-14-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "0010" on handle request                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-15-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-16-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA secure-read          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x10 0x11 0x12  |
+|                        |          |         |       |     0x13 0x14 0x15 0x16 0x17 0x18 0x19 0x20 0x21 0x22 0x23 0x24 0x25'   |
+|                        |          |         |       |     when prompted                                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-17-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA encrypt-read         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-18-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-19-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "0010" on handle request                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-20-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xBBBB read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '2' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-21-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA secure-read          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-22-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <pts_addr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA encrypt-read         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-06-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-07-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x10 0x11 0x12  |
+|                        |          |         |       |     0x13 0x14 0x15 0x16 0x17 0x18 0x19 0x20 0x21 0x22 0x23 0x24 0x25'   |
+|                        |          |         |       |     when prompted                                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BV-08-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x10 0x11 0x12  |
+|                        |          |         |       |     0x13 0x14 0x15 0x16 0x17 0x18 0x19 0x20 0x21 0x22 0x23 0x24 0x25'   |
+|                        |          |         |       |     when prompted                                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAR/BI-45-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA \                    |
+|                        |          |         |       |   read,write-without-response                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BV-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "0030" on handle request                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-04-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,secure-write    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | "Cannot find characteristic in the IUT database"                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-06-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,encrypt-write   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BV-05-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-07-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7' when prompted                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter "0030" on handle request                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-08-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7' when prompted                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-09-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7' when prompted                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-11-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write,authorize |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Reply no on authorization requests in bluetoothctl                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-12-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,secure-write    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-13-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,encrypt-write   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BV-08-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read,write               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '2' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BV-09-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read,write               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23  |
+|                        |          |         |       |     24 25' when prompted                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-32-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read,write               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '2' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-33-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-descriptor 0xBBBB read,write               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1 2 3 4 5 6 7' when prompted                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-server -r'                                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <pts_addr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | In a second terminal:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'btgatt-server'                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'btgatt-server'                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'btgatt-server'                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT server]# notify -i 0x0009 00 01                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAT/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/UNS/BI-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/UNS/BI-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

