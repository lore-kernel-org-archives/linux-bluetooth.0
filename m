Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-announce@lists.sourceforge.net
Cc: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1054908696.4791.157.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Subject: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Jun 2003 15:11:37 +0100

Hi,
I don't want to preempt the official packager of the Zaurus BlueZ
distribution but I couldn't wait for Sharp to get around to distributing
the kernel source and needed to try out BlueZ on the new ROM.

So I built BlueZ kernel modules from a vanilla 2.4.18 plus Marcel's
2.4.18-mh6 patch-set and a bit of tweaking to the 2.4.6 kernel config
file. 

>>From cursory testing, they seem to be ok: bluecard_cs is successfully
loaded and the latest versions of hciconfig, hcitool and sdptool all
work fine. (However YMMV, no warranty, don't blame me if your Z catches
fire, etc.)

I've uploaded them to our anonymous ftp area, along with the PCMCIA
configuration files, bluetooth and bluetooth.conf. Get them from
ftp://rococosoft.com/pub/zaurus

Installation:
* unpack the tar-ball in the /home/root/modules/2.4.18-rmk7-pxa3-embedix
directory
* run depmod -ae
* install bluetooth and bluetooth.conf in /etc/pcmcia
* run /etc/rc.d/init.d/pcmcia restart

Cheers,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
