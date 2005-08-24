Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI data packet
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1124877666.23599.174.camel@pegasus>
Message-Id: <20050824143059.0AA7D1EAEE7@mrelay1.st2.lyceu.net>
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
Date: Wed, 24 Aug 2005 16:31:50 +0200

Hi Marcel

Thanks for your help. That is what I was looking for.

Regarding the HCI data packets... What is the maximum size of the data
field? Is if fixed or can be set by the BlueZ user?

Regards

Esther

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: mi=E9rcoles, 24 de agosto de 2005 12:01
Para: bluez-devel@lists.sourceforge.net
Asunto: Re: [Bluez-devel] HCI data packet

Hi Ester,

>=20
> I have been reviewing BlueZ code and Bluetooth specification, and have
> found a doubt related with HCI data packets. They are supposed to be
> used to exchange data between Host and Host Controller, and the
> Connection Handle field addresses the connection from one BT device to
> another. But, how is this connection handle assigned? Can it be used
> to directly send data from one device to another by using HCI?=20

the ACL packet handle is assigned by the connect_complete event and you
can find any details about it in the HCI part of the core specification.

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
