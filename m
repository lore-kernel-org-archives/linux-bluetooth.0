Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FB25785D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533450; cv=none; b=mUyxh3cexN16hD5/jCjQMtLyCecyjQgn4NQD0emtaDSHYUp177YLMsm6O6UiBwoP3lvljaCKz08nPLtC23UM6EhubK+gyzK8K2qqI+c9ybd/0T++BUBiSP05bv2d7BiJL1A4z7yTxfqY5N9LMQj5u6bNqwKAHTXSuf40yyrPj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533450; c=relaxed/simple;
	bh=++0nU63kAhRFUAIG8sHptzEpwmXbLgTkTw6CXVcws+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hjouSbqOPLm6F8cEkOLlReQeFrb8yuoWLyJhBC9eqXn4tfH0w66h5070LUubDGiYapdbMmlqd3pY5qppngLEP9Wowi1b/mU5wSJ6Um14RD73mfu8NVbm9Yss0hqFFmX8grApsYlWntMzvxmcVuGHBdKPrSetvR4v0CKIoOtUiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qNU8n1Gf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qNU8n1Gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769533444;
	bh=++0nU63kAhRFUAIG8sHptzEpwmXbLgTkTw6CXVcws+0=;
	h=From:To:Subject:Date:From;
	b=qNU8n1GfhUdO2GRZ1/NjaC6IqKYUSukITqGvtorvF//LBD3SEddn1A+l7PSrHEXoz
	 EtA/0bB/IPFfu0Q7nUduycHBUQH3icCwYGdsY3PvKE4lpBM7rJvRR0f6ijYd863P4z
	 CkxOG3VjNCfb4xc8M6KeDuWIxXOKFMh+Z9mSLGcPxzQpjOa9381iLO8OncwvZELgnC
	 fK7qhzazS2rV5EMwQ3q0TJQhFTfY2g8qejxEtbC+kcqB0eo0SAg20Ewu8CG0CeIUUq
	 ISVAnWntr/LajUbqcZBULUGiNRSozSJBeecOUfFdGxyYGmnBSbJYfv8chKtQ7zQOuL
	 3xai4p3UK2neg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-871c-6E70-d798-dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4313A17E0E3F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:04:04 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the A2DP qualification
Date: Tue, 27 Jan 2026 18:03:58 +0100
Message-ID: <20260127170358.150004-1-frederic.danis@collabora.com>
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
 doc/qualification/a2dp-pics.rst | 904 ++++++++++++++++++++++++++++++++
 doc/qualification/a2dp-pts.rst  | 273 ++++++++++
 2 files changed, 1177 insertions(+)
 create mode 100644 doc/qualification/a2dp-pics.rst
 create mode 100644 doc/qualification/a2dp-pts.rst

diff --git a/doc/qualification/a2dp-pics.rst b/doc/qualification/a2dp-pics.rst
new file mode 100644
index 000000000..12692901f
--- /dev/null
+++ b/doc/qualification/a2dp-pics.rst
@@ -0,0 +1,904 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+===================================
+Advanced Audio Distribution Profile
+===================================
+(TCRL 2023-1, A2DP.ICS.p16ed3)
+
+Version
+=======
+**Table 2a: A2DP SRC X.Y Versions**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_2a_2   |          | A2DP 1.2 (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2a_3   | x        | A2DP 1.3 Withdrawn (C.1, C.2)                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2a_4   |          | A2DP 1.4 (C.1)                               |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support one and only one.
+- C.2: Can only be supported with an active X.Y.Z version after Deprecation.
+  Deprecated 2021-02-01. Withdrawn 2024-02-01.
+
+Version
+=======
+**Table 2b: A2DP SRC X.Y.Z Versions**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_2b_2   | x        | A2DP 1.3.2 (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF A2DP 2a/3 "A2DP 1.3", otherwise Excluded.
+
+Version
+=======
+**Table 7a: A2DP SNK X.Y Versions**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_7a_2   |          | A2DP 1.2 (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_7a_3   | x        | A2DP 1.3 Withdrawn (C.1, C.2)                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_7a_4   |          | A2DP 1.4 (C.1)                               |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support one and only one.
+- C.2: Can only be supported with an active X.Y.Z version after Deprecation.
+  Deprecated 2021-02-01. Withdrawn 2024-02-01.
+
+Version
+=======
+**Table 7b: A2DP SNK X.Y.Z Versions**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_7b_2   | x        | A2DP 1.3.2 (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF A2DP 7a/3 "A2DP 1.3", otherwise Excluded.
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_1_1    | x        | Source (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_1_2    | x        | Sink (C.1)                                   |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Source Features
+===============
+**Table 2: A2DP SRC Features**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_2_1    | x        | Initiate Connection Establishment (M)        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_2    | x        | Accept Connection Establishment (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_3    | x        | Initiate Start Streaming (M)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_4    | x        | Accept Start Streaming (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_5    | x        | Send Audio Stream (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_6    | x        | Initiate Connection Release (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_7    | x        | Accept Connection Release (M)                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_8    |          | Initiate Suspend (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_9    |          | Accept Suspend (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_10   | x        | SBC Encoder (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_10a  |          | Encode and Forward Audio Stream (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_11   |          | SBC Configurations in 16 kHz sampling        |
+|                  |          | frequency (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_12   |          | SBC Configurations in 32 kHz sampling        |
+|                  |          | frequency (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_13   | x        | SBC Configurations in 44.1 kHz sampling      |
+|                  |          | frequency (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_14   |          | SBC Configurations in 48 kHz sampling        |
+|                  |          | frequency (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_15   |          | Delay Reporting (C.2)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_16   |          | SRC video playback via Bluetooth VDP (C.3)   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_2_17   |          | SRC video playback on a local video display  |
+|                  |          | (C.3)                                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory to support at least one.
+- C.2: Mandatory IF A2DP 2/16 "SRC video playback via Bluetooth VDP" OR A2DP
+  2/17 "SRC video playback on a local video display", otherwise Excluded.
+- C.3: Excluded IF A2DP 2a/2 "A2DP 1.2", otherwise Optional.
+
+SRC Implementation
+==================
+**Table 3: Supported Codec Interoperability Requirements in SRC**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3_1    | x        | SBC encoder (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3_1a   |          | Encode and Forward SBC Audio Stream (O)      |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3_4    |          | Encode and forward MPEG-1,2 Audio Stream (O) |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3_6    |          | Encode and forward MPEG-2,4 AAC Audio Stream |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3_8    |          | Encode and forward ATRAC family Audio Stream |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3_10   |          | Encode and forward MPEG-D USAC Audio Stream  |
+|                  |          | (C.6)                                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.6: Excluded IF A2DP 2a/2 "A2DP 1.2" OR A2DP 2a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SRC Implementation
+==================
+**Table 3a: Supported Codec Feature Interoperability Requirements in SRC**
+
+Prerequisite: A2DP 3/1 "SBC encoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3a_1   | x        | Channel Mode - Mono (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_2   | x        | Channel Mode - Dual Channel (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_3   |          | Channel Mode - Stereo (C.1)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_4   |          | Channel Mode - Joint Stereo (C.1)            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_5   | x        | Block Length 4 (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_6   | x        | Block Length 8 (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_7   | x        | Block Length 12 (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_8   | x        | Block Length 16 (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_9   |          | Subbands - 4 (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_10  | x        | Subbands - 8 (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_11  |          | Allocation - SNR (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3a_12  | x        | Allocation - Loudness (M)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory to support at least one.
+
+SRC Implementation
+==================
+**Table 3g: Supported MPEG-2,4 AAC Object Type Interoperability Requirements
+in SRC**
+
+Prerequisite: A2DP 3/6 "Encode and forward MPEG-2,4 AAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3g_1   |          | MPEG-2 AAC LC (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_2   |          | MPEG-4 AAC LC (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_3   |          | MPEG-4 AAC LTP (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_4   |          | MPEG-4 AAC scalable (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_5   |          | MPEG-4 HE-AAC (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_6   |          | MPEG-4 HE-AACv2 (C.1)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3g_7   |          | MPEG-4 AAC-ELDv2 (C.1)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF A2DP 2a/2 "A2DP 1.2" OR A2DP 2a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SRC Implementation
+==================
+**Table 3h: Supported MPEG-2,4 AAC Channel Interoperability Requirements in
+SRC**
+
+Prerequisite: A2DP 3/6 "Encode and forward MPEG-2,4 AAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3h_1   |          | 1 Channel (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3h_2   |          | 2 Channels (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3h_3   |          | 6 (5.1) Channels (C.2)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3h_4   |          | 8 (7.1) Channels (C.2)                       |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+- C.2: Excluded IF A2DP 2a/2 "A2DP 1.2" OR A2DP 2a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SRC Implementation
+==================
+**Table 3i: Supported MPEG-2,4 AAC Sampling Frequency Interoperability
+Requirements in SRC**
+
+Prerequisite: A2DP 3/6 "Encode and forward MPEG-2,4 AAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3i_1   |          | 8000 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_2   |          | 11025 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_3   |          | 12000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_4   |          | 16000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_5   |          | 22050 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_6   |          | 24000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_7   |          | 32000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_8   |          | 44100 Hz (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_9   |          | 48000 Hz (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_10  |          | 64000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_11  |          | 88200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3i_12  |          | 96000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory to support at least one.
+
+SRC Implementation
+==================
+**Table 3j: Supported MPEG-2,4 AAC Feature Interoperability Requirements in
+SRC**
+
+Prerequisite: A2DP 3/6 "Encode and forward MPEG-2,4 AAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3j_1   |          | Variable Bit Rate (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3j_2   |          | MPEG-D DRC (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Excluded IF A2DP 2a/2 "A2DP 1.2" OR A2DP 2a/3 "A2DP 1.3", otherwise
+  Optional IF A2DP 3g/2 "MPEG-4 AAC LC" OR A2DP 3g/3 "MPEG-4 AAC LTP" OR A2DP
+  3g/4 "MPEG-4 AAC scalable" OR A2DP 3g/5 "MPEG-4 HE-AAC" OR A2DP 3g/6 "MPEG-4
+  HE-AACv2" OR A2DP 3g/7 "MPEG-4 AAC-ELDv2", otherwise Excluded.
+
+SRC Implementation
+==================
+**Table 3k: Supported MPEG-D USAC Channel Interoperability Requirements in
+SRC**
+
+Prerequisite: A2DP 3/10 "Encode and forward MPEG-D USAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3k_1   |          | 1 Channel (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3k_2   |          | 2 Channels (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+SRC Implementation
+==================
+**Table 3l: Supported MPEG-D USAC Sampling Frequency Interoperability
+Requirements in SRC**
+
+Prerequisite: A2DP 3/10 "Encode and forward MPEG-D USAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3l_1   |          | 7350 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_2   |          | 8000 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_3   |          | 8820 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_4   |          | 9600 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_5   |          | 11025 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_6   |          | 11760 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_7   |          | 12000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_8   |          | 12800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_9   |          | 14700 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_10  |          | 16000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_11  |          | 17640 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_12  |          | 19200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_13  |          | 22050 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_14  |          | 24000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_15  |          | 29400 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_16  |          | 32000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_17  |          | 35280 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_18  |          | 38400 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_19  |          | 44100 Hz (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_20  |          | 48000 Hz (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_21  |          | 58800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_22  |          | 64000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_23  |          | 70560 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_24  |          | 76800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_25  |          | 88200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3l_26  |          | 96000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory to support at least one.
+
+SRC Implementation
+==================
+**Table 3m: Supported MPEG-D USAC Feature Interoperability Requirements in
+SRC**
+
+Prerequisite: A2DP 3/10 "Encode and forward MPEG-D USAC Audio Stream"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_3m_1   |          | Variable Bit Rate (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_3m_2   |          | MPEG-D DRC (M)                               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SRC Implementation
+==================
+**Table 8: SDP Attributes (Source)**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_8_2    | x        | ProtocolDescriptorList (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_8_3    | x        | BluetoothProfileDescriptorList (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_8_4    |          | Supported Features (O)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SRC Implementation
+==================
+**Table 9: GAVDP Roles (Source)**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_9_1    | x        | Initiator (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_9_2    | x        | Acceptor (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_9_3    |          | Delay Reporting Initiator (C.2)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_9_4    |          | Delay Reporting Acceptor (C.1)               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded IF A2DP 2a/2 "A2DP 1.2", otherwise Optional.
+- C.2: Excluded for this Role. Note: It is not permitted to be a delay
+  reporting initiator for A2DP Source role.
+
+SRC Implementation
+==================
+**Table 11a: AVDTP Capabilities (Initiator, Source)**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_11a_1  | x        | Set configuration command (M)                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_11a_2  |          | Reconfigure command (O)                      |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SRC Implementation
+==================
+**Table 11b: AVDTP Capabilities (Acceptor, Source)**
+
+Prerequisite: A2DP 1/1 "Source"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_11b_1  | x        | Set configuration response (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_11b_2  |          | Reconfigure response (O)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Sink Features
+=============
+**Table 4: A2DP SNK Features**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_4_1    |          | Initiate Connection Establishment (O)        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_2    | x        | Accept Connection Establishment (M)          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_3    |          | Initiate Start Streaming (O)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_4    | x        | Accept Start Streaming (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_5    | x        | Receive Audio Stream (M)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_6    |          | Initiate Connection Release (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_7    | x        | Accept Connection Release (M)                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_8    |          | Initiate Suspend (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_9    |          | Accept Suspend (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_10   | x        | SBC Decoder (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_10a  |          | Receive and Decode Audio Stream (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_11   |          | SBC Configurations in 16 kHz sampling        |
+|                  |          | frequency (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_12   |          | SBC Configurations in 32 kHz sampling        |
+|                  |          | frequency (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_13   | x        | SBC Configurations in 44.1 kHz sampling      |
+|                  |          | frequency (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_14   | x        | SBC Configurations in 48 kHz sampling        |
+|                  |          | frequency (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_4_15   | x        | Delay Reporting (C.1)                        |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF A2DP 7a/2 "A2DP 1.2", otherwise Mandatory.
+
+SNK Implementation
+==================
+**Table 5: Supported Codec Interoperability Requirements in SNK**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5_1    | x        | SBC Decoder (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5_3    |          | MPEG-1,2 Audio decoder (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5_4    |          | MPEG-2,4 AAC decoder (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5_5    |          | ATRAC family decoder (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5_6    |          | MPEG-D USAC decoder (C.2)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.2: Excluded IF A2DP 7a/2 "A2DP 1.2" OR A2DP 7a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SNK Implementation
+==================
+**Table 5a: Supported Codec Feature Interoperability Requirements in SNK**
+
+Prerequisite: A2DP 5/1 "SBC Decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5a_1   | x        | Channel Mode - Mono (M)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_2   | x        | Channel Mode - Dual Channel (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_3   | x        | Channel Mode - Stereo (M)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_4   | x        | Channel Mode - Joint Stereo (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_5   | x        | Block Length 4 (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_6   | x        | Block Length 8 (M)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_7   | x        | Block Length 12 (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_8   | x        | Block Length 16 (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_9   | x        | Subbands - 4 (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_10  | x        | Subbands - 8 (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_11  | x        | Allocation - SNR (M)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5a_12  | x        | Allocation - Loudness (M)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+SNK Implementation
+==================
+**Table 5g: Supported MPEG-2,4 AAC Object Type Interoperability Requirements
+in SNK**
+
+Prerequisite: A2DP 5/4 "MPEG-2,4 AAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5g_1   |          | MPEG-2 AAC LC (M)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_2   |          | MPEG-4 AAC LC (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_3   |          | MPEG-4 AAC LTP (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_4   |          | MPEG-4 AAC scalable (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_5   |          | MPEG-4 HE-AAC (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_6   |          | MPEG-4 HE-AACv2 (C.1)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5g_7   |          | MPEG-4 AAC-ELDv2 (C.1)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF A2DP 7a/2 "A2DP 1.2" OR A2DP 7a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SNK Implementation
+==================
+**Table 5h: Supported MPEG-2,4 AAC Channel Interoperability Requirements in
+SNK**
+
+Prerequisite: A2DP 5/4 "MPEG-2,4 AAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5h_1   |          | 1 Channel (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5h_2   |          | 2 Channels (M)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5h_3   |          | 6 (5.1) Channels (C.1)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5h_4   |          | 8 (7.1) Channels (C.1)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded IF A2DP 7a/2 "A2DP 1.2" OR A2DP 7a/3 "A2DP 1.3", otherwise
+  Optional.
+
+SNK Implementation
+==================
+**Table 5i: Supported MPEG-2,4 AAC Sampling Frequency Interoperability
+Requirements in SNK**
+
+Prerequisite: A2DP 5/4 "MPEG-2,4 AAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5i_1   |          | 8000 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_2   |          | 11025 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_3   |          | 12000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_4   |          | 16000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_5   |          | 22050 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_6   |          | 24000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_7   |          | 32000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_8   |          | 44100 Hz (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_9   |          | 48000 Hz (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_10  |          | 64000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_11  |          | 88200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5i_12  |          | 96000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SNK Implementation
+==================
+**Table 5j: Supported MPEG-2,4 AAC Feature Interoperability Requirements in
+SNK**
+
+Prerequisite: A2DP 5/4 "MPEG-2,4 AAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5j_1   |          | Variable Bit Rate (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5j_2   |          | MPEG-D DRC (C.1)                             |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- C.1: Excluded IF A2DP 7a/2 "A2DP 1.2" OR A2DP 7a/3 "A2DP 1.3", otherwise
+  Optional IF A2DP 5g/2 "MPEG-4 AAC LC" OR A2DP 5g/3 "MPEG-4 AAC LTP" OR A2DP
+  5g/4 "MPEG-4 AAC scalable" OR A2DP 5g/5 "MPEG-4 HE-AAC" OR A2DP 5g/6 "MPEG-4
+  HE-AACv2" OR A2DP 5g/7 "MPEG-4 AAC-ELDv2", otherwise Excluded.
+
+SNK Implementation
+==================
+**Table 5k: Supported MPEG-D USAC Channel Interoperability Requirements in
+SNK**
+
+Prerequisite: A2DP 5/6 "MPEG-D USAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5k_1   |          | 1 Channel (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5k_2   |          | 2 Channels (M)                               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+SNK Implementation
+==================
+**Table 5l: Supported MPEG-D USAC Sampling Frequency Interoperability
+Requirements in SNK**
+
+Prerequisite: A2DP 5/6 "MPEG-D USAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5l_1   |          | 7350 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_2   |          | 8000 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_3   |          | 8820 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_4   |          | 9600 Hz (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_5   |          | 11025 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_6   |          | 11760 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_7   |          | 12000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_8   |          | 12800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_9   |          | 14700 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_10  |          | 16000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_11  |          | 17640 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_12  |          | 19200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_13  |          | 22050 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_14  |          | 24000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_15  |          | 29400 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_16  |          | 32000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_17  |          | 35280 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_18  |          | 38400 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_19  |          | 44100 Hz (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_20  |          | 48000 Hz (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_21  |          | 58800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_22  |          | 64000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_23  |          | 70560 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_24  |          | 76800 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_25  |          | 88200 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5l_26  |          | 96000 Hz (O)                                 |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SNK Implementation
+==================
+**Table 5m: Supported MPEG-D USAC Feature Interoperability Requirements in
+SNK**
+
+Prerequisite: A2DP 5/6 "MPEG-D USAC decoder"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_5m_1   |          | Variable Bit Rate (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_5m_2   |          | MPEG-D DRC (M)                               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+SNK Implementation
+==================
+**Table 12: SDP Attributes (Sink)**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_12_2   | x        | ProtocolDescriptorList (M)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_12_3   | x        | BluetoothProfileDescriptorList (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_12_4   |          | Supported Features (O)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+SNK Implementation
+==================
+**Table 13: GAVDP Roles (Sink)**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_13_1   |          | Initiator (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_13_2   | x        | Acceptor (M)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_13_3   | x        | Delay Reporting Initiator (C.1)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_13_4   |          | Delay Reporting Acceptor (C.2)               |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Excluded IF A2DP 7a/2 "A2DP 1.2", otherwise Mandatory.
+- C.2: Excluded for this Role. Note: It is not permitted to be a delay
+  reporting acceptor for A2DP Sink role.
+
+SNK Implementation
+==================
+**Table 15a: AVDTP Capabilities (Initiator, Sink)**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_15a_1  |          | Set configuration command (C.1)              |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_15a_2  |          | Reconfigure command (O)                      |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+- C.1: Mandatory IF A2DP 13/1 "Initiator", otherwise not defined.
+
+SNK Implementation
+==================
+**Table 15b: AVDTP Capabilities (Acceptor, Sink)**
+
+Prerequisite: A2DP 1/2 "Sink"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_A2DP_15b_1  | x        | Set configuration response (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_A2DP_15b_2  |          | Reconfigure response (O)                     |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
diff --git a/doc/qualification/a2dp-pts.rst b/doc/qualification/a2dp-pts.rst
new file mode 100644
index 000000000..43cedb09f
--- /dev/null
+++ b/doc/qualification/a2dp-pts.rst
@@ -0,0 +1,273 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+=================
+A2DP test results
+=================
+
+:PTS version: 8.5.2 Build 5
+
+Setup
+=====
+
+- Remove PTS device from Bluetooth devices
+
+- Update "TSPX_player_feature_bitmask" in IXIT to "1FFAFFBBF3BFF9040800000000000000"
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
+| A2DP/SNK/AS/BV-01-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-03-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 195                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-08-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 196                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-10-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 193                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-11-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 197                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-12-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 199                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-13-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 201                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-14-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 203                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-15-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 205                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-16-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 221                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/AVP/BI-20-C         | PASS     |     6.1 | 5.71  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop WirePlumber by running:                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user stop wireplumber                                   |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Run:                                                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - sudo avtest --reject setconf --reject-code 194                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Post-condition:                                                         |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Restart WirePlumber by running:                                       |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       |   - systemctl --user start wireplumber                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Stop 'avtest'                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-01-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-02-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-05-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-06-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-07-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/CC/BV-08-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/REL/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/SDP/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/SET/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/SET/BV-03-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/SET/BV-05-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - this test requests a RF shielded box                                  |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SNK/SYN/BV-01-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/AS/BV-01-I          | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/AS/BI-01-I          | PASS     |     6.1 | 5.69  | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/CC/BV-09-I          | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/REL/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/REL/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SDP/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start Lollypop and play a file                                        |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-03-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-04-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-05-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| A2DP/SRC/SET/BV-06-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/A2DP-SRC/SFC/BV-01-I | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

