Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 01/27] device: Fix returned error code
Date: Fri, 26 Apr 2013 08:16:57 +0200
Message-Id: <1366957043-2383-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The second 'err' shadows the main local variable which is being used to
as return value of the function. Otherwise -ENOENT was always returned
in case of error.
---
 src/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5f67610..18beed9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1060,8 +1060,6 @@ static int connect_next(struct btd_device *dev)
 	int err = -ENOENT;
 
 	while (dev->pending) {
-		int err;
-
 		profile = dev->pending->data;
 
 		err = profile->connect(dev, profile);
-- 
1.8.1.4

