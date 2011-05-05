Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH] Fix btio.c compilation warning
Date: Thu,  5 May 2011 14:55:24 -0400
Message-Id: <4dc2f2a9.f0c7ec0a.7feb.654f@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch fixes a compilation warning regarding btio/btio.c. Actually
this warning seems a false positive by Ubuntu Natty GCC version. A new
bug on Ubuntu bug system was opened but if you do not want to wait until
it is analyzed, just apply this minor fix.

btio/btio.c: In function 'bt_io_get':
btio/btio.c:803:11: warning: 'flushable' may be used uninitialized in
this function
---
 btio/btio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6d71b90..a3cf38a 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	uint8_t dev_class[3];
 	uint16_t handle;
 	socklen_t len;
-	gboolean flushable;
+	gboolean flushable = FALSE;
 
 	len = sizeof(l2o);
 	memset(&l2o, 0, len);
-- 
1.7.4.1

