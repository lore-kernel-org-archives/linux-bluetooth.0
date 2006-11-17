Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 17 Nov 2006 13:57:24 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lMTXFdmTGwrh5Ib"
Message-Id: <200611171357.25160.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] PATCH: handle unicode local device name
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

--Boundary-00=_lMTXFdmTGwrh5Ib
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey,

This patch fixes a problem with storage.c turning unicode local device names 
into '.' dots.

-Denis

--Boundary-00=_lMTXFdmTGwrh5Ib
Content-Type: text/x-diff;
  charset="us-ascii";
  name="storage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="storage.patch"

Index: storage.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/storage.c,v
retrieving revision 1.43
diff -u -5 -r1.43 storage.c
--- storage.c   27 Oct 2006 14:43:23 -0000      1.43
+++ storage.c   17 Nov 2006 03:53:12 -0000
@@ -119,11 +119,11 @@
        char filename[PATH_MAX + 1], str[249];
        int i;

        memset(str, 0, sizeof(str));
        for (i = 0; i < 248 && name[i]; i++)
-               if ((unsigned char) name[i] < 32 || name[i] == 127)
+               if ((unsigned char) name[i] < 32)
                        str[i] = '.';
                else
                        str[i] = name[i];

        create_filename(filename, PATH_MAX, bdaddr, "config");


--Boundary-00=_lMTXFdmTGwrh5Ib
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_lMTXFdmTGwrh5Ib
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_lMTXFdmTGwrh5Ib--
