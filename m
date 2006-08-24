Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Markus Becker <mab@comnets.uni-bremen.de>
In-Reply-To: <Pine.LNX.4.21.0608241231400.27134-200000@bugs.comnets.uni-bremen.de>
References: <Pine.LNX.4.21.0608241231400.27134-200000@bugs.comnets.uni-bremen.de>
Content-Type: multipart/mixed; boundary="=-OpnCY2FnzNav01ERXPwA"
Date: Thu, 24 Aug 2006 16:43:22 +0200
Message-Id: <1156430602.4133.108.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-libs UUID-128 support for
	Protocol	Descriptor List
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-OpnCY2FnzNav01ERXPwA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Markus,

> > > I've created a patch for bluez-libs/src/sdp.c to support the finding of
> > > UUID128 encoded protocols. So that also kdebluetooth and others can
> > > recognize those protocols. It changes the display of the Protocol
> > > Descriptor List for example from:
> > > 
> > > Service Name: ATEmulator
> > > Service RecHandle: 0x10010
> > > Service Class ID List:
> > >   "Error: This is UUID-128" (0x7dd6b763-99a9-4a92-87b5-bc8efe565c37)
> > >   "Error: This is UUID-128" (0x00001101-0000-1000-8000-00805f9b34fb)
> > > Protocol Descriptor List:
> > >   "Error: " (0x00000100-0000-1000-8000-00805f9b34fb)
> > >   "Error: " (0x00000003-0000-1000-8000-00805f9b34fb)
> > >     Channel: 25
> > > 
> > > to:
> > > 
> > > Service Name: ATEmulator
> > > Service RecHandle: 0x10010
> > > Service Class ID List:
> > >   UUID 128: 7dd6b763-99a9-4a92-87b5-bc8efe565c37
> > >   UUID 128: 00001101-0000-1000-8000-00805f9b34fb
> > > Protocol Descriptor List:
> > >   "L2CAP" (0x00000100-0000-1000-8000-00805f9b34fb)
> > >   "RFCOMM" (0x00000003-0000-1000-8000-00805f9b34fb)
> > >     Channel: 25
> > > 
> > > Please consider it for integration into mainline bluez-libs.
> > 
> > the patch is wrong. Before you are doing a lookup against the short
> > UUIDs of Bluetooth you should check if the base UUID is the Bluetooth
> > base UUID. Otherwise you can't do the lookup.
> > 
> OK. I attached a patch that does the whole String_lookup differently and
> using sdp_uuid128_to_uuid for 128 bit UUIDs. Unfortunately I had to change
> the interface in sdp_lib.h because of "const" not being fulfilled by
> sdp_uuid128_to_uuid.
> 
> I hope this patch is more to your liking. If not, contact me.

your patch is a little bit too complex and the coding style is wrong and
changing the prototypes is not a good idea.

Please test the attached patch. This is how I would do it.

Regards

Marcel


--=-OpnCY2FnzNav01ERXPwA
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: src/sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.42
diff -u -r1.42 sdp.c
--- src/sdp.c	23 Aug 2006 15:05:30 -0000	1.42
+++ src/sdp.c	24 Aug 2006 12:40:53 -0000
@@ -208,6 +208,24 @@
 	return "";
 }
 
+static char *string_lookup_uuid(struct tupla *pt0, const uuid_t* uuid)
+{
+	uuid_t tmp_uuid;
+
+	memcpy(&tmp_uuid, uuid, sizeof(tmp_uuid));
+
+	if (sdp_uuid128_to_uuid(&tmp_uuid)) {
+		switch (tmp_uuid.type) {
+		case SDP_UUID16:
+			return string_lookup(pt0, tmp_uuid.value.uuid16);
+		case SDP_UUID32:
+			return string_lookup(pt0, tmp_uuid.value.uuid32);
+		}
+	}
+
+	return "";
+}
+
 /*
  * Prints into a string the Protocol UUID
  * coping a maximum of n characters.
@@ -231,8 +249,9 @@
 		snprintf(str, n, str2);
 		break;
 	case SDP_UUID128:
-		snprintf(str, n, "Error: This is UUID-128");
-		return -4;
+		str2 = string_lookup_uuid(message, uuid);
+		snprintf(str, n, str2);
+		break;
 	default:
 		snprintf(str, n, "Type of UUID (%x) unknown.", uuid->type);
 		return -1;

--=-OpnCY2FnzNav01ERXPwA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-OpnCY2FnzNav01ERXPwA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-OpnCY2FnzNav01ERXPwA--
