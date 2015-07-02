Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 06/13] peripheral/gap: Init the gatt_server
Date: Thu,  2 Jul 2015 11:33:47 -0300
Message-Id: <1435847634-22831-7-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
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
2.4.5

