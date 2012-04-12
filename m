Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 17/19] src: Fix newline before EOF
Date: Thu, 12 Apr 2012 20:33:08 +0530
Message-id: <1334243001-17016-18-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/agent.h      |    1 -
 src/log.h        |    1 -
 src/sdp-client.c |    1 -
 src/storage.h    |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/agent.h b/src/agent.h
index f62bf3b..063a188 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -74,4 +74,3 @@ gboolean agent_matches(struct agent *agent, const char *name, const char *path);
 
 void agent_init(void);
 void agent_exit(void);
-
diff --git a/src/log.h b/src/log.h
index b43b2b7..51c52e6 100644
--- a/src/log.h
+++ b/src/log.h
@@ -56,4 +56,3 @@ void __btd_enable_debug(struct btd_debug_desc *start,
 	if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
 		btd_debug("%s:%s() " fmt,  __FILE__, __FUNCTION__ , ## arg); \
 } while (0)
-
diff --git a/src/sdp-client.c b/src/sdp-client.c
index f119313..3e78dde 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -366,4 +366,3 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
 
 	return 0;
 }
-
diff --git a/src/storage.h b/src/storage.h
index 6967f97..6255ae8 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -95,4 +95,3 @@ int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
 gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
-
-- 
1.7.4.1

