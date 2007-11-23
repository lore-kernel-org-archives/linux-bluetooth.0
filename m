Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47473455.4010900@frederic-blain.com>
Date: Fri, 23 Nov 2007 20:13:09 +0000
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Blain?= <bluez@frederic-blain.com>
MIME-Version: 1.0
To: Adam Strojek <zwierzak2003@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
References: <47430C9F.4060408@frederic-blain.com>	
	<c74b6b3d0711200801k7e161bd5kff310b98c5690822@mail.gmail.com>	
	<474317DC.6020204@frederic-blain.com>
	<c74b6b3d0711200832p56188bc9g87060e3b69df33a@mail.gmail.com>
In-Reply-To: <c74b6b3d0711200832p56188bc9g87060e3b69df33a@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1615572516=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1615572516==
Content-Type: multipart/alternative;
	boundary="------------070200050001010100060103"

This is a multi-part message in MIME format.
--------------070200050001010100060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Hello Adams,

I actually built bluez-utils with --enable-hidd option and renamed the 
file  /var/lib/bluetooth/xx:xx:xx:xx:xx/hidd  to
......./input to get /bluetoothd-service-input/ working. However, there 
is an issue with the current version since
new input devices (at least the sixaxis) does not seem to be recognized. 
I will try to post on bluez-devel to get
an idea on what should be done to fix this.

For those interested, I've written a step by step doc here:
http://creber.free.fr/frederic-blain/?n=Main.GentooOnPS3SixaxisBluetooth.

Thanks for your help,

-- 
creber





Adam Strojek wrote:
> This min that you need pair your sixaxis using old hidd deamon with
> patchs and instructions from this page, and then you can delete old
> deamons because you have propetly created pair link between your
> computer and your sixaxis.
>
> 2007/11/20, Frédéric Blain <bluez@frederic-blain.com>:
>   
>> Hello Adam and thanks for your help.
>>
>> My Sixaxis has a different Mac address than yours (00:19:C1:ED:21:31) :
>>
>> # dbus-monitor --system --monitor
>> signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0;
>> interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
>>    string "00:19:C1:ED:21:31"
>>
>> I've set  /var/lib/bluetooth/[mac od your bluetooth]/trusts accordingly
>> and let  /var/lib/bluetooth/[mac od your bluetooth]/input
>> as yours.
>>
>> I still have the same issue.
>> Do you know what's the structure of  /var/lib/bluetooth/[mac od your
>> bluetooth]/input ?
>> Should I change anything ?
>>
>> Also, I forgot to specify in my original mail :
>>
>> # uname -a
>> Linux localhost 2.6.23 #3 SMP Tue Nov 13 23:08:08 CET 2007 ppc64 Cell
>> Broadband Engine, altivec supported GNU/Linux
>>
>>
>> Thanks,
>>
>> --
>> creber
>>
>>
>> Adam Strojek wrote:
>>     
>>> I also couldn't use Sixaxis in bluetooth mode until I add this lines
>>> into pairing informations:
>>>
>>> $ cat /var/lib/bluetooth/[mac od your bluetooth]/input
>>> 05010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C000
>>> 00000000 Sony Computer Entertainment Wireless Controller
>>>
>>> $ cat /var/lib/bluetooth/[mac od your bluetooth]/trusts
>>> 00:19:C1:E4:2D:06 [all]
>>>
>>> All Sixaxis controllers have the same Mac adress, you need only add this lines.
>>>
>>> 2007/11/20, Frédéric Blain <bluez@frederic-blain.com>:
>>>
>>>       
>>>> Hello,
>>>>
>>>> I'm experiencing an issue while trying to use the Sony PS3 sixaxis under
>>>> Linux (Gentoo). The host machine is a PS3, I use bluez 3.22 out of the
>>>> box (no patches) on a 64 bits kernel. I followed the documentation at
>>>> http://www.pabr.org/sixlinux/
>>>>
>>>> This is my first bluetooth/Bluez experience, so please forgive if I use
>>>> the wrong term or if I ask stupid questions ...
>>>>
>>>>
>>>> ==== Problem Description ====
>>>>
>>>> The sixaxis is not recognized by bluetoothd-service-input.
>>>> According hcidump, a connection is made from the device (sixaxis)
>>>> to the host controler but when trying to contact HDI on control
>>>> channel (PSM 17),  bluetoothd-service-input generate an error:
>>>> "HIDP: Control: Virtual cable unplug".
>>>>
>>>> As a consequence, the device try few more times to establish the
>>>> connection and then give up. Sixaxis is never recognized and
>>>> created on the host.
>>>>
>>>>
>>>> ==== Investigations ====
>>>>
>>>> Attaching GDB to the running hcid and bluetoothd-service-input
>>>> processes, I've isolated the following behavior :
>>>>
>>>> **** bluetoothd-service-input side ****
>>>> At startup, it setup the callback mechanism from l2cap control
>>>> (psm 17) & interrupt (psm 19) sockets to the function
>>>> connect_event(). Later, when the device ask to open the psm 17 on
>>>> l2cap, connect_event() is called. Then :
>>>>
>>>> connect_event()  ==call=> input_device_set_channel() ==call==>
>>>> find_device() ==use==> GSList *devices;
>>>>
>>>> In my case, GSList *devices is NULL, so connect_event() do a /* Send
>>>> unplug virtual cable to unknown devices */.
>>>>
>>>> This point out that:
>>>>   1- The device structure for the sixaxis has not been created
>>>>   2- Having a device structure is a requirement to use HID
>>>>
>>>>
>>>> **** hcid side ****
>>>> Everything looks good here.
>>>> Once the device has completed the connection with hcid, the function
>>>> conn_complete() is called.
>>>>
>>>> This one will :
>>>>   + Send a dbus system signal via hcid_dbus_conn_complete() :
>>>>      signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceConnected
>>>>   + Read the remote name of the device
>>>>
>>>>
>>>>
>>>> **** dbus side ****
>>>> Everytime the sixaxis tries to establish a connection with the host, the
>>>> following messages appear :
>>>>
>>>> signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceConnected
>>>>    string "00:19:C1:ED:21:31"
>>>> signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteNameUpdated
>>>>    string "00:19:C1:ED:21:31"
>>>>    string "PLAYSTATION(R)3 Controller"
>>>> signal sender=:1.3 -> dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
>>>>    string "00:19:C1:ED:21:31"
>>>>
>>>>
>>>>
>>>> **** Other ****
>>>> Just to be sure, the pairing has been done using sixpair.c => same issue
>>>> I've tested with the CVS versions of hcid and bluetoothd-service-input => same issue.
>>>>
>>>>
>>>> ==== Need Help :/ ====
>>>>
>>>> Could someone explains me what should be the process to establish a HID
>>>> connection via Bluez ?
>>>>
>>>> I think bluetoothd-service-input should listen signals from
>>>> /org/bluez/hci0 and create a device structure when a
>>>> RemoteDeviceConnected signal is intercepted, but it doesn't seem to
>>>> work like this.
>>>>
>>>> In bluetoothd-service-input, in which step of this process should the
>>>> create_device() function be called ?
>>>>
>>>> Did I miss a something ?
>>>>
>>>>
>>>> Please find in attachment :
>>>>   + Output of "hcidump -w" while trying to establish a connection
>>>>   + Output of "dbus-monitor --system --monitor" while trying to establish a connection
>>>>   + Output of syslog while trying to establish a connection
>>>>
>>>> # dbus-daemon --version
>>>> D-Bus Message Bus Daemon 1.0.2
>>>>
>>>> Thanks in advance for your help,
>>>>
>>>> --
>>>> creber
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -------------------------------------------------------------------------
>>>> This SF.net email is sponsored by: Microsoft
>>>> Defy all challenges. Microsoft(R) Visual Studio 2005.
>>>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>>>> _______________________________________________
>>>> Bluez-users mailing list
>>>> Bluez-users@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>>
>>>>
>>>>
>>>>
>>>>         
>>     


--------------070200050001010100060103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Hello Adams,<br>
<br>
I actually built bluez-utils with --enable-hidd option and renamed the
file&nbsp; /var/lib/bluetooth/xx:xx:xx:xx:xx/hidd&nbsp; to<br>
......./input to get <em>bluetoothd-service-input</em> working.
However, there is an issue with the current version since<br>
new input devices (at least the sixaxis) does not seem to be
recognized. I will try to post on bluez-devel to get<br>
an idea on what should be done to fix this.<br>
<br>
For those interested, I've written a step by step doc here:<br>
<a class="moz-txt-link-freetext" href="http://creber.free.fr/frederic-blain/?n=Main.GentooOnPS3SixaxisBluetooth">http://creber.free.fr/frederic-blain/?n=Main.GentooOnPS3SixaxisBluetooth</a>.<br>
<br>
Thanks for your help,<br>
<br>
-- <br>
creber<br>
<br>
<br>
<br>
<br>
<br>
Adam Strojek wrote:
<blockquote
 cite="mid:c74b6b3d0711200832p56188bc9g87060e3b69df33a@mail.gmail.com"
 type="cite">
  <pre wrap="">This min that you need pair your sixaxis using old hidd deamon with
patchs and instructions from this page, and then you can delete old
deamons because you have propetly created pair link between your
computer and your sixaxis.

2007/11/20, Fr&eacute;d&eacute;ric Blain <a class="moz-txt-link-rfc2396E" href="mailto:bluez@frederic-blain.com">&lt;bluez@frederic-blain.com&gt;</a>:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello Adam and thanks for your help.

My Sixaxis has a different Mac address than yours (00:19:C1:ED:21:31) :

# dbus-monitor --system --monitor
signal sender=:1.3 -&gt; dest=(null destination) path=/org/bluez/hci0;
interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
   string "00:19:C1:ED:21:31"

I've set  /var/lib/bluetooth/[mac od your bluetooth]/trusts accordingly
and let  /var/lib/bluetooth/[mac od your bluetooth]/input
as yours.

I still have the same issue.
Do you know what's the structure of  /var/lib/bluetooth/[mac od your
bluetooth]/input ?
Should I change anything ?

Also, I forgot to specify in my original mail :

# uname -a
Linux localhost 2.6.23 #3 SMP Tue Nov 13 23:08:08 CET 2007 ppc64 Cell
Broadband Engine, altivec supported GNU/Linux


Thanks,

--
creber


Adam Strojek wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">I also couldn't use Sixaxis in bluetooth mode until I add this lines
into pairing informations:

$ cat /var/lib/bluetooth/[mac od your bluetooth]/input
05010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C000
00000000 Sony Computer Entertainment Wireless Controller

$ cat /var/lib/bluetooth/[mac od your bluetooth]/trusts
00:19:C1:E4:2D:06 [all]

All Sixaxis controllers have the same Mac adress, you need only add this lines.

2007/11/20, Fr&eacute;d&eacute;ric Blain <a class="moz-txt-link-rfc2396E" href="mailto:bluez@frederic-blain.com">&lt;bluez@frederic-blain.com&gt;</a>:

      </pre>
      <blockquote type="cite">
        <pre wrap="">Hello,

I'm experiencing an issue while trying to use the Sony PS3 sixaxis under
Linux (Gentoo). The host machine is a PS3, I use bluez 3.22 out of the
box (no patches) on a 64 bits kernel. I followed the documentation at
<a class="moz-txt-link-freetext" href="http://www.pabr.org/sixlinux/">http://www.pabr.org/sixlinux/</a>

This is my first bluetooth/Bluez experience, so please forgive if I use
the wrong term or if I ask stupid questions ...


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
(psm 17) &amp; interrupt (psm 19) sockets to the function
connect_event(). Later, when the device ask to open the psm 17 on
l2cap, connect_event() is called. Then :

connect_event()  ==call=&gt; input_device_set_channel() ==call==&gt;
find_device() ==use==&gt; GSList *devices;

In my case, GSList *devices is NULL, so connect_event() do a /* Send
unplug virtual cable to unknown devices */.

This point out that:
  1- The device structure for the sixaxis has not been created
  2- Having a device structure is a requirement to use HID


**** hcid side ****
Everything looks good here.
Once the device has completed the connection with hcid, the function
conn_complete() is called.

This one will :
  + Send a dbus system signal via hcid_dbus_conn_complete() :
     signal sender=:1.3 -&gt; dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceConnected
  + Read the remote name of the device



**** dbus side ****
Everytime the sixaxis tries to establish a connection with the host, the
following messages appear :

signal sender=:1.3 -&gt; dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceConnected
   string "00:19:C1:ED:21:31"
signal sender=:1.3 -&gt; dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteNameUpdated
   string "00:19:C1:ED:21:31"
   string "PLAYSTATION(R)3 Controller"
signal sender=:1.3 -&gt; dest=(null destination) path=/org/bluez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
   string "00:19:C1:ED:21:31"



**** Other ****
Just to be sure, the pairing has been done using sixpair.c =&gt; same issue
I've tested with the CVS versions of hcid and bluetoothd-service-input =&gt; same issue.


==== Need Help :/ ====

Could someone explains me what should be the process to establish a HID
connection via Bluez ?

I think bluetoothd-service-input should listen signals from
/org/bluez/hci0 and create a device structure when a
RemoteDeviceConnected signal is intercepted, but it doesn't seem to
work like this.

In bluetoothd-service-input, in which step of this process should the
create_device() function be called ?

Did I miss a something ?


Please find in attachment :
  + Output of "hcidump -w" while trying to establish a connection
  + Output of "dbus-monitor --system --monitor" while trying to establish a connection
  + Output of syslog while trying to establish a connection

# dbus-daemon --version
D-Bus Message Bus Daemon 1.0.2

Thanks in advance for your help,

--
creber





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
<a class="moz-txt-link-freetext" href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>




        </pre>
      </blockquote>
    </blockquote>
    <pre wrap="">
    </pre>
  </blockquote>
</blockquote>
<br>
</body>
</html>

--------------070200050001010100060103--


--===============1615572516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1615572516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1615572516==--
