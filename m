Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47477234.9010007@free.fr>
Date: Sat, 24 Nov 2007 00:37:08 +0000
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Blain?= <creber@free.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------080302040201080308060106"
Subject: [Bluez-devel] Sony PS3 sixaxis & bluez
Reply-To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080302040201080308060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
controller (Sixaxis) is
not recognized. As a workaround, you need to use the former HID daemon 
(hidd), rename
the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd to 
/var/lib/bluetooth/xx:xx:xx:xx:xx:xx/input
and restart bluez with bluetoothd-service-input. It will now recognize 
the controller.

I'm writting to this list to get some help to better understand the new 
process used by
bluetoothd-service-input to recognize and accept devices. I've read the 
code and the
documentation but I still need some information.

Could someone explains me what should be the process to establish a HID 
connection
from a remote device to the host using bluetoothd-service-input ? What 
are the
interactions between hcid and bluetoothd-service-input ? Do you have a 
doc / diagram
explaining this ?

I think bluetoothd-service-input should listen signals from 
/org/bluez/hci0 and create a
device structure when a  RemoteDeviceConnected signal is intercepted, 
but it doesn't
seem to work like this.

In bluetoothd-service-input, in which step of this process should the 
create_device()
function be called ?  I've noticed interrupt_connect_cb() & 
control_connect_cb() but
I can't figure out when they will be called.


Please be indulgent, this is my first bluetooth & bluez experience ;)

Below you can find a complete description of the problem and my 
investigations.


==== Problem Description ====

The sixaxis is not recognized by bluetoothd-service-input.
According hcidump, a connection is made from the device (sixaxis)
to the host controler but when trying to contact HDI on control
channel (PSM 17),  bluetoothd-service-input generate an error:
"HIDP: Control: Virtual cable unplug".

As a consequence, the device try few more times to establish the 
connection and then give up. Sixaxis is never recognized and
created on the host.


==== Investigations ====

Attaching GDB to the running hcid and bluetoothd-service-input 
processes, I've isolated the following behavior :

**** bluetoothd-service-input side ****
At startup, it setup the callback mechanism from l2cap control
(psm 17) & interrupt (psm 19) sockets to the function
connect_event(). Later, when the device ask to open the psm 17 on
l2cap, connect_event() is called. Then :

connect_event()  ==call=> input_device_set_channel() ==call==> 
find_device() ==use==> GSList *devices;

In my case, GSList *devices is NULL, so connect_event() do a /* Send 
unplug virtual cable to unknown devices */.

This point out that:
 1- The device structure for the sixaxis has not yet been created while 
opening the connection on psm 17 .
 2- Having a device structure is a requirement to open & use a l2cap 
channel.


**** hcid side ****
Everything looks good here.
Once the device has completed the connection with hcid, the function 
conn_complete() is called.

This one will :
 + Send a dbus system signal via hcid_dbus_conn_complete() :
    signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteDeviceConnected
 + Read the remote name of the device



**** dbus side ****
Everytime the sixaxis tries to establish a connection with the host, the 
following messages appear :

signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteDeviceConnected
  string "00:19:C1:ED:21:31"
signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteNameUpdated
  string "00:19:C1:ED:21:31"
  string "PLAYSTATION(R)3 Controller"
signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
  string "00:19:C1:ED:21:31"




==== Other ====

Just to be sure, the pairing has been done using sixpair.c => same issue

# dbus-daemon --version
D-Bus Message Bus Daemon 1.0.2

# uname -a
Linux localhost 2.6.23 #3 SMP Tue Nov 13 23:08:08 CET 2007 ppc64 Cell 
Broadband Engine, altivec supported GNU/Linux


Please find in attachment :
 + Output of "hcidump -w" while trying to establish a connection
 + Output of "dbus-monitor --system --monitor" while trying to establish 
a connection
 + Output of syslog while trying to establish a connection



==== Workaround ====

Basically, using the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd 
renamed as input will help since at startup,
bluetoothd-service-input will scan this file and fill 'GSList *devices' 
accordingly.
Also, the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/trusts has to be 
updated .

For those interested, a step by step description can be found here :
http://creber.free.fr/frederic-blain/index.php?n=Main.GentooOnPS3SixaxisBluetooth#Workaround.


Thanks in advance for your help,

-- 
creber


--------------080302040201080308060106
Content-Type: application/octet-stream;
 name="sixaxis-logs.tbz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sixaxis-logs.tbz2"

QlpoOTFBWSZTWeT8czMANqb////////////////////////////////////////////f4CLn
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
--------------080302040201080308060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080302040201080308060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080302040201080308060106--
