Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: sdp problem
Message-ID: <20050228062723.GJ5210@snoopy.src.ricoh.co.jp>
References: <20050228054041.GG5210@snoopy.src.ricoh.co.jp> <20050228060454.2107.qmail@web60910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050228060454.2107.qmail@web60910.mail.yahoo.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Feb 2005 15:27:23 +0900

Hi Michael,

your story is just too difficult to follow ... (or maybe it's just me)
You know mentioned about Synchronize but before you spoke about HF and HS=
 ...

anyway, as far as Synchonize profile is concerned, I have never used it.
(and I actually don't know if sdptool is able to create a record for it).
So you should check this first. If sdptool doesn't allow to create a reco=
rd
for synchronisation profile, you should directly use the bluez library=20
to create it.

And since (if I remember correctly) synchronisation profile is located=20
on the top of the OBEX layer you should use the openobex library and not
RFCOMM sockets directly.

Sincerely,

Alain

* Ka Kin Cheung [Mon, 28 Feb 2005 at 14:04 +0800]
<quote>
> Hi Alain,
>     Actually, I've tried to do for "sdptool add <service>", and it was =
success. But what I found disappointing is I cannot find any service in t=
he "sdptool --help" that the T610 can show "synchronization" in the "serv=
ice list". So, even thoguh I could add "system(...)" syntax follooowed by=
 "sdp_main()" and then "socket()", "listen()", "bind()" and then "accept(=
)" functions, I still can't see any desired results. So, my question now =
becomes "how can I link the SDP setting and socket programming of the ser=
ver together so that the SDP service can be added in my Linux PC followed=
 by waiting the devices, especially T610, and then accept the connections=
?" Thank you very much.
> Michael
> Alain Volmat <avolmat@src.ricoh.co.jp> wrote:
> Hi Michael,
>=20
> I'm not sure to understand all your saying but, I'll try to describe yo=
u
> what I think should be done. (I don't think I'm the first one to tell y=
ou=20
> that but ... still).
>=20
> Saying simply, you need two thing, a little program which listen to a=20
> specific RFCOMM channel (lets say channel 1). This part, you have to=20
> write it by yourself using rfcomm socket interface (or tty interface
> if that's enough for you to test). So now that you have your program
> listen on RFCOMM channel 1, you need to advertise this new service you
> are providing. This is done by using SDP.
> If you don't do that, nobody (for example your phone) will know that
> you have a program listening the channel 1 of RFCOMM.
>=20
> So you need to register a new SDP service, by either including
> some code in your program (based for example on sdptool) or=20
> if it's enough for testing, you can use the sdptool command line.
> One parameter when registering a new service is the RFCOMM channel
> (well, in case of HS or HF) is the channel.
> you can try the command: sdptool add
> this shows you the command line to add a new service, allowing
> you to set the channel. If here you say that your HF service is
> one channel 1, I guess your phone should be happy with that and should
> let you connect to the PC....
>=20
> Alain
>=20
>=20
> ---------------------------------
> Yahoo! =E5=B7=A5=E5=85=B7=E5=88=97 - =E5=85=A7=E7=BD=AE=E9=98=B2=E6=AD=A2=
=E5=BD=88=E5=87=BA=E8=A6=96=E7=AA=97=E5=B7=A5=E8=83=BD=EF=BC=81
</quote>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
