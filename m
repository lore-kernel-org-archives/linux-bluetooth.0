Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI data packet
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1124896464.8019.0.camel@pegasus>
Message-Id: <20050825164412.641571DCD56@mrelay2.st2.lyceu.net>
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
Date: Thu, 25 Aug 2005 18:45:02 +0200

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
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
