Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/5] attrib/gatt: Fix minor coding style
Date: Mon, 15 Dec 2014 10:59:03 +0100
Message-Id: <1418637547-20848-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gattrib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 7fe7647..3ce6748 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -224,7 +224,6 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
 	free(buf);
 }
 
-
 static void attrib_callback_notify(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-- 
1.8.4

