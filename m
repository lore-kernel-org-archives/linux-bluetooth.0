Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 7 Jun 2006 13:08:48 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <15207714a694.14a694152077@fh-wolfenbuettel.de>
Message-ID: <Pine.LNX.4.63.0606071302320.2900@redbean.intranet.gw-instruments.de>
References: <15207714a694.14a694152077@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463794332-1586515895-1149678528=:2900"
Subject: Re: [Bluez-devel] Sim Access Profile question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794332-1586515895-1149678528=:2900
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Goetz,=20

On Wed, 7 Jun 2006, G=F6tz Isse wrote:

> Hi,
>=20
> I have read the SimAccessProfile Spec and am not 100% sure on the follo=
wing:
>=20
> 1. Establish connection l2cap and rfcomm to SAP-server (ie. a mobile
> that supports this profile) as stated in section4.1, 2nd paragraph?
> Is l2cap really needed seperately or is it included when connection via
> rfcomm ?
RFCommm always uses L2CAP as the lower layer. So don't worry about L2CAP=20
because BlueZ will handle all this.=20
=20
> 2. Then build messages specified for conection request and write them o=
n
> the rfcomm connection using write(socket,values, length) ? ...wait for
> response etc. and continue.
> I have place the appropriate hex values in a array of unsigned char and
> then use that whole array to send.
>=20
> The real question is here:
> - Is the sending via rfcomm the correct way? I sent a dial command
> "atd123456789" to the port and my mobile starts dialing... so in genera=
l
> the connection is there and the phone reacts.=20
>=20
> - What is l2cap needed for? The spec does not help me. Maybe you can?
As before. L2CAP is always the lower layer for RFCOMM. To get the big=20
picture maybe you can try to get a textbook which givers you some overvie=
w=20
of the Bluetooth standard. Because from your name I assume you speak=20
German you may also find some general information on the Heise Verlag web=
=20
site (www.heise.de). Or search your favorite bookstore...=20

> Happy to phone anyone who can help directly, in case you are not happy
> writing all this.. just give me your phone number and a time...and your
> timezone.
>=20
> Thanks ,=20
> Goetz

Ciao,=20

Peter=20

>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |

---1463794332-1586515895-1149678528=:2900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


---1463794332-1586515895-1149678528=:2900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

---1463794332-1586515895-1149678528=:2900--
