Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050826111844.1ACEC1DC1D6@mrelay2.st2.lyceu.net>
References: <20050826111844.1ACEC1DC1D6@mrelay2.st2.lyceu.net>
Content-Type: text/plain; charset=windows-1251
Message-Id: <1125055955.25535.8.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Aug 2005 13:32:35 +0200

Hi Esther,

> I have a question related with BlueZ L2CAP sockets, and I hope
> somebody can help me=85
>=20
> If I want to communicate two Bluetooth devices using L2CAP, I just
> open an L2CAP socket and send data through this open socket. (Is this
> OK?).=20
>=20
> The question is related with the size and format of the data send
> throught this socket. How is the data packet created? Do I need to
> create headers and so on? What is the size of the data I can send?

the L2CAP socket is a SOCK_SEQPACKET and the MTU size can be retrieved
with a getsockopt() call.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
