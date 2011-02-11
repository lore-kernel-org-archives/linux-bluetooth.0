Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 3/7] Use host byte order when converting UUID16/32 to UUID128
Date: Fri, 11 Feb 2011 18:37:02 -0200
Message-Id: <1297456626-22837-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

uuid_t should store the UUID-128 values in the host byte order to
keep the consistency with UUID-16 and UUID32.
---
 lib/sdp.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index d24d1e2..af50a16 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2629,6 +2629,8 @@ int sdp_uuid128_cmp(const void *p1, const void *p2)
  */
 void sdp_uuid16_to_uuid128(uuid_t *uuid128, const uuid_t *uuid16)
 {
+	uint128_t n128;
+
 	/*
 	 * We have a 16 bit value, which needs to be added to
 	 * bytes 3 and 4 (at indices 2 and 3) of the Bluetooth base
@@ -2636,8 +2638,7 @@ void sdp_uuid16_to_uuid128(uuid_t *uuid128, const uuid_t *uuid16)
 	unsigned short data1;
 
 	/* allocate a 128bit UUID and init to the Bluetooth base UUID */
-	uuid128->value.uuid128 = bluetooth_base_uuid;
-	uuid128->type = SDP_UUID128;
+	n128 = bluetooth_base_uuid;
 
 	/* extract bytes 2 and 3 of 128bit BT base UUID */
 	memcpy(&data1, &bluetooth_base_uuid.data[2], 2);
@@ -2646,11 +2647,16 @@ void sdp_uuid16_to_uuid128(uuid_t *uuid128, const uuid_t *uuid16)
 	data1 += htons(uuid16->value.uuid16);
 
 	/* set bytes 2 and 3 of the 128 bit value */
-	memcpy(&uuid128->value.uuid128.data[2], &data1, 2);
+	memcpy(&n128.data[2], &data1, 2);
+
+	uuid128->type = SDP_UUID128;
+	ntoh128(&n128, &uuid128->value.uuid128);
 }
 
 void sdp_uuid32_to_uuid128(uuid_t *uuid128, const uuid_t *uuid32)
 {
+	uint128_t n128;
+
 	/*
 	 * We have a 32 bit value, which needs to be added to
 	 * bytes 1->4 (at indices 0 thru 3) of the Bluetooth base
@@ -2658,8 +2664,7 @@ void sdp_uuid32_to_uuid128(uuid_t *uuid128, const uuid_t *uuid32)
 	unsigned int data0;
 
 	/* allocate a 128bit UUID and init to the Bluetooth base UUID */
-	uuid128->value.uuid128 = bluetooth_base_uuid;
-	uuid128->type = SDP_UUID128;
+	n128 = bluetooth_base_uuid;
 
 	/* extract first 4 bytes */
 	memcpy(&data0, &bluetooth_base_uuid.data[0], 4);
@@ -2668,7 +2673,10 @@ void sdp_uuid32_to_uuid128(uuid_t *uuid128, const uuid_t *uuid32)
 	data0 += htonl(uuid32->value.uuid32);
 
 	/* set the 4 bytes of the 128 bit value */
-	memcpy(&uuid128->value.uuid128.data[0], &data0, 4);
+	memcpy(&n128.data[0], &data0, 4);
+
+	uuid128->type = SDP_UUID128;
+	ntoh128(&n128, &uuid128->value.uuid128);
 }
 
 uuid_t *sdp_uuid_to_uuid128(const uuid_t *uuid)
-- 
1.7.4

