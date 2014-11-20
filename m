Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] shared/gatt: Fix dereference before NULL check warnings
Date: Thu, 20 Nov 2014 15:13:14 +0200
Message-Id: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add NULL check otherwise constructions like below give warnings:
...
	uint8_t pdu[4 + get_uuid_len(uuid)];

	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
...
---
 src/shared/gatt-helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index d0bee3f..dc4a8e8 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -588,6 +588,9 @@ static void put_uuid_le(const bt_uuid_t *src, void *dst)
 
 static inline int get_uuid_len(const bt_uuid_t *uuid)
 {
+	if (!uuid)
+		return 0;
+
 	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
-- 
1.9.1

