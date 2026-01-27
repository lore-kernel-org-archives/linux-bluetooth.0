Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788C3624CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533937; cv=none; b=YTpHbjBleILFbynOcJyZ1/W702NUZkBjEVk4HTz6Pc56LUXCUBhCBTDzpOjC/Nb1GICew3S4MEVf7++LN4Pgj9Rw3TEEyVNZuxV0fj+lxeyPY4I2rMBPfQ/yfzd8yo/X+x/I5FfxskD94PC9tdgzz7w8oQ4yNCu+djmLGFGom6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533937; c=relaxed/simple;
	bh=3sy1DVgexuVbIaQLzeR1o5NEoYbKKNgharqslxe58G0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkXJ0iGTOj9uMyNi4E+KGSkD5OpI6OZ61xzd/mgn0utXZOvJDP1G/t1qTT1fbBmxtsy2IDAat1gEx4pkJNNZpyC9jigzXxeGj9kYoldJjwwe00A/jKlfpJ+K3IMu9TWZ0Bps+6gBOF/hsjwmClDxe11O67xq4lO4PtYrU6hp10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IvbosLSD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IvbosLSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769533933;
	bh=3sy1DVgexuVbIaQLzeR1o5NEoYbKKNgharqslxe58G0=;
	h=From:To:Subject:Date:From;
	b=IvbosLSD/KkHqp8elIQYNAZq0xTS2b1yel1808Nhxfo93PXI4k4rcbXucosHWpz1X
	 OEPiqepoYSAHDrqHlvPdrnhhYDN1m3L6S2ZB9A0MC+AgnfPBJeDQEpVlPx3fBKEBQG
	 YDkipW+wNZdjsR9hdPOTT3clbNDR8lrdtfYksq0650PeqQ6Qy37Ovom8tdG3P7MdQH
	 vksBLPomMFLxXrS8tTDZARtKVhrwXP4bTd3cmYLycxZ2bBBWHqzH5rh8qPWawQjZ+5
	 CpKUZoQqTURAUl5onVZrhJM78qz2GYDCHtQah1N1Xtxr/czAAnb6lH/J1M0Db4mgi2
	 qacYA5gQ83yIQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-871c-6E70-d798-dFC2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C5E1517E00AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:12:13 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the HID qualification
Date: Tue, 27 Jan 2026 18:12:08 +0100
Message-ID: <20260127171208.151197-1-frederic.danis@collabora.com>
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
 doc/qualification/hid-pics.rst | 385 +++++++++++++++++++++++++++++++++
 doc/qualification/hid-pts.rst  |  61 ++++++
 2 files changed, 446 insertions(+)
 create mode 100644 doc/qualification/hid-pics.rst
 create mode 100644 doc/qualification/hid-pts.rst

diff --git a/doc/qualification/hid-pics.rst b/doc/qualification/hid-pics.rst
new file mode 100644
index 000000000..0f63efb93
--- /dev/null
+++ b/doc/qualification/hid-pics.rst
@@ -0,0 +1,385 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==============================
+Human Interface Device Profile
+==============================
+(TCRL 2023-1, HID.ICS.p9)
+
+Versions
+========
+**Table 0: Major Versions (X.Y)**
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_0_1   | x        | HID v1.0 (M)                                   |
++----------------+----------+------------------------------------------------+
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_1_1   | x        | Host, Report protocol (C.1)                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_1_2   |          | Device (C.1)                                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_1_3   |          | Host, Boot protocol (C.1)                      |
++----------------+----------+------------------------------------------------+
+
+- C.1: Mandatory to support at least one of HID 1/1 "Host, Report protocol"
+  OR HID 1/2 "Device" OR HID 1/3 "Host, Boot protocol".
+
+Host Role
+=========
+**Table 2: Application Procedures**
+
+Prerequisite: HID 1/1 "Host, Report protocol" OR HID 1/3 "Host, Boot protocol"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_2_1   | x        | Establish HID connection (C.4)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_2   | x        | Accept HID connection (C.4)                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_3   | x        | Terminate HID connection (C.4)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_4   | x        | Accept Termination of HID connection (C.4)     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_5   | x        | Support for virtual cables (C.4)               |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_6   | x        | HID initiated reconnection (C.4)               |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_7   | x        | Host initiated reconnection (C.4)              |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_8   | x        | Host data transfer to HID (C.1)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_9   | x        | HID data transfer to Host (C.1)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_10  |          | HID Boot mode data transfer to Host (C.2)      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_11  |          | Host Boot mode data transfer to HID (C.2)      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_12  |          | Support for Application to send GET_REPORT (O) |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_13  |          | Support for Application to send SET_REPORT (O) |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_14  |          | Support for sending HCI_CONTROL with           |
+|                |          | VIRTUAL_CABLE_UNPLUG (C.3)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_2_15  |          | Support for receiving HCI_CONTROL with         |
+|                |          | VIRTUAL_CABLE_UNPLUG (C.3)                     |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF HID 1/1 "Host, Report protocol", otherwise Optional.
+- C.2: Mandatory IF HID 1/3 "Host, Boot protocol", otherwise Optional.
+- C.3: Optional IF HID 2/5 "Support for virtual cables", otherwise Excluded.
+- C.4: Mandatory IF HID 1/1 "Host, Report protocol", otherwise Optional.
+
+Host Role
+=========
+**Table 3: Device to Host Transfers**
+
+Prerequisite: HID 1/1 "Host, Report protocol" OR HID 1/3 "Host, Boot protocol"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_3_1   |          | Data reports larger than host MTU on Control   |
+|                |          | channel (O)                                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_3_2   |          | Data reports larger than host MTU on Interrupt |
+|                |          | channel (C.1)                                  |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_3_3   |          | Data reports to host (C.1)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_3_4   |          | Boot mode reports to host (C.2)                |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Excluded IF HID 1/3 "Host, Boot protocol", otherwise Mandatory IF HID
+  2/12 "Support for Application to send GET_REPORT", otherwise Optional.
+- C.2: Mandatory IF HID 1/3 "Host, Boot protocol", otherwise Optional.
+
+Host Role
+=========
+**Table 4: Host to Device Transfers**
+
+Prerequisite: HID 1/1 "Host, Report protocol" OR HID 1/3 "Host, Boot protocol"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_4_1   |          | Data reports larger than device MTU on Control |
+|                |          | channel (C.1)                                  |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_4_2   |          | Data reports larger than device MTU on         |
+|                |          | Interrupt channel (C.1)                        |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_4_3   | x        | Data reports to device (C.2)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_4_4   |          | Boot mode reports to device (O)                |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Excluded IF HID 1/3 "Host, Boot protocol", otherwise Optional.
+- C.2: Excluded IF HID 1/3 "Host, Boot protocol", otherwise Mandatory.
+
+Host Role
+=========
+**Table 5: HID Control Commands**
+
+Prerequisite: HID 1/1 "Host, Report protocol" OR HID 1/3 "Host, Boot protocol"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_5_1   |          | Set_Protocol command (C.1, C.4)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_5_2   |          | Get_Protocol command (C.1, C.4)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_5_3   |          | Set_Idle command (O)                           |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_5_4   |          | Get_Idle command (O)                           |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_5_5   |          | Set_Report command (C.2)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_5_6   |          | Get_Report command (C.3)                       |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF HID 1/3 "Host, Boot protocol", otherwise Optional.
+- C.2: Mandatory IF HID 1/1 "Host, Report protocol" AND HID 2/13 "Support for
+  Application to send SET_REPORT", otherwise Excluded.
+- C.3: Mandatory IF HID 1/1 "Host, Report protocol" AND HID 2/12 "Support for
+  Application to send GET_REPORT", otherwise Excluded.
+- C.4: Mandatory to support none or all of HID 5/1 "Set_Protocol command" OR
+  HID 5/2 "Get_Protocol command".
+
+Host Role
+=========
+**Table 6: LMP Requirements**
+
+Prerequisite: HID 1/1 "Host, Report protocol" OR HID 1/3 "Host, Boot protocol"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_6_8   | x        | Role switch (C.4)                              |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_6_9   | x        | Request role switch (C.4)                      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_6_12  | x        | Sniff mode (C.4)                               |
++----------------+----------+------------------------------------------------+
+
+- C.4: Mandatory IF HID 1/1 "Host, Report protocol", otherwise not defined.
+
+HID Role
+========
+**Table 8: HID Device Types**
+
+Prerequisite: HID 1/2 "Device"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_8_1   |          | Pointing HID (C.1)                             |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_8_2   |          | Keyboard HID (C.1)                             |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_8_3   |          | Identification HID (C.1)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_8_4   |          | Other HID (C.1)                                |
++----------------+----------+------------------------------------------------+
+
+- C.1: Mandatory to support at least one of HID 8/1 "Pointing HID" OR HID 8/2
+  "Keyboard HID" OR HID 8/3 "Identification HID" OR HID 8/4 "Other HID" IF
+  HID 1/2 "Device", otherwise Excluded.
+
+HID Role
+========
+**Table 9: Application Procedures**
+
+Prerequisite: HID 1/2 "Device"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_9_1   |          | Establish HID connection (O)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_2   |          | Accept HID connection (M)                      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_3   |          | Terminate HID connection (O)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_4   |          | Accept Termination of HID connection (M)       |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_5   |          | Support for virtual cables (O)                 |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_6   |          | HID initiated reconnection (C.1)               |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_7   |          | Host initiated reconnection (C.1)              |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_8   |          | Host data transfer to HID (C.2)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_9   |          | HID data transfer to Host (C.2)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_10  |          | HID Boot mode data transfer to Host (C.3)      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_11  |          | Host Boot mode data transfer to HID (C.4)      |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_12  |          | Output reports declared (C.4)                  |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_13  |          | Input reports declared (C.3)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_14  |          | Feature reports declared (O)                   |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_15  |          | Support for sending HCI_CONTROL with           |
+|                |          | VIRTUAL_CABLE_UNPLUG (C.5)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_9_16  |          | Support for receiving HCI_CONTROL with         |
+|                |          | VIRTUAL_CABLE_UNPLUG (C.5)                     |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory to support at least one of HID 9/6 "HID initiated
+  reconnection" OR HID 9/7 "Host initiated reconnection" IF HID 9/5 "Support
+  for virtual cables", otherwise Excluded.
+- C.2: Mandatory to support at least one of HID 9/8 "Host data transfer to
+  HID" OR HID 9/9 "HID data transfer to Host" IF HID 1/2 "Device", otherwise
+  Excluded.
+- C.3: Mandatory IF HID 8/1 "Pointing HID" OR HID 8/2 "Keyboard HID",
+  otherwise Excluded.
+- C.4: Mandatory IF HID 8/2 "Keyboard HID", otherwise Excluded.
+- C.5: Optional IF HID 9/5 "Support for virtual cables", otherwise Excluded.
+
+HID Role
+========
+**Table 10: Device to Host Transfers**
+
+Prerequisite: HID 9/13 "Input reports declared" OR HID 9/14 "Feature reports
+declared"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_10_1  |          | Data reports larger than host MTU on Control   |
+|                |          | channel (O)                                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_10_2  |          | Data reports larger than host MTU on Interrupt |
+|                |          | channel (O)                                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_10_3  |          | Data reports to host (O)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_10_4  |          | Boot mode reports to host (C.1)                |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF HID 8/1 "Pointing HID" OR HID 8/2 "Keyboard HID",
+  otherwise Optional IF HID 8/3 "Identification HID" OR HID 8/4 "Other HID",
+  otherwise Excluded.
+
+HID Role
+========
+**Table 11: Host to Device Transfers**
+
+Prerequisite: HID 9/12 "Output reports declared" OR HID 9/14 "Feature reports
+declared"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_11_1  |          | Data reports larger than device MTU on Control |
+|                |          | channel (O)                                    |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_11_2  |          | Data reports larger than device MTU on         |
+|                |          | Inetrrupt channel (O)                          |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_11_3  |          | Data reports to device (O)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_11_4  |          | Boot mode reports to device (C.1)              |
++----------------+----------+------------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF HID 8/2 "Keyboard HID", otherwise Optional IF HID 8/1
+  "Pointing HID" OR HID 8/3 "Identification HID" OR HID 8/4 "Other HID",
+  otherwise Excluded.
+
+HID Role
+========
+**Table 12: HID Control Commands**
+
+Prerequisite: HID 1/2 "Device"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_12_1  |          | Set_Protocol command (C.1, C.5)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_12_2  |          | Get_Protocol command (C.1, C.5)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_12_3  |          | Set_Idle command (C.2)                         |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_12_4  |          | Get_Idle command (C.2)                         |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_12_5  |          | Set_Report command (C.3)                       |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_12_6  |          | Get_Report command (C.4)                       |
++----------------+----------+------------------------------------------------+
+
+- C.1: Mandatory IF HID 8/1 "Pointing HID" OR HID 8/2 "Keyboard HID",
+  otherwise Optional IF HID 8/3 "Identification HID" OR HID 8/4 "Other HID",
+  otherwise Excluded.
+- C.2: Mandatory IF HID 8/2 "Keyboard HID", otherwise Optional IF HID 8/1
+  "Pointing HID" OR HID 8/3 "Identification HID" OR HID 8/4 "Other HID",
+  otherwise Excluded.
+- C.3: Mandatory IF HID 9/12 "Output reports declared" OR HID 9/14 "Feature
+  reports declared", otherwise Excluded.
+- C.4: Mandatory IF HID 9/13 "Input reports declared" OR HID 9/14 "Feature
+  reports declared", otherwise Excluded.
+- C.5: Mandatory to support none or all of HID 12/1 "Set_Protocol command" OR
+  HID 12/2 "Get_Protocol command".
+
+HID Role
+========
+**Table 13: LMP Requirements**
+
+Prerequisite: HID 1/2 "Device"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_13_8  |          | Role switch (C.3)                              |
++----------------+----------+------------------------------------------------+
+
+- C.3: Mandatory IF HID 9/6 "HID initiated reconnection", otherwise not
+  defined.
+
+HID Role
+========
+**Table 15: SDP Requirements**
+
+Prerequisite: HID 1/2 "Device"
+
++----------------+----------+------------------------------------------------+
+| Parameter Name | Selected | Description                                    |
++================+==========+================================================+
+| TSPC_HID_15_1  |          | Server (M)                                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_15_2  |          | LanguageBaseAttributeIdList (M)                |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_15_3  |          | ServiceClassIDList (M)                         |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_15_4  |          | ProtocolDescriptorList (M)                     |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_15_5  |          | BluetoothProfileDescriptorList (M)             |
++----------------+----------+------------------------------------------------+
+| TSPC_HID_15_6  |          | AdditionalProtocolDescriptorList (M)           |
++----------------+----------+------------------------------------------------+
+
+- M: Mandatory
diff --git a/doc/qualification/hid-pts.rst b/doc/qualification/hid-pts.rst
new file mode 100644
index 000000000..bc795c69d
--- /dev/null
+++ b/doc/qualification/hid-pts.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+HID test results
+================
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
+| HID/HOS/CON/BV-01-I          | PASS     |     6.1 | 5.69  | On 1st request run:                                                     |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - sudo btmgmt find                                                      |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | PTS device should be found                                              |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | On 2nd  and 3rd request run:                                            |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - sudo btmgmt find -L                                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | PTS device should be found                                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/DAT/BV-01-C          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HCE/BV-01-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HCE/BV-03-I          | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - this test requests a RF shielded box                                  |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HCE/BV-04-I          | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - this test requests a RF shielded box                                  |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HCR/BV-01-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HCR/BV-02-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HDT/BV-01-I          | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| HID/HOS/HDT/BV-02-I          | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/HID-HOS/SFC/BV-15-I  | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

