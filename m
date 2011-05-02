Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH] Remove btio.c compilation warning
Date: Mon,  2 May 2011 16:43:26 -0400
Message-Id: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch fixes a compilation warning regarding btio/btio.c
compilation.
---
 btio/btio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6d71b90..8f166cc 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	uint8_t dev_class[3];
 	uint16_t handle;
 	socklen_t len;
-	gboolean flushable;
+	gboolean flushable = TRUE;
 
 	len = sizeof(l2o);
 	memset(&l2o, 0, len);
-- 
1.7.4.1

