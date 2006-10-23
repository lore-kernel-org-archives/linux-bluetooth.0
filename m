Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <453D2170.8010600@vasmac.com>
Date: Mon, 23 Oct 2006 16:09:20 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>	<452E99E8.6070406@vasmac.com>	<452FBC82.1080901@free.fr>	<452FDC44.90803@vasmac.com>	<45310A24.1000604@free.fr>	<453114A0.50503@vasmac.com>	<453B9F4D.7080504@free.fr>	<453BAAFC.1090206@vasmac.com>
	<453D0CFD.1030909@free.fr>
In-Reply-To: <453D0CFD.1030909@free.fr>
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

Very interesting. I interpreted this to mean that if synchronous
channels are supported, then synchronous flow control is required.
Some form of feedback from the HCI device is required to main
synchronization. If you use timers you run occasional the risk of
getting out of sync.

All this speculation can be clarified if someone with an actual UART
dongle can speak up. The patch that I posted should work as long
as the device implements synchronous  flow control. Maybe the
solution is to not support SCO on UART until someone can take
responsibility.

One thing is clear, the current code is wrong. It allows application
programs to easily cause Linux to panic. I'm very surprised that this
condition has been allowed.

BTW, the IEEE spec is the base for bluetooth.

Jose

Fabien Chevalier wrote:
> Hello Jose,
>
> The documents i used as reference are the ones from bluetooth SIG. I 
> don't know who copied the others, but they are closely similar to the 
> one from IEEE :-)
> Concerning SCO flow control over UART link, it is stated nowhere it is 
> mandatory nor optionnal. :-(
>
> However, having a look at the Bluetooth 2.0+EDR spec (available on 
> www.bluetooth.com), section 6.26 "Supported commands" describes the 
> bitmask that lists the supported hci commands for a given 
> implementation, stating that *It is implied that if a command is listed 
> as supported, the feature underlying that command is also supported.*
>
> And guess what ?.... in the bitmask there is a bit for the "Write 
> Synchronous flow control enable" command. ;-)
>
> *** cut here ***
>     0 Read Hold Mode Activity
>     1 Write Hold Mode Activity
>     2 Read Transmit Power Level
>     3 Read Synchronous Flow Control Enable
> 10
>     4 Write Synchronous Flow Control Enable
>     5 Set Host Controller To Host Flow Control
>     6 Host Buffer Size
>     7 Host Number Of Completed Packets
> *** cut here ***
>
> Having analysed all these informations, my guess is that it is 
> synchronous flow control is 'optionnal', even for uart links.
>
> Cheers,
>
> Fabien
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
