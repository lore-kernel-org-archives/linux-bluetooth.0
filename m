Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 07/14] unit/gatt: Comment cleanup
Date: Tue, 30 Dec 2014 16:32:25 -0800
Message-Id: <1419985952-18334-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 647dd4e..6e075f6 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -866,17 +866,16 @@ static struct gatt_db *make_service_data_1_db(void)
 /*
  * Defined Test database 1:
  * Tiny database fits into a single minimum sized-pdu.
- * Satisfies:
- * 3. At least one primary seervice at the MAX handle
- * For each / all databases:
- * X 7. at least one service uuid with multiple instances
- * X 8. Some simple services, some with included services
- * X 9. an instance where handle of included service comes before the including
+ * Satisfies requirements:
+ * 3. At least one primary service at the MAX handle
+ * 7. at least one service uuid with multiple instances
+ * 8. Some simple services, some with included services
+ * 9. an instance where handle of included service comes before the including
  * service
- * X 11. Simple characteristics (no desc) and complex characteristics
- *       (multiple descriptors)
- * X 12. Instances of complex chars with 16-bit and 128-bit uuids
- * (although not in scrambled order)
+ * 11. Simple characteristics (no desc) and complex characteristics
+ *     (multiple descriptors)
+ * 12. Instances of complex chars with 16-bit and 128-bit uuids
+ *     (although not in scrambled order)
  */
 
 static struct gatt_db *make_test_spec_small_db(void)
-- 
2.2.0.rc0.207.ga3a616c

