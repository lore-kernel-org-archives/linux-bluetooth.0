Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f30e2610609021024j205f6a51id3d4b3c0f9129a3e@mail.gmail.com>
Date: Sat, 2 Sep 2006 12:24:20 -0500
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] off-by-one bugfix for sdp_data_alloc
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

The following patch against bluez-libs-3.4 fixes a problem where the
last character of a null-terminated string is lost.  Adding the +1
accounts for and preserves the null terminator.

    Regards,
     Jeff

--- bluez-libs-3.4/src/sdp.c    2006-08-24 20:16:12.000000000 -0500
+++ bluez-libs-3.4/src/sdp.c.mod        2006-09-02 12:12:51.000000000 -0500
@@ -498,7 +498,7 @@
                if (!value)
                        return NULL;

-               length = strlen((char *) value);
+               length = strlen((char *) value) + 1;
                break;
        default:
                length = 0;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
