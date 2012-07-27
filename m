Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/14] core: Start LE scanning when a device requests
Date: Fri, 27 Jul 2012 19:29:53 -0300
Message-Id: <1343428198-23621-10-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch enables the LE scanning when a device requires connection and
there isn't discovery sessions, triggering the General Connection
Establishment Procedure.
---
 src/adapter.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 46b32d7..3bc2d0e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2185,6 +2185,11 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_append(adapter->connect_list, device);
 	DBG("%s added to %s's connect_list", device_get_path(device),
 								adapter->name);
+
+	if (adapter->disc_sessions)
+		return;
+
+	mgmt_start_scanning(adapter->dev_id);
 }
 
 void adapter_connect_list_remove(struct btd_adapter *adapter,
-- 
1.7.10.4

