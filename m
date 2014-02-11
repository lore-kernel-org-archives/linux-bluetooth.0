Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 6/7] android: Add assertion for ID parameter in ipc_register/ipc_unregister
Date: Tue, 11 Feb 2014 14:32:31 -0400
Message-Id: <1392143552-11395-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is a programming error to pass a invalid ID for these functions (i.e.
the ID is statically defined on the code). Given that this ID is used
for indexing an array, adding an assertion will ensure that improper API
usage will not cause random crashes due to memory corruption.
---
 android/ipc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index ab0f1a4..373345c 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -336,12 +336,16 @@ void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size)
 {
+	g_assert(service <= HAL_SERVICE_ID_MAX);
+
 	services[service].handler = handlers;
 	services[service].size = size;
 }
 
 void ipc_unregister(uint8_t service)
 {
+	g_assert(service <= HAL_SERVICE_ID_MAX);
+
 	services[service].handler = NULL;
 	services[service].size = 0;
 }
-- 
1.7.9.5

