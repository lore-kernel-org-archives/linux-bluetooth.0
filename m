Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030307094003.06de3de0@mail1.qualcomm.com>
Date: Fri, 07 Mar 2003 09:44:57 -0800
To: david.libault@inventel.fr, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Cc: Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
In-Reply-To: <3E26CE2101C0104A@mel-rta6.wanadoo.fr> (added by
	postmaster@wanadoo.fr)
References: <5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
	<1046706518.14907.133.camel@linux>
	<5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

At 12:47 AM 3/7/2003, David LIBAULT wrote:
>Le Jeudi 6 Mars 2003 23:06, Max Krasnyansky a =E9crit :
>> At 10:06 AM 3/3/2003, David LIBAULT wrote:
>> >> 2. Have own patches against the stable kernel for qualification
>> >
>> >IMHO, it is possible to have L2CAP qualified without messing up that mu=
ch
>> > the code, and without changing the behavior/performance when "the othe=
r
>> > side" is working properly.
>>
>> May be. But we don't seem to know that for sure. What about that L2CAP M=
TU
>> negotiation thing for example ?
>
>I propose that we take this issue as the first step to qualification.
Agreed.

>> >Next step : L2CAP qualification.
>> >
>> >The main issue is to have the tester side...
>> >
>> >        1) write a small user-mode program that can open and close an A=
CL
>> > channel, and send any kind of packet over this link
>>
>> Don't you guys have that already ? If not I'll write this one.
>> Do you have any specific features in mind ?
>
>I have sent to you a very small program (l2capsession.c). You can make it=20
>GPL. To make sure you have it, I have attached it to this message. This=20
>program uses as an input a very simple script file that tells what to send=
,=20
>to what address etc...
>
>BUT
>
>This is usable only for "over L2CAP" protocols like SDP, BNEP, RFCOMM etc.=
..
>To do L2CAP tests, we need the same type of application but that sends dat=
a=20
>directly over an ACL link. Is it a special type of socket that needs to be=
=20
>opened to do so ?
Yes raw HCI socket. I'll write that one.

>This ACLsession program will help us do the L2CAP MTU negotiation test and=
=20
>we'll all see if fixing it in the main stream code is that much of a big=20
>deal, and what the 7layers BQB can reasonably accept.
Ok.

>> >        2) write a script for each test case
>>
>> Anybody willing to contribute that ?
>>
>
>Inventel can contribute with some test cases scripts using l2capsession.=20
>We'll do that if l2capsession "kind of way to do things" is retained.=20
>For the L2CAP tests (ACLsession) we have nothing yet.
Sounds good.

>> It sounds like we need to create a module in CVS and start putting thing=
s
>> that we need together. Any suggestion for a name ? "qube" ?
Ok. I'll implement this ACL thing and add create cvs tree (including your l=
2session).

Max
               =20



       =20
