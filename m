Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 5/5] android/README: Update status of HAL HFP HF implementation
Date: Fri, 28 Nov 2014 10:37:25 +0100
Message-Id: <1417167445-29099-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/README b/android/README
index aa12e51..6e5c95a 100644
--- a/android/README
+++ b/android/README
@@ -289,7 +289,7 @@ health            bt_hl.h            complete      complete
 pan               bt_pan.h           complete      complete
 avrcp             bt_rc.h            complete      complete
 socket            bt_sock.h          complete      partial
-handsfree_client  bt_hf_client.h     N/A           partial
+handsfree_client  bt_hf_client.h     N/A           complete
 map_client        bt_mce.h           N/A           complete
 a2dp_sink         bt_av.h            N/A           partial
 avrcp_ctrl        bt_rc.h            N/A           partial
-- 
1.8.4

