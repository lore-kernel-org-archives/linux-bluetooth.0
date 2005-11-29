Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
References: <200511262023.23140.Loial@home.nl> <200511291038.22058.Loial@home.nl> <1133259183.12447.4.camel@blade>
In-Reply-To: <1133259183.12447.4.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2086175.kmWo7g3Wji";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200511291146.42749.Loial@home.nl>
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
Date: Tue, 29 Nov 2005 11:46:38 +0100

--nextPart2086175.kmWo7g3Wji
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 29 November 2005 11:13, Marcel Holtmann wrote:
> Hi Rutger,
> > Actually, it is one of the Logitech diNovo devices (the mediapad). I know
> > you did some work on it (in december 2003) and that all information about
> > it is lost, but I'm willing to try to redo your work. It will be a nice
> > pastime, I hope :)
>
> why don't you tell us from the start what kind of device it is.

Sorry about that.

> > I already saw you were using report ID 16 and 17, so I will try that too.
>
> You need to send and receive reports with ID 16 and 17. Both have fixed
> length and 16 was for the short messages and 17 for the long messages if
> I remember that correctly. They are the same we used for switching the
> dongle from HID into HCI mode.
>
> The problem is to get these reports to the device. The HIDP kernel
> module with the report protocol (see -mh patch) lacks hiddev support.

Is there a specific reason for the lack of hiddev support?

Greetings
Rutger

--nextPart2086175.kmWo7g3Wji
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDjDGSZNkx8LIJzQ4RAjATAKCNY2o7+Chh5RiqH9Pr65DSEQTibQCfQ+MQ
rYsi4VciPGDJZqp88Vb9hfQ=
=4YKd
-----END PGP SIGNATURE-----

--nextPart2086175.kmWo7g3Wji--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
