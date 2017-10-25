Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Subject: [PATCH BlueZ] client: Fix segmentation fault while fetching
 advertising data
Date: Wed, 25 Oct 2017 12:09:32 +0530
Message-id: <1508913572-10746-1-git-send-email-anupam.r@samsung.com>
References: <CGME20171025063956epcas1p226e935dfc7347c738230c125c340766b@epcas1p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While testing advertisement, I encountered Seg fault in client, when bluetoothd
tries to fetch the Adv data set by client. It can happen either while fetching
Manufacturer specific data or Service data. Backtrace is provided below for reference
After fix is applied, advertisement works fine for me. I am sending the following patch
your review. Thank you.

Passing val instead of &val in dbus_message_iter_append_fixed_array
DBUS API causes segmentation fault while fecthing Manufacturer
data or service data set by client.

BT Before Fix:
[bluetooth]# set-advertise-name Test
[bluetooth]# set-advertise-uuids 0x1824
[bluetooth]# set-advertise-manufacturer 0x75 0x02 0x03 0x04
[bluetooth]# advertise on

Program received signal SIGSEGV, Segmentation fault.
in append_array_variant(iter=iter@entry=0x7fffffffd780,
val=val@entry=0x62485a <ad+90>, n_elements=n_elements@entry=3, type=121) at client/advertising.c:178
in dict_append_basic_array(type=121, n_elements=3,
val=0x62485a <ad+90>, key=0x624858 <ad+88>, key_type=113, dict=0x7fffffffd730) at client/advertising.c:205
get_manufacturer_data(property=<optimized out>, iter=0x7fffffffd840,
user_data=<optimized out>) at client/advertising.c:253

After Fix:
[bluetooth]# set-advertise-name Test
[bluetooth]# set-advertise-uuids 0x1824
[bluetooth]# set-advertise-manufacturer 0x75 0x02 0x03 0x04
[bluetooth]# advertise on
[CHG] Controller 00:19:0E:11:55:44 SupportedInstances: 0x04
[CHG] Controller 00:19:0E:11:55:44 ActiveInstances: 0x01
Advertising object registered
[bluetooth]#
---
 client/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index 76cee3d..7d98ae3 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -175,7 +175,7 @@ static void append_array_variant(DBusMessageIter *iter, int type, void *val,
 						type_sig, &array);
 
 	if (dbus_type_is_fixed(type) == TRUE) {
-		dbus_message_iter_append_fixed_array(&array, type, val,
+		dbus_message_iter_append_fixed_array(&array, type, &val,
 							n_elements);
 	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
 		const char ***str_array = val;
-- 
1.9.1

