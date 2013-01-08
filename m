Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] health: Fix possible use after free
Date: Tue, 08 Jan 2013 17:07:46 +0530
Message-id: <1357645069-30841-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
References: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A pointer to freed memory is dereferenced if we call function
channel_acquire_continue() with out any earlier reference.
---
 profiles/health/hdp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 823621e..82419b0 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -609,10 +609,10 @@ static DBusMessage *channel_acquire_continue(struct hdp_tmp_dc_data *data,
 					data, hdp_tmp_dc_data_destroy, &gerr))
 		return NULL;
 
-	hdp_tmp_dc_data_unref(data);
 	reply = g_dbus_create_error(data->msg, ERROR_INTERFACE ".HealthError",
 					"Cannot reconnect: %s", gerr->message);
 	g_error_free(gerr);
+	hdp_tmp_dc_data_unref(data);
 
 	return reply;
 }
-- 
1.7.9.5

