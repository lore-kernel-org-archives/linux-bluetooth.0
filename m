Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Toby Fisher <toby@tjfisher.co.uk>
To: "Nicholas A. Preyss" <nalp@gmx.net>
cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
In-Reply-To: <20040531115424.GA24449@gmx.net>
Message-ID: <Pine.LNX.4.58.0405311422140.6611@sebagqbbe.gwsvfure.pb.hx>
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
 <200405310213.25767.tim@birdsnest.maths.tcd.ie>
 <Pine.LNX.4.58.0405311108560.10172@sebagqbbe.gwsvfure.pb.hx>
 <20040531115424.GA24449@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 May 2004 14:24:40 +0100 (BST)

On Mon, 31 May 2004, Nicholas A. Preyss wrote:

> On  0, Toby Fisher <toby@tjfisher.co.uk> wrote:
> > On Mon, 31 May 2004, Timothy Murphy wrote:
> > > Do you have=20
> > > # CONFIG_BT_HCIUSB_SCO is not set
> > > in .config (or /proc/config.gz) ?
> > > On my machine (a Sony C1VFK Picturebook)
> > > I had more or less your problems when this was set.
> >=20
> > The problem here is that I have a usb bluetooth device, so according to=
=20
> > the kernel help I need this option, so yes, I do have it.
>=20
> You need the HCI_USB SCO option for audio transfer, only. For example if
> you use the Headset or Handsfree profile. For data transfer there is no
> need for SCO support. You are using RFCOMM which uses ACL links.
> And >=3D 2.6.6-mh1 there shouldn't be any problems with the SCO
> support activated.
>=20
> Maybe you can run hcidump while your problem appears and provide here
> the log.

Ok, I turned off the SCO options, but have another problem which was, I=20
think, there earlier.  Anyway, if I issue the command:
hciconfig hci0 reset
it eventually says that it times out initialising the device, the hcidump=
=20
log is very short.

Here it is;

=04=00=00=00 1=BB@0k=03=00=01=03=10=00

Itseem that it doesn't like being re-initialised.

Cheers.

--=20
Toby Fisher=09Email: toby@tjfisher.co.uk
Tel.: +44(0)1480 417272=09Mobile: +44(0)7974 363239
ICQ: #61744808


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
