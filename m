Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v7 4/9] core: Start LE scanning when a device requests
Date: Tue, 25 Sep 2012 14:38:01 -0300
Message-Id: <1348594686-26221-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch enables the LE scanning when a device requires connection and
there isn't discovery sessions, triggering the General Connection
Establishment Procedure.
---
 src/adapter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 49dee85..201e6a0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2200,6 +2200,11 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 						btd_device_ref(device));
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
1.7.11.4

