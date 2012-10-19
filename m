Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 12/15] input: Add profile .disconnect
Date: Fri, 19 Oct 2012 17:39:29 +0200
Message-Id: <1350661172-18125-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add the disconnect hook to the btd_profile.
---
 profiles/input/manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index a2690b5..71fd48f 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -90,6 +90,7 @@ static struct btd_profile input_profile = {
 
 	.auto_connect	= true,
 	.connect	= input_device_connect,
+	.disconnect	= input_device_disconnect,
 
 	.device_probe	= hid_device_probe,
 	.device_remove	= hid_device_remove,
-- 
1.7.11.7

