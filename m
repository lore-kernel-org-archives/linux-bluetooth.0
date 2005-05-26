Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05052614222118e70c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1117098491.12036.23.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
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
Date: Thu, 26 May 2005 18:22:15 -0300

Hi Marcel,

1. Glib
I will fix it. I found another approach using dbus main loop function.

2. libbridge
It should be removed. It is not being used at the momment.  I will fix
the Makefile.am
But in the the future, I would suggest provide automatic bridge creation.
Using libbridge it's possible create bridge and add bnep interfaces.

3. Coding style
sorry, I try do my best. I am not familiar with linux kernel coding style.

4. PThread=20
I will remove Posix Thread code.



Thanks for our comments!
I will send another patch until next monday.

Regards,
Claudio.

On 5/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > A new patch is available in the link below:
> > http://www.indt.org.br/maemo/bluez/
>=20
> lets welcome the Nokia 770 development ;)
>=20
> > The DBUS.TXT file contains information to run the sample and
> > how configure the service.
>=20
> We must make sure that we install a default service file, but we can
> sort this out later.
>=20
> > Suggestions and comments are welcome!
>=20
> We must really talk about the coding style at some point, but this is
> not important at the moment. We follow the kernel coding style and I
> wanna keep it that way.
>=20
> While looking through the whole source I realized that you used Glib and
> Pthread. This introduces a dependency chain that I don't wanna take. We
> must be really careful about this, because not all embedded systems can
> deal with it. We had a hard time to remove the Glib dependency from hcid
> and I am not going to introduce it again. For Pthread you might convince
> me, but there must be really good arguments.
>=20
> What is libbridge? I don't found it on any of my systems.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborat=
e
> online with coworkers and clients while avoiding the high cost of travel =
and
> communications. There is no equipment to buy and you can meet as often as
> you want. Try it free.http://ads.osdn.com/?ad_id=3D7402&alloc_id=3D16135&=
op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
