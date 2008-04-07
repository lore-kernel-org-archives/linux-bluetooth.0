Return-Path: <cyrus@holtmann.org>
Message-ID: <49f5aca0804070738l47fce53ey2b15ec7550ea10d0@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:38:58 +0200
From: "Pedro Vivancos" <pedro.vivancos@vocali.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Vala example of DiscoveringDevices Howto does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0843307684=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0843307684==
Content-Type: multipart/alternative;
	boundary="----=_Part_1650_31561524.1207579138213"

------=_Part_1650_31561524.1207579138213
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

When I try to compile the vala example of DiscoveringDevice
Howto<http://wiki.bluez.org/wiki/HOWTO/DiscoveringDevices>I get the
following error:

$ valac --pkg dbus-glib-1 -o bluetooth bluetooth.vala
bluetooth.vala:8.31-8.31: error: syntax error, unexpected ;, expecting {

** ERROR **: file parser.y: line 2182 (yyparse): should not be reached
aborting...

Does anyone manage to compile it?

Thanks in advance.
Pedro

------=_Part_1650_31561524.1207579138213
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>When I try to compile the vala example of <a href="http://wiki.bluez.org/wiki/HOWTO/DiscoveringDevices">DiscoveringDevice Howto</a> I get the following error:<br><br>$ valac --pkg dbus-glib-1 -o bluetooth bluetooth.vala<br>
bluetooth.vala:8.31-8.31: error: syntax error, unexpected ;, expecting {<br><br>** ERROR **: file parser.y: line 2182 (yyparse): should not be reached<br>aborting...<br><br>Does anyone manage to compile it?<br><br>Thanks in advance.<br>
Pedro<br>

------=_Part_1650_31561524.1207579138213--


--===============0843307684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0843307684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0843307684==--
