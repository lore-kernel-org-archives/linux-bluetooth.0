Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: sdp problem
Message-ID: <20050228042032.GB5210@snoopy.src.ricoh.co.jp>
References: <cvi5l2$q7m$1@sea.gmane.org> <20050228040651.78126.qmail@web60910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050228040651.78126.qmail@web60910.mail.yahoo.com>
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
Date: Mon, 28 Feb 2005 13:20:32 +0900

Hi Michael,

as Luis wrote you need to write a little program which listen as a specif=
ic
(protocol/channel).

As far as file transfer/object push, I think both are located on the top
of the OBEX layer what you should do is to play a bit with openobex.

As far as headset/handsfree are concerned, it needs SCO and AT commands
directly on the top of RFCOMM (if I remember correctly), so for handling
of AT commands, you can directly use RFCOMM socket (socket,bind,listen,ac=
cept).

Regards,

Alain


* Ka Kin Cheung [Mon, 28 Feb 2005 at 12:06 +0800]
<quote>
> Hi Soraberri!
>     I wish to know how to implement the basic service profiles such as =
SIM Access, headset, handsfree, file transfer and Object Push so that the=
 Linux PC can listen for the T610 client to connect to the PC? Thank you =
very much.
> Michael
>=20
> soraberri <421246@posta.unizar.es> wrote:
> Hi,
>=20
> Ka Kin Cheung wrote:
> > Hi!
> > The strange thing is here:
> > For Linux, when my phone searched for my PC, the PC can be found and=20
> > then added in the "My device" list, but when I looked at "Service lis=
t",=20
> > none service can be found. Then I opened Windows XP and the bluetooth=
=20
> > dongle driver was installed in my PC. Then I press "update" key to=20
> > update services, and I found headset, synchronisation, object push an=
d=20
> > file transfer in the "Service list" for my Windows PC. So, how can I =
do=20
> > for sdp in my Linux PC as my project is done on Linux? Thank you very=
=20
> > much for your kindness.
> > Michael
>=20
> You can advertise standard services in Linux using 'sdptool add ...' bu=
t
> advertising is not the same as offering... To offer a real service, an
> application has to be implemented and listening for clients at the
> appropiate network protocols and ports. Maybe what it is happening in
> windows is that most basic profiles are already implemented and
> correctly advertised. With BlueZ you can also advertise them in order
> to be seen by a remote device, but they won't work until you don't
> implement them. I hope this helps.
>=20
> regards,
> Luis
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
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
