Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] profiles/hog: Remove dead code
Date: Fri, 19 Dec 2014 19:20:54 +0530
Message-id: <1418997054-16603-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

warning: Value stored to 'attrib' is never read
		attrib = report->hogdev->attrib;
		^        ~~~~~~~~~~~~~~~~~~~~~~
---
 profiles/input/hog.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index fb51663..74351f3 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -221,7 +221,6 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
 			report = user_data;
-			attrib = report->hogdev->attrib;
 			write_ccc(desc->handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
-- 
1.9.1

