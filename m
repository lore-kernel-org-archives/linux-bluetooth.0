Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 03/12] health: Fix struct mcap_csp "csp_req" field type
Date: Fri,  3 Jan 2014 21:55:19 -0400
Message-Id: <1388800528-10699-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The values to which this field is set have nothing to do with MCAPCtrl.

Fixes clang error:

profiles/health/mcap_sync.c:767:24: error: comparison of constant 17
with expression of type 'MCAPCtrl' is always true
[-Werror,-Wtautological-constant-out-of-range-compare]
---
 profiles/health/mcap_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index 0d9f17d..7c35e4a 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -55,7 +55,7 @@ struct mcap_csp {
 	guint		remote_caps;	/* CSP-Slave: remote master got caps */
 	guint		rem_req_acc;	/* CSP-Slave: accuracy required by master */
 	guint		ind_expected;	/* CSP-Master: indication expected */
-	MCAPCtrl	csp_req;	/* CSP-Master: Request control flag */
+	uint8_t		csp_req;	/* CSP-Master: Request control flag */
 	guint		ind_timer;	/* CSP-Slave: indication timer */
 	guint		set_timer;	/* CSP-Slave: delayed set timer */
 	void		*set_data;	/* CSP-Slave: delayed set data */
-- 
1.8.3.2

