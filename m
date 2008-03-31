Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 31 Mar 2008 14:04:06 +1000
References: <47EDAEED.4000302@aircable.net>
	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>
	<47F05CEF.8040300@aircable.net>
In-Reply-To: <47F05CEF.8040300@aircable.net>
MIME-Version: 1.0
Message-Id: <200803311404.06902.denis.kenzior@trolltech.com>
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

Manuel,

> Ok if it's not there why not creating it? I can do it I think. Is there
> any convention on how to do this? Any API proposal?
>
> I would say it should be something like:
> methods:
> listenRFcomm
> closeRFcomm
>
> signals:
> RFcommConnected
> RfcommDisconnected
>
> Does it make any sense at all? I would say that maybe not, but it might
> be a good idea to have an rfcomm wrapper. Something that creates the
> rfcomm port, makes the connection and then just returns the rfcomm
> device. Ideas?

>>From our experience using RFCOMM ttys is not a good idea.  The bluetooth 
rfcomm tty driver in the kernel is too unreliable in certain situations.  We 
actually have to patch our device kernels in order to get it working somewhat 
correctly.  

The CreateProxy is still your best bet, or you can use bluetooth rfcomm 
sockets and do it yourself.

Regards,
-Denis

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
