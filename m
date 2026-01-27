Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868118DB2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534182; cv=none; b=LSuL0GTH6+CIHCeP6XVCCs+TOmCHmIExpp9wdklqKY/1iyqCsCpq74m40Q0jaTGTmzOXDGxYWp0dtED+rtjTmYRHfAcDQD8rIgtxyRNnLBlaJG1Cn8HawQoMyDGM4MDPEwuHL5Yx6sx++NDGX8fFDajxvxmzXkoilClWV8POVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534182; c=relaxed/simple;
	bh=Ue9W2qg5czQYxYE35dDYH3dOSmnxCFZFXStP50KOAFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQq2cdE/dOalr63734gsGpVsYNxkIv13eAAB1Sr9dgouPutAZWMJj7/ewlGqU1QUaVF27HqGBS+ygKx/ji1mWkSJSICAEuNrLBVNJ5r0ea78MJcFu2miTlqVN4HvAcv02+Odnli0mo6Qo9iRHyNnSnDr6DgfaylzCHAuXnfnpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KcJOQJ06; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KcJOQJ06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769534178;
	bh=Ue9W2qg5czQYxYE35dDYH3dOSmnxCFZFXStP50KOAFs=;
	h=From:To:Subject:Date:From;
	b=KcJOQJ06g2M5eJtnaTiVDbipzQQCmPus8SysNRoDMuOSupqbxwcUE+1EB8Y+/Q71I
	 uRBY8rOLVxlsLPn0je7UifSwsMR19ZuarzGFBd2pQV+pITWlDrxAU0ItAf2n6a2Rt/
	 RaJk7PCGLZO3Isns/6RNP8PZYCNYwNS9ija/sKO1UYRyKgvzoLpEJDUCgIQNp9y53V
	 1JbW9ABjhe2xbUhYiJ+/dYVQdasb5OtqmhR9Qj0FpjTG/MEK40reqSs0lf9Y3Zg0P1
	 MI3k3dDOqpmUnSYC0sPl4NgC4WUeyoA5nJ3ENHkmkhFwDZDi2M7KkLSs/OR8tV4iZd
	 6tpsuZmqsa3ig==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-871C-6E70-D798-dFc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D64AC17E0679
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:16:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the HSP qualification
Date: Tue, 27 Jan 2026 18:16:13 +0100
Message-ID: <20260127171613.151644-1-frederic.danis@collabora.com>
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
 doc/qualification/hsp-pics.rst | 234 +++++++++++++++++++++++++++++++++
 doc/qualification/hsp-pts.rst  |  87 ++++++++++++
 2 files changed, 321 insertions(+)
 create mode 100644 doc/qualification/hsp-pics.rst
 create mode 100644 doc/qualification/hsp-pts.rst

diff --git a/doc/qualification/hsp-pics.rst b/doc/qualification/hsp-pics.rst
new file mode 100644
index 000000000..cc607514f
--- /dev/null
+++ b/doc/qualification/hsp-pics.rst
@@ -0,0 +1,234 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+===============
+Headset Profile
+===============
+(TCRL 2023-1, HSP.ICS.p6)
+
+Versions
+========
+**Table 0: Major Versions (X.Y)**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_0_1     |          | HSP v1.1 DeprecatedTo be withdrawn (C.1)     |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_0_2     | x        | HSP v1.2 (C.1)                               |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support one and only one of HSP 0/1 "HSP v1.1" OR HSP 0/2 "HSP v1.2".
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_1_1     | x        | Audio Gateway (AG) (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_1_2     |          | Headset (HS) (C.1)                           |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one of HSP 1/1 "Audio Gateway (AG)" OR HSP 1/2 "Headset (HS)".
+
+Audio Gateway Role
+==================
+**Table 2: Application Features (AG)**
+
+Prerequisite: HSP 1/1 "Audio Gateway (AG)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_2_1     | x        | Incoming audio connection establishment (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_2     |          | Ring (AT command) (C.3)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_3     |          | Inband ring tone (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_4     |          | Outgoing audio connection establishment (O)  |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_5     | x        | Audio connection release from HS (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_6     |          | Audio connection release from AG (C.5)       |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_7     | x        | Audio connection transfer: AG to HS (M)      |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_8     | x        | Audio connection transfer: HS to AG (M)      |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_9     |          | Remote audio volume control (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_10    |          | HS informs AG about local changes of audio   |
+|                  |          | volume (O)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_11    |          | Audio volume setting storage by HS (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_12    |          | Remote microphone gain control (C.2)         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_13    |          | HS informs AG about local changes of         |
+|                  |          | microphone gain (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_14    |          | Microphone gain setting storage by HS (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2_15    | x        | Connection Handling with Detach/Page (M)     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF HSP 2/10 "HS informs AG about local changes of audio volume", otherwise Optional.
+- C.2: Mandatory IF HSP 2/13 "HS informs AG about local changes of microphone gain", otherwise Optional.
+- C.3: Excluded IF HSP 2/3 "Inband ring tone" AND HSP 4/1 "E2112/TSE 1134 (212): Show that in-band ringing and RING are mutually exclusive", otherwise Optional.
+- C.5: Mandatory IF HSP 0/1 "HSP v1.1", otherwise Optional.
+
+Audio Gateway Role
+==================
+**Table 2a: GAP Requirements**
+
+Prerequisite: HSP 1/1 "Audio Gateway (AG)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_2a_1    | x        | Initiation of general inquiry (M)            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Audio Gateway Role
+==================
+**Table 2b: SDP Requirements**
+
+Prerequisite: HSP 1/1 "Audio Gateway (AG)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_2b_1    | x        | ProtocolDescriptorList (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_2b_2    | x        | BluetoothProfileDescriptorList (M)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Audio Gateway Role
+==================
+**Table 2c: RFCOMM Requirements**
+
+Prerequisite: HSP 1/1 "Audio Gateway (AG)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_2c_1    | x        | RFCOMM with TS 07.10 (M)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Headset Role
+============
+**Table 3: Application Features (HS)**
+
+Prerequisite: HSP 1/2 "Headset (HS)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_3_1     |          | Incoming audio connection establishment (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_2     |          | Ring (AT command) (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_3     |          | Inband ring tone (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_4     |          | Outgoing audio connection establishment (M)  |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_5     |          | Audio connection release from HS (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_6     |          | Audio connection release from AG (M)         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_7     |          | Audio connection transfer: AG to HS (M)      |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_8     |          | Audio connection transfer: HS to AG (M)      |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_9     |          | Remote audio volume control (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_10    |          | HS informs AG about local changes of audio   |
+|                  |          | volume (O)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_11    |          | Audio volume setting storage by HS (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_12    |          | Remote microphone gain control (C.2)         |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_13    |          | HS informs AG about local changes of         |
+|                  |          | microphone gain (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_14    |          | Microphone gain setting storage by HS (O)    |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3_15    |          | Connection Handling with Detach/Page (M)     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory IF HSP 3/10 "HS informs AG about local changes of audio volume", otherwise Optional.
+- C.2: Mandatory IF HSP 3/13 "HS informs AG about local changes of microphone gain", otherwise Optional.
+
+Headset Role
+============
+**Table 3a: GAP Requirements**
+
+Prerequisite: HSP 1/2 "Headset (HS)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_3a_1    |          | Non-discoverable mode (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3a_2    |          | General discoverable mode (M)                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Headset Role
+============
+**Table 3b: SDP Requirements**
+
+Prerequisite: HSP 1/2 "Headset (HS)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_3b_1    |          | ProtocolDescriptorList (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_HSP_3b_2    |          | BluetoothProfileDescriptorList (M)           |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Headset Role
+============
+**Table 3c: RFCOMM Requirements**
+
+Prerequisite: HSP 1/2 "Headset (HS)"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_3c_1    |          | RFCOMM with TS 07.10 (M)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Errata Service Releases
+=======================
+**Table 4: Errata Service Releases (ESR)**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_HSP_4_1     |          | E2112/TSE 1134 (212): Show that in-band      |
+|                  |          | ringing and RING are mutually exclusive (C.1)|
++------------------+----------+----------------------------------------------+
+
+- C.1: Excluded IF HSP 0/2 "HSP v1.2", otherwise Optional.
diff --git a/doc/qualification/hsp-pts.rst b/doc/qualification/hsp-pts.rst
new file mode 100644
index 000000000..1233bc2a4
--- /dev/null
+++ b/doc/qualification/hsp-pts.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+HSP test results
+================
+
+:PTS version: 8.5.3 Build 4
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- PipeWire version >= 1.1.81
+
+Tests
+=====
+
+The kernel and BlueZ versions represent the oldest version without backport
+for which we know the test passed.
+
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| Test name                  | Result   | Kernel  | BlueZ |                                                                         |
++============================+==========+=========+=======+=========================================================================+
+| HSP/AG/IAC/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | - Start PulseAudio Volume Control                                       |
+|                            |          |         |       +-------------------------------------------------------------------------+
+|                            |          |         |       | Pair to PTS                                                             |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in Configuration tab that PTS-HFP profile is set to Headset Head |
+|                            |          |         |       | Unit, or select it                                                      |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Start playing file using Lollypop                                       |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in PulseAudio Volume Control's Output Devices tab that audio is  |
+|                            |          |         |       | playing on PTS-HFP device                                               |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | On request disconnect                                                   |
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HSP/AG/ACR/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | - Start PulseAudio Volume Control                                       |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | - Start playing file using Lollypop                                     |
+|                            |          |         |       +-------------------------------------------------------------------------+
+|                            |          |         |       | Verify in Configuration tab that PTS-HFP profile is set to Headset Head |
+|                            |          |         |       | Unit, or select it                                                      |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in PulseAudio Volume Control's Output Devices tab that audio is  |
+|                            |          |         |       | playing on PTS-HFP device                                               |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | On request disconnect                                                   |
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HSP/AG/ACT/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | - Start PulseAudio Volume Control                                       |
+|                            |          |         |       +-------------------------------------------------------------------------+
+|                            |          |         |       | Verify in Configuration tab that PTS-HFP profile is set to Headset Head |
+|                            |          |         |       | Unit, or select it                                                      |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Start playing file using Lollypop                                       |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in PulseAudio Volume Control's Output Devices tab that audio is  |
+|                            |          |         |       | playing on PTS-HFP device                                               |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | On request disconnect                                                   |
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HSP/AG/ACT/BV-02-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | - Start PulseAudio Volume Control                                       |
+|                            |          |         |       +-------------------------------------------------------------------------+
+|                            |          |         |       | Connect to PTS                                                          |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in Configuration tab that PTS-HFP profile is set to Headset Head |
+|                            |          |         |       | Unit, or select it                                                      |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Start playing file using Lollypop                                       |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | Verify in PulseAudio Volume Control's Output Devices tab that audio is  |
+|                            |          |         |       | playing on PTS-HFP device                                               |
+|                            |          |         |       |                                                                         |
+|                            |          |         |       | On request disconnect                                                   |
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/HSP-AG/SFC/BV-16-I | PASS     |     6.1 | 5.69  |                                                                         |
++----------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

