Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN question
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050907095648.B94171EC62F@mrelay1.st2.lyceu.net>
References: <20050907095648.B94171EC62F@mrelay1.st2.lyceu.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <1126088365.10631.5.camel@blade>
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
Date: Wed, 07 Sep 2005 12:19:25 +0200

Hi Esther,

> I have a question related the PAN profile and the implementation with
> BlueZ.
>=20
> To establish a PAN, I just run =E2=80=9Cpand --listen" or the correspon=
ding
> =E2=80=9Cpand --connect" on different devices. Once I have 7 slaves con=
nected,
> can I take one of them into a low-power non active state without
> having to close the PAN connection to add one more device to the PAN?

if you use a Bluetooth chip that supports more than seven slave
connections then you can do this. However I don't know of any chip that
is really capable of doing this.

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
