Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <I92JZQ$4438CF5CD46EDB224256583706BE5074@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Piconet problems
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
Date: Tue, 21 Dec 2004 12:02:14 +0100

Hi, 
 
I'm trying to create a simple piconet consisting of a master and=
 two slaves. I'm using three Digicom Palladio 
dongles. 
My packages li=
st is: 
 - bluez-libs-2.8-1.i386.rpm 
 - bluez-bluefw-1.0-1.i386.rpm =0D
=
 - bluez-hcidump-1.10-1.i386.rpm 
 - bluez-sdp-1.5-1.i386.rpm 
 - bluez=
-pan-1.1-1.i386.rpm 
 - bluez-utils-2.8-1.i386.rpm 
 - bridge-utils-0.9=
.6-1.i386.rpm 
 
 On master side I type: 
 # hciconfig hci0 up 
 # pa=
nd --listen --master --role GN 
 
 On the first slave I type: 
 # hcic=
onfig hci0 up 
 # hcitool inq 
 # pand --connect <master_bt_addr> 
 # =
ifconfig bnep0 10.10.10.2 broadcast 10.10.10.255 netmask 255.255.255.0 =0D
=
 
 if I type 
 # hcitool inq 
 I obtain: 
 
 Inquiry failed.: Device=
 or resource busy 
 
 On the second slave I type: 
 # hciconfig hci0 u=
p 
 # hcitool inq 
 I only obtain the master bt_addr. 
 # pand --conne=
ct <master_bt_addr> 
 
 and 
 # ifconfig bnep0 10.10.10.3 broadcast 10=
.10.10.255 netmask 255.255.255.0 
 
 Unfortunally I obtain: 
 
 SIOCS=
IFADDR: No such device 
 bnep0: unknown interface: No such device 
 SIO=
CSIFBRDADDR: No such device 
 bnep0: unknown interface: No such device =0D
=
 SIOCSIFNETMASK: No such device 
 
 Can someone tell me what is wrong? =
Thanks. 
 Jers 
 =0A=0A=0A=0A__________________________________________=
__________________=0ARegala e regalati Libero ADSL: 3 mesi gratis e navig=
hi veloce. 1.2 Mega di musica, film, video e sport. =0AAbbonati subito se=
nza costi di attivazione su http://www.libero.it=0A=0A



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
