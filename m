Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 4/4] tools/obexctl: Fix display of size on completion
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Message-ID: <ee85eca2-51f3-98f7-4ba8-bf38241eeb0e@jp.fujitsu.com>
Date: Fri, 9 Feb 2018 18:12:38 +0900
MIME-Version: 1.0
In-Reply-To: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Outputs zero as the transferred size on completion of transfer as below:

  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 5339965 (@32KB/s 00:01)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 5372726 (@32KB/s 00:00)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Transferred: 0 (@18446744073704178KB/s 00:00)
  [CHG] Transfer /org/bluez/obex/server/session3/transfer2 Status: complete
---
 tools/obexctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 4e46c7541..2ef1c044e 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1862,6 +1862,14 @@ static void print_transferred(struct transfer_data *data, const char *str,
 	int seconds, minutes;
 
 	dbus_message_iter_get_basic(iter, &valu64);
+
+	/*
+	 * Use the file size to output the proper size/speed since obexd resets
+	 * the current transferred size to zero on completion of transfer.
+	 */
+	if (valu64 == 0)
+		valu64 = data->size;
+
 	speed = valu64 - data->transferred;
 	data->transferred = valu64;
 
-- 
2.14.1

