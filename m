Return-Path: <cyrus@holtmann.org>
Message-ID: <4328a52e0806030654g62e8c4aepe9a7f2ea4386ef6b@mail.gmail.com>
Date: Tue, 3 Jun 2008 13:54:10 +0000
From: "Artem Skvira" <artem.skvira@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluez-gnome-0.26: out of memory
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1939476263=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1939476263==
Content-Type: multipart/alternative;
	boundary="----=_Part_13579_19022256.1212501250501"

------=_Part_13579_19022256.1212501250501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I have an issue with bluetooth on my ubuntu hardy. Basically, when I
ran *bluetooth-properties
*
and try to add a device, I get this error message:

"process 24083: arguments to dbus_message_new_method_call() were incorrect,
assertion "_dbus_check_is_valid_path (path)" failed in file dbus-message.c
line 1074.
This is normally a bug in some application using the D-Bus library.

** ERROR **: Out of memory
aborting...
Aborted"

I installed 0.26 as you Marcel suggested, but it didn't solve the problem.

Now I'm wondering is there anything else I can look into and try ti fix?
May be there's some information/logs I can post here?

Thanks!

------=_Part_13579_19022256.1212501250501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I have an issue with bluetooth on my ubuntu hardy. Basically, when I ran <b>bluetooth-properties </b><br>and try to add a device, I get this error message:<br><br>&quot;process 24083: arguments to dbus_message_new_method_call() were incorrect, assertion &quot;_dbus_check_is_valid_path (path)&quot; failed in file dbus-message.c line 1074.<br>
This is normally a bug in some application using the D-Bus library.<br><br>** ERROR **: Out of memory<br>aborting...<br>Aborted&quot;<br><br>I installed 0.26 as you Marcel suggested, but it didn&#39;t solve the problem.<br>
<br>Now I&#39;m wondering is there anything else I can look into and try ti fix?<br>May be there&#39;s some information/logs I can post here?<br><br>Thanks!<br><br>

------=_Part_13579_19022256.1212501250501--


--===============1939476263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1939476263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1939476263==--
