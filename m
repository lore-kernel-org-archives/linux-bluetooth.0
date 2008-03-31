Return-Path: <cyrus@holtmann.org>
Message-ID: <47F0E819.6000503@aircable.net>
Date: Mon, 31 Mar 2008 10:33:13 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EDAEED.4000302@aircable.net>	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>	<47F05CEF.8040300@aircable.net>
	<200803311404.06902.denis.kenzior@trolltech.com>
In-Reply-To: <200803311404.06902.denis.kenzior@trolltech.com>
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


> >From our experience using RFCOMM ttys is not a good idea.  The bluetooth 
> rfcomm tty driver in the kernel is too unreliable in certain situations.  We 
> actually have to patch our device kernels in order to get it working somewhat 
> correctly.  
>   
I know that RFcomm tty is a bit buggy, I've been investigating on ways
to implement a user-space tty device, but I can't find anything that can
apply to a 2.6 kernel. There's a hole framework but for the 2.4 branch.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
