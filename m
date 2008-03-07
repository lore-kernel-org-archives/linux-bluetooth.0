Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47D020D1.9020204@inov.pt>
References: <47D020D1.9020204@inov.pt>
Date: Fri, 07 Mar 2008 15:19:33 +0100
Message-Id: <1204899573.28006.4.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bug in compat_ppoll
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

Hi Jose,

> When I was cross-compiling Bluez for a system without the ppoll() system
> call, I've found a bug on you ppoll() stub, compat_ppoll(), that causes
> rfcomm to eat all CPU power when called in this way:
> 
> $ rfcomm listen 0 1 <cmd>
> 
> After the RFCOMM connection is established and the command is executed
> the CPU load reaches 100%.
> 
> This patch solved my problem:

your patch has been applied. Thanks.

I was actually considering to simply fail compilation on systems that
don't support ppoll().

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
