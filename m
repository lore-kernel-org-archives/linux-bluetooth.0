Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/README: Update implementation status for handsfree
Date: Wed, 17 Dec 2014 15:53:33 +0100
Message-Id: <1418828013-12385-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1418828013-12385-1-git-send-email-szymon.janc@tieto.com>
References: <1418828013-12385-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/README b/android/README
index 6e5c95a..b2864de 100644
--- a/android/README
+++ b/android/README
@@ -283,7 +283,7 @@ a2dp              bt_av.h            complete      complete
 gatt              bt_gatt.h          complete      partial
                   bt_gatt_client.h   complete      partial
                   bt_gatt_server.h   complete      partial
-handsfree         bt_hf.h            complete      partial
+handsfree         bt_hf.h            complete      complete
 hidhost           bt_hh.h            complete      complete
 health            bt_hl.h            complete      complete
 pan               bt_pan.h           complete      complete
-- 
1.9.1

