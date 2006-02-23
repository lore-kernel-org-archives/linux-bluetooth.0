Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602230937n72ba801at6d0005d0f1a98dce@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3333_26201869.1140716279820"
Subject: [Bluez-devel] Build Problem
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
Date: Thu, 23 Feb 2006 14:37:59 -0300

------=_Part_3333_26201869.1140716279820
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I saw that you changed the hcid/Makefile.am to add sdp files. When you
changed the file order the build broke. The attached patch should fix
this issue.

kword.c:42:20: error: parser.h: No such file or directory
kword.c:45: error: 'K_OPTIONS' undeclared here (not in a function)
kword.c:46: error: 'K_DEVICE' undeclared here (not in a function)
kword.c:48: error: 'K_AUTOINIT' undeclared here (not in a function)
kword.c:49: error: 'K_SECURITY' undeclared here (not in a function)
kword.c:50: error: 'K_PAIRING' undeclared here (not in a function)
kword.c:51: error: 'K_PTYPE' undeclared here (not in a function)
kword.c:52: error: 'K_LM' undeclared here (not in a function)
kword.c:53: error: 'K_LP' undeclared here (not in a function)
kword.c:54: error: 'K_ISCAN' undeclared here (not in a function)
kword.c:55: error: 'K_PSCAN' undeclared here (not in a function)
kword.c:56: error: 'K_NAME' undeclared here (not in a function)
kword.c:57: error: 'K_CLASS' undeclared here (not in a function)
kword.c:58: error: 'K_VOICE' undeclared here (not in a function)
kword.c:59: error: 'K_INQMODE' undeclared here (not in a function)
kword.c:60: error: 'K_PAGETO' undeclared here (not in a function)
kword.c:61: error: 'K_AUTH' undeclared here (not in a function)
kword.c:62: error: 'K_ENCRYPT' undeclared here (not in a function)
kword.c:63: error: 'K_PINCODE' undeclared here (not in a function)
kword.c:64: error: 'K_PINHELP' undeclared here (not in a function)
kword.c:65: error: 'K_DBUSPINHELP' undeclared here (not in a function)
kword.c:67: error: 'K_YES' undeclared here (not in a function)
kword.c:68: error: 'K_NO' undeclared here (not in a function)
make[2]: *** [kword.o] Error 1


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_3333_26201869.1140716279820
Content-Type: text/x-patch; name=Makefile.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek16fe06
Content-Disposition: attachment; filename="Makefile.patch"

Index: hcid/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/Makefile.am,v
retrieving revision 1.37
diff -u -r1.37 Makefile.am
--- hcid/Makefile.am	23 Feb 2006 12:56:46 -0000	1.37
+++ hcid/Makefile.am	23 Feb 2006 17:33:56 -0000
@@ -28,8 +28,8 @@
 endif
 
 hcid_SOURCES = main.c security.c device.c storage.c hcid.h \
-		sdp.c sdp.h lib.c lib.h kword.c kword.h \
-		parser.h parser.y lexer.l $(dbus_hcid_sources) \
+		sdp.c sdp.h lib.c lib.h parser.h parser.y \
+		lexer.l kword.c kword.h $(dbus_hcid_sources) \
 		$(top_builddir)/tools/oui.h $(top_builddir)/tools/oui.c
 
 hcid_LDADD = $(dbus_hcid_libs) @BLUEZ_LIBS@ \

------=_Part_3333_26201869.1140716279820--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
