Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] tools/obexctl: Fix display of size/bandwidth on
 completion
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <abac898f-8f93-7a35-06b7-d23186895818@jp.fujitsu.com>
Message-ID: <3ee3463d-6514-c8d5-4c06-d0af798b9cb5@jp.fujitsu.com>
Date: Fri, 12 Jan 2018 15:25:35 +0900
MIME-Version: 1.0
In-Reply-To: <abac898f-8f93-7a35-06b7-d23186895818@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Outputs the wrong size and bandwidth on completion of transfer as below:

  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 5339965 (@32KB/s 00:01)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 5372726 (@32KB/s 00:00)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 0 (@18446744073704178KB/s 00:00)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Status: complete
---
 tools/obexctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 05bbd3e84..ca139f050 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1862,6 +1862,14 @@ static void print_transferred(struct transfer_data *data, const char *str,
 	int seconds, minutes;
 
 	dbus_message_iter_get_basic(iter, &valu64);
+
+	/*
+	 * Use the file size to output the proper size/speed since obexd emits
+	 * zero as the current transferred size on completion of transfer.
+	 */
+	if (valu64 == 0)
+		valu64 = data->size;
+
 	speed = valu64 - data->transferred;
 	data->transferred = valu64;
 
-- 
2.14.1

