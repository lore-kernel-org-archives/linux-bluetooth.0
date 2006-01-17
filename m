Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <38907.62.33.148.3.1137487338.squirrel@62.33.148.3>
From: andrew@gin.chita.ru
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Subject: [Bluez-devel] linkkeys on jffs2
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
Date: Tue, 17 Jan 2006 17:42:18 +0900 (YAKT)

Hello.

Got a problem with hcid storing link keys on jffs2 file system.
Hcid is able to store only one link key, all subsequent keys doesn't
appear in linkkeys file.
After looking into sources I find out in common/textfile.c call of mmap()
with MAP_SHARED flag which is not suported on jffs2.
As mmap is used only for seeking keys in maped memory not for storing int=
o
file seems it's good idea to use MAP_PRIVATE flag. In this case there are
no error on jffs2

Here the patch:

--- bluez-utils-2.24-orig/common/textfile.c     2005-11-30
13:15:30.000000000 +0900
+++ bluez-utils-2.24/common/textfile.c  2006-01-17 17:39:16.000000000 +09=
00
@@ -148,7 +148,7 @@
                goto unlock;
        }

-       map =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED |
MAP_LOCKED, fd, 0);
+       map =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE |
MAP_LOCKED, fd, 0);
        if (!map || map =3D=3D MAP_FAILED) {
                err =3D errno;
                goto unlock;

Andrey Denisjuk
Chita, Russia


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
