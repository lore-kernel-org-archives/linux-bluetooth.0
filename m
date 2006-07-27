Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060727185006.69823.qmail@web27915.mail.ukl.yahoo.com>
Date: Thu, 27 Jul 2006 18:50:06 +0000 (GMT)
From: Wolfram Reda <wolfram_reda@yahoo.de>
To: Nils Faerber <nils.faerber@kernelconcepts.de>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44C8FB2F.9070403@kernelconcepts.de>
MIME-Version: 1.0
Cc: Bearcat@feline-soul.com
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
Reply-To: Wolfram Reda <wolfram_reda@yahoo.de>,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi nils,
Now it's working Yeah!!!!!!!!!!!!

I followed  your recommendation and switched auth on via hcitool and looked=
 to the hcidump but everything moved very fast and i didn't see any popup w=
here i can put in the pin string?

But after doing =


 hidd --connect 00:04:61:82:03:4A i can write suddenly on my keyboar which =
i'm using now to write the email !!!

here is the evidence:

hidd --connect show

root@woraBox:/home/rw024419# hidd --show
00:04:61:82:03:4A Bluetooth HID Boot Protocol Device [0000:0000] connected =
[boot-protocol]
00:04:61:81:F7:C8 Bluetooth HID Boot Protocol Device [0000:0000] connected =
[boot-protocol]

So now i'm hapy that everything works but i'm a little afraid to disconnect=
 and try again to understand really what happend. Nothing to see in the sys=
log!

But it looks like auth is required. But the pin input via hcidump is really=
 weard isn't ist?

Next Step  would be to make this permanent that after boot the keyboard and=
 mouse is connected automatically! Any hint on that?

Nils, many thanks for your great idea and help.

Best Regards
Wolfram

----- Urspr=FCngliche Mail ----
Von: Nils Faerber <nils.faerber@kernelconcepts.de>
An: Bearcat@feline-soul.com; BlueZ users <bluez-users@lists.sourceforge.net>
CC: Wolfram Reda <wolfram_reda@yahoo.de>
Gesendet: Donnerstag, den 27. Juli 2006, 19:43:11 Uhr
Betreff: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B

Bearcat M. Sandor schrieb:
> Wolfram,
Hi!

> I'm having the same problem with my logitech Cordless Elite. The mouse wo=
rks =

> great, but the keyboard just won't connect.  Perhaps there is something w=
rong =

> with keyboards in general or our keyboards are based on the same topology.
> =

> If i figure it out, i'll let you know. In the mean time, we ought to comp=
are =

> notes.

Hmm.. usually those keyboards want to be paired first.

So must have auth enabled.
But even then it might be that you have to enter the PIN on the keyboard
first before the requester on the Linux side pops-up.

So IIRC the process could be (as root):
  put keyboard in pairing mode (press some button somewhere so it also
becomes visible)
  start hcidump as root on some console and watch the output ;)
  try to connect the hidd to the keyboard (hidd --connect <bdaddr>)
  now you may get a auth request from the keyboard in the hcidump
  now enter a PIN on the keyboard and press the ENTER key, the PIN
usually can only consist of numbers (like 1234) typed on the regular
number key, not the numeric keypad!
  now again watch the hcidump output
  if your host is setup correctly the PIN request dialog should come up
and you have to enter the same PIN as before there
  watch hcidump again - auth successful? Then it should work now!

Not successful?
Darn!

OK, take two.

Make the keyboard visible again.
Now create a L2CAP connection manually by doing
    hcitool cc <bdaddr>
And now trigger the auth process manually
    hcitool auth <bdaddr>

And then follow the above steps right _after_ the connect hidd step.

After PIN exchange you should be paired and should be able to connect
using hidd to your keyboard.

Good luck!

> Bearcat
Cheers
  nils



> On Thursday 27 July 2006 01:46 in an email titled "[Bluez-users] can't co=
nnect =

> EPOX Keyboard BT-KB01B" Wolfram Reda wrote:
>> Hello,
>> I'm trying to connect my Buetooth Keyboard EPOX BT-KB01B but without suc=
cess
>> so far. The error message is:
>>
>> hcitool conf
>>
>> Connections:
>>        > ACL 00:04:61:81:F7:C8 handle 44 state 1 lm SLAVE
>>
>>        < ACL 00:04:61:82:03:4A handle 41 state 1 lm MASTER
>> root@woraBox:/home/rw024419# hidd --connect 00:04:61:82:03:4A
>> Can't create HID control channel: Connection timed out
>>
>> here the info from the Keyboard:
>>
>>
>> hcitool info 00:04:61:82:03:4A
>> Requesting information ...
>>        BD Address:  00:04:61:82:03:4A
>>        Device Name: Bluetooth-Keyboard 82034A
>>        LMP Version: 1.1 (0x1) LMP Subversion: 0x356
>>        Manufacturer: Cambridge Silicon Radio (10)
>>        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>>                <3-slot packets> <5-slot packets> <encryption> <slot offs=
et>
>>                <timing accuracy> <role switch> <hold mode> <sniff mode>
>>                <park state> <RSSI> <channel quality> <SCO link> <HV2
>> packets> <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>> <transparent SCO>
>>
>> and here the info from the bluetooth usb dongle:
>>
>>
>> hciconfig -a
>> hci0:   Type: USB
>>        BD Address: 00:04:61:81:5A:A8 ACL MTU: 192:8 SCO MTU: 64:8
>>        UP RUNNING PSCAN ISCAN
>>        RX bytes:967334 acl:38241 sco:0 events:47990 errors:0
>>        TX bytes:244813 acl:260 sco:0 commands:47588 errors:0
>>        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>        Link policy:
>>        Link mode: SLAVE ACCEPT
>>        Name: 'BlueZ linux (0)'
>>        Class: 0x000000
>>        Service Classes: Unspecified
>>        Device Class: Miscellaneous,
>>        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
>> 0x20d Manufacturer: Cambridge Silicon Radio (10)
>>
>> The EPOX Mous BT-MS02B works perfectly.
>>
>> I'm using a Kanotix Linux with Kernel 2.6.17.7.
>>
>> Can somebody help meor give me some hint what i did wrong?
>>
>> Thanks in advance.
>>
>> Wolfram
>>

-- =

kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
