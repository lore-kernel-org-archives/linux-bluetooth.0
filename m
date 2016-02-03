Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: syamsidhardh@gmail.com, Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] obexd: client: Fix memory leaks
Date: Wed, 03 Feb 2016 19:52:46 +0530
Message-id: <1454509366-19496-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We have to free the allocated memory for data and its members.
---
 obexd/client/session.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index ef998f9..5f981bf 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1179,6 +1179,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 	if (!data->remaining || !data->remaining[0]) {
 		error("obc_session_setpath: invalid path %s", path);
 		g_set_error(err, OBEX_IO_ERROR, -EINVAL, "Invalid argument");
+		setpath_data_free(data);
 		return 0;
 	}
 
-- 
1.7.9.5

