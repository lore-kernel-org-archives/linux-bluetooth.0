Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] core: Fix memory leak
Date: Fri, 24 Aug 2012 20:51:38 -0300
Message-Id: <1345852298-9204-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When ignoring a LE device that is not in a discoverable state 'alias'
is leaking.
---
 src/adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index b642e37..532fcdd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2707,8 +2707,10 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 
 		/* Avoid emitting DeviceFound() signal if device is not
 		 * discoverable */
-		if (!(dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+		if (!(dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))) {
+			g_free(alias);
 			return;
+		}
 
 		dev->legacy = FALSE;
 
-- 
1.7.12

