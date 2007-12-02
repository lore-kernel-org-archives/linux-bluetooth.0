Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <82b2af8e0712020835s12e9ac05m7475b78dfafea96c@mail.gmail.com>
Date: Sun, 2 Dec 2007 17:35:40 +0100
From: "=?ISO-8859-1?Q?=C1ngel_Guzm=E1n_Maeso?=" <shakaran@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] My blueetooth is supported?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1623414215=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1623414215==
Content-Type: multipart/alternative;
	boundary="----=_Part_3816_11942304.1196613340163"

------=_Part_3816_11942304.1196613340163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have Ubuntu 7.10, but my bluetooth doesn't work.

The commands:

shakaran@shakaran:~$ dmesg | grep Blue
[   38.044000] Bluetooth: Core ver 2.11
[   38.044000] Bluetooth: HCI device and connection manager initialized
[   38.044000] Bluetooth: HCI socket layer initialized
[   38.084000] Bluetooth: L2CAP ver 2.8
[   38.084000] Bluetooth: L2CAP socket layer initialized
[   38.488000] Bluetooth: RFCOMM socket layer initialized
[   38.488000] Bluetooth: RFCOMM TTY layer initialized
[   38.488000] Bluetooth: RFCOMM ver 1.8
[   38.696000] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[   38.696000] Bluetooth: BNEP filters: protocol multicast

shakaran@shakaran:~$ sudo hidd --search
Searching ...
shakaran@shakaran:~$  sudo hciconfig hci0 inqmode 0
Can't get device info: No such device
shakaran@shakaran:~$ hciconfig

I have a laptop Toshiba Satellite M60-126

In Windows XP bluetooth works but not because ubuntu gutsy?

Thanks you

-- 
Shakaran
Administrador de Apogeus - www.apogeusone.com
Tu web hispana del juegos de Rol  Apogeus, ONLINE y GRATUITO

------=_Part_3816_11942304.1196613340163
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have Ubuntu 7.10, but my bluetooth doesn&#39;t work.<br><br>The commands:<br><br>shakaran@shakaran:~$ dmesg | grep Blue<br>[&nbsp;&nbsp; 38.044000] Bluetooth: Core ver 2.11<br>[&nbsp;&nbsp; 38.044000] Bluetooth: HCI device and connection manager initialized
<br>[&nbsp;&nbsp; 38.044000] Bluetooth: HCI socket layer initialized<br>[&nbsp;&nbsp; 38.084000] Bluetooth: L2CAP ver 2.8<br>[&nbsp;&nbsp; 38.084000] Bluetooth: L2CAP socket layer initialized<br>[&nbsp;&nbsp; 38.488000] Bluetooth: RFCOMM socket layer initialized
<br>[&nbsp;&nbsp; 38.488000] Bluetooth: RFCOMM TTY layer initialized<br>[&nbsp;&nbsp; 38.488000] Bluetooth: RFCOMM ver 1.8<br>[&nbsp;&nbsp; 38.696000] Bluetooth: BNEP (Ethernet Emulation) ver 1.2<br>[&nbsp;&nbsp; 38.696000] Bluetooth: BNEP filters: protocol multicast
<br><br clear="all">shakaran@shakaran:~$ sudo hidd --search<br>Searching ...<br>shakaran@shakaran:~$&nbsp; sudo hciconfig hci0 inqmode 0<br>Can&#39;t get device info: No such device<br>shakaran@shakaran:~$ hciconfig <br><br>I have a laptop Toshiba Satellite M60-126
<br><br><div id="result_box" dir="ltr">In Windows XP bluetooth works but not because ubuntu gutsy?<br><br>Thanks you<br></div><br>-- <br>Shakaran<br>Administrador de Apogeus - <a href="http://www.apogeusone.com">www.apogeusone.com
</a><br>Tu web hispana del juegos de Rol&nbsp;&nbsp;Apogeus, ONLINE y GRATUITO

------=_Part_3816_11942304.1196613340163--


--===============1623414215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============1623414215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1623414215==--
