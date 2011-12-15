Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 1/4] audio: remove unnecessary method call
Date: Thu, 15 Dec 2011 11:01:04 +0100
Message-Id: <1323943267-14576-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Calling gateway_suspend_stream should not be necessary given that
gateway_unlock with rw flags already does it.
---
 audio/transport.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 7bde32d..6029528 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -535,7 +535,6 @@ static guint suspend_gateway(struct media_transport *transport,
 		return 0;
 	}
 
-	gateway_suspend_stream(device);
 	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
 	g_idle_add(gateway_suspend_complete, owner);
 	return id++;
-- 
1.7.6.4

