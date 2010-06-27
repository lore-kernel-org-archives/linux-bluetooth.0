Return-Path: <cyrus@holtmann.org>
From: Cody Rester <codyrester@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cody Rester <codyrester@gmail.com>
Subject: [PATCH] drivers: bluetooth: bluecard_cs.c: Fixed include error, changed to linux/io.h
Date: Sun, 27 Jun 2010 02:12:22 -0400
Message-Id: <1277619142-10751-1-git-send-email-codyrester@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed include error, changed to linux/io.h

Signed-off-by: Cody Rester <codyrester@gmail.com>
---
 drivers/bluetooth/bluecard_cs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index d9bf87c..89a4455 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -37,7 +37,7 @@
 #include <linux/wait.h>
 
 #include <linux/skbuff.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
-- 
1.7.0.4
