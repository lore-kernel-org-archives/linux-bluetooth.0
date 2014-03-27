Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/11] android/gatt: Service error when client cannot be created
Date: Thu, 27 Mar 2014 22:13:01 +0100
Message-Id: <1395954789-32459-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If memory allocation failed, return error from handle_client_register.
---
 android/gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 1af7e33..2e93ef7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -239,6 +239,11 @@ static void handle_client_register(const void *buf, uint16_t len)
 	}
 
 	client = new0(struct gatt_client, 1);
+	if (!client) {
+		error("gatt: cannot allocate memory for registering client");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
-- 
1.8.3.1

