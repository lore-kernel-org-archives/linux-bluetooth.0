Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <408E3774.4000108@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] problem with a speed
References: <007f01c42bc3$76b70720$fcca010a@firedrake> <408D61EA.2050200@grupopie.com> <008d01c42bd5$cbeea6a0$fcca010a@firedrake>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 27 Apr 2004 11:35:32 +0100

zubiwat wrote:

> These are two PC's - one with a Linux and RS232 dongle. The other one with a
> windows and USB dongle.


Here's your problem. An RS232 dongle only goes up to 115200 baud. Over this 
bandwidth it has to encapsulate all H4 protocol. Under that protocol it still 
uses xmodem or ymodem (or whatever you're using) to send the actual data, so in 
the end you probably will only get around 8 kbytes/s.

You will probably lose a lot of bandwidth in flow control too.


> When I'm trying to send a file it takes a while. It's very slow. What is
> responsible for the speed of connection in bluetooth. BT is capable of more
> than 115200 so what is wrong? Is the configuration of RFCOMM connection -
> "modems" ?


BT is capable of more than 115200 on the air. If you have a serial dongle, there 
is no way to push more bits than the serial port can handle.


> I can't figure out what is wrong.
> 


Use 2 USB dongles.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
