Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI data packet
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-Id: <20050901145400.BB3131EC845@mrelay1.st2.lyceu.net>
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
Date: Thu, 1 Sep 2005 16:54:47 +0200

Hello again

Regarding HCI data packets and BlueZ...

If I use the BlueZ command "hci_create_connection" and connect to =
another
device, how do I sent an HCI data packet to this device?

Thanks and Regards

Esther

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Esther =
Lopez
Enviado el: jueves, 25 de agosto de 2005 18:45
Para: bluez-devel@lists.sourceforge.net
Asunto: RE: [Bluez-devel] HCI data packet

Hi Marcel

> -----Mensaje original-----
> De: bluez-devel-admin@lists.sourceforge.net [mailto:bluez-devel-
> admin@lists.sourceforge.net] En nombre de Marcel Holtmann
> Enviado el: mi=E9rcoles, 24 de agosto de 2005 17:14
> Para: bluez-devel@lists.sourceforge.net
> Asunto: RE: [Bluez-devel] HCI data packet
>=20
> Hi Esther,
>=20
> > Regarding the HCI data packets... What is the maximum size of the =
data
> > field? Is if fixed or can be set by the BlueZ user?
>=20
> this depends on the ACL and SCO MTU sizes.
>=20
Thanks again for your help. I have been investigating and found that the =
ACL
and MTU sizes are fixed by the manufacturer. Is there any typical or =
maximum
value for them? I have here 2 USB dongle, and both have 192 bytes.

Thanks, and regards

Esther



> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing =
& QA
> Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle =
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
