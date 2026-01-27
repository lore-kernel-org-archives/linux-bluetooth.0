Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56494322B72
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535537; cv=none; b=rA23eXj+EkK3nU3+dvB6AVBUgQ6D80Xs92njXybO368f4GVFB+qDQuVHqi6PE2eiOHB8gDbBCA8jizByh0ZnzrzSSgKPsnL48teCTJgLwUikZaZUMGhIILPe9WwWNIoE9bTYrSNWasgWIJUmJjp5MFGSG4knofwOs8JBKhAYwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535537; c=relaxed/simple;
	bh=2PJ7czI0zwmED19HlwowiKTsciu0QQ7/aea2xzhpHjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHpq+ZuflHqMxslpUVgeZb2nUyLwtvY73vsGgh5x48P+lZR34YGffR6cOEek6qecGUBDOXwsNoNKGfHBH4DWotKkf+E1i9v98JPYHDef1Ta36qNXF1houHmaiRjKSvrXUNHJvN+d75iWjXXAO64WLWTyvB15DpJy1xu8OAwZVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=itHdMbJI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="itHdMbJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769535530;
	bh=2PJ7czI0zwmED19HlwowiKTsciu0QQ7/aea2xzhpHjE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=itHdMbJI5ji7q2CZx6BZ0pR6WN+4Z8r2iHIt42RtqivnaAd8eeh+wGoBQZj2W3w98
	 lQKhDJZkIyMklk9iWumjviTHieVPe7kb22RiPvt2L4sx//uDsziX8oQZDH5DakrX2F
	 62dxnBAqgrAgjlInlRSx6g2duEZda5WmthDl/jjyRIZe8HG2VHc9BbBgll0l0rrUxM
	 jfMPzlowvsG0VhV4NO02vi8SWXSD2rXtKFhuTcLJcFXNRAgu4ME8giTBKS82p4gWRj
	 S9QsNVomhQ4mpbbPLmA9EN6rwuretlLmGNTcdhP/nJogDt5/jF+5+QLnsbLUbJszkZ
	 ip6mPBBCoGUIg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-871c-6E70-D798-Dfc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3633717E1543
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:38:50 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/13] doc/qualification: Add PICS and howto for the SDP qualification
Date: Tue, 27 Jan 2026 18:38:37 +0100
Message-ID: <20260127173841.153747-9-frederic.danis@collabora.com>
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
 doc/qualification/sdp-pics.rst | 205 +++++++++++++++++++++++++++++++++
 doc/qualification/sdp-pts.rst  |  63 ++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 doc/qualification/sdp-pics.rst
 create mode 100644 doc/qualification/sdp-pts.rst

diff --git a/doc/qualification/sdp-pics.rst b/doc/qualification/sdp-pics.rst
new file mode 100644
index 000000000..980f0fa37
--- /dev/null
+++ b/doc/qualification/sdp-pics.rst
@@ -0,0 +1,205 @@
+==========================
+Service Discovery Protocol
+==========================
+(TCRL 2023-1, SDP.ICS.p23)
+
+
+Roles
+=====
+**Table 1b: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_1b_1    | x        | Server (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_1b_2    | x        | Client (C.1)                                 |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one of SDP 1b/1 "Server" OR SDP 1b/2
+  "Client".
+
+UUID capabilities
+=================
+**Table 1: Support Different Size Capabilities on UUID**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_1_1     | x        | 128 bit UUID (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_1_2     | x        | 32 bit UUID (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_1_3     | x        | 16 bit UUID (M)                              |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Service Search Request PDU
+==========================
+**Table 2: Service Search Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_2_1     | x        | Service Search Response (M)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_2_2     |          | Generates continuation state in Service      |
+|                  |          | Search Response (O)                          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Service Search Request PDU
+==========================
+**Table 3: Error Response to Invalid Service Search Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_3_1     | x        | Error response to Service Search Request (M) |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Service Attribute Request PDU
+=============================
+**Table 4: Service Attribute Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_4_1     | x        | Service Attribute Response (M)               |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_4_2     |          | Generates continuation state in Service      |
+|                  |          | Attribute Response (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_4_3     | x        | Service Attribute Response with              |
+|                  |          | AdditionalProtocolDescriptorList attribute   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Service Attribute Request PDU
+=============================
+**Table 5: Error Response to Invalid Service Attribute Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_5_1     | x        | Error response to Service Attribute Request  |
+|                  |          | (M)                                          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Service Search Attribute Request PDU
+====================================
+**Table 6: Service Search Attribute Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_6_1     | x        | Service Search Attribute Response (M)        |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_6_2     |          | Generates continuation state in Service      |
+|                  |          | Search Attribute Response (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_6_3     | x        | Service Search Attribute Response with       |
+|                  |          | AdditionalProtocolDescriptorList attribute   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Service Search Attribute Request PDU
+====================================
+**Table 7: Invalid Service Search Attribute Request**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_7_1     | x        | Error response to Service Search Attribute   |
+|                  |          | Request (M)                                  |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Service Browsing
+================
+**Table 8: Service Browsing**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_8_1     |          | Browsing, using SDP_ServiceSearchRequest and |
+|                  |          | SDP_ServiceAttributeRequest (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_8_2     |          | Browsing, using                              |
+|                  |          | SDP_ServiceSearchAttributeRequest (O)        |
++------------------+----------+----------------------------------------------+
+
+- O: Optional
+
+Attributes
+==========
+**Table 9: Attributes Present in IUT**
+Prerequisite: SDP 1b/1 "Server"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_SDP_9_1     |          | ServiceID (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_2     | x        | ProtocolDescriptorList (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_3     |          | ServiceRecordState (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_4     |          | ServiceInfoTimeToLive (O)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_5     |          | BrowseGroupList (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_6     |          | LanguageBaseAttributeIdList (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_7     |          | ServiceAvailability (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_8     |          | IconURL (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_9     | x        | ServiceName (O)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_10    | x        | ServiceDescription (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_11    |          | ProviderName (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_12    |          | VersionNumberList (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_13    |          | ServiceDataBaseState (O)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_14    | x        | BluetoothProfileDescriptorList (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_15    |          | DocumentationURL (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_16    |          | ClientExecutableURL (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_17    |          | AdditionalProtocolDescriptorList (C.1)       |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_18    | x        | ServiceRecordHandle (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_SDP_9_19    | x        | ServiceClassIDList (O)                       |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Optional IF SDP 9/2 "ProtocolDescriptorList", otherwise Excluded.
diff --git a/doc/qualification/sdp-pts.rst b/doc/qualification/sdp-pts.rst
new file mode 100644
index 000000000..1c80c4c58
--- /dev/null
+++ b/doc/qualification/sdp-pts.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+================
+SDP test results
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
++--------------------+----------+---------+-------+--------------------------+
+| Test name          | Result   | Kernel  | BlueZ |                          |
++====================+==========+=========+=======+==========================+
+| SDP/SR/SA/BV-01-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BV-05-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BV-17-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BV-20-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BV-21-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BI-01-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BI-02-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SA/BI-03-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SS/BV-01-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SS/BV-04-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SS/BI-01-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SS/BI-02-C  | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-01-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-02-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-03-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-04-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-11-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BV-23-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BI-01-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
+| SDP/SR/SSA/BI-02-C | PASS     |     6.1 | 5.69  |                          |
++--------------------+----------+---------+-------+--------------------------+
-- 
2.43.0

