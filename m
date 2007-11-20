Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <474317DC.6020204@frederic-blain.com>
Date: Tue, 20 Nov 2007 17:22:36 +0000
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Blain?= <bluez@frederic-blain.com>
MIME-Version: 1.0
To: Adam Strojek <zwierzak2003@gmail.com>
References: <47430C9F.4060408@frederic-blain.com>
	<c74b6b3d0711200801k7e161bd5kff310b98c5690822@mail.gmail.com>
In-Reply-To: <c74b6b3d0711200801k7e161bd5kff310b98c5690822@mail.gmail.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] ps3 sixaxis & bluez 3.22: HDI issue
Reply-To: bluez@frederic-blain.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello Adam and thanks for your help.

My Sixaxis has a different Mac address than yours (00:19:C1:ED:21:31) :

# dbus-monitor --system --monitor
signal sender=3D:1.3 -> dest=3D(null destination) path=3D/org/bluez/hci0; =

interface=3Dorg.bluez.Adapter; member=3DRemoteDeviceDisconnected
   string "00:19:C1:ED:21:31"

I've set  /var/lib/bluetooth/[mac od your bluetooth]/trusts accordingly =

and let  /var/lib/bluetooth/[mac od your bluetooth]/input
as yours.

I still have the same issue.
Do you know what's the structure of  /var/lib/bluetooth/[mac od your =

bluetooth]/input ?
Should I change anything ?

Also, I forgot to specify in my original mail :

# uname -a
Linux localhost 2.6.23 #3 SMP Tue Nov 13 23:08:08 CET 2007 ppc64 Cell =

Broadband Engine, altivec supported GNU/Linux


Thanks,

-- =

creber


Adam Strojek wrote:
> I also couldn't use Sixaxis in bluetooth mode until I add this lines
> into pairing informations:
>
> $ cat /var/lib/bluetooth/[mac od your bluetooth]/input
> 05010904A101A102850175089501150026FF0081037501951315002501350045010509190=
1291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931=
093209358102C0050175089527090181027508953009019102750895300901B102C0A102850=
2750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C000
> 00000000 Sony Computer Entertainment Wireless Controller
>
> $ cat /var/lib/bluetooth/[mac od your bluetooth]/trusts
> 00:19:C1:E4:2D:06 [all]
>
> All Sixaxis controllers have the same Mac adress, you need only add this =
lines.
>
> 2007/11/20, Fr=E9d=E9ric Blain <bluez@frederic-blain.com>:
>   =

>> Hello,
>>
>> I'm experiencing an issue while trying to use the Sony PS3 sixaxis under
>> Linux (Gentoo). The host machine is a PS3, I use bluez 3.22 out of the
>> box (no patches) on a 64 bits kernel. I followed the documentation at
>> http://www.pabr.org/sixlinux/
>>
>> This is my first bluetooth/Bluez experience, so please forgive if I use
>> the wrong term or if I ask stupid questions ...
>>
>>
>> =3D=3D=3D=3D Problem Description =3D=3D=3D=3D
>>
>> The sixaxis is not recognized by bluetoothd-service-input.
>> According hcidump, a connection is made from the device (sixaxis)
>> to the host controler but when trying to contact HDI on control
>> channel (PSM 17),  bluetoothd-service-input generate an error:
>> "HIDP: Control: Virtual cable unplug".
>>
>> As a consequence, the device try few more times to establish the
>> connection and then give up. Sixaxis is never recognized and
>> created on the host.
>>
>>
>> =3D=3D=3D=3D Investigations =3D=3D=3D=3D
>>
>> Attaching GDB to the running hcid and bluetoothd-service-input
>> processes, I've isolated the following behavior :
>>
>> **** bluetoothd-service-input side ****
>> At startup, it setup the callback mechanism from l2cap control
>> (psm 17) & interrupt (psm 19) sockets to the function
>> connect_event(). Later, when the device ask to open the psm 17 on
>> l2cap, connect_event() is called. Then :
>>
>> connect_event()  =3D=3Dcall=3D> input_device_set_channel() =3D=3Dcall=3D=
=3D>
>> find_device() =3D=3Duse=3D=3D> GSList *devices;
>>
>> In my case, GSList *devices is NULL, so connect_event() do a /* Send
>> unplug virtual cable to unknown devices */.
>>
>> This point out that:
>>   1- The device structure for the sixaxis has not been created
>>   2- Having a device structure is a requirement to use HID
>>
>>
>> **** hcid side ****
>> Everything looks good here.
>> Once the device has completed the connection with hcid, the function
>> conn_complete() is called.
>>
>> This one will :
>>   + Send a dbus system signal via hcid_dbus_conn_complete() :
>>      signal sender=3D:1.3 -> dest=3D(null destination) path=3D/org/bluez=
/hci0; interface=3Dorg.bluez.Adapter; member=3DRemoteDeviceConnected
>>   + Read the remote name of the device
>>
>>
>>
>> **** dbus side ****
>> Everytime the sixaxis tries to establish a connection with the host, the
>> following messages appear :
>>
>> signal sender=3D:1.3 -> dest=3D(null destination) path=3D/org/bluez/hci0=
; interface=3Dorg.bluez.Adapter; member=3DRemoteDeviceConnected
>>    string "00:19:C1:ED:21:31"
>> signal sender=3D:1.3 -> dest=3D(null destination) path=3D/org/bluez/hci0=
; interface=3Dorg.bluez.Adapter; member=3DRemoteNameUpdated
>>    string "00:19:C1:ED:21:31"
>>    string "PLAYSTATION(R)3 Controller"
>> signal sender=3D:1.3 -> dest=3D(null destination) path=3D/org/bluez/hci0=
; interface=3Dorg.bluez.Adapter; member=3DRemoteDeviceDisconnected
>>    string "00:19:C1:ED:21:31"
>>
>>
>>
>> **** Other ****
>> Just to be sure, the pairing has been done using sixpair.c =3D> same iss=
ue
>> I've tested with the CVS versions of hcid and bluetoothd-service-input =
=3D> same issue.
>>
>>
>> =3D=3D=3D=3D Need Help :/ =3D=3D=3D=3D
>>
>> Could someone explains me what should be the process to establish a HID
>> connection via Bluez ?
>>
>> I think bluetoothd-service-input should listen signals from
>> /org/bluez/hci0 and create a device structure when a
>> RemoteDeviceConnected signal is intercepted, but it doesn't seem to
>> work like this.
>>
>> In bluetoothd-service-input, in which step of this process should the
>> create_device() function be called ?
>>
>> Did I miss a something ?
>>
>>
>> Please find in attachment :
>>   + Output of "hcidump -w" while trying to establish a connection
>>   + Output of "dbus-monitor --system --monitor" while trying to establis=
h a connection
>>   + Output of syslog while trying to establish a connection
>>
>> # dbus-daemon --version
>> D-Bus Message Bus Daemon 1.0.2
>>
>> Thanks in advance for your help,
>>
>> --
>> creber
>>
>>
>>
>>
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Microsoft
>> Defy all challenges. Microsoft(R) Visual Studio 2005.
>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>>
>>     =



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
