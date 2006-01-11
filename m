Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <19c2b3920601110619x37c6e4ck@mail.gmail.com>
From: rangzen <lipare@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_57585_1133652.1136989146990"
Subject: [Bluez-users] Strange things with SE K750i and remote control
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Jan 2006 15:19:06 +0100

------=_Part_57585_1133652.1136989146990
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

i can upload/download files without any problem using bluetooth.

But when i use the remote control fonction, i need to delete the device i
want to use before use it if i used it before :/

For example :
i have no device declared on the phone
i choose remote control desktop
the phone find my USB key device
i choose yes yes yes yes in the menu and i can control my mouse, etc.
everything fine
i go out in the menu, send a sms, make a call or even nothing
i go back to the remote control menu and choose the device found just befor=
e
the phone write "impossible to connect" and /var/log/daemon add
a hcid[pid]: link_key_request sba USB dba MyPhone
i go in the device known by the phone, delete the connexion
i retry and it works again :/

Exactly the same things if i make the connection from the PC
only difference is
#hidd --connect 00:phonebt:00
Can't create HID control channel: Connection refused

The phone is configured with "Always accept" from this device

I have a Ubuntu 5.10 with

Any idea ?

--
libert=E9 - partage - respect
freedom - share - respect

------=_Part_57585_1133652.1136989146990
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br>
<br>
i can upload/download files without any problem using bluetooth.<br>
<br>
But when i use the remote control fonction, i need to delete the device i w=
ant to use before use it if i used it before :/<br>
<br>
For example :<br>
i have no device declared on the phone<br>
i choose remote control desktop<br>
the phone find my USB key device<br>
i choose yes yes yes yes in the menu and i can control my mouse, etc.<br>
everything fine<br>
i go out in the menu, send a sms, make a call or even nothing<br>
i go back to the remote control menu and choose the device found just befor=
e<br>
the phone write &quot;impossible to connect&quot; and /var/log/daemon add<b=
r>
a hcid[pid]: link_key_request sba USB dba MyPhone<br>
i go in the device known by the phone, delete the connexion<br>
i retry and it works again :/<br>
<br>
Exactly the same things if i make the connection from the PC<br>
only difference is<br>
#hidd --connect 00:phonebt:00<br>
Can't create HID control channel: Connection refused<br>
<br>
The phone is configured with &quot;Always accept&quot; from this device<br>
<br>
I have a Ubuntu 5.10 with<br>
<br>
Any idea ?<br clear=3D"all"><br>-- <br>libert=E9 - partage - respect<br>fre=
edom - share - respect

------=_Part_57585_1133652.1136989146990--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
