Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing on x86_64
From: Marcel Holtmann <marcel@holtmann.org>
To: Volker Fritzsch <kokor.hekkus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402212100.12603.kokor.hekkus@gmx.de>
References: <200402211252.15735.kokor.hekkus@gmx.de>
	 <200402211648.16390.kokor.hekkus@gmx.de> <1077379873.2716.18.camel@pegasus>
	 <200402212100.12603.kokor.hekkus@gmx.de>
Content-Type: multipart/mixed; boundary="=-0DyHu4YLElEWZN6lYV0+"
Message-Id: <1077416151.2716.29.camel@pegasus>
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
Date: Sun, 22 Feb 2004 03:15:51 +0100


--=-0DyHu4YLElEWZN6lYV0+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Volker,

> I couldn't understand too, but with your sizeof(char) question you made me 
> curious.
> 
> On x86_64, int has a size of 4 and size_t takes 8 (while on x86 both have a 
> size of 4).
> By passing &len to g_io_channel_read (which takes a size_t *buffer_read as 
> argument), we blank out the first four bytes of buf - which sits directly 
> after len in memory ('oh wonderful world...').
> 
> > This can be a problem that the call of the PIN helper program fails.
> This problem is also solved with the change from int len to size_t len.
> 
> So, please trash my first patch and take this instead.

and here is the patch I am going to apply. Please test it.

Regards

Marcel


--=-0DyHu4YLElEWZN6lYV0+
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Index: hcid/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/main.c,v
retrieving revision 1.11
diff -u -r1.11 main.c
--- hcid/main.c	17 Feb 2004 18:04:03 -0000	1.11
+++ hcid/main.c	22 Feb 2004 02:09:29 -0000
@@ -397,10 +397,11 @@
 
 gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	char buf[HCI_MAX_FRAME_SIZE], *ptr;
+	unsigned char buf[HCI_MAX_FRAME_SIZE], *ptr;
 	evt_stack_internal *si;
 	hci_event_hdr *eh;
-	int  len, type;
+	int type;
+	size_t len;
 	GIOError err;
 
 	ptr = buf;
Index: hcid/security.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/security.c,v
retrieving revision 1.9
diff -u -r1.9 security.c
--- hcid/security.c	17 Feb 2004 18:04:03 -0000	1.9
+++ hcid/security.c	22 Feb 2004 02:09:29 -0000
@@ -365,9 +365,10 @@
 
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
+	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
 	struct hci_dev_info *di = (void *) data;
-	int len, type, dev;
+	int type, dev;
+	size_t len;
 	hci_event_hdr *eh;
 	GIOError err;
 

--=-0DyHu4YLElEWZN6lYV0+--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
