Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] input: Fix crash when connecting HID keyboard
Date: Tue, 31 Jul 2012 14:48:24 +0200
Message-ID: <1343738904-12556-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hidp_add_connection should return after setting up security watch when
connecting HID keyboard, otherwise req will be freed and encrypt_notify
callback will receive invalid pointer.
---
 profiles/input/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ed178b4..48d397a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -663,6 +663,8 @@ static int hidp_add_connection(const struct input_device *idev,
 		iconn->req = req;
 		iconn->sec_watch = g_io_add_watch(iconn->intr_io, G_IO_OUT,
 							encrypt_notify, iconn);
+
+		return 0;
 	}
 
 	err = ioctl_connadd(req);
-- 
1.7.11.3

