Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] PAN question
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <1126088365.10631.5.camel@blade>
Message-Id: <20050907105710.D4C121DC826@mrelay2.st2.lyceu.net>
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
Date: Wed, 7 Sep 2005 12:58:04 +0200

Hi Marcell

Thanks for your answer. So I can't have PAN communication between a =
master
and 9 slaves, even if two of them are in low-power mode. But can I have
L2CAP connections (L2CAP socket open) between the master and 9 slaves =
and
let it opened although they are low-powered, or have I got to open it =
each
time the device is wake up?

Thanks again

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: mi=E9rcoles, 07 de septiembre de 2005 12:19
Para: bluez-devel@lists.sourceforge.net
Asunto: Re: [Bluez-devel] PAN question

Hi Esther,

> I have a question related the PAN profile and the implementation with
> BlueZ.
>=20
> To establish a PAN, I just run =93pand --listen" or the corresponding
> =93pand --connect" on different devices. Once I have 7 slaves =
connected,
> can I take one of them into a low-power non active state without
> having to close the PAN connection to add one more device to the PAN?

if you use a Bluetooth chip that supports more than seven slave
connections then you can do this. However I don't know of any chip that
is really capable of doing this.

Regards

Marcel




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
