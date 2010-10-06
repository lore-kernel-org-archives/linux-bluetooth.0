Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Change Battery Service on attribute sample server
Date: Wed,  6 Oct 2010 17:39:53 -0300
Message-Id: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add an optional Client Characteristic Configuration attribute for
Battery State to control which clients want notification/indication
when this attribute value changes.
---
 attrib/example.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 76afce9..c29e1e4 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -161,10 +161,15 @@ static int register_attributes(void)
 
 	/* Battery: battery state attribute */
 	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
-	u16 = htons(BATTERY_STATE_UUID);
 	atval[0] = 0x04;
 	attrib_db_add(0x0110, &uuid, atval, 1);
 
+	/* Battery: Client Characteristic Configuration */
+	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	atval[0] = 0x00;
+	atval[1] = 0x00;
+	attrib_db_add(0x0111, &uuid, atval, 2);
+
 	timeout_id = g_timeout_add_seconds(10, change_battery_state, NULL);
 
 	/* Thermometer: primary service definition */
-- 
1.7.3.1

