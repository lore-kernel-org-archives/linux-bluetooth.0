Return-Path: <cyrus@holtmann.org>
Message-ID: <3ad703600712210116p59cc3a27uaad6300625fd2645@mail.gmail.com>
Date: Fri, 21 Dec 2007 10:16:43 +0100
From: "Geoffrey Doret" <gdoret@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198163860.8050.257.camel@aeonflux>
MIME-Version: 1.0
References: <3ad703600712110300j7a3e628cj1e4d55dd9d4a0d5b@mail.gmail.com>
	<1197562554.5644.95.camel@aeonflux>
	<3ad703600712200615i1c039fbep5076ac119bddef61@mail.gmail.com>
	<1198163860.8050.257.camel@aeonflux>
Subject: Re: [Bluez-devel] Patch proposal for serial manager
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

>
> it has to take "hciX" strings or the local BD_ADDR of the adapter. Both
> must work. This is how other methods handle this. The reason behind it
> is that as an application developer using this method, you should not
> worry about the details. The service should do all the heavy lifting.

If I've understood, that is how hci_devid handle its parameter? If that is
correct, the new adapter parameter is correctly handled.
>
> Don't forget to document this new method in serial-api.txt.

Documentation is included in the last patch.

Regards,
Geoffrey Doret

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
