Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05050208322febd0bf@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1114989490.21785.80.camel@pegasus>
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
Date: Mon, 2 May 2005 12:32:43 -0300

Hi Marcel,

After analyze both approachs and consider the future enhancements
for BlueZ, implement DBUS  service at BlueZ level can be better
because it open a new perspective, local services can provided:
- dial-up networking
- business card exchange
- fax
- file transfer
- headset
- audio gateway
- ...

This is very interesting for embedded environment because
only the assigned application will handle the request/notifications.

Regarding the service name, I suggest:
"org.bluez.pand"
Is it fine for you?

Do you want a macro to enable this feature at
build time?


Regards,
Claudio.

On 5/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I suggested provide a DBUS message service in another
> > level because I will try contribute with NetworkManager
> > project:
> > http://people.redhat.com/dcbw/NetworkManager/index.html
>=20
> then this is not about D-Bus integration. What you need is to make the
> NetworkManager daemon capable of dealing with Bluetooth PAN connections.
>=20
> > I will analyze these two approachs and define the most
> > interesting solution for my project.
>=20
> Both parts are fine with me, but the NetworkManager thing should be done
> outside of the BlueZ utilities.
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
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
