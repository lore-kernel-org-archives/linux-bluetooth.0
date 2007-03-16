Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703152326g73ec4815n4c0e3045fb846b32@mail.gmail.com>
Date: Fri, 16 Mar 2007 06:26:14 +0000
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-devel@lists.sourceforge.net, bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] HELP with Input Manager Hierarchy, BlueZ D-Bus API!!!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0358871500=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

--===============0358871500==
Content-Type: multipart/alternative;
	boundary="----=_Part_64635_19328959.1174026374259"

------=_Part_64635_19328959.1174026374259
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

No one has come back to me on the devel and user mailing lists.

I am trying to use the BlueZ D-Bus API and have come across
http://wiki.bluez.org/wiki/Input which states that "The Bluetooth Input
daemon provides an interface to access Bluetooth Human Interface Devices.
The Manager interface provides methods to list, create and remove input
devices objects. The Device interface provides methods to retrieve device
information, connect and disconnect"

I am trying to develop for the Nokia 770 - the idea is to use the PDA as a
mouse to control another bluetooth-enabled PC.

Code-wise:
- establish a bluetooth connection (via dbus?) I am unsure of how to use
dbus to establish a bluetooth connection.
- sending data (the mouse movements), via packets?, via HID Profile? Once I
get at this point I believe I do not need to worry about the other end
receiving the information since the other PC would have the bluetooth
connection established and would reflect the data sent.

Would someone please HELP???

Thanks and regards,

Meena

------=_Part_64635_19328959.1174026374259
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>No one has come back to me on the devel and user mailing
lists.<br><br>I am trying to use the BlueZ D-Bus API and have come across <a href="http://wiki.bluez.org/wiki/Input" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://wiki.bluez.org/wiki/Input
</a> which states that &quot;The Bluetooth Input daemon provides an interface to access Bluetooth
Human Interface Devices. The Manager interface provides methods to
list, create and remove input devices objects. The Device interface
provides methods to retrieve device information, connect and disconnect&quot;<span class="q"><br><br></span><span class="q">I
am trying to develop for the Nokia 770 - the idea is to use the PDA as
a mouse to control another bluetooth-enabled PC. <br><br></span>Code-wise:<br>- establish a bluetooth connection (via dbus?) I am <span style="text-decoration: underline;">
unsure of how to use dbus to establish a bluetooth connection.</span><br>-
sending data (the mouse movements), via packets?, via HID Profile? Once
I get at this point I believe I do not need to worry about the other
end receiving the information since the other PC would have the
bluetooth connection established and would reflect the data sent.
<br><br>Would someone please HELP???<br><br>Thanks and regards,<br><br>Meena<br>

------=_Part_64635_19328959.1174026374259--


--===============0358871500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0358871500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0358871500==--
