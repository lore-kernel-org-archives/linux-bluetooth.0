Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <04fa01c8d2f6$65597b50$6701a8c0@freqonedev>
References: <038c01c8d152$2d0fc1f0$6701a8c0@freqonedev>
	<1213801443.19872.6.camel@violet.holtmann.net>
	<04fa01c8d2f6$65597b50$6701a8c0@freqonedev>
Date: Fri, 20 Jun 2008 19:07:57 +0200
Message-Id: <1213981677.25820.57.camel@violet>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Next Release, and Device.DiscoverServices
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

Hi David,

> Thanks for the feedback.  Upgrading to 3.33 resolved the immediate problem with accessing UUIDs, and I do get the correct UUID from 
> the remote (hurray!).
> 
> FWIW, with SSP I intend to use only the "Just Works" model at this point, keeping the handshake as simple as possible (not a highly 
> secure application).  So, the capability parameter will be "NoInputOutput", if I am reading the code correctly (adapter.c). 
> Hopefully, that will "JustWork", and I can proceed with the effort I originally undertook.  At any rate, I will be watching CVS 
> closely...

you will need some kernel patches to make SSP work. I am going to
publish them soon. Just finished the last testing of unlikely error and
corner cases.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
