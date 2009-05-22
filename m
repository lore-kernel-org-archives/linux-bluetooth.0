Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200905221914.48170.Hugo.Mildenberger@namir.de>
References: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
	 <1242853150.3147.32.camel@localhost.localdomain>
	 <5d223510905210710s21f5a433r50ae5ca610ccff4@mail.gmail.com>
	 <200905221914.48170.Hugo.Mildenberger@namir.de>
Date: Fri, 22 May 2009 15:39:09 -0300
Message-ID: <5d223510905221139i26a6ef40ie10d7e95dc765b88@mail.gmail.com>
Subject: Re: bluez 4.x, SCO socket - connection reset by peer
From: Rafael Seste <rseste@gmail.com>
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 22, 2009 at 2:14 PM, Hugo Mildenberger
<Hugo.Mildenberger@namir.de> wrote:
> Am Donnerstag, 21. Mai 2009 schrieb Rafael Seste:
>> Marcel
>>
>> On Wed, May 20, 2009 at 5:59 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>> > Hi Rafael,
>> >
>> >> I trying to use asterisk (with chan_mobile) to connect with my mobile=
 phone.
>> >> When there is a incoming/outgoing call, this module creates a
>> >> sco_socket to send/receive audio packets.
>> >>
>> >> socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)
>> >>
>> >> when this socket is ready...it can write data once, after that when i=
t
>> >> tries to read an error is returned:
>> >>
>> >> sco_read() error 104
>> >>
>> >> 104 means - connection reset by peer
>> >>
>> >> after this i got error 107 - not connect.
>> >>
>> >> Some one knows why is the reason of this error 104???
>> >>
>> >> kernel 2.6.22.18
>> >> bluez 4.32
>> >
>> > I don't know, but your kernel is ancient. Please re-test with 2.6.30-r=
c6
>> > and bluez-4.40 to see if this error still persists.
>> >
>> > Regards
>> >
>> > Marcel
>> >
>> >
>> >
>>
>> I have a setup:
>> kernel 2.6.9-78.ELsmp #1 SMP Fri Jul 25 00:04:28 EDT 2008 i686 i686
>> i386 GNU/Linux
>> and bluez 2.10-3
>>
>> and it works fine.
>>
>> The difference is the arch that now I changed to an ARM and i can't
>> install this old kernel.
>>
>
> I can confirm this behaviour on x86 with a CSR Adapter (0a12:0001),
> a Nokia 6280 V6.43, linux-2.6.30-rc6-00159-ga15ae93 and bluez-4.40.
>
> Until today, I thought it might be related to the interaction between
> the Nokia firmware and Asterisk, but if Rafael says 2.6.9-78/bluez-2.10.3
> would be working?
>
> https://issues.asterisk.org/view.php?id=3D15075 now has a patch which at
> least cures the symptoms.
>
> I do also see some kernel errors via dmesg:
>
> btusb_isoc_complete: hci0 corrupted SCO packet
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> btusb_isoc_complete: hci0 corrupted SCO packet
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> [...]
>
>
>
>

I forgot to tell one important detail. I'm trying to install this
stuffs in a SoC. It is a ARM
root@debian:~# uname -a
Linux debian 2.6.22.18 #1 Thu Mar 19 14:46:22 IST 2009 armv5tejl GNU/Linux
The kernel that I'm using has a lot of patchs to work in this architecture.

Today I reproduce the same setup in a PC (i386):
root@ubuntu:/var/log# uname -a
Linux ubuntu 2.6.22.18 #4 SMP Fri May 22 09:29:09 BRT 2009 i686 GNU/Linux
bluez 4.32 from apt-get and asterisk 1.6.1.0

and it works....
Maybe this is an architecture incompatibility..

Investigating the logs from the ARM, I found that the error
"connection reset by peer" occurs after I hang up.
So, asterisk writes once in the socket ( I can see the SCO package
going out in hcidump), then it tries to read from the sco socket but
there is no data available. It sleeps until some data arrives. The
only information that arrives is when I hang up so it returns the
error.

On hcidump output I can see only one sco package from asterisk to
mobile phone, and no SCO package from mobile to the asterisk.

Could it be some connection configuration problem??
What kernel drivers/modules are necessary??? I enable the bluetooth
ones in networking-->bluetooth subsystem support!!






--=20
Rafael S. Seste
Eng Computa=E7=E3o - Unicamp
