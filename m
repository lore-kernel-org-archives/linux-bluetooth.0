Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] 2. Re: Re: Re: Bluetooth SCO message
	sending	(sco_send_frame)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4312AEBD.4090907@core.kaist.ac.kr>
References: <4312AEBD.4090907@core.kaist.ac.kr>
Content-Type: text/plain
Message-Id: <1125922447.11955.24.camel@pegasus>
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
Date: Mon, 05 Sep 2005 14:14:07 +0200

Hi,

> In my case, there is some problem when I connect SCO over UART(h4).
> When I sent data to h4 interface, h4 make frame and btsco sent that
> frame to the SCO channel.
> The frame size from h4 interface is varied periodically and somtimes
> larger than MTU size so SCO channel drop several frames.
> 
> Of course I changed the MTU size using "hciconfig scomtu" command but it
> is not effective at all.

this command is useless.

> Now, I tested the problem using samsung module based on CSR bluecore
> chipset.
> However, there is no problem if I use SCO over USB because the frame
> size from USB is always same & smaller than MTU.

As I told you, the kernel will tell you the MTU size you have to use and
then you must segment and reassembly in your code.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
