Return-Path: <cyrus@holtmann.org>
Message-ID: <47F05CEF.8040300@aircable.net>
Date: Mon, 31 Mar 2008 00:39:27 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>	<B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>	<47F059B9.5030003@aircable.net>
	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>
In-Reply-To: <52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>
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

Marcel,
> in the most cases this is a hardware port. It can be emulated, but  
> that is not the usual case.
>   
Ouu ok. Not good for me then.

> You can't really do that over D-Bus. Use the native RFCOMM sockets  
> from the Bluetooth library.
>   
Ok if it's not there why not creating it? I can do it I think. Is there
any convention on how to do this? Any API proposal?

I would say it should be something like:
methods:
listenRFcomm
closeRFcomm

signals:
RFcommConnected
RfcommDisconnected

Does it make any sense at all? I would say that maybe not, but it might
be a good idea to have an rfcomm wrapper. Something that creates the
rfcomm port, makes the connection and then just returns the rfcomm
device. Ideas?

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
