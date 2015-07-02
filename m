Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 05/13] peripheral/gap: Fix missing includes
Date: Thu,  2 Jul 2015 11:33:46 -0300
Message-Id: <1435847634-22831-6-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 peripheral/gap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/peripheral/gap.c b/peripheral/gap.c
index f659f7f..a78dc45 100644
--- a/peripheral/gap.c
+++ b/peripheral/gap.c
@@ -27,9 +27,15 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
+#include "lib/uuid.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "peripheral/gatt.h"
-- 
2.4.5

