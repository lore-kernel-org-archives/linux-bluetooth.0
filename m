Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2007 19:17:24 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <009b01c8432a$f2b9a800$0200a8c0@jester>
Message-ID: <Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
MIME-Version: 1.0
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


Hi Oli, 

On Thu, 20 Dec 2007, Olivier Le Pogam wrote:

> Hello,
> 
> When I try to open 3 RFCOMM connections from the same device to 3 
> remote ones, the first connection is OK but the 2 following give a 
> "Error: Command Disallowed". I suspect an incorrect bluetooth parameter 
> in my hcid.conf (lp ? lm ?)
> 
> Any hint is welcome !
> 
> PC is running a 2.6.23.12 Kernel with BlueZ 3.23
> 

This is probably because you start the creation of the new connection 
before the previous connection request is completed. CSR Chips do not 
allow multiple connection setups in parallel. So either wait with the next 
connection setup until the previous is compledet (either success or 
failure) or retry the connection setup when you get command disallowed 
(and it may be a good idea to sleep some 100 milliseconds before 
retrying). 

Ciao,

Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
