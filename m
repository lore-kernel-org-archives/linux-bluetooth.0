Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "Can't connect RFCOMM socket"
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <31511.1143197715@www019.gmx.net>
References: <31511.1143197715@www019.gmx.net>
Content-Type: text/plain
Message-Id: <1143199077.6863.4.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 24 Mar 2006 11:17:56 +0000

On Fri, 2006-03-24 at 11:55 +0100, Daniel Hertrich wrote:
> Dear bluez developers,
<snip>
> * rfcomm bind /dev/rfcomm0 00:02:EE:0D:71:96 1

Did you check that the device you're connecting to has RFCOMM on channel
1?

> --> The phone asks "connect to ?" I confirm and enter the pin which is
> stored in /etc/bluetooth/pin. After a few seconds:
> --> Can't connecto to RFCOMM socket: Resource temporarily unavailable

Double-check the pin setup in /etc/bluetooth/hcid.conf, the pin_helper
is the important thing.

> Some of the hci* tools complained about a missing libsdp library.

The tools will complain, but libsdp is included in libbluetooth nowadays
and isn't required anymore.

-- 
Bastien Nocera <hadess@hadess.net> 
It's beautiful, it's like a monkey.            -- Jean-Claude Van Damme



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
