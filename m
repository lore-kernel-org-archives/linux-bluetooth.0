Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 6/6] core/advertising: improve errors for add advertising
Date: Tue, 14 Apr 2015 15:07:01 -0700
Message-Id: <1429049221-21984-7-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the error string and check the size of the response when we get
response from the add advertising command.
---
 src/advertising.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 46de9b4..7d69ee1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -402,7 +402,13 @@ static void add_advertising_callback(uint8_t status, uint16_t length,
 	const struct mgmt_rp_add_advertising *rp = param;
 
 	if (status || !param) {
-		error("Failed to add advertising MGMT");
+		error("Failed to add advertisement: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of add advertising response");
 		return;
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

