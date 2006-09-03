Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Sun, 3 Sep 2006 20:07:21 +0000 (UTC)
Message-ID: <loom.20060903T214020-327@post.gmane.org>
References: <loom.20060902T125209-74@post.gmane.org>
	<1157221409.32195.0.camel@aeonflux.holtmann.net>
	<loom.20060902T200908-292@post.gmane.org>
	<loom.20060902T222740-106@post.gmane.org>
	<1157319129.32195.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?adding_a_SDP_attribute_HID=5FDESCRIPTOR?=
	=?utf-8?q?=5FLIST?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann <marcel <at> holtmann.org> writes:
> what are you talking about. I have no idea and it would be better if you
> send me an example on how to reproduce this segmentation fault.

Hi Marcel,

try the following patch on bluez-utils-3.4:
--- tools/sdptool.c      2006-06-17 16:31:37.000000000 +0200
+++ tools/sdptool.c      2006-09-03 21:54:54.000000000 +0200
@@ -2139,6 +2139,21 @@
                0x75, 0x01,
                0x95, 0x04,
                0x81, 0x01,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
+               0x0, 0x0,
                0xc0         // end tag
        };

(this patch adds 30 zero's to hid_report so it is >128)

and see:
$ sdptool add keyb
Segmentation fault

the following patch on bluez-utils:
$ sed -i -e 's/\(#define SDP_SEQ_PDUFORM_SIZE\) 128/\1 256/' ${S}/src/sdp.c

fixes the problem for me... (increasing the PDUFORM_SIZE)

So my questions are:
- could you increase the SDP_SEQ_PDUFORM_SIZE
- it would be nice to have some range checking, it's very confusing because the
segfault occures in sdp_record_register and not in
sdp_attr_add()/sdp_data_alloc()/sdp_seql_alloc()

greetings,
Dick


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
