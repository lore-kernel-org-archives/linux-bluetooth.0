Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: sdp problem
Message-ID: <20050228054041.GG5210@snoopy.src.ricoh.co.jp>
References: <20050228042032.GB5210@snoopy.src.ricoh.co.jp> <20050228052232.66579.qmail@web60902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050228052232.66579.qmail@web60902.mail.yahoo.com>
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
Date: Mon, 28 Feb 2005 14:40:41 +0900

Hi Michael,

I'm not sure to understand all your saying but, I'll try to describe you
what I think should be done. (I don't think I'm the first one to tell you=
=20
that but ... still).

Saying simply, you need two thing, a little program which listen to a=20
specific RFCOMM channel (lets say channel 1). This part, you have to=20
write it by yourself using rfcomm socket interface (or tty interface
if that's enough for you to test). So now that you have your program
listen on RFCOMM channel 1, you need to advertise this new service you
are providing. This is done by using SDP.
If you don't do that, nobody (for example your phone) will know that
you have a program listening the channel 1 of RFCOMM.

So you need to register a new SDP service, by either including
some code in your program (based for example on sdptool) or=20
if it's enough for testing, you can use the sdptool command line.
One parameter when registering a new service is the RFCOMM channel
(well, in case of HS or HF) is the channel.
you can try the command: sdptool add
this shows you the command line to add a new service, allowing
you to set the channel. If here you say that your HF service is
one channel 1, I guess your phone should be happy with that and should
let you connect to the PC....

Alain

* Ka Kin Cheung [Mon, 28 Feb 2005 at 13:22 +0800]
<quote>
> Hi Alain,
>     Thanks for your comment. But I have questions about headset/handsfree=
 part. You said that I can directly use RFCOMM socket i.e. use the function=
s socket(), bind(), listen() and accept(). But when I implemented in my pro=
gram and then run it, there isn't anything that I can see. Then I asked my =
project's tutor, and he said that SDP is needed. Then I tried to add SDP se=
rvices in my Linux PC, but the strange thing is, the T610 cannot show "sync=
hronisation" in the "My device" list's "service list" so that even though I=
 can add my Linux PC in my "handsfree device" list, the T610 cannot connect=
 to the PC by showing "Nluetooth connection failed". So, what can I do for =
SDP? And how the program for the phone and even other mobile devices can be=
 listened in a specific channel can be written? Is there any example code f=
or it? I provide the information here so that you can know what I mean and =
I can do.
> Channel for connecting T610: 1
> code for sdp implemented into my program:=20
> system("sdptool add SAP");
> sdp_main(argc, argv); //sdp_main is the main function in sdptool.c
>                                 //and I modified it for implementing in m=
y main program
>     I do hope that you can help me according to my provided information.
> Michael
>=20
>=20
> Alain Volmat <avolmat@src.ricoh.co.jp> wrote:
> Hi Michael,
>=20
> as Luis wrote you need to write a little program which listen as a specif=
ic
> (protocol/channel).
>=20
> As far as file transfer/object push, I think both are located on the top
> of the OBEX layer what you should do is to play a bit with openobex.
>=20
> As far as headset/handsfree are concerned, it needs SCO and AT commands
> directly on the top of RFCOMM (if I remember correctly), so for handling
> of AT commands, you can directly use RFCOMM socket (socket,bind,listen,ac=
cept).
>=20
> Regards,
>=20
> Alain
>=20
>=20
> * Ka Kin Cheung [Mon, 28 Feb 2005 at 12:06 +0800]
>=20
> > Hi Soraberri!
> > I wish to know how to implement the basic service profiles such as SIM =
Access, headset, handsfree, file transfer and Object Push so that the Linux=
 PC can listen for the T610 client to connect to the PC? Thank you very muc=
h.
> > Michael
> >=20
> > soraberri <421246@posta.unizar.es> wrote:
> > Hi,
> >=20
> > Ka Kin Cheung wrote:
> > > Hi!
> > > The strange thing is here:
> > > For Linux, when my phone searched for my PC, the PC can be found and=
=20
> > > then added in the "My device" list, but when I looked at "Service lis=
t",=20
> > > none service can be found. Then I opened Windows XP and the bluetooth=
=20
> > > dongle driver was installed in my PC. Then I press "update" key to=20
> > > update services, and I found headset, synchronisation, object push an=
d=20
> > > file transfer in the "Service list" for my Windows PC. So, how can I =
do=20
> > > for sdp in my Linux PC as my project is done on Linux? Thank you very=
=20
> > > much for your kindness.
> > > Michael
> >=20
> > You can advertise standard services in Linux using 'sdptool add ...' but
> > advertising is not the same as offering... To offer a real service, an
> > application has to be implemented and listening for clients at the
> > appropiate network protocols and ports. Maybe what it is happening in
> > windows is that most basic profiles are already implemented and
> > correctly advertised. With BlueZ you can also advertise them in order
> > to be seen by a remote device, but they won't work until you don't
> > implement them. I hope this helps.
> >=20
> > regards,
> > Luis
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >=20
> >=20
> >=20
> > ---------------------------------
> > Yahoo! =E5=B7=A5=E5=85=B7=E5=88=97 - =E5=85=A7=E7=BD=AE=E9=98=B2=E6=AD=
=A2=E5=BD=88=E5=87=BA=E8=A6=96=E7=AA=97=E5=B7=A5=E8=83=BD=EF=BC=81
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20
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
