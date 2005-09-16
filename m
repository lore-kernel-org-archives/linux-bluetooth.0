Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e26105091604311260a9cc@mail.gmail.com>
From: Jeff Wilson <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] problems with role switch
In-Reply-To: <1126588119.28181.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5f30e26105091219156b689b30@mail.gmail.com>
	 <1126588119.28181.0.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 06:31:39 -0500

Right you are.  I finally found the bug.  I forgot to close a socket
file descriptor.  This is what caused bind() to fail.

Once I found the bug, I tested through several iterations.  I reduced
my pause between iterations and was able to reduce the pause to 0.  I
increased my iterations and stopped counting after reaching 30
iterations.

So!  Very definitely *not* a limitation of Bluetooth or BlueZ!  Thanks
again for your time.

    Regards,
     jw

On 9/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jeff,
>=20
> this sounds like a bug inside your code.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
