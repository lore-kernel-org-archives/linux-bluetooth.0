Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 5/6] media: Trivial style fix
Date: Wed,  5 Dec 2012 17:15:33 +0100
Message-Id: <1354724134-7354-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

No whitespace should exist before parenthesis close.
---
 profiles/audio/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0fd2469..666f68a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -663,7 +663,7 @@ static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
 			GDBUS_ARGS({ "fd", "h" }, { "mtu_r", "q" },
-							{ "mtu_w", "q" } ),
+							{ "mtu_w", "q" }),
 			acquire) },
 	{ GDBUS_ASYNC_METHOD("TryAcquire",
 			NULL,
-- 
1.7.11.7

