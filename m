Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 2/2] shared/gatt-helpers: Fix find by type response handling
Date: Mon, 17 Oct 2016 12:02:32 +0200
Message-Id: <1476698552-8030-2-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1476698552-8030-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1476698552-8030-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to regression from

db24bf0 shared/gatt-helper: Consolidate error checking,

procedure Discover Primary Services by Service UUID, can succeed
only when last response is Error Response with ATTRIBUTE_NOT_FOUND
error code.

With this patch it also succeed when Find By Type response contains
service which is already in a required search range.

It is verified with unit test /TP/GAD/CL/BV-02-C-1-alternative
---
 src/shared/gatt-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index a0a5b26..6b39bb1 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -797,7 +797,7 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	success = false;
+	success = true;
 
 done:
 	discovery_op_complete(op, success, att_ecode);
-- 
2.7.4

