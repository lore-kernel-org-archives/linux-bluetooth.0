Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
References: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
	<20070924192203.GA31266@sus.mcgill.ca>
	<2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
Date: Tue, 25 Sep 2007 00:14:50 +0200
Message-Id: <1190672090.5133.133.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] help with Logitech Travel Mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Jared,

> Yea, I would think that would fix things, but I tried that (the hidd
> --connect) and it doesn't seem to work to get connected...

use the new input service and don't use hidd. The input service will
convert your configured devices automatically. There is no need to use
hidd --search or hidd --connect more than once. Whoever tells you
differently is wrong. Period.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
