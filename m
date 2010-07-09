Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Add missing HCIUARTGETDEVICE ioctl to compat_ioctl.c
Date: Fri,  9 Jul 2010 16:28:36 -0300
Message-Id: <1278703716-9674-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 fs/compat_ioctl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 1863896..547452d 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -601,8 +601,9 @@ static int ioc_settimeout(unsigned int fd, unsigned int cmd,
 }
 
 /* Bluetooth ioctls */
-#define HCIUARTSETPROTO	_IOW('U', 200, int)
-#define HCIUARTGETPROTO	_IOR('U', 201, int)
+#define HCIUARTSETPROTO		_IOW('U', 200, int)
+#define HCIUARTGETPROTO		_IOR('U', 201, int)
+#define HCIUARTGETDEVICE	_IOR('U', 202, int)
 
 #define BNEPCONNADD	_IOW('B', 200, int)
 #define BNEPCONNDEL	_IOW('B', 201, int)
-- 
1.7.0.4

