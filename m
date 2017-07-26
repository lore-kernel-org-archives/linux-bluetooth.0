Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
Subject: [PATCH 1/2] monitor: Fix OOB information bit in mesh oob table
Date: Wed, 26 Jul 2017 07:40:39 +0200
Message-Id: <20170726054040.17970-2-frederic.dalleau@collabora.com>
In-Reply-To: <20170726054040.17970-1-frederic.dalleau@collabora.com>
References: <20170726054040.17970-1-frederic.dalleau@collabora.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bit 15 should be used for 'On device'.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 387be1dcb..f72fcab6a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3514,7 +3514,7 @@ static const struct {
 	{ 12, "Inside box"						},
 	{ 13, "On piece of paper"					},
 	{ 14, "Inside manual"						},
-	{ 14, "On device"						},
+	{ 15, "On device"						},
 	{ }
 };
 
-- 
2.11.0

