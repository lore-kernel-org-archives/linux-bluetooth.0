Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2621d9af05042603075410e639@mail.gmail.com>
From: "N. I." <neutralidea@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] auto pairing between client & server
In-Reply-To: <1114205889.10706.9.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
	 <1114205889.10706.9.camel@pegasus>
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
Date: Tue, 26 Apr 2005 06:07:39 -0400

hi Marcel,
Thanks for replying. I'm using an old version of BlueZ stack, which
link key file is a binary file. I know we have a new thread talking
about changing this file to ascii. Since my product is already in
development phase, I can't wait until the new BlueZ release coming out
to use that feature.
Do you know any tool that can go and extract the content of the link
key file from binary to readable format ascii? (That's how I should
verify the pairing state in the link key file, right?)

N.I

On 4/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>=20
> > I have a laptop which runs my application as server, and another
> > cellphone as client. Both of them communicate to each other using
> > Bluetooth (Bluez implementation).
> >
> > What should I do in order to perform automatic pairing between these 2
> > devices (knowing the BD_ADDR) inside my application?
>=20
> there is no such thing than automatic pairing.
>=20
> > How can I detect if the pairing had been done between these
> > client-server devices inside my application? And from that, how to do
> > pairing using the "givepin" script?
> >
> > I want to avoid the pop-ups window asking for entering the PIN.
>=20
> Write your own PIN helper shell script that uses a fixed PIN. Check the
> link key file for the current state of the pairing.
>=20
> Regards
>=20
> Marcel
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
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
