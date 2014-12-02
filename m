Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/13] unit: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:36 +0100
Message-Id: <1417541318-24259-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 unit/test-uuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 6c7e9d0..49ea031 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -115,6 +115,7 @@ static void test_uuid(gconstpointer data)
 		 */
 		g_assert(memcmp(&uuid.value.u128, test_data->binary, 16) == 0);
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		return;
         }
-- 
1.9.1

