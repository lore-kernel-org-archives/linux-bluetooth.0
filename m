Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in
	hidp/core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050123113924.GA17069@salvia.homeip.net>
References: <20050119224400.GA7881@salvia.homeip.net>
	 <1106180379.8190.146.camel@pegasus>
	 <20050120003408.GA8619@salvia.homeip.net>
	 <1106182874.8190.166.camel@pegasus>
	 <20050120090340.GA9719@salvia.homeip.net> <1106470008.8112.9.camel@pegasus>
	 <20050123113924.GA17069@salvia.homeip.net>
Content-Type: multipart/mixed; boundary="=-aY2GRIQGFtctrKKfpgBd"
Message-Id: <1106481693.9269.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 23 Jan 2005 13:01:33 +0100


--=-aY2GRIQGFtctrKKfpgBd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Juha,

> > I think we should add a patch for this, but I don't like the way you did
> > it. Checking for the end value of a for-loop is not a good programming
> > practice. Using memcmp() here should be a lot better and cleaner.
> 
> It depends on how you think about the problem.  If you see the data as just
> an array of bytes, memcmp() is the way to go.  If you think of it as 6
> consecutive key codes, with each one set to 1, for loop is conceptually the            
> right thing to use.

I don't see your difference. We have to match a specific case and we
have to do it with clean code. And as I said, checking the end value of
a for-loop is not good code for me. So I am using memcmp() for it and my
patch is attached.

Regards

Marcel


--=-aY2GRIQGFtctrKKfpgBd
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== net/bluetooth/hidp/core.c 1.3 vs edited =====
--- 1.3/net/bluetooth/hidp/core.c	2004-12-26 19:19:32 +01:00
+++ edited/net/bluetooth/hidp/core.c	2005-01-23 10:01:48 +01:00
@@ -74,6 +74,8 @@
 	150,158,159,128,136,177,178,176,142,152,173,140
 };
 
+static unsigned char hidp_mkeyspat[] = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 };
+
 static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 {
 	struct hidp_session *session;
@@ -174,6 +176,11 @@
 	case 0x01:	/* Keyboard report */
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
+
+		/* If all the key codes have been set to 0x01, it means
+		 * too many keys were pressed at the same time. */
+		if (!memcmp(udata + 2, hidp_mkeyspat, 6))
+			break;
 
 		for (i = 2; i < 8; i++) {
 			if (keys[i] > 3 && memscan(udata + 2, keys[i], 6) == udata + 8) {

--=-aY2GRIQGFtctrKKfpgBd--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
