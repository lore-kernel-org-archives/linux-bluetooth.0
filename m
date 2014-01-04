Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/12] attrib: Fix sprintf() format specification
Date: Fri,  3 Jan 2014 21:55:20 -0400
Message-Id: <1388800528-10699-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes clang error:

src/attrib-server.c:916:26: error: format specifies type 'unsigned char'
but the argument has type 'uint16_t' (aka 'unsigned short')
[-Werror,-Wformat]
---
 src/attrib-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index a6f1066..a7ee55d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -913,7 +913,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 		sprintf(group, "%hu", handle);
-		sprintf(value, "%hhX", cccval);
+		sprintf(value, "%hX", cccval);
 		g_key_file_set_string(key_file, group, "Value", value);
 
 		data = g_key_file_to_data(key_file, &length, NULL);
-- 
1.8.3.2

