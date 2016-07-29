Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
	<michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ] monitor/l2cap: Fix buffer overflow when printing UUIDs
Date: Fri, 29 Jul 2016 11:01:17 +0200
Message-Id: <1469782877-19492-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 76 flags 0x02 dlen 18                                                                                                                                                                          [hci0] 22.985107
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x000b
        UUID: Generic Attribute Profile (0x1801)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                                                                                                                          [hci0] 22.985304
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000c-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                                               [hci0] 23.051113
        Num handles: 1
        Handle: 76
        Count: 1
> ACL Data RX: Handle 76 flags 0x02 dlen 26                                                                                                                                                                          [hci0] 23.115103
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x000c-0x0010
*** buffer overflow detected ***: monitor/btmon terminated

==14384== Process terminating with default action of signal 6 (SIGABRT)
==14384==    at 0x4E6F418: raise (raise.c:54)
==14384==    by 0x4E71019: abort (abort.c:89)
==14384==    by 0x4EB1729: __libc_message (libc_fatal.c:175)
==14384==    by 0x4F5289B: __fortify_fail (fortify_fail.c:37)
==14384==    by 0x4F5089F: __chk_fail (chk_fail.c:28)
==14384==    by 0x4F4FE08: _IO_str_chk_overflow (vsprintf_chk.c:31)
==14384==    by 0x4EB55DF: _IO_default_xsputn (genops.c:455)
==14384==    by 0x4E87DBF: vfprintf (vfprintf.c:1631)
==14384==    by 0x4F4FE93: __vsprintf_chk (vsprintf_chk.c:82)
==14384==    by 0x4F4FDEC: __sprintf_chk (sprintf_chk.c:31)
==14384==    by 0x422826: sprintf (stdio2.h:33)
==14384==    by 0x422826: print_uuid (l2cap.c:2014)
==14384==    by 0x423373: print_group_list (l2cap.c:2334)
==14384==    by 0x423373: att_read_group_type_rsp (l2cap.c:2348)
---
 monitor/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 59a3206..41ea1bc 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1999,7 +1999,7 @@ static void print_hex_field(const char *label, const uint8_t *data,
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
-	char uuidstr[36];
+	char uuidstr[37];
 
 	switch (size) {
 	case 2:
-- 
2.7.4

