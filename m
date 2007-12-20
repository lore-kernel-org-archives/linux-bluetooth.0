Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3ad703600712200615i1c039fbep5076ac119bddef61@mail.gmail.com>
References: <3ad703600712110300j7a3e628cj1e4d55dd9d4a0d5b@mail.gmail.com>
	<1197562554.5644.95.camel@aeonflux>
	<3ad703600712200615i1c039fbep5076ac119bddef61@mail.gmail.com>
Date: Thu, 20 Dec 2007 16:17:40 +0100
Message-Id: <1198163860.8050.257.camel@aeonflux>
Mime-Version: 1.0
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

Hi Geoffrey,

> I tied to speak on the channel two times but it seems we are not
> present at the same time. So I noted your remarks and reformulated my
> patch.
> First, I opted for "ConnectServiceByAdapter" but changing the naming
> is quite simple. 
> Second, the format of the new adapter parameter is a string "hciX" or
> a string representing the adapter address.

it has to take "hciX" strings or the local BD_ADDR of the adapter. Both
must work. This is how other methods handle this. The reason behind it
is that as an application developer using this method, you should not
worry about the details. The service should do all the heavy lifting.

Don't forget to document this new method in serial-api.txt.

Try the IRC channel again. At some point, I might pick up the
conversation. If I am not responding, ask Johan.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
