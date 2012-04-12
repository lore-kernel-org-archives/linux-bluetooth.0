Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 14/19] network: Remove header declared but not defined
Date: Thu, 12 Apr 2012 20:33:05 +0530
Message-id: <1334243001-17016-15-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 network/server.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/network/server.h b/network/server.h
index d88acab..6351f6d 100644
--- a/network/server.h
+++ b/network/server.h
@@ -25,5 +25,3 @@ int server_init(DBusConnection *conn, gboolean secure);
 void server_exit(void);
 int server_register(struct btd_adapter *adapter);
 int server_unregister(struct btd_adapter *adapter);
-
-int server_find_data(const char *path, const char *pattern);
-- 
1.7.4.1

