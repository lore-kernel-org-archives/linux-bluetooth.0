Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm connection send data
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1366.1078828940@www52.gmx.net>
References: <1366.1078828940@www52.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1078877588.30990.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Mar 2004 01:13:08 +0100

Hi Franz,

> i=B4m trying to develop an application using the bluezstack (usb dongle=
)  and
> the sonyericsson p900.
> i=B4m able to connect the two devices via rfcomm.
>=20
> rfcomm connect 0 00:00:00:00:00:00  5
> Connected /dev/rfcomm0 to 00:00:00:00:00:00  on channel 5
> Press CTRL-C for hangup
>=20
> now i want to send data(string) from one device to the other.
> on the p900 i use MIDlets and the java bluetooth api.=20
>=20
> if i start listening and dump with ./rctest -d and trying to connect th=
e
> p900 the following message returns:
> ./rctest -d
> rctest: Waiting for connection on channel 10 ...
> rctest: Connect from 00:00:00:00:00:00 (p900 adress)
> rctest: Receiving ...
>=20
> an nothing happens...
> i use in the MIDlet the command: connector client =3D (StreamConnection=
)
> Connector.open(btspp://dongle adress and channel));
>=20
> so the connection seems to work alright.
>=20
> the data i want to send is a string saved in content:
> output =3D client.openOutputStream();
> byte[] data =3D content.getBytes();
> output.write(data);
>=20
> the p900 confirms it sended the data and rctest gives no error message =
or
> anything.

run "hcidump -x" (as root) and see what happens on the Linux side.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
