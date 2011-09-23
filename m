Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH BlueZ] Add device blocking events to mgmt API documentation
Date: Fri, 23 Sep 2011 11:57:02 +0300
Message-Id: <1316768222-1898-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e5cf5de..4ccbabf 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -552,3 +552,17 @@ Discovering Event
 Event Code		0x00014
 Controller Index	<controller id>
 Event Parameters	Discovering (1 Octet)
+
+Device Blocked Event
+====================
+
+Event Code		0x00015
+Controller Index	<controller id>
+Event Parameters	Address (6 Octets)
+
+Device Unblocked Event
+======================
+
+Event Code		0x00016
+Controller Index	<controller id>
+Event Parameters	Address (6 Octets)
-- 
1.7.2.5

