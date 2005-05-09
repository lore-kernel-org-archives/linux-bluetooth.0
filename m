Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05050914312761aa57@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1115051077.21785.133.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
	 <e1effdeb0504291520167b9bb8@mail.gmail.com>
	 <1114819470.8836.124.camel@pegasus>
	 <e1effdeb050501141626c62c35@mail.gmail.com>
	 <1114989490.21785.80.camel@pegasus>
	 <e1effdeb05050208322febd0bf@mail.gmail.com>
	 <1115051077.21785.133.camel@pegasus>
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
Date: Mon, 9 May 2005 18:31:55 -0300

Hi Marcel,

According with our last discussion. I will to add DBUS service
support in the pand. All code related to DBUS will be added=20
in a new file.

The dbus service will be enabled using the argument "--dbus".
However if this argument is provide with other arguments like
"--connect", "--role" or "--listen" a sharing problem will happen.

What is the behaviour that you want?
1. if "--dbus" was informed no other arguments will be accepted
2. support a shared mode, accepting other arguments.


In this last case, I have to solve a small problem: shared=20
variables,  add functions to check the device status,
and common codes like this:

create_connection()

static uint16_t role =3D BNEP_SVC_PANU;=09/* Local role (ie service) */
static uint16_t service =3D BNEP_SVC_NAP;=09/* Remote service */

static int  encrypt;
static int  secure;
static int  master;

static char netdev[16] =3D "bnep%d";
static bdaddr_t src_addr =3D *BDADDR_ANY;
static int src_dev =3D -1;




Regards,
Claudio.


On 5/2/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > After analyze both approachs and consider the future enhancements
> > for BlueZ, implement DBUS  service at BlueZ level can be better
> > because it open a new perspective, local services can provided:
> > - dial-up networking
> > - business card exchange
> > - fax
> > - file transfer
> > - headset
> > - audio gateway
> > - ...
> >
> > This is very interesting for embedded environment because
> > only the assigned application will handle the request/notifications.
> >
> > Regarding the service name, I suggest:
> > "org.bluez.pand"
> > Is it fine for you?
>=20
> the name is fine with me.
>=20
> > Do you want a macro to enable this feature at
> > build time?
>=20
> Follow the hcid example. The configure script already detects if D-Bus
> is available or not.
>=20
> Make sure that the current tasks (--connect and --listen) of pand are
> working the same and use --dbus for starting a pand with a D-Bus
> interface.
>=20
> Keep all the D-Bus specific things in a separate files.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, =
4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=3D20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


--=20
_______________________________________
Claudio Takahasi
INdT - Nokia Technology Institute
Phone: +55 81 21223034
Recife - Pernambuco - Brazil


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
