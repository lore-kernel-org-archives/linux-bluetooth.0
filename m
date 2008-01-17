Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY134-DS3C865C476D02281CDD6BAB1410@phx.gbl>
From: "shy" <shyboysby@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Thu, 17 Jan 2008 09:09:38 +0800
MIME-Version: 1.0
Subject: [Bluez-devel] bluez utils complie error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0781906136=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0781906136==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_006D_01C858E8.AFE58250"

------=_NextPart_000_006D_01C858E8.AFE58250
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit

hi, all
 I encountered an error when I compiled the bluez utils. If I compiled the
original code without modifying any code, there would be no error. But If I
modified the code, e.g., I added "printf("test\n");" in the function
dev_info in hcitool.c, there would be an error:

 make[2]: Entering directory
`/home/tester/bluez_code3.20/bluez-utils-3.20/hcid'
 test -f parser.c || /bin/bash ../ylwrap parser.y y.tab.c parser.c y.tab.h
parser.h y.output parser.output -- yacc -d
 ../ylwrap: line 111: yacc: command not found
 make[2]: *** [parser.c] Error 1
 make[2]: Leaving directory
`/home/tester/bluez_code3.20/bluez-utils-3.20/hcid'
 make[1]: *** [all-recursive] Error 1
 make[1]: Leaving directory `/home/tester/bluez_code3.20/bluez-utils-3.20'
 make: *** [all] Error 2
 
Could anyone help to resolve it?
Many thanks in advance.
Best regards
Shi Buyun

------=_NextPart_000_006D_01C858E8.AFE58250
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3199" name=3DGENERATOR></HEAD>
<BODY>
<DIV>hi, all<BR>&nbsp;I encountered an error when I compiled the bluez =
utils. If=20
I compiled the original code without modifying any code, there would be =
no=20
error. But If I modified the code, e.g., I added "printf("test\n");" in =
the=20
function dev_info in hcitool.c, there would be an =
error:<BR><BR>&nbsp;make[2]:=20
Entering directory=20
`/home/tester/bluez_code3.20/bluez-utils-3.20/hcid'<BR>&nbsp;test -f =
parser.c ||=20
/bin/bash ../ylwrap parser.y y.tab.c parser.c y.tab.h parser.h y.output=20
parser.output -- yacc -d<BR>&nbsp;../ylwrap: line 111: yacc: command not =

found<BR>&nbsp;make[2]: *** [parser.c] Error 1<BR>&nbsp;make[2]: Leaving =

directory =
`/home/tester/bluez_code3.20/bluez-utils-3.20/hcid'<BR>&nbsp;make[1]:=20
*** [all-recursive] Error 1<BR>&nbsp;make[1]: Leaving directory=20
`/home/tester/bluez_code3.20/bluez-utils-3.20'<BR>&nbsp;make: *** [all] =
Error=20
2<BR>&nbsp;<BR>Could anyone help to resolve it?<BR>Many thanks in=20
advance.<BR>Best regards<BR>Shi Buyun</DIV></BODY></HTML>

------=_NextPart_000_006D_01C858E8.AFE58250--


--===============0781906136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0781906136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0781906136==--
