Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] android/health: Fix adding missing break
Date: Mon, 30 Jun 2014 15:53:47 +0300
Message-Id: <1404132829-5670-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404132829-5670-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/health.c b/android/health.c
index 94d3804..9d360be 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1374,6 +1374,7 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 		switch (*conf) {
 		case CHANNEL_TYPE_ANY:
 			*conf = CHANNEL_TYPE_RELIABLE;
+			break;
 		case CHANNEL_TYPE_RELIABLE:
 			break;
 		case CHANNEL_TYPE_STREAM:
-- 
1.8.3.2

