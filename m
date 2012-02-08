Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Fix memory leak when parsing EIR
Date: Wed,  8 Feb 2012 16:04:17 -0400
Message-Id: <1328731457-3047-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 5c6ff29..4424ec9 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -447,6 +447,8 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 	btd_event_conn_complete(&info->bdaddr, &ev->addr.bdaddr,
 					mgmt_addr_type(ev->addr.type),
 					eir_data.name, eir_data.dev_class);
+
+	eir_data_free(&eir_data);
 }
 
 static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
-- 
1.7.5.4

