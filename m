Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695035C1B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165590; cv=none; b=lC8bPvRqfq8bgbUAZsGZoOfpYtULWbYUBmmTi0iJVlc0ZqwBYgIRRzO0vYwqeXMatvObDjGvJD7D1dDKkZnaq6kdyUPwgakQTcuJ6YusIfSYIQSPfJUQgdgS9jKYXV60BDm1qRyDjepnpUGCnS0eWcV1mA6GTCw1RXzIzc5tfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165590; c=relaxed/simple;
	bh=UOGdzhFgto5z9sHWOLUPw41CQl1jvd3dXetyv5bFVtc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcXM59ytW4wOU1g90K+Qh+HFaDEyCL+A18dx/2h3hm23lTgOr35DaHCqYaIUmtpQbp1nZKAH/NVBuMIpurMq7cAqVqJjmd/P6LnWYGLsPwomXA/Q8BlBH1B8CUG4TZ7uKqNcjgO6l1e8m9FUezRQnYZXof/HGZzHMPEUzAWsAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QuzpvVbt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QuzpvVbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769165574;
	bh=UOGdzhFgto5z9sHWOLUPw41CQl1jvd3dXetyv5bFVtc=;
	h=From:To:Subject:Date:From;
	b=QuzpvVbtuJQPqgYoFLcbAeFhPbawfV29kXcyjxZh6pSuKYiA8kA5JlJd6jXaawCi6
	 v7D7JcsEeM411c8ck8lRv+6nEBP9WZVftcWxE2eoiy10VGcX27TiAQmoqyn1oF9BnA
	 3uzOe0lP6cebvW+BUdofqAlpY5UqFhaDp2/S/J31hmbMinx4DNyQcHTRAb0/zrFd+d
	 0SBqF0x2fxSLoVMW3zaarPMKNu9Dk/Ryh99Iy/Esau9RJ/aPYjFvh/Y9KyzL1RNZbZ
	 8PrkXO97Pt+G5TZUi2B4kZJJgBoq+PNYbEobehngqUoJBgX8qbRZtlclglGlp3+x1K
	 Mkdhh2vjT+txQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-0A83-3cb6-e898-a29d.rev.sfr.net [IPv6:2a02:8428:af44:1001:a83:3cb6:e898:a29d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C75D417E10F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:52:53 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the GAP qualification
Date: Fri, 23 Jan 2026 11:52:49 +0100
Message-ID: <20260123105249.677211-1-frederic.danis@collabora.com>
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
 doc/qualification/gap-pics.rst | 1642 +++++++++++++++++++++++
 doc/qualification/gap-pts.rst  | 2228 ++++++++++++++++++++++++++++++++
 2 files changed, 3870 insertions(+)
 create mode 100644 doc/qualification/gap-pics.rst
 create mode 100644 doc/qualification/gap-pts.rst

diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.rst
new file mode 100644
index 000000000..aef0b3cbd
--- /dev/null
+++ b/doc/qualification/gap-pics.rst
@@ -0,0 +1,1642 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+======================
+Generic Access Profile
+======================
+(TCRL 2023-1, GAP.ICS.p40)
+
+Device and version configuration
+================================
+**Table 0: Device Configuration**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_0_1     |          | BR/EDR (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_0_2     |          | LE (C.2)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_0_3     | x        | BR/EDR/LE (C.3)                              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF SUM ICS 32/3 "Generic Access Profile (BR/EDR)" AND
+  NOT SUM ICS 34/2 "Generic Access Profile (LE)", otherwise Excluded.
+- C.2: Mandatory IF SUM ICS 34/2 "Generic Access Profile (LE)" AND
+  NOT SUM ICS 32/3 "Generic Access Profile (BR/EDR)", otherwise Excluded.
+- C.3: Mandatory IF SUM ICS 32/3 "Generic Access Profile (BR/EDR)" AND
+  SUM ICS 34/2 "Generic Access Profile (LE)", otherwise Excluded.
+
+BR/EDR Capability Statement
+===========================
+**Table 1: Modes**
+
+Prerequisite: GAP 0/1 "BR/EDR" OR GAP 0/3 "BR/EDR/LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_1_1     | x        | Non-discoverable mode (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_2     | x        | Limited discoverable mode (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_3     | x        | General discoverable mode (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_4     | x        | Non-connectable mode (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_5     | x        | Connectable mode (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_6     |          | Non-bondable mode (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_7     | x        | Bondable mode (C.2)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_8     |          | Non-synchronizable mode (C.3)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_1_9     |          | Synchronizable mode (C.3)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GAP 1/2 "Limited discoverable mode", otherwise Optional.
+- C.2: Mandatory IF GAP 3/5 "Initiation of general bonding", otherwise
+  Optional.
+- C.3: Optional IF BB 3a/1 "Connectionless Peripheral Broadcast Transmitter",
+  otherwise Excluded.
+
+BR/EDR Capability Statement
+===========================
+**Table 2: Security Aspects**
+
+Prerequisite: GAP 0/1 "BR/EDR" OR GAP 0/3 "BR/EDR/LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_2_1     |          | Authentication procedure (C.1)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_2     | x        | Support of LMP-Authentication (M)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_3     | x        | Initiate LMP-Authentication (C.5)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_4     |          | Security mode 1 (C.7)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_5     |          | Security mode 2 (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_6     |          | Security mode 3 (C.7)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_7     | x        | Security mode 4 (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_7a    |          | Security mode 4, level 4 (C.9)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_7b    |          | Security mode 4, level 3 (C.9)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_7c    |          | Security mode 4, level 2 (C.9)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_7d    |          | Security mode 4, level 1 (C.9)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_8     | x        | Authenticated link key (C.6)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_9     | x        | Unauthenticated link key (C.6)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_10    | x        | Security Optional (C.6)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_11    | x        | Secure Connections Only Mode (C.8)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_12    |          | 56-bit minimum encryption key size (C.10)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_2_13    |          | 128-bit encryption key size capable (C.11)   |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GAP 2/5 "Security mode 2" OR GAP 2/6 "Security mode 3",
+  otherwise Optional.
+- C.5: Mandatory IF GAP 2/5 "Security mode 2" OR GAP 2/6 "Security mode 3" OR
+  GAP 2/7 "Security mode 4", otherwise Optional.
+- C.6: Mandatory to support at least one IF GAP 2/7 "Security mode 4",
+  otherwise Excluded.
+- C.7: Excluded. Note 2: A Core 2.1 or later is required to support security
+  mode 4. Security mode 2 is used only for backward compatibility purposes
+  with Core 2.0 and earlier devices. Security mode 1 and security mode 3 are
+  excluded for Core 2.1 or later devices
+- C.8: Mandatory IF GAP 25/10 "Secure Connections Only mode" OR
+  GAP 35/10 "Secure Connections Only mode", otherwise Optional IF LMP 2/26
+  "Secure Connections (Controller Support)" AND GAP 2/7a "Security mode 4,
+  level 4", otherwise Excluded.
+- C.9: Optional IF GAP 2/7 "Security mode 4", otherwise Excluded.
+- C.10: Optional IF GAP 2/7d "Security mode 4, level 1" OR
+  GAP 2/7c "Security mode 4, level 2" OR GAP 2/7b "Security mode 4, level 3",
+  otherwise Excluded.
+- C.11: Mandatory IF GAP 2/7a "Security mode 4, level 4", otherwise Optional
+  IF GAP 2/7d "Security mode 4, level 1" OR GAP 2/7c "Security mode 4, level
+  2" OR GAP 2/7b "Security mode 4, level 3", otherwise Excluded.
+
+BR/EDR Capability Statement
+===========================
+**Table 3: Idle Mode Procedures**
+
+Prerequisite: GAP 0/1 "BR/EDR" OR GAP 0/3 "BR/EDR/LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_3_1     | x        | Initiation of general inquiry (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_3_2     | x        | Initiation of limited inquiry (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_3_3     | x        | Initiation of name discovery (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_3_4     | x        | Initiation of device discovery (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_3_5     | x        | Initiation of general bonding (O)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_3_6     | x        | Initiation of dedicated bonding (O)          |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory to support at least one IF GAP 3/5 "Initiation of general
+  bonding", otherwise Optional.
+
+BR/EDR Capability Statement
+===========================
+**Table 4: Establishment Procedures**
+
+Prerequisite: GAP 0/1 "BR/EDR" OR GAP 0/3 "BR/EDR/LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_4_1     | x        | Link Establishment as initiator (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_2     | x        | Link Establishment as acceptor (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_3     | x        | Channel Establishment as initiator (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_4     | x        | Channel Establishment as acceptor (M)        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_5     | x        | Connection Establishment as initiator (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_6     | x        | Connection Establishment as acceptor (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_4_7     |          | Synchronization Establishment as receiver    |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF BB 3a/2 "Connectionless Peripheral Broadcast Receiver",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 5: LE Roles**
+
+Prerequisite: GAP 0/2 "LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_5_1     |          | Broadcaster (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_5_2     |          | Observer (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_5_3     |          | Peripheral (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_5_4     |          | Central (C.1)                                |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+LE Capability Statement
+=======================
+**Table 6: Broadcaster Physical Layer**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_6_1     | x        | Transmitter (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_6_2     | x        | Receiver (O)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 7: Broadcaster Link Layer States**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_7_1     | x        | Standby state (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_7_2     | x        | Advertising state (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_7_3     |          | Isochronous Broadcasting State (C.1)         |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 8: Broadcaster Link Layer Advertising Event Types**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_8_1     | x        | Non-connectable and non-scannable undirected |
+|                  |          | event (M)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8_2     | x        | Scannable undirected event (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8_3     |          | Non-connectable and non-scannable directed   |
+|                  |          | event (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8_4     |          | Scannable directed event (C.1)               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 8a: Broadcaster Link Layer Advertising Data Types**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_8a_1    | x        | Service UUID (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_2    | x        | Local Name (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_3    | x        | Flags (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_4    | x        | Manufacturer Specific Data (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_5    | x        | TX Power Level (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_6    |          | Security Manager OOB (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_7    |          | Security Manager TK Value (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_8    |          | Peripheral Connection Interval Range (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_9    |          | Service Solicitation (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_10   |          | Service Data (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_11   | x        | Appearance (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_12   |          | Public Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_13   |          | Random Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_14   |          | Advertising Interval (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_14a  |          | Advertising Interval - Long (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_15   |          | LE Bluetooth Device Address (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_16   |          | LE Role (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_17   |          | Uniform Resource Identifier (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_18   |          | LE Supported features (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_19   |          | Encrypted Data (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_8a_20   |          | Periodic Advertising Response Timing (O)     |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF SM 2/4 "OOB supported", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 9: Broadcaster Connection Modes and Procedures**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_9_1     | x        | Non-connectable mode (M)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 10: Broadcaster Broadcasting and Observing Features**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_10_1    | x        | Broadcast mode (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_10_2    |          | Broadcast Isochronous Synchronizability mode |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_10_3    |          | Broadcast Isochronous Broadcasting mode (C.2)|
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_10_4    |          | Broadcast Isochronous Terminate procedure    |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_10_5    |          | Broadcast Isochronous Channel Map Update     |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF GAP 10/3 "Broadcast Isochronous Broadcasting mode",
+  otherwise Excluded.
+- C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 11: Broadcaster Privacy Feature**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_11_1    |          | Privacy feature (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11_2    | x        | Resolvable private address generation        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11_3    | x        | Non-resolvable private address generation    |
+|                  |          | procedure (C.2)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11_4    |          | Resolvable private address resolution        |
+|                  |          | procedure (O)                                |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF GAP 11/1 "Privacy feature" AND NOT GAP 11/3
+  "Non-resolvable private address generation procedure", otherwise Optional.
+- C.2: Mandatory IF GAP 11/1 "Privacy feature" AND NOT GAP 11/2
+  "Resolvable private address generation procedure", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 11a: Periodic Advertising Modes and Procedures**
+
+Prerequisite: (GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster
+(BR/EDR/LE)") AND NOT (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18
+"Core v4.2+HS")
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_11a/1   |          | Periodic Advertising Synchronizability mode  |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11a/2   |          | Periodic Advertising mode (C.2)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11a/3   |          | Periodic Advertising with Responses (C.3)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11a/4   |          | Periodic Advertising Connection (C.4)        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF LL 3/10 "Periodic Advertising", otherwise Excluded.
+- C.2: Mandatory IF GAP 11a/1 "Periodic Advertising Synchronizability mode",
+  otherwise Excluded.
+- C.3: Mandatory IF LL 3/10a "Periodic Advertising with Responses",
+  otherwise Excluded.
+- C.4: Optional IF GAP 11a/3 "Periodic Advertising with Responses",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 11b: Broadcaster Security Aspects Features**
+
+Prerequisite: GAP 5/1 "Broadcaster (LE)" OR GAP 38/1 "Broadcaster (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_11b_1   |          | LE security mode 3 (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11b_2   |          | LE security mode 3 level 1 (C.2)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11b_3   |          | LE security mode 3 level 2 (C.2)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_11b_4   |          | LE security mode 3 level 3 (C.2)             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF GAP 10/2 "Broadcast Isochronous Synchronizability mode",
+  otherwise Excluded.
+- C.2: Mandatory to support at least one IF GAP 11b/1 "LE security mode 3",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 12: Observer Physical Layer**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_12_1    | x        | Receiver (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_12_2    | x        | Transmitter (O)                              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 13: Observer Link Layer States**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_13_1    | x        | Standby state (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_13_2    | x        | Scanning state (M)                           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 14: Observer Link Layer Scanning Types**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_14_1    | x        | Passive scanning (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14_2    | x        | Active scanning (O)                          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 14a: Observer Link Layer Scanning Data Types**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_14a_1   |          | Service UUID (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_2   |          | Local Name (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_3   |          | Flags (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_4   |          | Manufacturer Specific Data (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_5   |          | TX Power Level (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_6   |          | Security Manager OOB (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_7   |          | Security Manager TK Value (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_8   |          | Peripheral Connection Interval Range (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_9   |          | Service Solicitation (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_10  |          | Service Data (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_11  |          | Appearance (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_12  |          | Public Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_13  |          | Random Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_14  |          | Advertising Interval (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_14a |          | Advertising Interval - Long (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_15  |          | LE Bluetooth Device Address (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_16  |          | LE Role (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_17  |          | Uniform Resource Identifier (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_18  |          | LE Supported features (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_19  |          | Encrypted Data (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_14a_20  |          | Periodic Advertising Response Timing (O)     |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 15: Observer Connection Modes and Procedures**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_15_1    | x        | Non-connectable mode (M)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 16: Observer Broadcasting and Observing Features**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_16_1    | x        | Observation procedure (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_16_2    |          | Broadcast Isochronous Synchronization        |
+|                  |          | Establishment procedure (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_16_3    |          | Broadcast Isochronous Termination procedure  |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_16_4    |          | Broadcast Isochronous Channel Map Update     |
+|                  |          | procedure (C.2)                              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1",
+  otherwise Optional.
+- C.2: Mandatory IF GAP 16/2 "Broadcast Isochronous Synchronization
+  Establishment procedure", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 17: Observer Privacy Feature**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_17_1    |          | Privacy feature (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17_2    | x        | Non-resolvable private address generation    |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17_3    | x        | Resolvable private address resolution        |
+|                  |          | procedure (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17_4    | x        | Resolvable private address generation        |
+|                  |          | procedure (C.2)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF GAP 17/1 "Privacy feature" AND GAP 14/2 "Active scanning"
+  AND NOT GAP 17/4 "Resolvable private address generation procedure",
+  otherwise Optional.
+- C.2: Mandatory IF GAP 17/1 "Privacy feature" AND GAP 14/2 "Active scanning"
+  AND NOT GAP 17/2 "Non-resolvable private address generation procedure",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 17a: Periodic Advertising Modes and Procedures**
+
+Prerequisite: (GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)") AND
+NOT (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS")
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_17a_1   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure without listening for|
+|                  |          | periodic advertising (C.2)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17a_2   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure with listening for   |
+|                  |          | periodic advertising (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17a_3   |          | Periodic Advertising Connection (C.3)        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF LL 4/8 "Scanning for Periodic Advertising", otherwise
+  Excluded.
+- C.2: Optional IF LL 11/1 "Synchronizing to Periodic Advertising", otherwise
+  Excluded.
+- C.3: Optional IF LL 4/8a "Scanning for Periodic Advertising with Responses",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 17b: Observer Security Aspects Features**
+
+Prerequisite: GAP 5/2 "Observer (LE)" OR GAP 38/2 "Observer (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_17b_1   |          | LE security mode 3 (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17b_2   |          | LE security mode 3 level 1 (C.2)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17b_3   |          | LE security mode 3 level 2 (C.2)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_17b_4   |          | LE security mode 3 level 3 (C.2)             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF GAP 16/2 "Broadcast Isochronous Synchronization
+  Establishment procedure", otherwise Excluded.
+- C.2: Mandatory to support at least one IF GAP 17b/1 "LE security mode 3",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 18: Peripheral Physical Layer**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_18_1    | x        | Transmitter (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_18_2    | x        | Receiver (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 19: Peripheral Link Layer States**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_19_1    | x        | Standby state (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_19_2    | x        | Advertising state (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_19_3    | x        | Connection state, Peripheral role (M)        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 20: Peripheral Link Layer Advertising Event Types**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_20_1    | x        | Connectable and scannable undirected event   |
+|                  |          | (M)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_2    | x        | Connectable directed event (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_3    | x        | Non-connectable and non-scannable undirected |
+|                  |          | event (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_4    | x        | Scannable undirected event (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_5    | x        | Connectable undirected event (C.1)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_6    |          | Non-connectable and non-scannable directed   |
+|                  |          | event (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20_7    |          | Scannable directed event (C.1)               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 20A: Peripheral Link Layer Advertising Data Types**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_20A_1   |          | Service UUID (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_2   | x        | Local Name (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_3   | x        | Flags (C.2)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_4   | x        | Manufacturer Specific Data (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_5   | x        | TX Power Level (C.1)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_6   |          | Security Manager OOB (C.3)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_7   |          | Security Manager TK Value (C.1)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_8   |          | Peripheral Connection Interval Range (C.1)   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_9   |          | Service Solicitation (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_10  |          | Service Data (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_11  | x        | Appearance (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_12  |          | Public Target Address (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_13  |          | Random Target Address (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_14  |          | Advertising Interval (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_14a |          | Advertising Interval - Long (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_15  |          | LE Bluetooth Device Address (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_16  |          | LE Role (C.1)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_17  |          | Uniform Resource Identifier (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_18  |          | LE Supported features (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_19  |          | Encrypted Data (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_20A_20  |          | Periodic Advertising Response Timing (C.4)   |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF GAP 20/1 "Connectable and scannable undirected event" OR
+  GAP 20/3 "Non-connectable and non-scannable undirected event" OR GAP 20/4
+  "Scannable undirected event", otherwise Excluded.
+- C.2: Mandatory IF GAP 22/2 "Limited discoverable mode" OR GAP 22/3 "General
+  discoverable mode", otherwise Optional.
+- C.3: Optional IF (GAP 20/1 "Connectable and scannable undirected event" OR
+  GAP 20/3 "Non-connectable and non-scannable undirected event" OR GAP 20/4
+  "Scannable undirected event") AND SM 2/4 "OOB supported", otherwise
+  Excluded.
+- C.4: Mandatory IF LL 3/10a "Periodic Advertising with Responses",
+  otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 21: Peripheral Link Layer Control Procedures**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_21_1    | x        | Connection Update procedure (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_2    | x        | Channel Map Update procedure (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_3    | x        | Encryption procedure (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_4    | x        | Central-initiated Feature Exchange procedure |
+|                  |          | (M)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_5    | x        | Version Exchange procedure (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_6    | x        | Termination procedure (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_7    |          | LE Ping procedure (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_8    | x        | Peripheral-initiated Feature Exchange        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_9    | x        | Connection Parameter Request procedure (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_10   |          | Data Length Update procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_11   |          | PHY Update procedure (C.2)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_21_12   |          | Minimum Number Of Used Channels procedure    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GAP 21/9 "Connection Parameter Request procedure",
+  otherwise Optional.
+- C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 22: Peripheral Discovery Modes and Procedures**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_22_1    | x        | Non-discoverable mode (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_22_2    | x        | Limited discoverable mode (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_22_3    | x        | General discoverable mode (C.1)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_22_4    | x        | Name discovery procedure (O)                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF NOT GAP 22/2 "Limited discoverable mode", otherwise
+  Optional.
+
+LE Capability Statement
+=======================
+**Table 23: Peripheral Connection Modes and Procedures**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_23_1    | x        | Non-connectable mode (M)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_2    |          | Directed connectable mode (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_3    | x        | Undirected connectable mode (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_4    |          | Connection parameter update procedure (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_5    | x        | Terminate connection procedure (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_6    |          | Connected Isochronous Stream Peripheral      |
+|                  |          | Establishment procedure (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_7    |          | Connected Isochronous Stream Terminate       |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_23_8    |          | Connection Subrate procedure (C.2)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF LL 9/32 "Connected Isochronous Stream Peripheral",
+  otherwise Excluded.
+- C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1" OR SUM ICS 31/21
+  "Core v5.2", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 24: Peripheral Bonding Modes and Procedures**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_24_1    | x        | Non-bondable mode (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_24_2    | x        | Bondable mode (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_24_3    | x        | Bonding procedure (C.2)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_24_4    | x        | Multiple Bonds (C.1)                         |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF GAP 24/2 "Bondable mode", otherwise Excluded.
+- C.2: Mandatory IF GAP 24/2 "Bondable mode", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 25: Peripheral Security Aspects Features**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_25_1    | x        | LE security mode 1 (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_2    | x        | LE security mode 2 (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_3    | x        | Authentication procedure (O)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_4    | x        | Authorization procedure (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_5    | x        | Connection data signing procedure (C.6)      |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_6    | x        | Authenticate signed data procedure (C.6)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_7    | x        | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_8    | x        | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_9    | x        | LE security mode 1 level 4 (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_10   | x        | Secure Connections Only mode (C.4)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_11   |          | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) with LE Secure Connections Pairing  |
+|                  |          | only (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_12   |          | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) with LE Secure Connections Pairing  |
+|                  |          | only (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_13   | x        | Minimum 128 Bit entropy key (C.5)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_25_14   | x        | Client security checks for GATT indications  |
+|                  |          | and notifications (C.7)                      |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF GAP 25/1 "LE security mode 1", otherwise Excluded.
+- C.4: Mandatory IF GAP 2/11 "Secure Connections Only Mode" OR GAP 35/10
+  "Secure Connections Only mode", otherwise Optional IF GAP 25/9 "LE security
+  mode 1 level 4", otherwise Excluded.
+- C.5: Mandatory IF GAP 25/9 "LE security mode 1 level 4", otherwise Optional
+  IF GAP 25/11 "Unauthenticated Pairing (LE security mode 1 level 2) with LE
+  Secure Connections Pairing only" OR GAP 25/12 "Authenticated Pairing (LE
+  security mode 1 level 3) with LE Secure Connections Pairing only",
+  otherwise Excluded.
+- C.6: Mandatory to support at least one IF GAP 25/2 "LE security mode 2",
+  otherwise Optional.
+- C.7: Optional IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1" OR SUM ICS 31/21
+  "Core v5.2", otherwise Mandatory.
+
+LE Capability Statement
+=======================
+**Table 26: Peripheral Privacy Feature**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_26_1    |          | Privacy feature (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_26_2    | x        | Non-resolvable private address generation    |
+|                  |          | procedure (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_26_3    | x        | Resolvable private address generation        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_26_4    | x        | Resolvable private address resolution        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF GAP 26/1 "Privacy feature", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 27: Peripheral GAP Characteristics**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_27_1    | x        | Device Name (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_2    | x        | Appearance (M)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_5    |          | Peripheral Preferred Connection Parameters   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_6    |          | Writable Device Name (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_7    |          | Writable Appearance (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_9    |          | Central Address Resolution (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_10   |          | Encrypted Data Key Material (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27_11   |          | LE GATT Security Levels (O)                  |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF LL 2/5 "Resolution of private addresses", otherwise
+  Excluded.
+
+LE Capability Statement
+=======================
+**Table 27a: Periodic Advertising Modes and Procedures**
+
+Prerequisite: (GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)")
+AND NOT (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS" OR SUM ICS
+31/19 "Core v5.0")
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_27a_1   |          | Periodic Advertising Synchronization Transfer|
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27a_2   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure over an LE connection|
+|                  |          | without listening for periodic advertising   |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27a_3   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure over an LE connection|
+|                  |          |  with listening for periodic advertising     |
+|                  |          | (C.3)                                        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF LL 9/26 "Periodic Advertising Sync Transfer: Sender",
+  otherwise Excluded.
+- C.2: Optional IF LL 9/27 "Periodic Advertising Sync Transfer: Recipient",
+  otherwise Excluded.
+- C.3: Optional IF LL 11/1 "Synchronizing to Periodic Advertising" AND LL 9/27
+  "Periodic Advertising Sync Transfer: Recipient", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 27b: SM Requirements**
+
+Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_27b_1   | x        | Peripheral Role (Responder) (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_2   | x        | Authenticated MITM protection (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_3   | x        | Unauthenticated no MITM protection (C.2)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_4   |          | No security requirements (C.3)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_5   | x        | LE Secure Connections (C.4)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_6   | x        | Encryption Key (C.5)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_7   | x        | Identity Key (C.6)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_27b_8   | x        | Signing Key (C.7)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF GAP 25/7 "Authenticated Pairing (LE security mode 1 level
+  3)" OR GAP 25/12 "Authenticated Pairing (LE security mode 1 level 3) with LE
+  Secure Connections Pairing only" OR (GAP 25/2 "LE security mode 2" AND GAP
+  25/3 "Authentication procedure"), otherwise not defined.
+- C.2: Mandatory IF GAP 25/8 "Unauthenticated Pairing (LE security mode 1
+  level 2)" OR GAP 25/11 "Unauthenticated Pairing (LE security mode 1 level 2)
+  with LE Secure Connections Pairing only" OR (GAP 25/2 "LE security mode 2"
+  AND NOT GAP 25/3 "Authentication procedure"), otherwise not defined.
+- C.3: Mandatory IF GAP 25/1 "LE security mode 1" AND NOT GAP 25/8
+  "Unauthenticated Pairing (LE security mode 1 level 2)" AND NOT GAP 25/7
+  "Authenticated Pairing (LE security mode 1 level 3)", otherwise not defined.
+- C.4: Mandatory IF GAP 25/9 "LE security mode 1 level 4" OR GAP 25/11
+  "Unauthenticated Pairing (LE security mode 1 level 2) with LE Secure
+  Connections Pairing only" OR GAP 25/12 "Authenticated Pairing (LE security
+  mode 1 level 3) with LE Secure Connections Pairing only", otherwise not
+  defined.
+- C.5: Mandatory IF GAP 24/2 "Bondable mode", otherwise not defined.
+- C.6: Mandatory IF GAP 26/3 "Resolvable private address generation
+  procedure", otherwise not defined.
+- C.7: Mandatory IF GAP 25/6 "Authenticate signed data procedure", otherwise
+  not defined.
+
+LE Capability Statement
+=======================
+**Table 28: Central Physical Layer**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_28_1    | x        | Transmitter (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_28_2    | x        | Receiver (M)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 29: Central Link Layer States**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_29_1    | x        | Standby state (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_29_2    | x        | Scanning state (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_29_3    | x        | Initiating state (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_29_4    | x        | Connection state, Central role (M)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+LE Capability Statement
+=======================
+**Table 30: Central Link Layer Scanning Types**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_30_1    | x        | Passive scanning (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30_2    | x        | Active scanning (C.1)                        |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF NOT GAP 30/1 "Passive scanning", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 30a: Central Link Layer Scanning Data Types**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_30a_1   |          | Service UUID (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_2   |          | Local Name (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_3   |          | Flags (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_4   |          | Manufacturer Specific Data (O)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_5   |          | TX Power Level (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_6   |          | Security Manager OOB (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_7   |          | Security Manager TK Value (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_8   |          | Peripheral Connection Interval Range (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_9   |          | Service Solicitation (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_10  |          | Service Data (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_11  |          | Appearance (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_12  |          | Public Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_13  |          | Random Target Address (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_14  |          | Advertising Interval (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_14a |          | Advertising Interval - Long (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_15  |          | LE Bluetooth Device Address (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_16  |          | LE Role (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_17  |          | Uniform Resource Identifier (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_18  |          | LE Supported features (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_19  |          | Encrypted Data (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_30a_20  |          | Periodic Advertising Response Timing (O)     |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 31: Central Link Layer Control Procedures**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_31_1    | x        | Connection Update procedure (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_2    | x        | Channel Map Update procedure (M)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_3    | x        | Encryption procedure (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_4    | x        | Central-initiated Feature Exchange procedure |
+|                  |          | (M)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_5    | x        | Version Exchange procedure (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_6    | x        | Termination procedure (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_7    |          | LE Ping procedure (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_8    | x        | Peripheral-initiated Feature Exchange        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_9    | x        | Connection Parameter Request procedure (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_10   |          | Data Length Update procedure (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_11   |          | PHY Update procedure (C.2)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_31_12   |          | Minimum Number Of Used Channels procedure    |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GAP 31/9 "Connection Parameter Request procedure",
+  otherwise Optional.
+- C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
+  otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 32: Central Discovery Modes and Procedures**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_32_1    | x        | Limited Discovery procedure (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_32_2    | x        | General Discovery procedure (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_32_3    | x        | Name Discovery procedure (O)                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+LE Capability Statement
+=======================
+**Table 33: Central Connection Modes and Procedures**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_33_1    | x        | Auto connection establishment procedure (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_2    | x        | General connection establishment procedure   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_3    | x        | Selective connection establishment procedure |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_4    | x        | Direct connection establishment procedure (M)|
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_5    | x        | Connection parameter update procedure (M)    |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_6    | x        | Terminate connection procedure (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_7    |          | Connected Isochronous Stream Central         |
+|                  |          | Establishment procedure (C.1)                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_8    |          | Connected Isochronous Stream Terminate       |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_33_9    |          | Connection Subrate procedure (C.2)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF LL 9/31 "Connected Isochronous Stream Central",
+  otherwise Excluded.
+- C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1" OR SUM ICS 31/21
+  "Core v5.2", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 34: Central Bonding Modes and Procedures**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_34_1    | x        | Non-bondable mode (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_34_2    | x        | Bondable mode (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_34_3    | x        | Bonding procedure (C.1)                      |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF GAP 34/2 "Bondable mode", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 35: Central Security Features**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_35_1    | x        | LE security mode 1 (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_2    | x        | LE security mode 2 (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_3    | x        | Authentication procedure (O)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_4    |          | Authorization procedure (O)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_5    |          | Connection data signing procedure (O)        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_6    |          | Authenticate signed data procedure (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_7    | x        | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_8    | x        | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_9    | x        | LE security mode 1 level 4 (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_10   | x        | Secure Connections Only mode (C.3)           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_11   |          | Unauthenticated Pairing (LE security mode 1  |
+|                  |          | level 2) with LE Secure Connections Pairing  |
+|                  |          | only (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_12   |          | Authenticated Pairing (LE security mode 1    |
+|                  |          | level 3) with LE Secure Connections Pairing  |
+|                  |          | only (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_13   | x        | Minimum 128 Bit entropy key (C.4)            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_14   |          | Encrypted Advertising Data Procedure (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_35_15   | x        | Client security checks for GATT indications  |
+|                  |          | and notifications (C.5)                      |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF GAP 35/1 "LE security mode 1", otherwise Excluded.
+- C.3: Mandatory IF GAP 2/11 "Secure Connections Only Mode" OR GAP 25/10
+  "Secure Connections Only mode", otherwise Optional IF GAP 35/9 "LE security
+  mode 1 level 4", otherwise Excluded.
+- C.4: Mandatory IF GAP 35/9 "LE security mode 1 level 4", otherwise Optional
+  IF GAP 35/11 "Unauthenticated Pairing (LE security mode 1 level 2) with LE
+  Secure Connections Pairing only" OR GAP 35/12 "Authenticated Pairing (LE
+  security mode 1 level 3) with LE Secure Connections Pairing only", otherwise
+  Excluded.
+- C.5: Optional IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1" OR SUM ICS 31/21
+  "Core v5.2", otherwise Mandatory.
+
+LE Capability Statement
+=======================
+**Table 36: Central Privacy Feature**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_36_1    |          | Privacy feature (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_36_2    | x        | Non-resolvable private address generation    |
+|                  |          | procedure (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_36_3    | x        | Resolvable private address resolution        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_36_5    | x        | Resolvable private address generation        |
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF GAP 36/1 "Privacy feature", otherwise Optional.
+
+LE Capability Statement
+=======================
+**Table 37: Central GAP Characteristics**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_37_1    | x        | Device Name (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37_2    | x        | Appearance (M)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37_3    |          | Central Address Resolution (C.1)             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37_4    |          | LE GATT Security Levels (O)                  |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF LL 2/5 "Resolution of private addresses", otherwise
+  Excluded.
+
+LE Capability Statement
+=======================
+**Table 37a: Periodic Advertising Modes and Procedures**
+
+Prerequisite: (GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)") AND
+NOT (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS" OR SUM ICS
+31/19 "Core v5.0")
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_37a_1   |          | Periodic Advertising Synchronization Transfer|
+|                  |          | procedure (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37a_2   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure over an LE connection|
+|                  |          | without listening for periodic advertising   |
+|                  |          | (C.2)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37a_3   |          | Periodic Advertising Synchronization         |
+|                  |          | Establishment procedure over an LE connection|
+|                  |          | with listening for periodic advertising (C.3)|
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF LL 9/26 "Periodic Advertising Sync Transfer: Sender",
+  otherwise Excluded.
+- C.2: Optional IF LL 9/27 "Periodic Advertising Sync Transfer: Recipient",
+  otherwise Excluded.
+- C.3: Optional IF LL 11/1 "Synchronizing to Periodic Advertising" AND LL 9/27
+  "Periodic Advertising Sync Transfer: Recipient", otherwise Excluded.
+
+LE Capability Statement
+=======================
+**Table 37b: SM Requirements**
+
+Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_37b_1   | x        | Central Role (Initiator) (M)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_2   | x        | Authenticated MITM protection (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_3   | x        | Unauthenticated no MITM protection (C.2)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_4   |          | No security requirements (C.3)               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_5   | x        | LE Secure Connections (C.4)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_6   | x        | Encryption Key (C.5)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_7   | x        | Identity Key (C.6)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_37b_8   |          | Signing Key (C.7)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF GAP 35/7 "Authenticated Pairing (LE security mode 1 level
+  3)" OR GAP 35/12 "Authenticated Pairing (LE security mode 1 level 3) with
+  LE Secure Connections Pairing only" OR (GAP 35/2 "LE security mode 2" AND
+  GAP 35/3 "Authentication procedure"), otherwise not defined.
+- C.2: Mandatory IF GAP 35/8 "Unauthenticated Pairing (LE security mode 1
+  level 2)" OR GAP 35/11 "Unauthenticated Pairing (LE security mode 1 level
+  2) with LE Secure Connections Pairing only" OR (GAP 35/2 "LE security mode
+  2" AND NOT GAP 35/3 "Authentication procedure"), otherwise not defined.
+- C.3: Mandatory IF GAP 35/1 "LE security mode 1" AND NOT GAP 35/8
+  "Unauthenticated Pairing (LE security mode 1 level 2)" AND NOT GAP 35/7
+  "Authenticated Pairing (LE security mode 1 level 3)", otherwise not defined.
+- C.4: Mandatory IF GAP 35/9 "LE security mode 1 level 4" OR GAP 35/11
+  "Unauthenticated Pairing (LE security mode 1 level 2) with LE Secure
+  Connections Pairing only" OR GAP 35/12 "Authenticated Pairing (LE security
+  mode 1 level 3) with LE Secure Connections Pairing only", otherwise not
+  defined.
+- C.5: Mandatory IF GAP 34/2 "Bondable mode", otherwise not defined.
+- C.6: Mandatory IF GAP 36/5 "Resolvable private address generation
+  procedure", otherwise not defined.
+- C.7: Mandatory IF GAP 35/6 "Authenticate signed data procedure", otherwise
+  not defined.
+
+BR/EDR/LE Capability Statement
+=======================
+**Table 38: BR/EDR/LE Roles**
+
+Prerequisite: GAP 0/3 "BR/EDR/LE"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_38_1    | x        | Broadcaster (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_38_2    | x        | Observer (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_38_3    | x        | Peripheral (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_38_4    | x        | Central (C.1)                                |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+BR/EDR/LE Capability Statement
+=======================
+**Table 41: Central BR/EDR/LE Security Aspects**
+
+Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_41_1    | x        | Security aspects (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_41_2a   |          | Derivation of BR/EDR Link Key from LE LTK (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_41_2b   |          | Derivation of LE LTK from BR/EDR Link Key (O)|
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+BR/EDR/LE Capability Statement
+=======================
+**Table 44: Central Simultaneous BR/EDR and LE Transports**
+
+Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_44_1    | x        | Simultaneous BR/EDR and LE Transports -      |
+|                  |          | BR/EDR Peripheral to the same device (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_44_2    | x        | Simultaneous BR/EDR and LE Transports -      |
+|                  |          | BR/EDR Central to the same device (O)        |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+BR/EDR/LE Capability Statement
+=======================
+**Table 43: Peripheral BR/EDR/LE Security Aspects**
+
+Prerequisite: GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_43_1    | x        | Security aspects (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_43_2a   |          | Derivation of BR/EDR Link Key from LE LTK (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_43_2b   |          | Derivation of LE LTK from BR/EDR Link Key (O)|
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+BR/EDR/LE Capability Statement
+=======================
+**Table 45: Peripheral Simultaneous BR/EDR and LE Transports**
+
+Prerequisite: GAP 38/3 "Peripheral (BR/EDR/LE)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_GAP_45_1    | x        | Simultaneous BR/EDR and LE Transports -      |
+|                  |          | BR/EDR Peripheral to the same device (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_GAP_45_2    | x        | Simultaneous BR/EDR and LE Transports -      |
+|                  |          | BR/EDR Central to the same device (O)        |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
diff --git a/doc/qualification/gap-pts.rst b/doc/qualification/gap-pts.rst
new file mode 100644
index 000000000..d7fa58c75
--- /dev/null
+++ b/doc/qualification/gap-pts.rst
@@ -0,0 +1,2228 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+GAP test results
+================
+
+:PTS version: 8.5.3 Build 4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- In IXIT update:
+
+  - "TSPX_iut_device_name_in_adv_packet_for_random_address" to the IUT name
+
+  - "TSPX_iut_invalid_connection_interval_min" to "0004"
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
+| GAP/BROB/BCST/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt':                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# add-adv -d                                                    |
+|                        |          |         |       |   0201040503001801180D095054532D4741502D3036423803190000 1              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising on                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising off                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising on                                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BROB/BCST/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt':                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# add-adv -d                                                    |
+|                        |          |         |       |   0201040503001801180D095054532D4741502D3036423803190000 1              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising on                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising off                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# advertising on                                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BROB/BCST/BV-03-C  | PASS     |     6.9 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# power off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.privacy on                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# power on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.name on                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.add-adv                                           |
+|                        |          |         |       |     0201040503001801180D095054532D4741502D3036423803190000 1            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.connectable on                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.advertising on                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayYesNo                                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# power off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.privacy off                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# power on                                                 |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BROB/OBSV/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt':                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# find -l                                                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BROB/OBSV/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt':                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [mgmt]# find -l                                                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/NONM/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on' on demand                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/NONM/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# power off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.bredr off'                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.connectable on'                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.discov off'                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# power on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.advertising on                                    |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# power off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.bredr on                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# power on                                                 |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMM/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl' on demand:                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise.discoverable-timeout 30                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise.timeout 45                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMM/BV-02-C  | PASS     |     6.9 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.connectable on                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.advertising on                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.discov limited 30                                 |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENM/BV-01-C  | **FAIL** |     6.1 | 5.69  | **"Does the IUT have an ability to send non-connectable advertising     |
+|                        |          |         |       | report?"**                                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENM/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run :                                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt connectable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt advertising on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt discov on                                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMP/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMP/BV-03-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMP/BV-04-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/LIMP/BV-05-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl scan on' on demand                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENP/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENP/BV-03-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl scan on' on demand                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENP/BV-04-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl scan on' on demand                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DISC/GENP/BV-05-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl scan on' on demand                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/NAMP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on' on demand                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/NAMP/BV-02-C  | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/GIN/BV-01-C   | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/DNDIS/BV-01-C | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run :                                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl discoverable on                                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/LIN/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/DED/BV-02-C   | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/BON/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/BON/BV-03-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/BON/BV-04-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/BON/BV-05-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -n -P 4097 <bdaddr>' on request                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/IDLE/BON/BV-06-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -n -P 4097 <bdaddr>' on request                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/NCON/BV-01-C  | PASS     |     6.1 | 5.69  | Reply No to question "Does the IUT have an ability to send              |
+|                        |          |         |       | non-connectable advertising report?"                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'sudo btmgmt connectable off' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/NCON/BV-02-C  | PASS     |     6.1 | 5.69  | Reply No to question "Does the IUT have an ability to send              |
+|                        |          |         |       | non-connectable advertising report?"                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/NCON/BV-03-C  | PASS     |     6.1 | 5.69  | Reply No to question "Does the IUT have an ability to send              |
+|                        |          |         |       | non-connectable advertising report?"                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/DCON/BV-01-C  | **FAIL** |     6.1 | 5.69  | **"Did not find IUT's advertising packet with the event type = 1"       |
+|                        |          |         |       | (Directed Connectable Mode ?)**                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/UCON/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt connectable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt advertising on                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/UCON/BV-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt connectable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt advertising on                                          |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/UCON/BV-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt connectable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt advertising on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo btmgmt discov limited 30                                       |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/ACEP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/GCEP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/GCEP/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/SCEP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/DCEP/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/DCEP/BV-03-C  | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-02-C  | **FAIL** |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | **'This test case expected the 'connection parameter update request' to |
+|                        |          |         |       | timeout. Please consider changing the value(s) in                       |
+|                        |          |         |       | TSPX_conn_update_int_max, TSPX_conn_update_int_min,                     |
+|                        |          |         |       | TSPX_conn_update_peripheral_latency and                                 |
+|                        |          |         |       | TSPX_conn_update_supervision_timeout in the IXIT table item(s) and run  |
+|                        |          |         |       | the test again.'**                                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'btgatt-client -d <pts_le_only_addr>' on demand                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-05-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'btgatt-client -d <pts_le_only_addr>' on demand                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-06-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - ** Request hcitool**                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo systemctl restart bluetooth                                    |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'btgatt-client -d <pts_le_only_addr>' on demand                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | After services has been displayed run in a second terminal:             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - hcitool lecup 1 0x0032 0x0046 0x0001 0x01F4                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-08-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/CPUP/BV-10-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - ** Request hcitool**                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run:                                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo systemctl restart bluetooth                                    |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'bluetoothctl advertise on' on demand                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | After services has been displayed run in a second terminal:             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - hcitool lecup 1 0x0032 0x0046 0x0001 0x01F4                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/CONN/TERM/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/EST/LIE/BV-02-C    | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/NBON/BV-01-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl pair <bdaddr>' on demand                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'sudo btmgmt bondable off' on demand                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>' on demand                                 |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt bondable on                                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/NBON/BV-02-C  | PASS     |     6.1 | 5.69  | Run 'bluetoothctl pair <bdaddr>' on demand                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/NBON/BV-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - bluetoothctl advertise on                                             |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt bondable off                                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt bondable on                                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/BON/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on' on demand                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/BON/BV-02-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on' on demand                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/BON/BV-03-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on' on demand                               |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/BOND/BON/BV-04-C   | PASS     |     6.1 | 5.69  | Pair to PTS on demand                                                   |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-04-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-05-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.bondable off                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent NoInputNoOutput                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.bondable on                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-50-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.bondable off                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent NoInputNoOutput                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.bondable on                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-06-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-51-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in the second terminal on demand:                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-07-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc only                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-52-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc only                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan on                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-08-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -n -P 4097 -E <bdaddr>' on demand                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-09-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent NoInputNoOutput                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 8193 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a third terminal on demand:                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr> -S                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-53-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent NoInputNoOutput                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 8193 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in the second terminal on demand:                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 8193 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a third terminal on demand:                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr> -S                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-10-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -E                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BI-24-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run in a first terminal:                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - sudo bluetoothctl mgmt.sc on                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - bluetoothctl discoverable on                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - l2test -r -P 4097                                                   |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run in a second terminal, when PTs is waiting for L2CAP connection (3   |
+|                        |          |         |       | secs, may need multiple retry)                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-11-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -E                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-12-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -E                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-13-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-47-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-14-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-48-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-15-C    | **INC**  |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | (- [bluetooth]# remove <bdaddr>)                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"Please send L2CAP Connection Response with Security Blocked to PTS"**|
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-49-C    | **INC**  |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -r -P 4097 -S                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"Please send L2CAP Connection Response with Security Blocked to PTS"**|
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-16-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -r -P 4097 -E <bdaddr>' on demand                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-17-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -r -P 4097 -E <bdaddr>' on demand                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-18-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-54-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in the second terminal on demand:                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-19-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-55-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in the second terminal on demand:                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-20-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'l2test -r -P 4097 -E <bdaddr>' on demand                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Use '0000' Pin code on demand                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-21-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run 'bluetoothctl':                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on "ATT service request" demand:                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-22-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
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
+| GAP/SEC/SEM/BV-23-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
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
+| GAP/SEC/SEM/BV-24-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc on                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
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
+| GAP/SEC/SEM/BV-25-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc only                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-56-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - **Request patch                                                       |
+|                        |          |         |       |   shared-gatt-Add-env-variable-to-prefer-indication-ov.patch**          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e '[Service]\nEnvironment="PREFER_INDICATION=1"' | \            |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/indication_env.conf  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-57-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - **Request patch                                                       |
+|                        |          |         |       |   shared-gatt-Add-env-variable-to-prefer-indication-ov.patch**          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e '[Service]\nEnvironment="PREFER_INDICATION=1"' | \            |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/indication_env.conf  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-58-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - **Request patch                                                       |
+|                        |          |         |       |   shared-gatt-Add-env-variable-to-prefer-indication-ov.patch**          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e '[Service]\nEnvironment="PREFER_INDICATION=1"' | \            |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/indication_env.conf  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-59-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-60-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-61-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait for reconnection                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-26-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024]# gatt.select-attribute \                               |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<handle - 1>]# gatt.read             |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-27-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA read,write         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-28-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl'                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.sc on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayYesNo                                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-29-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl'                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayYesNo                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA secure-write       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-30-C    | PASS     |     6.1 | 5.69  | Run 'sudo bluetoothctl'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc only                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent off                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# agent DisplayYesNo                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le                                                  |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Disconnect on demand:                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run in a second terminal on demand:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 4097 <bdaddr>                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-62-C    | PASS     |     6.1 | 5.70  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | In *btgatt-client*:                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# write-value 0x<handle> 02 00                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-client -d <bdaddr>' on demand:                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# register-notify 0x<handle - 2>                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-63-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | In *btgatt-client*:                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# write-value 0x<handle> 02 00                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-client -d <bdaddr>' on demand:                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# register-notify 0x<handle - 2>                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-64-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | In *btgatt-client*:                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# write-value 0x<handle> 02 00                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Run 'btgatt-client -d <bdaddr>' on demand:                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# register-notify 0x<handle - 2>                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-65-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-66-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-67-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le                                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<yyyy>]# gatt.notify on              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - '[PTS-GAP-1024]# gatt.select-attribute \                              |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<yyyy>' where \      |
+|                        |          |         |       |   char<yyyy>/desc<handle>                                               |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BI-09-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BI-10-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# remove <bdaddr>                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# mgmt.sc on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayYesNo                                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | In a second terminal, repeat on demand:                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -s fips -d <bdaddr>                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | In first terminal, repeat on demand:                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.sc off                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/SEM/BV-45-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Click *No* on "Click Yes if device support User Interaction to pair     |
+|                        |          |         |       | with peer" request                                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-11-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA secure-read        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-12-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-13-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-14-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-17-C    | PASS     |     6.1 | 5.69  | Run 'btgatt-client -d <pts_addr>' on demand                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# read-value 0x<handle>                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Accept pairing                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# read-value 0x<handle>'                                 |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-18-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024]# gatt.select-attribute \                               |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<handle - 1>]# gatt.read             |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-19-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - In a second terminal, run 'sudo btmgmt' to be able to see the         |
+|                        |          |         |       |   requested passkey                                                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <pts_addr>                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Repeat on demand:                                                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [GATT client]# read-value 0x<handle>                                  |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-20-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo mkdir -p /etc/systemd/system/bluetooth.service.d                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - echo -e \                                                             |
+|                        |          |         |       |   '[Service]\nExecStart=\nExecStart=/usr/lib/bluetooth/bluetoothd \     |
+|                        |          |         |       |   --noplugin=gap' | \                                                   |
+|                        |          |         |       |   sudo tee /etc/systemd/system/bluetooth.service.d/no_gap.conf          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'sudo bluetoothctl':                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024]# gatt.select-attribute \                               |
+|                        |          |         |       |   /org/bluez/hci0/<dev_pts_addr>/service<xxxx>/char<handle - 1>         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-1024:/service<xxxx>/char<handle - 1>]# gatt.read             |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo rm -rf /etc/systemd/system/bluetooth.service.d                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl daemon-reload                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo systemctl restart bluetooth                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-21-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# scan le'                                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-22-C    | **INC**  |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"Security failed. result = 4 Failed to complete a security procedure."|
+|                        |          |         |       | or "Please confirm that IUT has informed of a lost bond."**             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-23-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-24-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Set "TSPX_encryption_before_service_request" in IXIT to "True"        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayOnly                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On handle request, enter the handle displayed for the characteristic    |
+|                        |          |         |       | during register-application                                             |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Set "TSPX_encryption_before_service_request" in IXIT to "False        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-25-C    | **INC**  |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayOnly                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"PTS did not receive ATT service request"**                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/AUT/BV-27-C    | **INC**  |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'sudo bluetoothctl':                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent off                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# agent DisplayOnly                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan le                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"PTS did not receive ATT service request"**                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BV-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Set "TSPX_gap_iut_role" in IXIT to "Central"                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run in a first terminal:                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand run in a first terminal:                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - 'sudo grep -A 1 LocalSignatureKey \                                   |
+|                        |          |         |       |   /var/lib/bluetooth/<iut_bdaddr>/<pts_bdaddr>/info | grep -v \         |
+|                        |          |         |       |   LocalSignatureKey | cut -d "=" -f 2' to get local CSRK                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>:                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# set-sign-key -c <local_CSRK>                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [GATT client]# write-value -w -s 0x<handle> 0                       |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Post-condition:                                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Set "TSPX_gap_iut_role" in IXIT to "Peripheral                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BV-02-C  | PASS     |     6.1 | 5.73  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BI-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | No data update message => OK                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BI-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | 2 update messages, out of 3 signed write commands => OK                 |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BI-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     encrypt-authenticated-read                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | No data update message => OK                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/SEC/CSIGN/BI-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA \                  |
+|                        |          |         |       |     authenticated-signed-writes,encrypt-authenticated-write             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | No data update message => OK                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-01-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.uuids AAAA                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-02-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.name on                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-03-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-04-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.manufacture 01 01 02 03 04 05 06             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-05-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.tx-power on                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/ADV/BV-11-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise.appearance 1                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/GAT/BV-04-C        | **FAIL** |     6.1 | 5.69  | Optional (TSPC_GAP_27_5)                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | **"Failed to find any instances of the characteristic under             |
+|                        |          |         |       | test(Peripheral Preferred Connection Parameters)"**                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/NCON/BV-01-C    | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt connectable off                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - bluetoothctl advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Pair to PTS on demand                                                   |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/CON/BV-01-C     | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt connectable on                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - bluetoothctl advertise off                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/BON/BV-01-C     | PASS     |     6.1 | 5.69  | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo bluetoothctl:                                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan on                                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | after "Please set IUT into bondable mode":                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# pair <bdaddr>                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# mgmt.pair -c 0x04 -t 0x01 <bdaddr>                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand:                                                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# connect <bdaddr>                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/GIN/BV-01-C     | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find' on demand                                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LIN/BV-01-C     | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find -L' on demand                                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/NAD/BV-01-C     | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt find' on demand                                        |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/NAD/BV-02-C     | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-01-C     | PASS     |     6.1 | 5.69  | Run 'bluetoothctl'                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Sometimes got "BR/EDR not Supported Flag should be set to 0 for         |
+|                        |          |         |       | BR/EDR/LE compliant device", retry                                      |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-06-C     | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Request LE Only dongle for PTS                                        |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Run 'btgatt-client -d <pts_le_only_addr>' on demand                     |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-07-C     | PASS     |     6.1 | 5.69  | Run 'bluetoothctl'                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-08-C     | PASS     |     6.1 | 5.69  | Run 'bluetoothctl'                                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# discoverable on                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-09-C     | PASS     |     6.1 | 5.69  | On demand, run in a first terminal:                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | On demand, run in a second terminal:                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 31 <bdaddr>                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-10-C     | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# discoverable on                                        |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# scan on                                                |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand, run in a second terminal:                                    |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - l2test -n -P 31 <bdaddr>                                              |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/DM/LEP/BV-11-C     | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - bluetoothctl discoverable on                                          |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/NDIS/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl discoverable off' on demand                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/LDIS/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt discov limited 30' on demand                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/LDIS/BV-02-C   | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt discov limited 30' on demand                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/LDIS/BV-03-C   | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt discov limited 30' on demand                           |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/GDIS/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl discoverable on' on demand                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/GDIS/BV-02-C   | PASS     |     6.1 | 5.69  | Run 'bluetoothctl discoverable on' on demand                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/NCON/BV-01-C   | PASS     |     6.1 | 5.69  | Run 'sudo btmgmt connectable off' before starting the tests             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GAP/MOD/CON/BV-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - bluetoothctl discoverable on                                          |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On demand run:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - sudo btmgmt connectable on                                            |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

