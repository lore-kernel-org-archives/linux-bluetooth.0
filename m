Return-Path: <cyrus@holtmann.org>
From: "Counihan, Tom" <tom.counihan@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 27 Jul 2010 12:28:04 +0100
Subject: [PATCH] De-register pbap drivers on init failure scenarios
Message-ID: <B09AD526409DF14F8DA79CC5429052C299EE0FC7@irsmsx505.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unwind the driver registration/phonebook initialization stack on pbap plugin init failure scenarios.


---
 plugins/pbap.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index af4b452..2d3bebd 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -892,21 +892,36 @@ static int pbap_init(void)
 
 	err = phonebook_init();
 	if (err < 0)
-		return err;
+		goto fail_pb_init;
 
 	err = obex_mime_type_driver_register(&mime_pull);
 	if (err < 0)
-		return err;
+		goto fail_mime_pull;
 
 	err = obex_mime_type_driver_register(&mime_list);
 	if (err < 0)
-		return err;
+		goto fail_mime_list;
 
 	err = obex_mime_type_driver_register(&mime_vcard);
 	if (err < 0)
-		return err;
+		goto fail_mime_vcard;
+
+	err = obex_service_driver_register(&pbap);
+	if (err < 0)
+			goto fail_pbap_reg;
 
-	return obex_service_driver_register(&pbap);
+	return 0;
+
+fail_pbap_reg:
+	obex_mime_type_driver_unregister(&mime_vcard);
+fail_mime_vcard:
+	obex_mime_type_driver_unregister(&mime_list);
+fail_mime_list:
+	obex_mime_type_driver_unregister(&mime_pull);
+fail_mime_pull:
+	phonebook_exit();
+fail_pb_init:
+	return err;
 }
 
 static void pbap_exit(void)
-- 
1.7.1.1



--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


