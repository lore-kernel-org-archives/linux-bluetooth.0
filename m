Return-Path: <cyrus@holtmann.org>
Message-ID: <000801c84343$f6efce40$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
	<Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
Date: Thu, 20 Dec 2007 21:07:35 +0100
MIME-Version: 1.0
Cc: Peter Wippich <pewi@gw-instruments.de>
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Thanks a lot for your answer Peter,

> This is probably because you start the creation of the new connection
> before the previous connection request is completed. CSR Chips do not
> allow multiple connection setups in parallel.

Sorry if my question is stupid, but do you know if there are other bluetooth 
chips used in common dongles that would support multiple connection setups 
in parallel ? This way I could to find one of them and test it ;)

> So either wait with the next
> connection setup until the previous is compledet (either success or
> failure) or retry the connection setup when you get command disallowed
> (and it may be a good idea to sleep some 100 milliseconds before
> retrying).

I use a simple socket "connect" to perform my connections, and having a look 
at my hcidump it seems that the low level layer is retrying the connection 
by itself, without actually leaving the "connect". Not sure how this retry 
is performed though, and how to tune it ?

I will provide you with complete hcidump tomorrow morning as Marcel asked.

Best regards,
Oli


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
