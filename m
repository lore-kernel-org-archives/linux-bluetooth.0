Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1d49725d0704112005q6b90105dtc9e2e6affc647f63@mail.gmail.com>
Date: Wed, 11 Apr 2007 23:05:40 -0400
From: "Donnie Smith" <cwiid@abstrakraft.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Error connecting after inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1536045269=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1536045269==
Content-Type: multipart/alternative;
	boundary="----=_Part_38974_7699654.1176347140366"

------=_Part_38974_7699654.1176347140366
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I am developing an application that connects to the Nintendo Wii remote,
which is a bluetooth device, using BlueZ.  The API allows a bdaddr to be
supplied, or not.  If it is not supplied, the API invokes a search function
that does an hci_inquiry to get all available devices, hci_open_dev to get a
device connection, then traverses the array, calling hci_remote_name and
checking the class for each item returned from hci_inquiry until a Wiimote
is found, closes the hci device, and returns the bdaddr of the Wiimote.  The
calling function then opens a couple of L2CAP sockets and proceeds to
communicate with the device.

Here's my problem: many users receive errors on the L2CAP socket open only
when a bdaddr is not supplied, but it works fine when the bdaddr is provided
(thus skipping the search procedure described above).  I've verified that
the bdaddr returned by the search function is, in fact, identical to that
supplied, so the parameters to the socket open call are identical.  It
happens every time on some machines, and never on others - to my knowledge,
there are no intermittently failing machines.  Any ideas?

The calling function is cwiid_connect, listed in
http://abstrakraft.org/cwiid/browser/trunk/libcwiid/connect.c
The search function is cwiid_find_wiimote, which calls
cwiid_get_bdinfo_array, both listed in
http://abstrakraft.org/cwiid/browser/trunk/libcwiid/bluetooth.c

Thanks for any help you can provide,
L. Donnie Smith
CWiid Developer
http://abstrakraft.org/cwiid

------=_Part_38974_7699654.1176347140366
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I am developing an application that connects to the Nintendo Wii remote, which is a bluetooth device, using BlueZ.&nbsp; The API allows a bdaddr to be supplied, or not.&nbsp; If it is not supplied, the API invokes a search function that does an hci_inquiry to get all available devices, hci_open_dev to get a device connection, then traverses the array, calling hci_remote_name and checking the class for each item returned from hci_inquiry until a Wiimote is found, closes the hci device, and returns the bdaddr of the Wiimote.&nbsp; The calling function then opens a couple of L2CAP sockets and proceeds to communicate with the device.
<br><br>Here&#39;s my problem: many users receive errors on the L2CAP socket open only when a bdaddr is not supplied, but it works fine when the bdaddr is provided (thus skipping the search procedure described above).&nbsp; I&#39;ve verified that the bdaddr returned by the search function is, in fact, identical to that supplied, so the parameters to the socket open call are identical.&nbsp; It happens every time on some machines, and never on others - to my knowledge, there are no intermittently failing machines.&nbsp; Any ideas?
<br><br>The calling function is cwiid_connect, listed in <a href="http://abstrakraft.org/cwiid/browser/trunk/libcwiid/connect.c">http://abstrakraft.org/cwiid/browser/trunk/libcwiid/connect.c</a><br>The search function is cwiid_find_wiimote, which calls cwiid_get_bdinfo_array, both listed in 
<a href="http://abstrakraft.org/cwiid/browser/trunk/libcwiid/bluetooth.c">http://abstrakraft.org/cwiid/browser/trunk/libcwiid/bluetooth.c</a><br><br>Thanks for any help you can provide,<br>L. Donnie Smith<br>CWiid Developer
<br><a href="http://abstrakraft.org/cwiid">http://abstrakraft.org/cwiid</a><br>

------=_Part_38974_7699654.1176347140366--


--===============1536045269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1536045269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1536045269==--
