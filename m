Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <3612.89.176.57.95.1158080976.squirrel@mail.palacky.net>
In-Reply-To: <8712867d0609120643n7fd0d072o5b0bc88541f1ae39@mail.gmail.com>
References: <200609112146.15972.petr@palacky.net>
	<1157998259.26541.47.camel@localhost>
	<4304.89.176.57.95.1158012904.squirrel@mail.palacky.net>
	<8712867d0609120643n7fd0d072o5b0bc88541f1ae39@mail.gmail.com>
Date: Tue, 12 Sep 2006 19:09:36 +0200 (CEST)
From: petr@palacky.net
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] 3 or more BT dongles over 1 USB-2.0 4-port HUB
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Jamie,

my USB HUB is with and can also operate without power supply.
Today i tried these HUB and dongles on the ARM board with Debian Linux and
kernel 2.4 and here can i set "UP" only one dongle (with or without extra
power supply).
This looks as hci_usb doesn't like USB 2.0 standards...

Petr P.


Dne 12 Z=E1=F8=ED 2006, 15:43, Jaime Alberto Silva napsal(a):
> Could it be a power problem? maybe your USB port can't supply enough
> power to all the devices.
>
> On 9/11/06, petr@palacky.net <petr@palacky.net> wrote:
>
>> Hi Marcel,
>>
>>
>> thank you for your tip.
>>
>> I tried loading hci_usb with option isoc=3D0, but still nothing happens.
>> I don't think if this is question for USB Guys, because other devices
>> eg. printer, mouse, keyboard, flash-disk etc. works fine and all
>> together attached into one USB HUB. I think this is problem with any
>> component from bluez stack...
>>
>> BR
>> Petr
>>
>>
>> Dne 11 Z=E1=F8=ED 2006, 20:10, Marcel Holtmann napsal(a):
>>
>>> Hi Petr,
>>>
>>>
>>>
>>>> i have problem with three (and more) USB BT dongles (all are the
>>>> same, CSR-based) and 4-port USB-2.0 HUB.
>>>>
>>>>
>>>>
>>>> When i attach one USB dongle alone, everything is good (hci0 is up
>>>> and running). When i attach the second dongle (after the first),
>>>> still is everything OK (hci0 and hci1 are up and running). But when
>>>> i attach third (or fourth) dongle, this does not work.
>>>>
>>>> I tried attaching all dongles differently but every time the third
>>>> (or
>>>> fourth) dongle is not OK and dmesg says: #dmesg
>>>> hci_usb_intr_rx_submit: hci2 intr rx submit failed urb cd55b674 err
>>>> -28
>>>>
>>>>
>>>
>>> try loading the hci_usb driver with the isoc=3D0 option. This maybe
>>> helps, but it can also be a general problem with your USB root hub. In
>>> that case you have to check with the USB guys, because this is not
>>> Bluetooth
>>> specific.
>>>
>>> Regards
>>>
>>>
>>>
>>> Marcel
>>>
>>>
>>>
>>>
>>>
>>> ---------------------------------------------------------------------
>>> ----
>>> Using Tomcat but need to do more? Need to support web services,
>>> security? Get stuff done quickly with pre-integrated technology to
>>> make your job easier Download IBM WebSphere Application Server v.1.0.1
>>> based on Apache Geronimo
>>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D1216
>>> 42
>>> _______________________________________________
>>> Bluez-users mailing list
>>> Bluez-users@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>>
>>>
>>
>>
>>
>> -----------------------------------------------------------------------
>> --
>> Using Tomcat but need to do more? Need to support web services,
>> security? Get stuff done quickly with pre-integrated technology to make
>> your job easier Download IBM WebSphere Application Server v.1.0.1 based
>> on Apache Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D12164
>> 2
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>
>
> --
> Jaime Alberto Silva
> L I N U X      .~.
> The Choice     /V\
> of a GNU      / ( ) \ Generation    ^^-^^
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
