Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Heiko Wundram (Beenic)" <wundram@beenic.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 6 Jul 2007 08:44:48 +0200
References: <200707041719.20662.wundram@beenic.net>
	<200707051135.23459.wundram@beenic.net>
	<1183702165.6351.121.camel@aeonflux.holtmann.net>
In-Reply-To: <1183702165.6351.121.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200707060844.48546.wundram@beenic.net>
Subject: Re: [Bluez-devel]
	=?iso-8859-1?q?Using_BlueZ_in_commercial_applicatio?=
	=?iso-8859-1?q?ns_-=09Once=09again=2E?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Freitag 06 Juli 2007 um 08:09:25 schrieb Marcel Holtmann:
> the D-Bus IPC is a public API with no restrictions. You only have to
> obey with the license of the bindings. However make sure that you don't
> link -lbluetooth into your application. If you do then it becomes GPL.
> And just as a side note. The OpenOBEX library can become GPL, too. So
> you better should involve a lawyer at some point.

I'm not using OpenOBEX; the OBEX (packet parser and builder) implementation=
 in =

the product I'm talking about is done from scratch (or rather, from the =

specs) completely by us (and will be released under a BSD-style license, bt=
w, =

once I finish it up). The decision to implement OBEX on our own was driven =
by =

the need for a "proper" object (meaning C++) model for OBEX, which simply =

isn't (easily) possible with OpenOBEX.

So, it's pretty much only BlueZ I was concerned about, and that's why I cam=
e =

here.

> The D-Bus API works perfectly fine for Nokia and Access. It will also
> work for OpenMoko. The decisions behind its design are driven by the
> applications need.

Yup, that's why I asked. But, again, the important points I need the wrappe=
r =

library (D-BUS in this case) to have is service registration (which you say =

is possible, and I'll have to recheck the sources for the way to do that, =

because it's not stated anywhere specifically in the Wiki) and RFCOMM =

server-socket support (which you didn't say anything about, so I guess it's =

not).

By the way: even if server socket support were available in the D-BUS API (=
and =

which I'd happily agree to write), how would you want to map that to the =

D-BUS IPC model? Mapping server socket creation and handling to an IPC-API =
is =

slightly... Strange. Simply because either you handle the socket completely =

transparently and only pass the data send/received (which would mean that =

most of the application dispatcher logic is part of the "wrapper", but whic=
h =

would introduce different problems because of the inherently difficult natu=
re =

of trying to map a server-client model over a client-server model), or you =

pass the accepted socket directly to the application by some means of =

SCM_RIGHTS control message. But, all of this isn't clean for me in any =

acceptable definition I have of "clean" code and application modelling.

And, on a second note: small- to medium-scale product only meant that I don=
't =

have the means to implement a Bluetooth stack on my own. Which is what I'd =

need to do, simply because any form of "raw" Bluetooth communication is =

disallowed in non-GPL'd code (even implementing SDP on my own) by having =

bluetooth.h and the other protocol-defining headers be GPL'd, see my reply =
to =

Ranulf.

> To be quite honest. That is not my problem. I am not making any money
> with selling a Bluetooth solution. However it seems that the current
> solution is enough for the Nokia N800 and other commercial systems and
> so I don't see your problem. If you wanna simply have a cheap solution
> that is developed by someone else and that you can use in potential
> products to make money with, you might wanna re-think your business
> model.

I said, just to repeat it, that I didn't want to complain about the licensi=
ng =

decision you as the maintainer and the other contributors of BlueZ have =

taken. The GPL is a perfectly sensible license, and using "GPL-circumventin=
g" =

code like IPC also works smoothly on most tasks where the system you're =

trying to map fits into an IPC client-server model anyway. But, especially =

with server socket code, it will not.

> Let me make this bluntly clear. The BlueZ project moves with the needs
> of its users, but users that don't contribute have no say whatsoever. I
> simply don't care. So if you want changes or additions, then start
> working on them and play with the open source rules and be active in the
> community.

You don't have to educate me about open source rules; maybe you'd just chec=
k =

up my name on Google Code to see contributions to large open source project=
s =

I have done in the past. I simply thought that maybe you'd point me in a =

direction, possibly also in a direction where I could contribute code (whic=
h =

is fine by me), where BlueZ would be usable for the need I have. Finally, I =

don't want to make this an ideological discussion, but simply thought that =

because the Website doesn't include a single line of text in what respect =

BlueZ is used/usable in commercial applications, that some feedback from th=
e =

developers is sensible. And I guess that basically we've fixed what's =

possible and what's not.

-- =

Heiko Wundram
Product & Application Development
-------------------------------------
Office Germany - EXPO PARK HANNOVER
=A0
Beenic Networks GmbH
Mail=E4nder Stra=DFe 2
30539 Hannover
=A0
Fon =A0 =A0 =A0 =A0+49 511 / 590 935 - 15
Fax =A0 =A0 =A0 =A0+49 511 / 590 935 - 29
Mail =A0 =A0 =A0 wundram@beenic.net


Beenic Networks GmbH
-------------------------------------
Sitz der Gesellschaft: Hannover
Gesch=E4ftsf=FChrer: Jorge Delgado
Registernummer: HRB 61869
Registergericht: Amtsgericht Hannover

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
