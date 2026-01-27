Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794535D603
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533865; cv=none; b=i57ChQAEFDdoDQZPYnBdToM98oMJbyQIyN4z+uNNOrqJqZIHiXTVFWOkrQxJxrTXm9TWUy4TRP4sMC1aL4FfEIXtzgT4osd869VEolFeq99w6JLMYC35QHEWCLsO0HtN3CKzjmA8HhfkrKEr7iWoT0B2S3J+XS5cqM0XvJ4n1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533865; c=relaxed/simple;
	bh=oReNH/RioPFbYpgJsgfHPrx3HH9XizXWOYt5q+An2E4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R32c4f+rQ9XiZ13PNuYPudA/8pmTnoAbrofejetX079iIjQXDiA3SsXtX7xkd+t5u/vF4hc6hhnx/kd46In4sUDNBp4UnUabqkGydPQp1QrdmNsGIC7DdXczV9vTI6mx0DQRG0jSx0wONaHZBbpkaOxEi8ujB3PWxbltV07bbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dfre2Ihp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dfre2Ihp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769533858;
	bh=oReNH/RioPFbYpgJsgfHPrx3HH9XizXWOYt5q+An2E4=;
	h=From:To:Subject:Date:From;
	b=Dfre2IhphNHzjyw7QKvzIr3r1ifxCR5ghxy5POHkEucqhKWwIi+ZIMuO6eD2zHdCS
	 9mBKr/Ehenbg0win6UrxPBjyarteLkCM4gNgLS8jYPPDbtvSVMAMaPo+Md+8attfAF
	 gvxixSYVRYjfQnu2rLwFBaVvC4XXu5if0tIDb6By/niFPPEDhiR61w4pz4BMHLIbXM
	 d8k9j1SSaJB9FVFw2RZUBAbV9WDfTVgONlLeulg9AfMZ4Bukszk+JO+9sjCK0LfVwc
	 NjRlQsEHydtkjQlEkEekG2nbcpjAi4zUWLPIoDy38TSP0Bt2V+bv9gWHpUmno57TaO
	 QhVD+JKKtkdMA==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-871C-6E70-D798-DFc2.rev.sfr.net [IPv6:2a02:8428:af44:1001:871c:6e70:d798:dfc2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E2D017E0679
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:10:58 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Add PICS and howto for the AVRCP qualification
Date: Tue, 27 Jan 2026 18:10:53 +0100
Message-ID: <20260127171054.151065-1-frederic.danis@collabora.com>
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
 doc/qualification/avrcp-pics.rst | 1153 ++++++++++++++++++++++++++++++
 doc/qualification/avrcp-pts.rst  |  223 ++++++
 2 files changed, 1376 insertions(+)
 create mode 100644 doc/qualification/avrcp-pics.rst
 create mode 100644 doc/qualification/avrcp-pts.rst

diff --git a/doc/qualification/avrcp-pics.rst b/doc/qualification/avrcp-pics.rst
new file mode 100644
index 000000000..ee7acd6f2
--- /dev/null
+++ b/doc/qualification/avrcp-pics.rst
@@ -0,0 +1,1153 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==================================
+Audio/Video Remote Control Profile
+==================================
+(TCRL 2023-1, AVRCP.ICS.p16)
+
+Versions
+========
+**Table 2b: Controller - X.Y Versions**
+
+Prerequisite: AVRCP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_2b_4  |          | AVRCP v1.5 (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2b_5  | x        | AVRCP v1.6	(C.1, C.2)                       |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support one and only one.
+- C.2: Can only be supported with an active X.Y.Z version after Deprecation.
+  Deprecated 2021-02-01. Withdrawn 2024-02-01.
+
+Versions
+========
+**Table 2c: Controller - X.Y.Z Versions**
+
+Prerequisite: AVRCP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_2c_2  | x        | AVRCP v1.6.2 (C.1)                           |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF AVRCP 2b/5 "AVRCP v1.6", otherwise Excluded.
+
+Versions
+========
+**Table 7b: Target - X.Y Versions**
+
+Prerequisite: AVRCP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_7b_4  |          | AVRCP v1.5 (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7b_5  | x        | AVRCP v1.6 (C.1, C.2)                        |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support one and only one.
+- C.2: Can only be supported with an active X.Y.Z version after Deprecation.
+  Deprecated 2021-02-01. Withdrawn 2024-02-01.
+
+Versions
+========
+**Table 7c: Target - X.Y.Z Versions**
+
+Prerequisite: AVRCP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_7c_7  | x        | AVRCP v1.6.2 (C.1)                           |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF AVRCP 7b/5 "AVRCP v1.6", otherwise Excluded.
+
+Roles
+=====
+**Table 1: Role Requirements**
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_1_1   | x        | Controller (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_1_2   | x        | Target (C.1)                                 |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one.
+
+Controller features
+===================
+**Table 2: Controller Features**
+
+Prerequisite: AVRCP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_2_1   | x        | Initiating connection establishment for      |
+|                  |          | control (M)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_2   | x        | Accepting connection establishment for       |
+|                  |          | control initiated by TG (M)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_3   | x        | Initiating connection release for control (M)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_4   | x        | Accepting connection release for control     |
+|                  |          | initiated by TG (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_5   |          | Sending UNIT INFO command (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_6   |          | Sending SUBUNIT INFO command (O)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_7   |          | Sending PASS THROUGH command in category 1   |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_8   | x        | Sending PASS THROUGH command in category 2   |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_9   |          | Sending PASS THROUGH command in category 3   |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_10  |          | Sending PASS THROUGH command in category 4   |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_11  |          | Get Capabilities (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_12  |          | List Player Application Setting Attributes   |
+|                  |          | (C.9)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_13  |          | List Player Application Setting Values (O)   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_14  |          | Get Current Player Application Setting Value |
+|                  |          | (C.10)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_15  |          | Set Player Application Setting Value (C.10)  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_16  |          | Get Player Application Setting Attribute Text|
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_17  |          | Get Player Application Setting Value Text (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_18  |          | Inform Displayable Character Set (O)         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_19  |          | Inform Battery Status of CT (O)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_20  |          | Get Element Attributes (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_21  |          | Get Play Status (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_22  | x        | Register Notification (C.11)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_23  |          | Request Continuing Response (C.2)            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_24  |          | Abort Continuing Response (C.2)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_25  |          | Next Group (C.12)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_26  |          | Previous Group (C.12)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_27  |          | Media Player Selection (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_28  |          | SetAddressedPlayer (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_29  |          | GetFolderItems(MediaPlayerList) (C.5)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_29b |          | GetTotalNumberOfItems(MediaPlayerList) (C.15)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_30  |          | EVENT_AVAILABLE_PLAYERS_CHANGED (O)          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_31  |          | EVENT_ADDRESSED_PLAYER_CHANGED (O)           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_32  |          | Browsing (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_33  |          | SetBrowsedPlayer (C.4)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_34  |          | ChangePath (C.4)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_35  |          | GetFolderItems(Filesystem) (C.4)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_35b |          | GetTotalNumberOfItems(Filesystem) (C.15)     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_36  |          | GetItemAttributes (O)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_37  |          | PlayItem(Filesystem) (C.4)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_38  |          | EVENT_UIDS_CHANGED (O)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_39  |          | Searching (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_40  |          | Search (C.7)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_41  |          | GetFolderItems(Search Results) (C.7)         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_41b |          | GetTotalNumberOfItems(Search Results) (C.15) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_42  |          | PlayItem(SearchResultList) (C.7)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_43  |          | NowPlaying (C.8)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_44  |          | GetFolderItems(NowPlayingList) (C.8)         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_44b |          | GetTotalNumberOfItems(NowPlayingList) (C.15) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_45  |          | PlayItem(NowPlayingList) (C.8)               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_46  |          | AddToNowPlaying (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_47  |          | EVENT_NOW_PLAYING_CONTENT_CHANGED (O)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_48  |          | Playable Folders (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_49  | x        | Absolute Volume (C.3)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_50  | x        | SetAbsoluteVolume (C.3)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_51  | x        | NotifyVolumeChange (C.3)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_52  | x        | Discoverable Mode (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_53  |          | PASSTHROUGH operation supporting Press and   |
+|                  |          | Hold (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_54  |          | Cover Art (C.15)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_55  |          | GetImageProperties (C.14)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_56  |          | GetImage (C.13)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_2_57  |          | GetLinkedThumbnail (C.13)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory to support at least one.
+- C.2: Mandatory to support at least one IF AVRCP 2/20 "Get Element
+  Attributes", otherwise Optional.
+- C.3: Mandatory IF AVRCP 2/8 "Sending PASS THROUGH command in category 2",
+  otherwise Excluded.
+- C.4: Mandatory IF AVRCP 2/32 "Browsing", otherwise Excluded.
+- C.5: Mandatory IF AVRCP 2/27 "Media Player Selection", otherwise Excluded.
+- C.7: Mandatory IF AVRCP 2/39 "Searching", otherwise Excluded.
+- C.8: Mandatory IF AVRCP 2/32 "Browsing", otherwise Optional.
+- C.9: Mandatory IF AVRCP 2/13 "List Player Application Setting Values" OR
+  AVRCP 2/14 "Get Current Player Application Setting Value" OR AVRCP 2/15 "Set
+  Player Application Setting Value", otherwise Optional.
+- C.10: Mandatory to support at least one IF AVRCP 2/12 "List Player
+  Application Setting Attributes", otherwise Excluded.
+- C.11: Mandatory IF AVRCP 2/20 "Get Element Attributes" OR AVRCP 2/49
+  "Absolute Volume", otherwise Optional.
+- C.12: Mandatory to support none or all.
+- C.13: Excluded IF AVRCP 2b/4 "AVRCP v1.5", otherwise Mandatory to support at
+  least one IF AVRCP 2/54 "Cover Art", otherwise Excluded.
+- C.14: Excluded IF AVRCP 2b/4 "AVRCP v1.5", otherwise Optional IF AVRCP 2/54
+  "Cover Art", otherwise Excluded.
+- C.15: Excluded IF AVRCP 2b/4 "AVRCP v1.5", otherwise Optional.
+
+Controller features
+===================
+**Table 3: operation_id of category 1 for CT**
+
+Prerequisite: AVRCP 2/7 "Sending PASS THROUGH command in category 1"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_3_1   |          | 0 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_2   |          | 1 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_3   |          | 2 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_4   |          | 3 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_5   |          | 4 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_6   |          | 5 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_7   |          | 6 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_8   |          | 7 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_9   |          | 8 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_10  |          | 9 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_11  |          | dot (C.1)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_12  |          | enter (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_13  |          | clear (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_14  |          | sound select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_15  |          | input select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_16  |          | display information (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_17  |          | help (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_18  |          | power (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_19  |          | play (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_20  |          | stop (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_21  |          | pause (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_22  |          | record (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_23  |          | rewind (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_24  |          | fast forward (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_25  |          | eject (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_26  |          | forward (C.1)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_27  |          | backward (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_28  |          | angle (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_29  |          | subpicture (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_30  |          | F1 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_32  |          | F3 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_33  |          | F4 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_34  |          | F5 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_3_35  |          | vendor unique (C.1)                          |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one item.
+
+Controller features
+===================
+**Table 4: operation_id of category 2 for CT**
+
+Prerequisite: AVRCP 2/8 "Sending PASS THROUGH command in category 2"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_4_1   |          | 0 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_2   |          | 1 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_3   |          | 2 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_4   |          | 3 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_5   |          | 4 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_6   |          | 5 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_7   |          | 6 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_8   |          | 7 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_9   |          | 8 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_10  |          | 9 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_11  |          | dot (C.1)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_12  |          | enter (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_13  |          | clear (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_14  |          | sound select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_15  |          | input select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_16  |          | display information (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_17  |          | help (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_18  |          | power (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_19  | x        | volume up (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_20  | x        | volume down (C.1)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_21  |          | mute (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_22  |          | F1 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_23  |          | F2 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_24  |          | F3 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_25  |          | F4 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_26  |          | F5 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_4_27  |          | vendor unique (C.1)                          |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one item.
+
+Controller features
+===================
+**Table 5: operation_id of category 3 for CT**
+
+Prerequisite: AVRCP 2/9 "Sending PASS THROUGH command in category 3"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_5_1   |          | 0 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_2   |          | 1 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_3   |          | 2 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_4   |          | 3 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_5   |          | 4 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_6   |          | 5 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_7   |          | 6 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_8   |          | 7 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_9   |          | 8 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_10  |          | 9 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_11  |          | dot (C.1)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_12  |          | enter (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_13  |          | clear (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_14  |          | channel up (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_15  |          | channel down (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_16  |          | previous channel (C.1)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_17  |          | sound select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_18  |          | input select (C.1)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_19  |          | display information (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_20  |          | help (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_21  |          | power (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_22  |          | angle (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_23  |          | subpicture (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_24  |          | F1 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_25  |          | F2 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_26  |          | F3 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_27  |          | F4 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_28  |          | F5 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_5_29  |          | vendor unique (C.1)                          |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one item.
+
+Controller features
+===================
+**Table 6: operation_id of category 4 for CT**
+
+Prerequisite: AVRCP 2/10 "Sending PASS THROUGH command in category 4"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_6_1   |          | select (C.1)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_2   |          | up (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_3   |          | down (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_4   |          | left (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_5   |          | right (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_6   |          | right-up (C.1)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_7   |          | right-down (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_8   |          | left-up (C.1)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_9   |          | left-down (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_10  |          | root menu (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_11  |          | setup menu (C.1)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_12  |          | contents menu (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_13  |          | favorite menu (C.1)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_14  |          | exit (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_15  |          | 0 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_16  |          | 1 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_17  |          | 2 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_18  |          | 3 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_19  |          | 4 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_20  |          | 5 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_21  |          | 6 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_22  |          | 7 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_23  |          | 8 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_24  |          | 9 (C.1)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_25  |          | dot (C.1)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_26  |          | enter (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_27  |          | clear (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_28  |          | display information (C.1)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_29  |          | help (C.1)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_30  |          | page up (C.1)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_31  |          | page down (C.1)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_32  |          | power (C.1)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_33  |          | F1 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_34  |          | F2 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_35  |          | F3 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_36  |          | F4 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_37  |          | F5 (C.1)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_6_38  |          | vendor unique (C.1)                          |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory to support at least one item.
+
+Target features
+===============
+**Table 7: Target Features**
+
+Prerequisite: AVRCP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_7_1   |          | Initiating connection establishment for      |
+|                  |          | control (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_2   | x        | Accepting connection establishment for       |
+|                  |          | control initiated by CT (M)                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_3   | x        | Initiating connection release for control (M)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_4   | x        | Accepting connection release for control     |
+|                  |          | initiated by CT (M)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_5   | x        | Receiving UNIT INFO command (M)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_6   | x        | Receiving SUBUNIT INFO command (M)           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_7   | x        | Receiving PASS THROUGH command in category 1 |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_8   | x        | Receiving PASS THROUGH command in category 2 |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_9   |          | Receiving PASS THROUGH command in category 3 |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_10  |          | Receiving PASS THROUGH command in category 4 |
+|                  |          | (C.1)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_11  | x        | Get Capabilities Response (C.3)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_12  |          | List Player Application Settings Attributes  |
+|                  |          | Response (C.14)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_13  |          | List Player Application Setting Values       |
+|                  |          | Response (C.14)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_14  |          | Get Current Player Application Settings Value|
+|                  |          | Response (C.14)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_15  |          | Set Player Application Setting Value Response|
+|                  |          | (C.14)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_16  |          | Get Player Application Setting Attribute Text|
+|                  |          | Response (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_17  |          | Get Player Application Setting Value Text    |
+|                  |          | Response (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_18  |          | Inform Displayable Character Set Response (O)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_19  |          | Inform Battery Status of CT Response (O)     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_20  | x        | Get Element Attributes Response (C.3)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_21  | x        | Get Play Status Response (C.2)               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_22  | x        | Register Notification Response (C.12)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_23  | x        | Notify Event Response:                       |
+|                  |          | PLAYBACK_STATUS_CHANGED (C.4)                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_24  | x        | Notify Event Response: TRACK_CHANGED (C.4)   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_25  |          | Notify Event Response: TRACK_REACHED_END (O) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_26  |          | Notify Event Response: TRACK_REACHED_START   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_27  |          | Notify Event Response: PLAYBACK_POS_CHANGED  |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_28  |          | Notify Event Response: BATT_STATUS_CHANGED   |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_29  |          | Notify Event Response: SYSTEM_STATUS_CHANGED |
+|                  |          | (O)                                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_30  |          | Notify Event Response:                       |
+|                  |          | PLAYER_APPLICATION_SETTING_CHANGED (O)       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_31  | x        | Request Continuing Response (C.2)            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_32  | x        | Abort Continuing Response (C.2)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_34  |          | Next Group (C.15)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_35  |          | Previous Group (C.15)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_36  | x        | Media Player Selection (C.8)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_37  | x        | SetAddressedPlayer (C.8)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_38  | x        | GetFolderItems(MediaPlayerList) (C.8)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_38b | x        | GetTotalNumberOfItems(MediaPlayerList) (C.20)|
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_39  | x        | EVENT_AVAILABLE_PLAYERS_CHANGED (C.8)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_40  | x        | EVENT_ADDRESSED_PLAYER_CHANGED (C.8)         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_41  |          | Supports Multiple Players (O)                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_42  |          | Browsing (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_42a |          | Initiating connection establishment for      |
+|                  |          | browsing channel (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_43  |          | SetBrowsedPlayer (C.6)                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_43a |          | Non-addressed Player Browsing (C.17)         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_44  |          | ChangePath (C.6))                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_45  |          | GetFolderItems(Filesystem) (C.6)             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_45b |          | GetTotalNumberOfItems(Filesystem) (C.19)     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_46  |          | GetItemAttributes (C.6)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_47  |          | PlayItem(Filesystem) (C.6)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_48  |          | EVENT_UIDS_CHANGED (C.9)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_49  |          | Database Aware Players (O)                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_50  |          | Searching (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_51  |          | Search (C.10)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_52  |          | GetFolderItems(Search Results) (C.10)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_52b |          | GetTotalNumberOfItems(SearchResults) (C.21)  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_53  |          | PlayItem(SearchResultList) (C.10)            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_54  |          | NowPlaying (C.11)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_55  |          | GetFolderItems(NowPlayingList) (C.11)        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_55b |          | GetTotalNumberOfItems(NowPlayingList) (C.22) |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_56  |          | PlayItem(NowPlayingList) (C.11)              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_57  |          | AddToNowPlaying (O)                          |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_58  |          | EVENT_NOW_PLAYING_CONTENT_CHANGED (C.11)     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_59  |          | Playable Folders (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_60  | x        | Absolute Volume (C.5)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_61  | x        | SetAbsoluteVolume (C.5)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_62  | x        | NotifyVolumeChange (C.5)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_63  |          | Error Response (O)                           |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_64  | x        | General Reject (C.13)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_65  | x        | Discoverable Mode (M)                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_66  |          | PASSTHROUGH operation supporting Press and   |
+|                  |          | Hold (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_67  |          | Cover Art (C.18)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_68  |          | GetImageProperties (C.16)                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_69  |          | GetImage (C.16)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_7_70  |          | GetLinkedThumbnail (C.16)                    |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+- C.1: Mandatory to support at least one.
+- C.2: Mandatory IF AVRCP 7/20 "Get Element Attributes Response", otherwise
+  Optional.
+- C.3: Mandatory IF AVRCP 7/7 "Receiving PASS THROUGH command in category 1",
+  otherwise Optional.
+- C.4: Mandatory IF AVRCP 7/22 "Register Notification Response" AND AVRCP 7/20
+  "Get Element Attributes Response", otherwise Optional.
+- C.5: Mandatory IF AVRCP 7/8 "Receiving PASS THROUGH command in category 2",
+  otherwise Excluded.
+- C.6: Mandatory IF AVRCP 7/42 "Browsing", otherwise Excluded.
+- C.8: Mandatory IF AVRCP 7/7 "Receiving PASS THROUGH command in category 1"
+  OR AVRCP 7/9 "Receiving PASS THROUGH command in category 3", otherwise
+  Excluded.
+- C.9: Mandatory IF AVRCP 7/49 "Database Aware Players", otherwise Optional.
+- C.10: Mandatory IF AVRCP 7/50 "Searching", otherwise Excluded.
+- C.11: Mandatory IF AVRCP 7/42 "Browsing", otherwise Optional.
+- C.12: Mandatory IF AVRCP 7/7 "Receiving PASS THROUGH command in category 1"
+  OR (AVRCP 7/8 "Receiving PASS THROUGH command in category 2" AND AVRCP 7/60
+  "Absolute Volume") OR AVRCP 7/9 "Receiving PASS THROUGH command in category
+  3", otherwise Optional.
+- C.13: Mandatory IF AVRCP 7/7 "Receiving PASS THROUGH command in category 1"
+  OR AVRCP 7/9 "Receiving PASS THROUGH command in category 3" OR AVRCP 7/42
+  "Browsing", otherwise Optional.
+- C.14: Mandatory to support none or all.
+- C.15: Mandatory to support none or all.
+- C.16: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Mandatory IF AVRCP 7/67
+  "Cover Art", otherwise Excluded.
+- C.17: Optional IF AVRCP 7/42 "Browsing", otherwise Excluded.
+- C.18: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Optional.
+- C.19: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Mandatory IF AVRCP 7/42
+  "Browsing", otherwise Excluded.
+- C.20: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Mandatory IF AVRCP 7/7
+  "Receiving PASS THROUGH command in category 1" OR AVRCP 7/9 "Receiving PASS
+  THROUGH command in category 3", otherwise Excluded.
+- C.21: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Mandatory IF AVRCP 7/50
+  "Searching", otherwise Excluded.
+- C.22: Excluded IF AVRCP 7b/4 "AVRCP v1.5", otherwise Mandatory IF AVRCP 7/42
+  "Browsing", otherwise Optional.
+
+Target features
+===============
+**Table 8: operation_id of category 1 for TG**
+
+Prerequisite: AVRCP 7/7 "Receiving PASS THROUGH command in category 1"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_8_1   |          | 0 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_2   |          | 1 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_3   |          | 2 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_4   |          | 3 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_5   |          | 4 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_6   |          | 5 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_7   |          | 6 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_8   |          | 7 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_9   |          | 8 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_10  |          | 9 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_11  |          | Dot (O)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_12  |          | Enter (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_13  |          | Clear (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_14  |          | Sound select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_15  |          | Input select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_16  |          | Display information (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_17  |          | Help (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_18  |          | Power (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_19  | x        | Play (M)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_20  | x        | Stop (M)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_21  |          | Pause (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_22  |          | Record (O)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_23  |          | Rewind (O)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_24  |          | Fast forward (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_25  |          | Eject (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_26  |          | Forward (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_27  |          | Backward (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_28  |          | Angle (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_29  |          | Subpicture (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_30  |          | F1 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_31  |          | F2 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_32  |          | F3 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_33  |          | F4 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_33a |          | F5 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_8_34  |          | Vendor unique (O)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Target features
+===============
+**Table 9: operation_id of category 2 for TG**
+
+Prerequisite: AVRCP 7/8 "Receiving PASS THROUGH command in category 2"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_9_1   |          | 0 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_2   |          | 1 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_3   |          | 2 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_4   |          | 3 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_5   |          | 4 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_6   |          | 5 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_7   |          | 6 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_8   |          | 7 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_9   |          | 8 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_10  |          | 9 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_11  |          | Dot (O)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_12  |          | Enter (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_13  |          | Clear (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_14  |          | Sound select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_15  |          | Input select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_16  |          | Display information (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_17  |          | Help (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_18  |          | Power (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_19  | x        | Volume up (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_20  | x        | Volume down (M)                              |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_21  |          | Mute (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_22  |          | F1 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_23  |          | F2 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_24  |          | F3 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_25  |          | F4 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_26  |          | F5 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_9_27  |          | Vendor unique (O)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Target features
+===============
+**Table 10: operation_id of category 3 for TG**
+
+Prerequisite: AVRCP 7/9 "Receiving PASS THROUGH command in category 3"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_10_1  |          | 0 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_2  |          | 1 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_3  |          | 2 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_4  |          | 3 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_5  |          | 4 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_6  |          | 5 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_7  |          | 6 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_8  |          | 7 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_9  |          | 8 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_10 |          | 9 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_11 |          | Dot (O)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_12 |          | Enter (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_13 |          | Clear (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_14 |          | Channel up (M)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_15 |          | Channel down (M)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_16 |          | Previous channel (O)                         |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_17 |          | Sound select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_18 |          | Input select (O)                             |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_19 |          | Display information (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_20 |          | Help (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_21 |          | Power (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_21a|          | Angle (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_21b|          | Subpicture (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_22 |          | F1 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_23 |          | F2 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_24 |          | F3 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_25 |          | F4 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_25a|          | F5 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_10_26 |          | Vendor unique (O)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Target features
+===============
+**Table 11: operation_id of category 4 for TG**
+
+Prerequisite: AVRCP 7/10 "Receiving PASS THROUGH command in category 4"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_11_1  |          | Select (M)                                   |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_2  |          | Up (M)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_3  |          | Down (M)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_4  |          | Left (M)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_5  |          | Right (M)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_6  |          | Right-up (O)                                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_7  |          | Right-down (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_8  |          | Left-up (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_9  |          | Left-down (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_10 |          | Root menu (M)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_11 |          | Setup menu (O)                               |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_12 |          | Contents menu (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_13 |          | Favorite menu (O)                            |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_14 |          | Exit (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_15 |          | 0 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_16 |          | 1 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_17 |          | 2 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_18 |          | 3 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_19 |          | 4 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_20 |          | 5 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_21 |          | 6 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_22 |          | 7 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_23 |          | 8 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_24 |          | 9 (O)                                        |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_25 |          | Dot (O)                                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_26 |          | Enter (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_27 |          | Clear (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_28 |          | Display information (O)                      |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_29 |          | Help (O)                                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_30 |          | Page up (O)                                  |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_31 |          | Page down (O)                                |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_32 |          | Power (O)                                    |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_33 |          | F1 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_34 |          | F2 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_35 |          | F3 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_36 |          | F4 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_36a|          | F5 (O)                                       |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_11_37 |          | Vendor unique (O)                            |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+- O: Optional
+
+Requirements towards other profiles
+===================================
+**Table 12: Requirements towards the Generic Access Profile (CT)**
+
+Prerequisite: AVRCP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_12_1  | x        | General discoverable mode (M)                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Requirements towards other profiles
+===================================
+**Table 13: Requirements towards the Generic Access Profile (TG)**
+
+Prerequisite: AVRCP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_13_1  | x        | General discoverable mode (M)                |
++------------------+----------+----------------------------------------------+
+
+- M: Mandatory
+
+Requirements towards other profiles
+===================================
+**Table 14: OBEX Operations (AVRCP CT, OBEX Client)**
+
+Prerequisite: AVRCP 1/1 "Controller"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_14_1  |          | OBEX Connect operation (C.1)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_14_2  |          | OBEX Get operation (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_14_3  |          | OBEX Disconnect operation (C.1)              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF AVRCP 2/54 "Cover Art", otherwise Excluded.
+
+Requirements towards other profiles
+===================================
+**Table 15: OBEX Operations (AVRCP TG, OBEX Server)**
+
+Prerequisite: AVRCP 1/2 "Target"
+
++------------------+----------+----------------------------------------------+
+| Parameter Name   | Selected | Description                                  |
++==================+==========+==============================================+
+| TSPC_AVRCP_15_1  |          | OBEX Connect operation (C.1)                 |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_15_2  |          | OBEX Get operation (C.1)                     |
++------------------+----------+----------------------------------------------+
+| TSPC_AVRCP_15_3  |          | OBEX Disconnect operation (C.1)              |
++------------------+----------+----------------------------------------------+
+
+- C.1: Mandatory IF AVRCP 7/67 "Cover Art", otherwise Excluded.
diff --git a/doc/qualification/avrcp-pts.rst b/doc/qualification/avrcp-pts.rst
new file mode 100644
index 000000000..34733798f
--- /dev/null
+++ b/doc/qualification/avrcp-pts.rst
@@ -0,0 +1,223 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2025-2026 Collabora Ltd.
+
+==================
+AVRCP test results
+==================
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
+- The Bluetooth Transport path used for "busctl set-property …" is displayed by 'mpris-proxy',
+  e.g. "Bluetooth Transport /org/bluez/hci0/dev_<BD_ADDR>/sep1/fd4 found":
+
+  - Start "mpris-proxy" in a different terminal, it should run during all the AVRCP tests
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
+| AVRCP/CT/CEC/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request create a Bluetooth connection from IUT to PTS                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/CEC/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/CRC/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/CRC/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/PTH/BV-01-C         | PASS     |     6.1 | 5.69  | - busctl call org.bluez /org/bluez/hci0/dev_<BD_ADDR> \                 |
+|                              |          |         |       |   org.bluez.MediaControl1 VolumeUp                                      |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl call org.bluez /org/bluez/hci0/dev_<BD_ADDR> \                 |
+|                              |          |         |       |   org.bluez.MediaControl1 VolumeDown                                    |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/PTT/BV-02-I         | PASS     |     6.1 | 5.69  | - busctl call org.bluez /org/bluez/hci0/dev_<BD_ADDR> \                 |
+|                              |          |         |       |   org.bluez.MediaControl1 VolumeUp                                      |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl call org.bluez /org/bluez/hci0/dev_<BD_ADDR> \                 |
+|                              |          |         |       |   org.bluez.MediaControl1 VolumeDown                                    |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BI-03-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       | - Start VLC                                                             |
+|                              |          |         |       | - Cancel first try when requesting to initiate a control channel        |
+|                              |          |         |       |   connection, then retry this test                                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request create a Bluetooth connection from IUT to PTS                |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | On volume change request:                                               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl set-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/sep1/fd0 \|
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Check using audio volume panel                                          |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BI-04-C         | PASS     |     6.1 | 5.69  | Check using audio volume panel                                          |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BV-01-C         | PASS     |     6.1 | 5.69  | On volume change request:                                               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl set-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/sep1/fd0 \|
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BV-03-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BV-01-I         | PASS     |     6.1 | 5.69  | Check using audio volume panel                                          |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/VLH/BV-02-I         | PASS     |     6.1 | 5.69  | On volume change request:                                               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl set-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/sep1/fd0 \|
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/CT/NFY/BV-01-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request create a Bluetooth connection from IUT to PTS                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/CEC/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request create a Bluetooth connection from IUT to PTS                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/CFG/BI-01-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/CFG/BV-02-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/CRC/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/CRC/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/ICC/BV-01-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/ICC/BV-02-I         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/INV/BI-01-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/INV/BV-02-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MDI/BV-02-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MDI/BV-04-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MDI/BV-05-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BI-01-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-02-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       | - Start VLC and open a file                                             |
+|                              |          |         |       | - Cancel first try when requesting to initiate a control channel        |
+|                              |          |         |       |   connection, then retry this test                                      |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request create a Bluetooth connection from IUT to PTS                |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-06-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-09-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-12-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
+|                              |          |         |       | - Start VLC                                                             |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | VLC is shown as "Media Player: Player"                                  |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-02-I         | PASS     |     6.1 | 5.69  | Check using audio volume panel                                          |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/MPS/BV-03-I         | PASS     |     6.1 | 5.69  | Check using audio volume panel                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Sometimes the volume is changed on Speaker instead of the Bluetooth PTS |
+|                              |          |         |       | audio device                                                            |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/NFY/BI-01-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/NFY/BV-02-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start Lollypop and open a file                                        |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On request play the file in Lollypop                                    |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/NFY/BV-04-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start VLC and play a file                                             |
+|                              |          |         |       +-------------------------------------------------------------------------+
+|                              |          |         |       | On "Place the IUT into a state where no track is currently selected…"   |
+|                              |          |         |       | request close VLC then press OK                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/NFY/BV-05-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start VLC and play a file                                             |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/NFY/BV-08-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start VLC and open a file                                             |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/PTT/BV-01-I         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Start Lollypop, play a file then pause it (not stopped)               |
+|                              |          |         |       |   (VLC doesn't receive the Play command but receive the Stop command)   |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/PTT/BV-02-I         | PASS     |     6.1 | 5.69  | Check using audio volume panel                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Sometimes the volume is changed on Speaker instead of the Bluetooth PTS |
+|                              |          |         |       | audio device, in this case check Bluetooth volume is above 0% or        |
+|                              |          |         |       | manually increase it                                                    |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/RCR/BV-02-C         | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Open 'sbc_enc_test_04_more_than_512_bytes_metadata.mp3' file in VLC   |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/RCR/BV-04-C         | PASS     |     6.1 | 5.69  |                                                                         |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BI-01-C         | PASS     |     6.1 | 5.69  | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BI-02-C         | PASS     |     6.1 | 5.69  | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BV-02-C         | PASS     |     6.1 | 5.69  | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BV-04-C         | PASS     |     6.1 | 5.69  | On volume change request:                                               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl set-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/fd0 \     |
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BV-01-I         | PASS     |     6.1 | 5.69  | On volume change request:                                               |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl set-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/fd0 \     |
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | Sometimes inconclusive, retry                                           |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| AVRCP/TG/VLH/BV-02-I         | PASS     |     6.1 | 5.69  | Expect to hear sound (or not), then silence:                            |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl get-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/fd0 \     |
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 0                                  |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | (click OK), then sound really low (click OK):                           |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - busctl get-property org.bluez /org/bluez/hci0/dev_<BD_ADDR>/fd0 \     |
+|                              |          |         |       |   org.bluez.MediaTransport1 Volume q 64                                 |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| IOPT/CL/AVRCP-CT/SFC/BV-03-I | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                              |          |         |       |                                                                         |
+|                              |          |         |       | - Remove PTS device from Bluetooth devices                              |
++------------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.43.0

