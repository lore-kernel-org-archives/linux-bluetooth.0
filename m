Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 54/60] Set MDL state to closed when a connection failed
Date: Thu, 22 Jul 2010 10:58:11 +0200
Message-Id: <1279789097-2420-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-5-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 788b565..e9d5d36 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1823,6 +1823,7 @@ static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
 									&err)) {
 				error("MDL accept error %s", err->message);
+				mdl->state = MDL_CLOSED;
 				g_error_free(err);
 				goto drop;
 			}
-- 
1.6.3.3

