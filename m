Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SDP service
Message-ID: <20050301010048.GA32017@snoopy.src.ricoh.co.jp>
References: <1109606794.17256.111.camel@pegasus> <20050301005541.32014.qmail@web60909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050301005541.32014.qmail@web60909.mail.yahoo.com>
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
Date: Tue, 1 Mar 2005 10:00:48 +0900

Hi Michael,

SDP and PAN packages are now depracated since their functionalities
are now included into LIBS/UTILS.
So now, only utils, libs and hcidump are necessary.

in your case, you shouldn't have the 2 followings packages:
> > bluez-sdp-1.5-1.i386.rpm
> > bluez-pan-1.1-1.i386.rpm

Alain

* Ka Kin Cheung [Tue,  1 Mar 2005 at 08:55 +0800]
<quote>
> Hi Marcel!
>     Does you mean that something is/are not needed to be installed, suc=
h as the rpm of sdp and pan? And is it ok if I just installed utils, libs=
 and hcidump?
> Thx!
> Michael
> =20
> Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michael,
>=20
> > My config of bluez tools are as follows:
> > bluez-utils-2.15
> > bluez-libs-2.15
> > bluez-sdp-1.5-1.i386.rpm
> > bluez-pan-1.1-1.i386.rpm
> > bluez-hcidump-1.18
> > bluez-hciemu-1.1
> > Is there any tool that have newer version than I've installed? Or
> > is there any problem about the sdp/pan installation?
>=20
> the bluez-{sdp|pan} is included in bluez-{libs|utils} and thus you have
> a screwed installation.
>=20
> Regards
>=20
> Marcel
>=20
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
