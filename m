Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
References: <200511262023.23140.Loial@home.nl> <1133033547.15981.2.camel@blade>
In-Reply-To: <1133033547.15981.2.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1625687.t0uqamrEyX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200511281620.55644.Loial@home.nl>
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
Date: Mon, 28 Nov 2005 16:20:49 +0100

--nextPart1625687.t0uqamrEyX
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 26 November 2005 20:32, Marcel Holtmann wrote:
> Hi Rutger,
>
> > I have a bluetooth device here that has an LCD display. I want to be ab=
le
> > to send arbitrary data to the device. This way I can (hopefully) make
> > text appear on the LCD display. The problem is, that I can not find
> > enough documentation to send the arbitrary data. So I'm hoping to find
> > some help here...
> >
> > But, now I'm stuck. What function can I call to send arbitrary hex data?
>
> totally wrong direction. Use sdptool and its various option to discover
> the services offered by this LCD device.
>
> Regards
>
> Marcel

Hi Marcel,

sdptool finds the LCD device supports the HID service (which I already=20
knew :P ) What I do not know is how I can send data to the device (using=20
HID). Any pointers to docs/example code ?

Thanks!
Rutger

--nextPart1625687.t0uqamrEyX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDiyBXZNkx8LIJzQ4RAtPVAJsFh8nCR5ED5Mag4+tJF+d+9hbGfwCePDxu
Wh+/4xeyAxlF+NyXQWuY8g8=
=tAB8
-----END PGP SIGNATURE-----

--nextPart1625687.t0uqamrEyX--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
