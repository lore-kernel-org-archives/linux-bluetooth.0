Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01338BF66
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838158; cv=none; b=vC6fdUE5sPja0fCf86MY99KnrQmNmhrKHzjvpEjl0cbFOJ5/I0FIuQJII1feNp5uszHuvLSVGdpXyG6QWTnzFgBa0V8YuuSUZ73UJj+iBVkra3Xu1+HX/ytxSY7l5MK6kpiele/Jnpy+PAV1a8ed9YZYN0p+c5smUy6qVag7gqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838158; c=relaxed/simple;
	bh=3nSAvgk1jY9RIGuFPEsY5pFND9kiAc/qf9DlBBGq+Ks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyE7XNLqFLOTa3O58l9YYNT9lXb3fHktp62tSg7jICYSvLDGLp9k/YuBDoMgwuXbbxr7EUkXAsQStdI+ToffVmiuzE91KLHAYyWtycGd+YF6RHs7uaalHWw+MOJlNafBzNbDQaHZ7UK3or9UdyNRZizbQSjs43qeFCIiNxlFMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IFWDMXPD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IFWDMXPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768838153;
	bh=3nSAvgk1jY9RIGuFPEsY5pFND9kiAc/qf9DlBBGq+Ks=;
	h=From:To:Subject:Date:From;
	b=IFWDMXPDS5TrdnES9YF0/6PBg17/TT/GeSTI1gp3vCTbkufvqq1pTqzhw23UPuYKx
	 PgxQ1YLXCdhvWg/Sov3sDF4XYv27qQYxRTpIHS5Yxrpoy81XShClSyg1c4fBKDk/Xe
	 /D9NCQQKhCxRWwcMlMOshIuPrkspMS489H/scyXqZWV2u86OKaU22xRZbFbPKQSdFj
	 9efLueiArmcJiZF5AXwnywurS1UrJzXqh64GTxl0XhZw902fRYsn/gEpjnGLDz5U23
	 bHlm7L6pHtiKScJ69j9jlFSDGRGDoMWUHIcPShB26Za0Yl759SV10cUEDHZ/h06vuT
	 6GgA/1S5wxT1w==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-1C50-b2c8-3CC6-a2A0.rev.sfr.net [IPv6:2a02:8428:af44:1001:1c50:b2c8:3cc6:a2a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8825A17E0FFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:55:53 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the L2CAP qualification
Date: Mon, 19 Jan 2026 16:55:48 +0100
Message-ID: <20260119155548.89569-1-frederic.danis@collabora.com>
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
 doc/qualification/l2cap-pics.rst | 345 ++++++++++++++++++++++++
 doc/qualification/l2cap-pts.rst  | 443 +++++++++++++++++++++++++++++++
 2 files changed, 788 insertions(+)
 create mode 100644 doc/qualification/l2cap-pics.rst
 create mode 100644 doc/qualification/l2cap-pts.rst

diff --git a/doc/qualification/l2cap-pics.rst b/doc/qualification/l2cap-pics.rst
new file mode 100644
index 000000000..da7de5241
--- /dev/null
+++ b/doc/qualification/l2cap-pics.rst
@@ -0,0 +1,345 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+============================================
+Logical Link Control and Adaptation Protocol
+============================================
+(TCRL 2023-1, L2CAP.ICS.p25ed3)
+
+L2CAP Transport Configuration
+=============================
+**Table 0: L2CAP Transport Configuration**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_0_1   |          | BR/EDR (includes possible support of GAP LE  |
+|                  |          | Broadcaster or LE Observer roles) (C.1)      |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_0_2   |          | LE (C.2)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_0_3   | x        | BR/EDR/LE (C.3)                              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF SUM ICS 32/1 "Logical Link Control and Adaptation
+  Protocol (L2CAP)", otherwise Excluded.
+- C.2: Mandatory IF SUM ICS 34/1 "Logical Link Control and Adaptation
+  Protocol (L2CAP)", otherwise Excluded.
+- C.3: Mandatory IF SUM ICS 32/1 "Logical Link Control and Adaptation
+  Protocol (L2CAP)" AND SUM ICS 34/1 "Logical Link Control and Adaptation
+  Protocol (L2CAP)", otherwise Excluded.
+
+Capability Statement
+====================
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_1_1   | x        | Data Channel Initiator (C.3)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_1_2   | x        | Data Channel Acceptor (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_1_3   | x        | LE Central (C.2)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_1_4   | x        | LE Peripheral (C.2)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_1_5   |          | LE Data Channel Initiator (C.4)              |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_1_6   |          | LE Data Channel Acceptor (C.5)               |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.2: Mandatory to support at least one IF L2CAP 0/2 "LE" OR L2CAP 0/3
+  "BR/EDR/LE", otherwise Excluded.
+- C.3: Optional IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.4: Optional IF (L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE") AND L2CAP 2/46
+  "LE Credit Based Flow Control Mode", otherwise Excluded.
+- C.5: Mandatory IF (L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE") AND L2CAP
+  2/46 "LE Credit Based Flow Control Mode", otherwise Excluded.
+
+Capability Statement
+====================
+**Table 2: General Operation**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_2_1   | x        | L2CAP Signaling channel over BR/EDR (C.16)   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_2   | x        | Configuration process (C.16)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_3   | x        | Connection-oriented data channel over BR/EDR |
+|                  |          | (C.16)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_4   | x        | Send echo request (C.17)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_5   | x        | Send echo response (C.16)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_6   | x        | Send information request (C.17)              |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_7   | x        | Send information response (C.16)             |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_10  |          | Retransmission mode (C.17)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_11  |          | Flow Control mode (C.17)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_12  | x        | Enhanced Retransmission Mode (C.11)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_13  | x        | Streaming Mode (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_14  | x        | FCS Option (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_15  |          | Generate Local Busy Condition (C.2)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_16  |          | Send Reject (C.2)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_17  | x        | Send Selective Reject (C.2)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_18  |          | Mandatory use of ERTM (C.3)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_19  |          | Mandatory use of Streaming Mode (C.4)        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_20  | x        | Optional use of ERTM (C.3)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_21  | x        | Optional use of Streaming Mode (C.4)         |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_22  | x        | Send data using SAR in ERTM (C.5)            |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_23  | x        | Send data using SAR in Streaming Mode (C.6)  |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_24  | x        | Actively request Basic Mode for a PSM that   |
+|                  |          | supports the use of ERTM or Streaming Mode   |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_25  | x        | Performing L2CAP channel mode configuration  |
+|                  |          | fallback from Streaming Mode to ERTM (C.8)   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_26  |          | Sending more than one unacknowledged I-Frame |
+|                  |          | when operating in ERTM (C.5)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_27  |          | Sending more than three unacknowledged       |
+|                  |          | I-Frame when operating in ERTM (C.5)         |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_28  | x        | Peer TxWindow configuration greater than 1   |
+|                  |          | (C.5)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_29  |          | AMP (C.24)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_30  | x        | Fixed channel(s) (C.11)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_31  |          | AMP Manager (C.18)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_32  |          | ERTM over AMP (C.25)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_33  |          | Streaming Mode Source over AMP (C.12)        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_34  |          | Streaming Mode Sink over AMP (C.12)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_35  |          | Unicast Connectionless Data, Reception (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_36  |          | Ability to transmit an unencrypted packet    |
+|                  |          | over a Unicast connectionless L2CAP channel  |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_37  |          | Ability to transmit an encrypted packet over |
+|                  |          | a Unicast connectionless L2CAP channel (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_38  |          | Extended Flow Specification for BR/EDR (C.1) |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_39  |          | Extended Window Size (C.1)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_40  | x        | L2CAP LE Signaling channel (C.13)            |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_41  | x        | Command reject (C.13)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_42  | x        | Send Connection Parameter Update Request     |
+|                  |          | (C.14)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_43  | x        | Send Connection Parameter Update Response    |
+|                  |          | (C.15)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_44  |          | Extended Flow Specification for AMP (C.18)   |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_45  | x        | Send Disconnect Request Command (C.21)       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_45a |          | Send Disconnect Request Command - LE (C.22)  |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_46  |          | LE Credit Based Flow Control Mode (C.19)     |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_47  |          | LE Data Channel (C.20)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_48  |          | Enhanced Credit Based Flow Control Mode      |
+|                  |          | (C.23)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_48a |          | Enhanced Credit Based Flow Control Mode -    |
+|                  |          | BR/EDR (C.26)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_2_48b |          | Enhanced Credit Based Flow Control Mode - LE |
+|                  |          | (C.27)                                       |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Optional IF L2CAP 2/12 "Enhanced Retransmission Mode" OR
+  L2CAP 2/13 "Streaming Mode", otherwise Excluded.
+- C.2: Optional IF L2CAP 2/12 "Enhanced Retransmission Mode" AND
+  L2CAP 2/28 "Peer TxWindow configuration greater than 1", otherwise Excluded.
+- C.3: Mandatory to support at least one IF L2CAP 2/12 "Enhanced
+  Retransmission Mode", otherwise Excluded.
+- C.4: Mandatory to support at least one IF L2CAP 2/13 "Streaming Mode",
+  otherwise Excluded.
+- C.5: Optional IF L2CAP 2/12 "Enhanced Retransmission Mode",
+  otherwise Excluded.
+- C.6: Optional IF L2CAP 2/13 "Streaming Mode", otherwise Excluded.
+- C.8: Mandatory IF L2CAP 2/12 "Enhanced Retransmission Mode" AND L2CAP 2/13
+  "Streaming Mode" AND L2CAP 2/21 "Optional use of Streaming Mode",
+  otherwise Excluded.
+- C.11: Mandatory IF SUM ICS 31/18 "Core v4.2+HS", otherwise Optional.
+- C.12: Optional IF L2CAP 2/29 "AMP", otherwise Excluded.
+- C.13: Mandatory IF L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.14: Optional IF L2CAP 1/4 "LE Peripheral", otherwise Excluded.
+- C.15: Mandatory IF L2CAP 1/3 "LE Central", otherwise Excluded.
+- C.16: Mandatory IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.17: Optional IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.18: Mandatory IF L2CAP 2/29 "AMP", otherwise Excluded.
+- C.19: Optional IF L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE",
+  otherwise Excluded.
+- C.20: Mandatory IF L2CAP 2/46 "LE Credit Based Flow Control Mode",
+  otherwise Excluded.
+- C.21: Optional IF L2CAP 2/1 "L2CAP Signaling channel over BR/EDR",
+  otherwise Excluded.
+- C.22: Optional IF L2CAP 2/40 "L2CAP LE Signaling channel" AND L2CAP 2/46
+  "LE Credit Based Flow Control Mode", otherwise Excluded.
+- C.23: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS"
+  OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20 "Core v5.1",
+  otherwise Optional.
+- C.24: Mandatory IF SUM ICS 31/18 "Core v4.2+HS", otherwise Optional IF SUM
+  ICS 31/17 "Core v4.2" OR SUM ICS 31/19 "Core v5.0" OR SUM ICS 31/20
+  "Core v5.1" OR SUM ICS 31/21 "Core v5.2", otherwise Excluded.
+- C.25: Optional IF L2CAP 2/12 "Enhanced Retransmission Mode" AND L2CAP 2/29
+  "AMP", otherwise Excluded.
+- C.26: Optional IF L2CAP 2/48 "Enhanced Credit Based Flow Control Mode" AND
+  (L2CAP 0/1 "BR/EDR (includes possible support of GAP LE Broadcaster or LE
+  Observer roles)" OR L2CAP 0/3 "BR/EDR/LE"), otherwise Excluded.
+- C.27: Optional IF L2CAP 2/48 "Enhanced Credit Based Flow Control Mode" AND
+  (L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE"), otherwise Excluded.
+
+Capability Statement
+====================
+**Table 3: Configurable Parameters**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_3_1   | x        | RTX timer (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_2   | x        | ERTX timer (C.4)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_3   | x        | Minimum MTU size of 48 octets (C.4)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_4   | x        | MTU size larger than 48 octets (C.5)         |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_5   | x        | Flush timeout value for reliable channel     |
+|                  |          | (C.4)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_6   | x        | Flush timeout value for unreliable channel   |
+|                  |          | (C.5)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_7   | x        | Bi-directional quality of service (QoS)      |
+|                  |          | option field (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_8   |          | Negotiate QoS service type (C.5)             |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_9   |          | Negotiate and support service type           |
+|                  |          | 'No traffic' (C.2)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_10  |          | Negotiate and support service type           |
+|                  |          | 'Best effort' (C.3)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_11  |          | Negotiate and support service type           |
+|                  |          | 'Guaranteed' (C.2)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_12  | x        | Minimum MTU size of 23 octets (C.6)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_13  |          | Negotiate and support service type           |
+|                  |          | 'No traffic' for Extended Flow Specification |
+|                  |          | (C.7)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_14  |          | Negotiate and support service type           |
+|                  |          | 'Best Effort' for Extended Flow Specification|
+|                  |          | (C.8)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_15  |          | Negotiate and support service type           |
+|                  |          | 'Guaranteed' for Extended Flow Specification.|
+|                  |          | (C.7)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_3_16  |          | Support Multiple Simultaneous LE Data        |
+|                  |          | Channels (C.10)                              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Mandatory IF L2CAP 3/8 "Negotiate QoS service type", otherwise
+  Optional.
+- C.2: Optional IF L2CAP 3/8 "Negotiate QoS service type", otherwise Excluded.
+- C.3: Mandatory IF L2CAP 3/8 "Negotiate QoS service type", otherwise
+  Excluded.
+- C.4: Mandatory IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE", otherwise
+  Excluded.
+- C.5: Optional IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
+  Broadcaster or LE Observer roles)" OR L2CAP 0/3 "BR/EDR/LE", otherwise
+  Excluded.
+- C.6: Mandatory IF L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE", otherwise
+  Excluded.
+- C.7: Optional IF L2CAP 2/44 "Extended Flow Specification for AMP" OR
+  L2CAP 2/38 "Extended Flow Specification for BR/EDR", otherwise Excluded.
+- C.8: Mandatory IF L2CAP 2/44 "Extended Flow Specification for AMP" OR
+  L2CAP 2/38 "Extended Flow Specification for BR/EDR", otherwise Excluded.
+- C.10: Optional IF L2CAP 2/47 "LE Data Channel", otherwise Excluded.
+
+Capability Statement
+====================
+**Table 4: GAP Requirements - Security Aspects (LE)**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_4_1   |          | Authentication procedure (LE) (C.1)          |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_4_2   |          | Authorization procedure (LE) (C.1)           |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_4_3   | x        | Encryption procedure (C.2)                   |
++------------------+----------+----------------------------------------------+
+
+- C.1: Optional IF L2CAP 0/2 "LE" OR L2CAP 0/3 "BR/EDR/LE", otherwise not
+  defined.
+- C.2: Mandatory IF GAP 25/6 "Authenticate signed data procedure" OR
+  GAP 25/7 "Authenticated Pairing (LE security mode 1 level 3)" OR
+  GAP 25/9 "LE security mode 1 level 4" OR
+  GAP 35/6 "Authenticate signed data procedure" OR
+  GAP 35/7 "Authenticated Pairing (LE security mode 1 level 3)" OR
+  GAP 35/9 "LE security mode 1 level 4", otherwise Optional.
+
+Capability Statement
+====================
+**Table 5: GAP Requirements - Security Aspects (BR/EDR)**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_L2CAP_5_1   |          | Authentication procedure (BR/EDR) (C.1)      |
++------------------+----------+----------------------------------------------+
+| TSPC_L2CAP_5_2   |          | Authorization procedure (BR/EDR) (O)         |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF GAP 2/1 "Authentication procedure", otherwise Optional.
diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
new file mode 100644
index 000000000..931df7875
--- /dev/null
+++ b/doc/qualification/l2cap-pts.rst
@@ -0,0 +1,443 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=================
+HoGP test results
+=================
+
+:PTS version: 8.5.3 Build 4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- In IXIT update "TSPX_psm" to "1011"
+
+Tests
+=====
+
+The kernel and BlueZ versions represent the oldest version without backport
+for which we know the test passed.
+
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| Test name             | Result | Kernel | BlueZ |                                                      |
++=======================+========+========+=======+======================================================+
+| L2CAP/COS/CED/BV-01-C | PASS   |    6.1 | 5.69  | On request run: l2test -n -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-03-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -w -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-04-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-05-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-07-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-08-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-09-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-11-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-12-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BV-13-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-01-C | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-02-C | PASS   |    6.7 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - bluetoothctl discoverable on                     |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-01-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-02-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-03-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-08-C | PASS   |    6.1 | 5.69  | On request run: l2test -n -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-09-C | PASS   |    6.1 | 5.69  | On request run: l2test -y -N 1 -P 4113 <bdaddr>      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-11-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-12-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFD/BV-14-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CID/BV-01-C | PASS   |    6.1 | 5.69  | On request run: l2test -c -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/IEX/BV-01-C | PASS   |    6.1 | 5.69  | On request run: l2test -n -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/IEX/BV-01-C | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/ECH/BV-01-C | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/ECH/BV-02-C | PASS   |    6.1 | 5.69  | On request run: sudo l2ping -c 1 <bdaddr>            |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/EXF/BV-01-C     | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/EXF/BV-02-C     | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/EXF/BV-03-C     | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/EXF/BV-05-C     | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-01-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-03-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-04-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-05-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-06-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-07-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-08-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-09-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-10-C     | PASS   |    6.1 | 5.69  | On request run: l2test -c -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-11-C     | PASS   |    6.1 | 5.69  | On request run: l2test -c -P 4113 <bdaddr>           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-14-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BV-15-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BI-05-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/CMC/BI-06-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 4113                                |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/FOC/BV-01-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113 -F 0                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/FOC/BV-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113 -F 0                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/FOC/BV-03-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113 -F 0                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-01-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -F 0 -N 1              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113 -F 0                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-03-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X streaming -P 4113 -F 0 -N 1         |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-04-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -X streaming -P 4113 -F 0              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-05-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-06-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-07-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X streaming -P 4113 -F 0 -N 1         |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/OFS/BV-08-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-01-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 3 -Y 3              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-03-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-08-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-09-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-10-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-11-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1 -Q 1              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-12-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1 -Q 1              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-17-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-18-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -D 2000 -N 2           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-19-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-20-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 1                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BV-23-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X ertm -P 4113 -N 2                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/ERM/BI-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -X ertm -P 4113                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/STM/BV-01-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X streaming -P 4113 -N 3 -Y 3         |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/STM/BV-02-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -X streaming -P 4113                   |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/STM/BV-03-C     | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -x -X streaming -P 4113 -N 2              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/FIX/BV-01-C     | PASS   |    6.1 | 5.69  | On request run: sudo l2test -z -P 4113 <bdaddr>      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CPU/BV-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Request a LE only dongle for PTS                   |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run in a first terminal:                           |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - sudo bluetoothctl advertise on                   |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run in a second terminal:                          |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -J 4                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CPU/BV-02-C  | PASS   |    6.1 | 5.69  | On request run: l2test -n -V le_public -J 4 <bdaddr> |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CPU/BI-01-C  | PASS   |    6.1 | 5.69  | On request run: l2test -n -V le_public -J 4 <bdaddr> |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CPU/BI-02-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - sudo btmgmt advertising on                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -J 4                      |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Post-condition:                                      |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - sudo btmgmt advertising off                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/REJ/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -J 4                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/REJ/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -V le_public -J 4                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
-- 
2.43.0

