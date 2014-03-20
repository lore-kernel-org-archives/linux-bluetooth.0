Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 38/62] Replace att_get_u32() by get_le32()
Date: Thu, 20 Mar 2014 11:43:03 -0300
Message-Id: <1395326607-27068-39-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 3 ++-
 profiles/thermometer/thermometer.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index f78c224..918f237 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -36,6 +36,7 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/dbus-common.h"
+#include "src/shared/util.h"
 #include "src/error.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -573,7 +574,7 @@ static void process_measurement(struct csc *csc, const uint8_t *pdu,
 		}
 
 		m.has_wheel_rev = true;
-		m.wheel_rev = att_get_u32(pdu);
+		m.wheel_rev = get_le32(pdu);
 		m.last_wheel_time = att_get_u16(pdu + 4);
 		pdu += 6;
 		len -= 6;
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c9ab759..d2ea56b 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -36,6 +36,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 #include "src/error.h"
 #include "src/log.h"
 #include "attrib/gattrib.h"
@@ -361,7 +362,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		return;
 	}
 
-	raw = att_get_u32(pdu);
+	raw = get_le32(pdu);
 	m.mant = raw & 0x00FFFFFF;
 	m.exp = ((int32_t) raw) >> 24;
 
-- 
1.8.3.1

