Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 06 Jun 2007 19:24:35 +0200
Message-Id: <1831337479@web.de>
MIME-Version: 1.0
From: 01flipstar@web.de
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez-utils on old kernel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi everybody,

I'm still tring to get my bluetooth working.
Then I plugin the stick it is correct show when I run lsusb.

Bus 001 Device 002: ID 0a5c:2101 Broadcom Corp.

Next I start to load the modules:

insmod
  bluetooth
  sco
  l2cap
  rfcomm
  hci_uart
  hci_vhci
  firmware_class
  hidp
  bcm203x
  hci_usb

but when the last module is loaded I get a segmentation fault

I don't really understand how the firmware loading is working,
is it right that the firmware_class module is loading the firmware?

The firmware is /lib/firmware/

For the 2.4 kernel there used to be a tool bcm203x to load the firmware
to the dongle.


Can somebody please give me a hint.

Thanks
Philipp

01flipstar@web.de schrieb:
> Hi,
> =

>> -----Urspr=FCngliche Nachricht-----
>> Von: BlueZ users <bluez-users@lists.sourceforge.net>
>> Gesendet: 04.06.07 17:43:29
>> An: "BlueZ users" <bluez-users@lists.sourceforge.net>
>> Betreff: Re: [Bluez-users] bluez-utils on old kernel
> =

> =

>> On 6/3/07, 01flipstar@web.de <01flipstar@web.de> wrote:
>>> I'm trying to add bluetooth support to my arm based NAS which runs on
>>> a 2.6.10 Kernel.
>>>
>>> I compiled the bluez-libs and utils (3.11) but hcitool dev won't
>>> show any devices and when I exec hciconfig I get
>> I did the same. I have utils 3.11 on 2.6.10. it is not vanilla 2.6.10 th=
ough -
>> it is from embedded distribution, but things seems to work.
> =

> great your not vanilla kernel is not a storlink kernel ?!?! :-)
> What is your hardware doing -> is it a NAS to?
> =

> im currently getting some errors when I plug in the usb-donkle
> =

> like :
> ...
> [<c007e4c4>] (sys_ioctl+0x0/0x5c) from [<c0020900>] (ret_fast_syscall+0x0=
/0x2c)
>  r6 =3D BEFFFE1C  r5 =3D 00000000  r4 =3D 00000003 =

> Code: e59f0014 e58dc000 ebfabc61 e3a03000 (e5833000) =

>  prev->state: 2 !=3D TASK_RUNNING??
> hciconfig/7373: BUG in __schedule at kernel/sched.c:2902
> =

> so i'll try to change the scheduler tomorrow
> =

>> just my 2 cents.
>>
>> voni.
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by DB2 Express
>> Download DB2 Express C - the FREE version of DB2 express and take
>> control of your XML. No limits. Just data. Click to get it now.
>> http://sourceforge.net/powerbar/db2/
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
> =

> =

> _______________________________________________________________
> SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
> kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=3D021192
> =

> =

> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=3D021192


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
