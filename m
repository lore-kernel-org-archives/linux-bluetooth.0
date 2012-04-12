Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 4/4] client: Remove unused struct session_callback
Date: Thu, 12 Apr 2012 20:33:15 +0530
Message-id: <1334243001-17016-25-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/client/session.c b/client/session.c
index 0663262..51acbfa 100644
--- a/client/session.c
+++ b/client/session.c
@@ -61,11 +61,6 @@ struct callback_data {
 	void *data;
 };
 
-struct session_callback {
-	session_callback_t func;
-	void *data;
-};
-
 struct pending_request {
 	guint id;
 	guint req_id;
-- 
1.7.4.1

