Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd] Obexd: Add parse apparam support to Obex Put
Date: Mon, 20 Feb 2012 18:46:54 +0530
Message-id: <1329743814-7172-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add parse apparam support to Obex put, which is missing in
current code.
---
 src/obex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 5b580d3..f9b7e22 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -978,6 +978,7 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 	parse_name(os, req);
 	parse_length(os, req);
 	parse_time(os, req);
+	parse_apparam(os, req);
 
 	if (!os->checked) {
 		if (!check_put(obex, req, user_data))
-- 
1.7.0.4

