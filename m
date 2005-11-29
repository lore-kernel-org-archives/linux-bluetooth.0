Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
References: <200511262023.23140.Loial@home.nl> <200511281620.55644.Loial@home.nl> <1133208749.31513.45.camel@blade>
In-Reply-To: <1133208749.31513.45.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1356146.ySBtQv3bmg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200511291038.22058.Loial@home.nl>
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
Date: Tue, 29 Nov 2005 10:38:17 +0100

--nextPart1356146.ySBtQv3bmg
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 28 November 2005 21:12, Marcel Holtmann wrote:
> Hi Rutger,
>
> > > > I have a bluetooth device here that has an LCD display. I want to be
> > > > able to send arbitrary data to the device. This way I can (hopefull=
y)
> > > > make text appear on the LCD display. The problem is, that I can not
> > > > find enough documentation to send the arbitrary data. So I'm hoping
> > > > to find some help here...
> > > >
> > > > But, now I'm stuck. What function can I call to send arbitrary hex
> > > > data?
> > >
> > > totally wrong direction. Use sdptool and its various option to discov=
er
> > > the services offered by this LCD device.
> >
> > sdptool finds the LCD device supports the HID service (which I already
> > knew :P ) What I do not know is how I can send data to the device (using
> > HID). Any pointers to docs/example code ?
>
> don't tell me that it is one of the Logitech diNovo devices. If it is
> is, please see my comments about it on the mailing list. Otherwise send
> in details about that device.

Actually, it is one of the Logitech diNovo devices (the mediapad). I know y=
ou=20
did some work on it (in december 2003) and that all information about it is=
=20
lost, but I'm willing to try to redo your work. It will be a nice pastime, =
I=20
hope :)

I have searched the archives in the past and could not find anything, but n=
ow=20
I looked again and I've finally found the messages in which you describe so=
me=20
of your findings!

I will read through all I can find and see if there is anything in there I =
can=20
use, which will probably be the case :) I already saw you were using report=
 ID=20
16 and 17, so I will try that too.

Greetings
Rutger

--nextPart1356146.ySBtQv3bmg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDjCGNZNkx8LIJzQ4RAgjdAJ9CHKqUcGFFhn1nCsV0M8S2gTZWUgCfTZmm
9s5V0YeHH0ucujkcv9U8CKM=
=bly/
-----END PGP SIGNATURE-----

--nextPart1356146.ySBtQv3bmg--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
