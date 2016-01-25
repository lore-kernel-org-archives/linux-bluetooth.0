Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line discipline
Date: Mon, 25 Jan 2016 08:44:03 +0100
Message-Id: <1453707843-92704-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCIUARTGETDEVICE, HCIUARTSETFLAGS and HCIUARTGETFLAGS ioctl are
missing the COMPATIBLE_IOCTL declaration.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 fs/compat_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a5b8eb69a8f4..6402eaf8ab95 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1261,6 +1261,9 @@ COMPATIBLE_IOCTL(HCIUNBLOCKADDR)
 COMPATIBLE_IOCTL(HCIINQUIRY)
 COMPATIBLE_IOCTL(HCIUARTSETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETPROTO)
+COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
+COMPATIBLE_IOCTL(HCIUARTSETFLAGS)
+COMPATIBLE_IOCTL(HCIUARTGETFLAGS)
 COMPATIBLE_IOCTL(RFCOMMCREATEDEV)
 COMPATIBLE_IOCTL(RFCOMMRELEASEDEV)
 COMPATIBLE_IOCTL(RFCOMMGETDEVLIST)
-- 
2.5.0

