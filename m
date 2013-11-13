Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 3/3] input: Fix setting .local_uuid
Date: Wed, 13 Nov 2013 10:53:33 +0200
Message-Id: <1384332813-7891-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

By setting .local_uuid it makes the core do a scrict check on uuids
enabled for the adapter but HID host does not have a record so it
does not require a .local_uuid to be set.
---
 profiles/input/manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 689ccdd..b12b43e 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -57,7 +57,6 @@ static void hid_server_remove(struct btd_profile *p,
 
 static struct btd_profile input_profile = {
 	.name		= "input-hid",
-	.local_uuid	= HID_UUID,
 	.remote_uuid	= HID_UUID,
 
 	.auto_connect	= true,
-- 
1.8.3.1

