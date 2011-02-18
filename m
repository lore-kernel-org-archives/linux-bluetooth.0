Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 12/14] Convert from little endian to host order when parsing EIR data
Date: Fri, 18 Feb 2011 20:29:31 -0200
Message-Id: <1298068173-16518-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EIR data uses little endian format, UUID128 values needs to be
converted to host order before to use it on SDP library functions.
---
 src/event.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/src/event.c b/src/event.c
index 12dbca2..87e96dd 100644
--- a/src/event.c
+++ b/src/event.c
@@ -361,11 +361,7 @@ static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
 
 	service.type = SDP_UUID128;
 	for (i = uuid32_count + uuid16_count; i < total; i++) {
-		int k;
-
-		for (k = 0; k < 16; k++)
-			service.value.uuid128.data[k] = uuid128[16 - k - 1];
-
+		btoh128((uint128_t *) uuid128, &service.value.uuid128);
 		uuid_str = bt_uuid2string(&service);
 		eir->services = g_slist_append(eir->services, uuid_str);
 		uuid128 += 16;
-- 
1.7.4.1

