Return-Path: <david.libault@inventel.fr>
Message-ID: <3E26CE2101C0104A@mel-rta6.wanadoo.fr> (added by postmaster@wanadoo.fr)
From: David LIBAULT <david.libault@inventel.fr>
Reply-To: david.libault@inventel.fr
To: Max Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-devel] BlueZ Qualification
Date: Fri, 7 Mar 2003 09:47:34 +0100
Cc: Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
References: <1046706518.14907.133.camel@linux>
	<5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2w6JjM9uC/n7ErosrhSK"
List-ID: <bluez-devel.lists.sourceforge.net>


--=-2w6JjM9uC/n7ErosrhSK
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; CHARSET=iso-8859-1

Le Jeudi 6 Mars 2003 23:06, Max Krasnyansky a écrit :
> At 10:06 AM 3/3/2003, David LIBAULT wrote:
> >> 2. Have own patches against the stable kernel for qualification
> >
> >IMHO, it is possible to have L2CAP qualified without messing up that much
> > the code, and without changing the behavior/performance when "the other
> > side" is working properly.
>
> May be. But we don't seem to know that for sure. What about that L2CAP MTU
> negotiation thing for example ?

I propose that we take this issue as the first step to qualification.

>
> >It anyway does not make sense to have one stack for qualification and one
> > stack for "real usage", as, in theory, only qualified bluetooth products
> > should be runing...
>
> Linux servers, workstations, laptops, etc are not "bluetooth products".
> Also we're not saying two stacks right. We're saying a separate package (or
> patch or whatever). And the only reason to have that package is if
> qualification support becomes ugly.
>
> >Bluez is one of the cleanest Bluetooth implementations, and is becoming
> > (or is already) a reference implementation. Lets qualify it !
>
> Sure. I'm with you.
>
> >> The same rules apply to the userspace utils and also to the userspace
> >> protocol implementations like SDP and OBEX.
> >>
> >> In general I think a qualified version of the BlueZ stack is a good
> >> idea, but this is also hard work and at this points comes the money
> >> problem in. The end user don't get any advantages of a qualified Linux
> >> Bluetooth (it only sounds great), but companies who plan to use BlueZ in
> >> their Bluetooth products will save a lot of time, money and knowledge if
> >> they don't have to qualify the complete stack again. If we really got
> >> BlueZ qualified and companies can take advantage of it I think that they
> >> should payback something to the OpenSource community. And at this point
> >> the idea of a non-profit organization which takes care of a qualified
> >> version of the BlueZ stack and represent the Linux fraction in the
> >> Bluetooth SIG comes to my mind.
> >
> >My interest as a company is to help having Bluez qualified. If once I have
> >suffered, for the qualification I have to pay someone again later there is
> >absolutely no interest in having Bluez qualified ! I just use Bluez as it
> > is and qualify it myself !
>
> Darn, no Volvo for me :(
>
> >I also think that having Bluez qualified is very small effort compared to
> > the one of developing a complete/robust/functional/performant stack. The
> > biggest effort has already been done by Maxim and other people, and it is
> > open source. Companies take more advantage from Bluez itself than from a
> > "qualified" Bluez. Qualification should be as the stack itself : open
> > source.
>
> I see another benefit of qualification. In order to get qualified we need a
> tool set that implements test cases and stuff. This toolset is pretty much
> a regression test suite which is always good to have.
>
> >> People that already have some experiences in qualification (and
> >> especially BlueZ) should start now sharing their results with us, so we
> >> can start planing the next step.
> >
> >Next step : L2CAP qualification.
> >
> >The main issue is to have the tester side...
> >
> >        1) write a small user-mode program that can open and close an ACL
> > channel, and send any kind of packet over this link
>
> Don't you guys have that already ? If not I'll write this one.
> Do you have any specific features in mind ?

I have sent to you a very small program (l2capsession.c). You can make it 
GPL. To make sure you have it, I have attached it to this message. This 
program uses as an input a very simple script file that tells what to send, 
to what address etc...

BUT

This is usable only for "over L2CAP" protocols like SDP, BNEP, RFCOMM etc...
To do L2CAP tests, we need the same type of application but that sends data 
directly over an ACL link. Is it a special type of socket that needs to be 
opened to do so ?

This ACLsession program will help us do the L2CAP MTU negotiation test and 
we'll all see if fixing it in the main stream code is that much of a big 
deal, and what the 7layers BQB can reasonably accept.

>
> >        2) write a script for each test case
>
> Anybody willing to contribute that ?
>

Inventel can contribute with some test cases scripts using l2capsession. 
We'll do that if l2capsession "kind of way to do things" is retained. For the 
L2CAP tests (ACLsession) we have nothing yet.

> It sounds like we need to create a module in CVS and start putting things
> that we need together. Any suggestion for a name ? "qube" ?
>
> Max

--=-2w6JjM9uC/n7ErosrhSK
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="l2capsession.c"
Content-Type: text/x-c++; CHARSET=iso-8859-1; NAME=l2capsession.c

Ly8gRGF2aWQgTElCQVVMVA0KLy8gTGUgMjkgSmFudmllciAyMDAzDQovLyBsMmNhcHNlc3Npb24g
OiBsMmNhcCBzZXNzaW9uIGhhbmRsZXINCg0KLyogDQoJbDJjYXBzZXNzaW9uIC0gTDJDQVAgc2Vz
c2lvbiBoYW5kbGVyCQ0KCUNvcHlyaWdodCAoQykgMjAwMyBEYXZpZCBMaWJhdWx0IDxkYXZpZC5s
aWJhdWx0QGludmVudGVsLmZyPg0KDQoJVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCglpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KCXB1Ymxpc2hl
ZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOw0KDQoJVEhFIFNPRlRXQVJFIElTIFBS
T1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MNCglP
UiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9G
IE1FUkNIQU5UQUJJTElUWSwNCglGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQg
Tk9OSU5GUklOR0VNRU5UIE9GIFRISVJEIFBBUlRZIFJJR0hUUy4NCglJTiBOTyBFVkVOVCBTSEFM
TCBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBBTkQgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5Z
IENMQUlNLA0KCU9SIEFOWSBTUEVDSUFMIElORElSRUNUIE9SIENPTlNFUVVFTlRJQUwgREFNQUdF
UywgT1IgQU5ZIERBTUFHRVMgV0hBVFNPRVZFUg0KCVJFU1VMVElORyBGUk9NIExPU1MgT0YgVVNF
LCBEQVRBIE9SIFBST0ZJVFMsIFdIRVRIRVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULA0KCU5F
R0xJR0VOQ0UgT1IgT1RIRVIgVE9SVElPVVMgQUNUSU9OLCBBUklTSU5HIE9VVCBPRiBPUiBJTiBD
T05ORUNUSU9OIFdJVEggVEhFDQoJVVNFIE9SIFBFUkZPUk1BTkNFIE9GIFRISVMgU09GVFdBUkUu
DQoNCglBTEwgTElBQklMSVRZLCBJTkNMVURJTkcgTElBQklMSVRZIEZPUiBJTkZSSU5HRU1FTlQg
T0YgQU5ZIFBBVEVOVFMsIENPUFlSSUdIVFMsDQoJVFJBREVNQVJLUyBPUiBPVEhFUiBSSUdIVFMs
IFJFTEFUSU5HIFRPIFVTRSBPRiBUSElTIFNPRlRXQVJFIElTIERJU0NMQUlNRUQuDQoqLw0KDQoj
aW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQoNCiNpbmNsdWRlIDxi
bHVldG9vdGgvYmx1ZXRvb3RoLmg+DQojaW5jbHVkZSA8Ymx1ZXRvb3RoL2wyY2FwLmg+DQoNCmlu
dCBsMmNhcF9zb2NrID0gLTEgOw0KDQppbnQgZG9fb3BlbihjaGFyICphcmdzKQ0Kew0KCXN0cnVj
dCBsMmNhcF9vcHRpb25zIGwybzsNCiAgaW50IHBzbSwgb2xlbiwgbXR1IDsNCiAgY2hhciBiZF9h
ZGRyX3N0clsxMjhdIDsNCiAgYmRhZGRyX3QgZHN0IDsNCglzdHJ1Y3Qgc29ja2FkZHJfbDIgc2E7
DQogIGludCByZXN1bHQgOw0KCWJkYWRkcl90IHNyY19hZGRyID0gKkJEQUREUl9BTlk7ICANCg0K
ICBpZiAobDJjYXBfc29jayAhPSAtMSkNCiAgew0KICAgIHByaW50ZigibDJjYXAgc29ja2V0IGFs
cmVhZHkgb3BlbmVkLi4uXG4iKSA7DQogICAgcmV0dXJuIC0xIDsNCiAgfQ0KICBzc2NhbmYoYXJn
cywgIiVzICVkICVkIiwgYmRfYWRkcl9zdHIsICZwc20sICZtdHUpIDsNCglwcmludGYoImJhIDog
JXMsIHBzbSAlZCwgbXR1ICVkXG4iLCBiZF9hZGRyX3N0ciwgcHNtLCBtdHUpIDsNCiAgc3RyMmJh
KGJkX2FkZHJfc3RyLCAmZHN0KSA7DQogIGwyY2FwX3NvY2sgPSBzb2NrZXQoUEZfQkxVRVRPT1RI
LCBTT0NLX1NFUVBBQ0tFVCwgQlRQUk9UT19MMkNBUCkgOw0KICBpZiAobDJjYXBfc29jayA8IDAp
DQogIHsNCiAgICBwcmludGYoIkVycm9yLCBjYW4ndCBvcGVuIGwyY2FwIHNvY2tldCB0byAlc1xu
IiwgYXJncykgOw0KICAgIHByaW50ZigibDJjYXBfc29jayA6ICVkXG4iLCBsMmNhcF9zb2NrKSA7
DQogICAgcmV0dXJuIC0xIDsNCiAgfQ0KLy8gU2V0IGxvY2FsIGFkZHJlc3MNCglnZXRzb2Nrb3B0
KGwyY2FwX3NvY2ssIFNPTF9MMkNBUCwgTDJDQVBfT1BUSU9OUywgJmwybywgJm9sZW4pOw0KCWwy
by5pbXR1ID0gbDJvLm9tdHUgPSBtdHU7DQoJc2V0c29ja29wdChsMmNhcF9zb2NrLCBTT0xfTDJD
QVAsIEwyQ0FQX09QVElPTlMsICZsMm8sIHNpemVvZihsMm8pKTsNCg0KIAlzYS5sMl9mYW1pbHkg
PSBBRl9CTFVFVE9PVEg7DQogIHNhLmwyX3BzbSA9IDA7DQoJc2EubDJfYmRhZGRyID0gc3JjX2Fk
ZHI7DQoJaWYgKGJpbmQobDJjYXBfc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSAmc2EsIHNpemVv
ZihzYSkpKQ0KICB7DQogICAgcHJpbnRmKCJFcnJvciwgQ291bGRuJ3QgYmluZCBzb2NrZXRcbiIp
IDsNCiAgICByZXR1cm4gLTEgOw0KICB9DQoNCglzYS5sMl9wc20gPSBwc20gOw0KCXNhLmwyX2Jk
YWRkciA9IGRzdDsNCglyZXN1bHQgPSBjb25uZWN0KGwyY2FwX3NvY2ssIChzdHJ1Y3Qgc29ja2Fk
ZHIgKikmc2EsIHNpemVvZihzYSkpIDsNCiAgaWYgKHJlc3VsdCA9PSAwKQ0KICB7DQogICAgcmV0
dXJuIDAgOw0KICB9DQogIGVsc2UNCiAgew0KICAgIHByaW50ZigiQ29ubmVjdGlvbiBmYWlsZWQs
IHJlc3VsdCA6ICVkXG4iLCByZXN1bHQpIDsNCiAgICBsMmNhcF9zb2NrID0gLTEgOw0KICAgIHJl
dHVybiAtMSA7DQogIH0NCn0NCg0KaW50IGRvX2Nsb3NlKCkNCnsNCiAgY2xvc2UobDJjYXBfc29j
aykgOw0KICBsMmNhcF9zb2NrID0gLTEgOw0KfQ0KDQppbnQgZG9fc2xlZXAoY2hhciAqYXJncykN
CnsNCiAgaW50IGkgOw0KICANCiAgc3NjYW5mKGFyZ3MsICIlZCIsICZpKSA7DQogIHByaW50Zigi
U2xlZXAgJWQgc2Vjb25kc1xuIiwgaSkgOw0KICBzbGVlcChpKSA7DQp9DQoNCmludCBkb19zZW5k
KGNoYXIgKmFyZ3MpDQp7DQoJaW50IGJ5dGVzU2VudCA9IDAgOw0KCXVuc2lnbmVkIGNoYXIgcGFj
a2V0WzEwMDAwXSA7DQogIHVuc2lnbmVkIGNoYXIgYnl0ZVs1XSA7DQogIGludCByZXFzaXplID0g
MCA7DQogIGludCBuID0gMCA7DQogIGludCBpIDsNCiAgaW50IHZhbHVlIDsNCiAgDQoNCiAgaWYg
KGwyY2FwX3NvY2sgPCAwKQ0KICB7DQogICAgcHJpbnRmKCJDYW4ndCBzZW5kIHdoaWxlIGwyY2Fw
IHNvY2tldCBpcyBub3Qgb3BlbmVkXG4iKSA7DQogICAgcmV0dXJuIC0xIDsNCiAgfQ0KICAgIA0K
ICBkbyANCiAgew0KICAgIHNzY2FuZihhcmdzLCAiJXMiLCBieXRlKSA7DQogICAgYXJncyArPSBz
dHJsZW4oYnl0ZSkgKzEgOw0KICAgIHNzY2FuZihieXRlLCAiJXgiLCAmdmFsdWUpIDsNCiAgICBw
YWNrZXRbcmVxc2l6ZV0gPSB2YWx1ZSA7DQogICAgcmVxc2l6ZSsrIDsNCiAgfSB3aGlsZSAoc3Ry
bGVuKGFyZ3MpKSA7DQoNCiAgcHJpbnRmKCJTZW5kaW5nICVkIGJ5dGVzXG4iLCByZXFzaXplKSA7
DQoJZm9yIChpPTAgOyBpPHJlcXNpemUgOyBpKyspDQogICAgcHJpbnRmKCIweCUyLjJYICIsIHBh
Y2tldFtpXSkgOw0KICBwcmludGYoIlxuIikgOw0KCW4gPSBzZW5kKGwyY2FwX3NvY2ssIHBhY2tl
dCwgcmVxc2l6ZSwgMCk7DQoJaWYgKG4gPT0gLTEpIA0KICB7DQoJCQlwcmludGYoIkVycm9yIHNl
bmRpbmcgZGF0YVxuIik7DQoJCQlyZXR1cm4gLTE7DQoJfQ0KICBpZiAobiAhPSByZXFzaXplKQ0K
ICB7DQogICAgcHJpbnRmKCJFcnJvciBzZW50ICVkIG91dCBvZiAlZCBieXRlc1xuIiwgbiwgcmVx
c2l6ZSkgOw0KICAgIHJldHVybiAtMSA7DQogIH0NCn0NCg0KaW50IGRvX3dhaXQoY2hhciAqYXJn
cykNCnsNCiAgaW50IHJ4X3RpbWVvdXQgOw0KCWZkX3NldCByZWFkRmRzOw0KCXN0cnVjdCB0aW1l
dmFsIHRpbWVvdXQ7DQoJaW50IGJ5dGVzUmVjdmQgPSAwIDsNCiAgY2hhciByc3BidWZbMjU2XSA7
DQogIGludCBpIDsNCiAgDQogIGlmIChsMmNhcF9zb2NrIDwgMCkNCiAgew0KICAgIHByaW50Zigi
Q2FuJ3Qgd2FpdCB3aGlsZSBsMmNhcCBzb2NrZXQgaXMgbm90IG9wZW5lZFxuIikgOw0KICAgIHJl
dHVybiAtMSA7DQogIH0NCiAgc3NjYW5mKGFyZ3MsICIlZCIsIHJ4X3RpbWVvdXQpIDsNCgl0aW1l
b3V0LnR2X3NlYyA9IHJ4X3RpbWVvdXQ7DQoJdGltZW91dC50dl91c2VjID0gMDsNCglGRF9TRVQo
bDJjYXBfc29jaywgJnJlYWRGZHMpOw0KCXByaW50ZigiV2FpdGluZyBmb3IgcmVzcG9uc2VcbiIp
Ow0KCWlmICgwID09IHNlbGVjdChsMmNhcF9zb2NrICsgMSwgJnJlYWRGZHMsIE5VTEwsIE5VTEws
ICZ0aW1lb3V0KSkgew0KCQlwcmludGYoIkNsaWVudCB0aW1lZCBvdXRcbiIpOw0KCQlyZXR1cm4g
LTE7DQoJfQ0KCWJ5dGVzUmVjdmQgPSByZWN2KGwyY2FwX3NvY2ssIHJzcGJ1ZiwgMjU2LCAwKTsN
CglwcmludGYoIlJlYWQgJWQgYnl0ZXMgOlxuIiwgYnl0ZXNSZWN2ZCk7DQoJZm9yIChpPTAgOyBp
PGJ5dGVzUmVjdmQgOyBpKyspDQogICAgcHJpbnRmKCIweCUyLjJYICIsIHJzcGJ1ZltpXSkgOw0K
ICBwcmludGYoIlxuIikgOw0KICByZXR1cm4gMDsgIA0KfQ0KDQpjaGFyICpmcmVhZGxpbmUoRklM
RSAqZikNCnsNCiAgc3RhdGljIGNoYXIgYnVmZmVyWzY1MDAwXSA7DQogIGludCBjLGkgPSAwIDsN
CiAgaW50IGVzY2FwZV9uZXh0PTA7DQogIGludCBjb21tZW50cz0wOw0KDQogIGMgID0gZmdldGMo
ZikgOw0KDQogIHdoaWxlKCghZmVvZihmKSkmJihpPDY1MDAwKSkNCiAgew0KICAgIHN3aXRjaCAo
YykNCiAgICB7DQogICAgY2FzZSAnIyc6DQogICAgICAvLyBoYXNoIDogY29tbWVudHMsIG9yIG5v
dCA/DQogICAgICBpZiAoZXNjYXBlX25leHQpIHtidWZmZXJbaSsrXT1jO2VzY2FwZV9uZXh0PTA7
YnJlYWs7fQ0KICAgICAgY29tbWVudHM9MTsNCiAgICAgIGJyZWFrOw0KCQkNCiAgICBjYXNlICdc
XCc6DQogICAgICAvLyBlc2NhcGluZyBuZXh0IGNoYXINCiAgICAgIGlmIChlc2NhcGVfbmV4dCkg
e2J1ZmZlcltpKytdPWM7ZXNjYXBlX25leHQ9MDticmVhazt9DQogICAgICBlc2NhcGVfbmV4dD0x
Ow0KICAgICAgYnJlYWs7DQoNCiAgICBjYXNlICdcbic6DQogICAgICAvLwkJY2FzZSAnXHInOg0K
ICAgICAgLy8gZW5kIG9mIGxpbmUNCi8vICAgICAgYnVmZmVyW2krK10gPSBjOw0KICAgICAgYnVm
ZmVyW2krK10gPSAwOw0KICAgICAgcmV0dXJuIGJ1ZmZlcjsNCiAgICAgIGJyZWFrOw0KICAgIGNh
c2UgRU9GOg0KICAgICAgLy8gZW5kIG9mIGZpbGUNCiAgICAgIGJ1ZmZlcltpKytdPTA7DQogICAg
ICByZXR1cm4gYnVmZmVyOw0KICAgICAgYnJlYWs7DQoJCSAgDQogICAgZGVmYXVsdDoNCiAgICAg
IC8vIG5vcm1hbA0KICAgICAgaWYgKGNvbW1lbnRzPT0wKSBidWZmZXJbaSsrXSA9IGMgOw0KICAg
ICAgYnJlYWs7DQogICAgfQ0KICAgIGMgPSBmZ2V0YyhmKTsNCiAgfQ0KICBidWZmZXJbaSsrXT0w
Ow0KICByZXR1cm4gYnVmZmVyIDsNCn0NCg0KaW50IGhhbmRsZV9pbnB1dChjaGFyICpsaW5lKQ0K
ew0KICAJY2hhciBjb21tYW5kWzI1XSA7DQogICAgDQogIAlzc2NhbmYobGluZSwgIiVzIiwgY29t
bWFuZCkgOw0KICAgIHByaW50ZigiR290IGNvbW1hbmQgJXNcbiIsIGNvbW1hbmQpIDsNCiAgICBp
ZiAoIXN0cm5jbXAoY29tbWFuZCwgIm9wZW4iLCA0KSkNCiAgICB7DQogICAgICBkb19vcGVuKGxp
bmUgKyA0KSA7DQogICAgfQ0KICAgIGVsc2UgaWYgKCFzdHJuY21wKGNvbW1hbmQsICJjbG9zZSIs
IDUpKQ0KICAgIHsNCiAgICAgIGRvX2Nsb3NlKCkgOw0KICAgIH0NCiAgICBlbHNlIGlmICghc3Ry
bmNtcChjb21tYW5kLCAic2VuZCIsIDQpKQ0KICAgIHsNCiAgICAgIGRvX3NlbmQobGluZSArIDQp
IDsNCiAgICB9DQogICAgZWxzZSBpZiAoIXN0cm5jbXAoY29tbWFuZCwgIndhaXQiLCA0KSkNCiAg
ICB7DQogICAgICBkb193YWl0KGxpbmUgKyA0KSA7DQogICAgfQ0KICAgIGVsc2UgaWYgKCFzdHJu
Y21wKGNvbW1hbmQsICJzbGVlcCIsIDUpKQ0KICAgIHsNCiAgICAgIGRvX3NsZWVwKGxpbmUgKyA1
KSA7DQogICAgfQ0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQp7DQogIEZJ
TEUgKmZfaW5wdXQ9TlVMTCA7DQoJY2hhciAqbGluZV9idWZmIDsNCiAgDQogIGZfaW5wdXQgPSBm
b3Blbihhcmd2WzFdLCAiciIpIDsNCiAgaWYgKGZfaW5wdXQgPT0gTlVMTCkNCiAgew0KICAgIHBy
aW50ZigiSW1wb3NzaWJsZSB0byBvcGVuIGZpbGUgJXNcbiIsIGFyZ3ZbMV0pIDsNCiAgICByZXR1
cm4gLTEgOw0KICB9DQogIHdoaWxlKCFmZW9mKGZfaW5wdXQpKQ0KICB7DQogICAgbGluZV9idWZm
ID0gZnJlYWRsaW5lKGZfaW5wdXQpIDsNCiAgICBpZiAoc3RybGVuKGxpbmVfYnVmZikpDQogICAg
ew0KLy8gICAgICBwcmludGYoIkhhbmRsaW5nIGxpbmVcbiIpIDsNCiAgICAgIGhhbmRsZV9pbnB1
dChsaW5lX2J1ZmYpIDsNCiAgICB9DQogIH0NCiAgcmV0dXJuIDAgOw0KfQ0K

--=-2w6JjM9uC/n7ErosrhSK--
