Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AF259BFC-2022-4280-9F98-D4679A280A84@holtmann.org>
References: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com>
	<AF259BFC-2022-4280-9F98-D4679A280A84@holtmann.org>
Date: Tue, 5 Nov 2013 12:37:55 +0100
Message-ID: <CALkxMhHvbgaS4cxbrrQFGk59W9LoR-R47D-iTDBkrw3TG7sofA@mail.gmail.com>
Subject: Re: Wireshark and new BlueZ BTSNOOP format
From: Michal Labedzki <michal.labedzki@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 4 November 2013 15:40, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michal,
>
>> There is a need to add support for latest BTSNOOP format currently
>> used in BlueZ (5). I have two questions:
>>
>> 1. Is BlueZ btsnoop format official and stable? Or invented by BlueZ
>> team? (stable? safe?)
>
> the original btsnoop format was done by Symbian and adopted by Frontline.=
 We started using that as well since it was better than what we had before.=
 These are the ones with 1xxx link types.
> With BlueZ 5 and kernels 3.5 and newer we introduced a Bluetooth monitor =
to the kernel that can catch all controllers and can catch early messages a=
s well. Previous hcidump could only read one interface at a time and was no=
t able to catch early init frames.
>
> The link type 2001 is stable.

Regarding "all controllers and catch early messages" - if you use
Bluetooth USB dongle than this is not a problem, because
Wireshark/libpcap can live capture USB stream. There is ready HCI USB
transport described in Bluetooth Core specification. Try Wireshark >=3D
1.10 and filter by "hci_usb" . Only non-standard Bluetooth USB dongles
cannot work with it (however I have non-standard dongle "Broadcom
Corp. BCM20702A0 Bluetooth 4.0", but it seems to be standard dongle -
only it present itself as "vendor specific").

Quick Howto:
1. [Recommended] Latest Wireshark
2. [Recommended] Latest libpcap.
3. lsusb # to detect on which "Bus" Bluetooth dongle is connected
4. wireshark and select usbmonN, where N is "Bus" ID.
5. Filter "hci_usb" (useful if more devices connected to this Bus)

>> 2. Is there any documentation describes this format?
>
> It is documented inside the kernel as include/net/bluetooth/hci_mon.h and=
 that is as close as it gets to documentation. btsnoop v2 takes the BTSnoop=
 header and uses the 2001 link type and then encodes the opcode and index i=
nto the flags field. The frame data is always a raw HCI message similar to =
link type 1001.

Ok, I assume there is no real specification. This is not a problem for me.

>> In code I saw two new magic numbers:
>> 2001                   Bluetooth monitor
>> 2002                   Bluetooth simulator
>> Is Bluetooth simulator completed now?
>
> The simulator is a low-level Low Energy Link Layer simulator. And it is n=
ot completed and not stable yet.

Please let me know if will be completed or dropped. Or please create
feature request on Wireshark Bugzilla:
https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=3D---&query_form=
at=3Dadvanced&list_id=3D11093


>> For now Wireshark (>=3D 1.10, trunk is recommended) provide probably
>> full Bluetooth support, all protocols, colours, filtering,
>> reassembling. If you find a bug or need new feature please create a
>> bug at https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=3D---&=
query_format=3Dadvanced&list_id=3D11093
>
> What also would be interesting is an integration of Bluetooth monitor soc=
ket with libpcap so Wireshark can do live capture.
>
> Regards
>
> Marcel
>

For now Wireshark can support live capture on old kernel interface (if
you do not see Bluetooth interfaces than you need newer libpcap). Also
you can choose more than one interface to capture: for example
Bluetooth0, Bluetooth1 and usbmon1 (nice duplicated streams do you
see)

I will try to add support for new BTSNOOP format and libpcap support
for new kernel. I think Wireshark can be useful for BlueZ and Android
developers.

--=20

Pozdrawiam / Best regards
---------------------------------------------------------------------------=
----------------------------------
Micha=C5=82 =C5=81ab=C4=99dzki, Software Engineer
Tieto Corporation

Product Development Services

http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wroc=C5=82aw, Poland
room: 5.01 (desk next to 5.08)
---
Please note: The information contained in this message may be legally
privileged and confidential and protected from disclosure. If the
reader of this message is not the intended recipient, you are hereby
notified that any unauthorised use, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please notify us immediately by replying to
the message and deleting it from your computer. Thank You.
---
Please consider the environment before printing this e-mail.
---
Tieto Poland sp=C3=B3=C5=82ka z ograniczon=C4=85 odpowiedzialno=C5=9Bci=C4=
=85 z siedzib=C4=85 w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S=C4=85dzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydzia=C5=82 Gospodarczy Krajowego
Rejestru S=C4=85dowego pod numerem 0000124858. NIP: 8542085557. REGON:
812023656. Kapita=C5=82 zak=C5=82adowy: 4 271500 PLN
