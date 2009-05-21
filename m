Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1242853150.3147.32.camel@localhost.localdomain>
References: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
	 <1242853150.3147.32.camel@localhost.localdomain>
Date: Thu, 21 May 2009 11:10:26 -0300
Message-ID: <5d223510905210710s21f5a433r50ae5ca610ccff4@mail.gmail.com>
Subject: Re: bluez 4.x, SCO socket - connection reset by peer
From: Rafael Seste <rseste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel

On Wed, May 20, 2009 at 5:59 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Rafael,
>
>> I trying to use asterisk (with chan_mobile) to connect with my mobile ph=
one.
>> When there is a incoming/outgoing call, this module creates a
>> sco_socket to send/receive audio packets.
>>
>> socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)
>>
>> when this socket is ready...it can write data once, after that when it
>> tries to read an error is returned:
>>
>> sco_read() error 104
>>
>> 104 means - connection reset by peer
>>
>> after this i got error 107 - not connect.
>>
>> Some one knows why is the reason of this error 104???
>>
>> kernel 2.6.22.18
>> bluez 4.32
>
> I don't know, but your kernel is ancient. Please re-test with 2.6.30-rc6
> and bluez-4.40 to see if this error still persists.
>
> Regards
>
> Marcel
>
>
>

I have a setup:
kernel 2.6.9-78.ELsmp #1 SMP Fri Jul 25 00:04:28 EDT 2008 i686 i686
i386 GNU/Linux
and bluez 2.10-3

and it works fine.

The difference is the arch that now I changed to an ARM and i can't
install this old kernel.

--=20
Rafael S. Seste
Eng Computa=E7=E3o - Unicamp
