Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05070813041c5a19a0@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
In-Reply-To: <1120849847.7444.5.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <e1effdeb05070805454b8960b6@mail.gmail.com>
	 <1120834052.18553.123.camel@pegasus>
	 <e1effdeb050708092343073205@mail.gmail.com>
	 <1120849847.7444.5.camel@notepaq>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 8 Jul 2005 17:04:59 -0300

Hi Marcel,

On 7/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I see a new repository in the CVS(Bluehood).  I think that this
> > daemon will be the metaserver, is that correct?
>=20
> actually that is quite old and has nothing to do with it. The new
> bluetoothd will be inside utils/daemon/.
[Claudio Takahasi]
Which D-Bus services will be provided by bluetoothd?=20
Please fix me if it is wrong or add more details to clarify=20
my clouds.
- periodic inquiry?
- service discovery? Currenlty, All daemons(dund, pand, hidd )=20
 have search option. In my opinion a parametrized search
 should be provided only by bluetoothd
- signal lost notifications?
- link configuration?
- adapter status: enable/disable authentication, encryption, pscan, iscan ?


Are there plans to implement D-Bus services for=20
the others bluez-utils daemons?

Regards,
Claudio.

>=20
> > > The new InquiryResult and RemoteName signals are implemented in hcid =
for
> > > testing. Start "dbus-monitor --system" and call "hcitool scan".
> > I didn't find  this code in the bluez-utils-2.18 code. Where is it? Cou=
ld
> > you send me the CVS branch or the code?
> > I found references in the kbluetoothd(neighbourmonitor.cpp), but there =
is no
> > D-Bus messages involved.
>=20
> You are mixing things here. The KDE Bluetooth stuff has nothing to do
> with it at the moment. The code is inside the CVS and will be part of
> the 2.19 release.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted by H=
P,
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
