Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 1/9] gobex: fix callback remove when canceling transfer
Date: Tue, 21 Feb 2012 09:46:15 +0100
Message-Id: <1329813983-26707-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This code path could lead to situations where the callback is later
used, making the daemon crash.
---
 gobex/gobex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0665749..bc76e57 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -735,6 +735,9 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
 			goto immediate_completion;
 		}
 
+		if (remove_callback)
+			obex->pending_req->rsp_func = NULL;
+
 		return TRUE;
 	}
 
-- 
1.7.6.5

