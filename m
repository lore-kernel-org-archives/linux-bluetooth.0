Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] unit/avrcp: Fix lengths byte order
Date: Thu, 27 Feb 2014 11:11:28 +0200
Message-Id: <1393492291-15099-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

params_len is passed as function argument and needs to be in host byte
order.
---
 unit/test-avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index f222df8..a43985a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -323,7 +323,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 	}
 
 fail:
-	*params_len = htons(1);
+	*params_len = 1;
 	params[0] = AVRCP_STATUS_INVALID_PARAM;
 
 	return AVC_CTYPE_REJECTED;
-- 
1.8.3.2

