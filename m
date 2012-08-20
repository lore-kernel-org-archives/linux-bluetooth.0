Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/4] att: Replace ATT magic number
Date: Mon, 20 Aug 2012 14:32:20 -0300
Message-Id: <1345483942-27973-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the magic number used in Find Information Response
Format field by a proper declared constant.
---
 profiles/gatt/gas.c                |    2 +-
 profiles/input/hog_device.c        |    2 +-
 profiles/thermometer/thermometer.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 61e6745..e82513b 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -208,7 +208,7 @@ static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (list == NULL)
 		return;
 
-	if (format != 0x01)
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
 		goto done;
 
 	for (i = 0; i < list->num; i++) {
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 5a1de12..10c5a45 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -213,7 +213,7 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 	if (list == NULL)
 		return;
 
-	if (format != 0x01)
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
 		goto done;
 
 	for (i = 0; i < list->num; i++) {
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index ad352a9..6652a41 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -430,7 +430,7 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		desc->handle = att_get_u16(value);
 		desc->ch = ch;
 
-		if (format == 0x01)
+		if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
 			desc->uuid = att_get_uuid16(&value[2]);
 		else
 			desc->uuid = att_get_uuid128(&value[2]);
-- 
1.7.8.6

