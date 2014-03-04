Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] android/hal-avrcp: Remove unused code
Date: Tue,  4 Mar 2014 21:43:24 +0100
Message-Id: <1393965804-13866-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-avrcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index a720a1e..5f98f5b 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -351,7 +351,6 @@ static int write_text(uint8_t *ptr, uint8_t id, uint8_t *text, size_t *len)
 	value->len = strnlen((const char *) text, BTRC_MAX_ATTR_STR_LEN);
 
 	*len += attr_len;
-	ptr += attr_len;
 
 	if (value->len + *len > IPC_MTU)
 		value->len = IPC_MTU - *len;
-- 
1.9.0

