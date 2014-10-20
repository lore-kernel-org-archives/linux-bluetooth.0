Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	luiz.dentz@gmail.com, Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 3/3] tools/sdptool: Add MAP supported features
Date: Mon, 20 Oct 2014 20:34:29 +0530
Message-id: <1413817469-4255-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
References: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MapSupportedFeatures into MAS
attribute names.
---
 tools/sdptool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 1600c3e..f2d3068 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -236,6 +236,7 @@ static struct attrib_def goep_attrib_names[] = {
 static struct attrib_def mas_attrib_names[] = {
 	{ 0x0315, "MASInstanceID", NULL, 0 },
 	{ 0x0316, "SupportedMessageTypes", NULL, 0 },
+	{ 0x0317, "MapSupportedFeatures", NULL, 0 },
 };
 
 /* Same for the UUIDs. See BT assigned numbers */
-- 
1.9.1

