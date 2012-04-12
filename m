Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 1/4] client: Fix memory leak during session connect
Date: Thu, 12 Apr 2012 20:33:12 +0530
Message-id: <1334243001-17016-22-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index a9883c7..0663262 100644
--- a/client/session.c
+++ b/client/session.c
@@ -407,8 +407,11 @@ static int session_connect(struct obc_session *session,
 	}
 
 	/* Ongoing connection */
-	if (session->id > 0)
+	if (session->id > 0) {
+		obc_session_unref(callback->session);
+		g_free(callback);
 		return 0;
+	}
 
 	session->id = transport->connect(session->source, session->destination,
 					driver->uuid, session->channel,
-- 
1.7.4.1

