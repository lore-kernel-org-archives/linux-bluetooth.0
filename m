Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 2/6] client: fix unreported error case
Date: Mon, 13 Feb 2012 15:39:01 +0100
Message-Id: <1329143945-4934-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The authorization request of a queued transfer could fail, and this
needs to be reported to the transfer initiator. Otherwise it would
likely result in D-Bus timeouts.
---
 client/session.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index cb46510..ea707b3 100644
--- a/client/session.c
+++ b/client/session.c
@@ -734,6 +734,19 @@ static void session_process_queue(struct obc_session *session)
 			return;
 		}
 
+		if (p->func) {
+			GError *gerr;
+
+			obc_session_ref(session);
+			g_set_error(&gerr, OBEX_IO_ERROR, err,
+							"Authorization failed");
+
+			p->func(session, gerr, p->data);
+
+			g_error_free(gerr);
+			obc_session_unref(session);
+		}
+
 		pending_request_free(p);
 	}
 }
-- 
1.7.6.5

