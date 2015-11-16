Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH 1/4] shared/gatt-server: Fix exit on error during execute write
Date: Mon, 16 Nov 2015 22:08:29 +0100
Message-Id: <1447708112-12695-2-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is an error during execute write we should drop all
outstanding data
---
 src/shared/gatt-server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ba668e3..329f53f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1204,6 +1204,9 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	err = BT_ATT_ERROR_UNLIKELY;
 
 error:
+	queue_remove_all(server->prep_queue, NULL, NULL,
+						prep_write_data_destroy);
+
 	bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
 								ehandle, err);
 }
-- 
2.5.0

