Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 3/3] hog: When no VID&PID also register a DIS notifier
Date: Fri, 24 Feb 2017 16:13:26 -0800
Message-Id: <1487981606-14150-4-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
References: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DIS was reading VID & PID but they were not communicated to the HOG due to lack
of registered notifier.

Add a notified also in this case.
---
 profiles/input/hog-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 71de3a1..dab385f 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1406,6 +1406,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 		/* Try creating a DIS instance in case pid/vid are not set */
 		if (!vendor && !product) {
 			hog->dis = bt_dis_new(db);
+			bt_dis_set_notification(hog->dis, dis_notify, hog);
 		}
 	}
 
-- 
2.7.4

