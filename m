Return-Path: <cyrus@holtmann.org>
From: bruna.moreira@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 2/3] adapter: Emit DeviceFound() signal only to discoverable devices
Date: Thu, 26 Jul 2012 13:37:27 -0400
Message-Id: <50117f08.0a4bec0a.04ec.ffffcfe4@mx.google.com>
In-Reply-To: <1343324248-19276-1-git-send-email-y>
References: <y>
 <1343324248-19276-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The DeviceFound() signal will only be emitted if the device is
discoverable.
---
 src/adapter.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b05a030..d46f3c3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2690,6 +2690,11 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	if (dev->bdaddr_type != BDADDR_BREDR) {
 		uint16_t app;
 
+		/* Avoid emitting DeviceFound() signal if device is not
+		 * discoverable */
+		if (!(dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+			return;
+
 		dev->legacy = FALSE;
 
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
-- 
1.7.9.5

