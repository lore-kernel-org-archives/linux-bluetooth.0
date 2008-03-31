Return-Path: <cyrus@holtmann.org>
Message-ID: <47F0EE21.8060607@aircable.net>
Date: Mon, 31 Mar 2008 10:58:57 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>	<B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>	<47F059B9.5030003@aircable.net>	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>	<47F05CEF.8040300@aircable.net>	<CA77AEF1-2E8A-4EDB-A806-563338C34565@holtmann.org>	<47F0620F.8020606@aircable.net>
	<9ABEE439-610E-470F-AC7E-C2A611337022@holtmann.org>
In-Reply-To: <9ABEE439-610E-470F-AC7E-C2A611337022@holtmann.org>
Subject: Re: [Bluez-devel] CreateProxy usage?
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
> go and write up a proper proposal for that API and make an  
> implementation.
>   
Ok I had investigated, and you're right, it doesn't make any sense to
make a DBUS api. We will need a socket anyway, so it's easier using the
socket interface.

I will write some simple samples and put them on the wiki so others can
use them.

Thanks,
Manuel

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
