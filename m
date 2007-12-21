Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003101c843ba$5d611280$0200a8c0@jester>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
	<Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
	<000801c84343$f6efce40$0200a8c0@jester>
	<003101c843ba$5d611280$0200a8c0@jester>
Date: Fri, 21 Dec 2007 14:39:51 +0100
Message-Id: <1198244391.8050.285.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
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

Hi Olivier,

> I have tried parallel connection requests with 2 types of dongles :
> - Cambridge Silicon Radio (CSR) one is successful for the first connection, 
> and, as Peter said, returns "Command Disallowed" for next ones (and there 
> are automatic retries)
> - Integrated System Solution Corp. one allows all connection requests (no 
> more "Command Disallowed")

not seeing the "Command Disallowed" doesn't meant the connection request
is not queued. It is impossible to have two (or more) baseband pages at
the same time. You only have one radio in the chip. Once that is busy
with a connection attempt, then everything else has to wait. So if the
host stack queues these connection attempts or the link manager inside
the Bluetooth chip makes no real difference.

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
