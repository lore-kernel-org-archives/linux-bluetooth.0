Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hid2usb error
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077216551.17051.14.camel@pc-04.ycom.ch>
References: <1077206432.17056.7.camel@pc-04.ycom.ch>
	 <1077215608.2767.2.camel@pegasus> <1077216551.17051.14.camel@pc-04.ycom.ch>
Content-Type: multipart/mixed; boundary="=-s987UToyB7yzKKUb9hjU"
Message-Id: <1077217133.2767.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 19 Feb 2004 19:58:54 +0100


--=-s987UToyB7yzKKUb9hjU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alexandre,

> Can I find this patch somewhere ?

in the Linux USB development mailing list archive. I searched for you
and attached it.

Regards

Marcel


--=-s987UToyB7yzKKUb9hjU
Content-Disposition: attachment; filename=hid-core.diff
Content-Type: text/x-patch; name=hid-core.diff; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-orig/drivers/usb/input/hid-core.c	2004-01-08 22:59:44.000000000 -0800
+++ linux-2.6.1/drivers/usb/input/hid-core.c	2004-01-21 15:15:35.000000000 -0800
@@ -224,6 +224,9 @@
 	offset = report->size;
 	report->size += parser->global.report_size * parser->global.report_count;
 
+	if (usages < parser->global.report_count)
+		usages = parser->global.report_count;
+
 	if (usages == 0)
 		return 0; /* ignore padding fields */
 
@@ -235,9 +238,13 @@
 	field->application = hid_lookup_collection(parser, HID_COLLECTION_APPLICATION);
 
 	for (i = 0; i < usages; i++) {
-		field->usage[i].hid = parser->local.usage[i];
+		int j = i;
+		/* Duplicate the last usage we parsed if we have excess values */
+		if (i >= parser->local.usage_index)
+			j = parser->local.usage_index - 1;
+		field->usage[i].hid = parser->local.usage[j];
 		field->usage[i].collection_index =
-			parser->local.collection_index[i];
+			parser->local.collection_index[j];
 	}
 
 	field->maxusage = usages;

--=-s987UToyB7yzKKUb9hjU--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
