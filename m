Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] PAN question
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <1126090955.10631.15.camel@blade>
Message-Id: <20050907111226.010371EC5B3@mrelay1.st2.lyceu.net>
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
Date: Wed, 7 Sep 2005 13:13:19 +0200

Ok, thanks for your help...

One more question. I can have one Bluetooth device on two different =
piconet,
acting as a master in one of them, and as a slave in the other, and
therefore forming a scatternet. But can this Bluetooth device form one =
PAN
on each piconet, and be GN on one of them and PANU on the other?

Regards, and sorry for too much questions

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: mi=E9rcoles, 07 de septiembre de 2005 13:03
Para: bluez-devel@lists.sourceforge.net
Asunto: RE: [Bluez-devel] PAN question

Hi Esther,

> Thanks for your answer. So I can't have PAN communication between a =
master
> and 9 slaves, even if two of them are in low-power mode. But can I =
have
> L2CAP connections (L2CAP socket open) between the master and 9 slaves =
and
> let it opened although they are low-powered, or have I got to open it =
each
> time the device is wake up?

this is a chip limitation. On most chips the maximum number of supported
ACL links is seven. On these seven ACL links you can have as much L2CAP
connections as you like.

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
