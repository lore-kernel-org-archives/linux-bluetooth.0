Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Add missing opcode to check_device_permissions
Date: Wed, 28 May 2014 08:54:01 +0200
Message-Id: <1401260041-693-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It returned ATT_ECODE_UNLIKELY when processing find_by_type_value
request.
---
 android/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/gatt.c b/android/gatt.c
index b95047d..3bce506 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3885,6 +3885,7 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 	case ATT_OP_READ_BLOB_REQ:
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_FIND_BY_TYPE_REQ:
 		if (!(permissions & GATT_PERM_READ))
 			return ATT_ECODE_READ_NOT_PERM;
 
-- 
1.9.0

