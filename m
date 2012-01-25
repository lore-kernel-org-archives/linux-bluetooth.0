Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/8] gatt-service: Move va_end just after processing the argument list
Date: Wed, 25 Jan 2012 11:03:04 +0100
Message-Id: <1327485790-26249-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1327485790-26249-2-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
 <1327485790-26249-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 187ef5a..a5e6dcb 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -307,12 +307,14 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 
 	va_start(args, opt1);
 	chrs = parse_opts(opt1, args);
+	va_end(args);
+
 	/* calculate how many attributes are necessary for this service */
 	for (l = chrs, size = 1; l != NULL; l = l->next) {
 		struct gatt_info *info = l->data;
 		size += info->num_attrs;
 	}
-	va_end(args);
+
 	start_handle = attrib_db_find_avail(adapter, size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
-- 
1.7.8.4

