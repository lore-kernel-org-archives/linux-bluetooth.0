Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Connection withaphonestaysopenafterclosingRFCOMM channel
Message-ID: <C70061B183DE09419568AB2060C52A951CAAA1@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Thu, 10 Mar 2005 10:35:38 +0100

Hi Marcel,

Fixes it for me too (SE630). Thanks.

Regards,
      Victor.=20


Victor Shcherbatyuk | Software Developer | TomTom |
victor.shcherbatyuk@tomtom.com | +31 (0) 20 4469 873 office | +31 (0)
628 186314 mobile


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Wednesday, March 09, 2005 18:52 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connection
withaphonestaysopenafterclosingRFCOMM channel

Hi Victor,

> > Hope that explains....
>=20
> it does not explain it, but this is what I expected. Another reference

> counting problem. Maybe introduced at that time I fixed another one of

> these crazy problems. Funny is that this does not result in an oops.=20
> The easiest way to fix this is, if you send me one of these phones,=20
> because otherwise it will take quite some time to reproduce it.

try the attached patch. It fixes it for me when I tested this with a
Nokia 6310.

Regards

Marcel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
