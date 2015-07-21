Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 06/15] peripheral/gap: Init the gatt_server
Date: Tue, 21 Jul 2015 20:16:39 -0300
Message-Id: <1437520608-22444-7-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will init the list that will have all the callbacks that will
register the services not part of the core.
---
 peripheral/gap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/peripheral/gap.c b/peripheral/gap.c
index a78dc45..fe65700 100644
--- a/peripheral/gap.c
+++ b/peripheral/gap.c
@@ -535,6 +535,8 @@ void gap_start(void)
 		return;
 	}
 
+	gatt_server_init();
+
 	if (!mgmt_send(mgmt, MGMT_OP_READ_COMMANDS,
 				MGMT_INDEX_NONE, 0, NULL,
 				read_commands_complete, NULL, NULL)) {
-- 
2.4.6

