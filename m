Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unused fields in btd_driver_data struct
Date: Tue, 22 Mar 2011 17:56:36 -0300
Message-Id: <1300827396-8043-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index e9d9e65..5121064 100644
--- a/src/device.c
+++ b/src/device.c
@@ -68,9 +68,7 @@
 #define GLOBAL_TRUST "[all]"
 
 struct btd_driver_data {
-	guint id;
 	struct btd_device_driver *driver;
-	void *priv;
 };
 
 struct btd_disconnect_data {
-- 
1.7.4.1

