Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT Initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00a401c41436$58423520$fcca010a@lysydziadek>
References: <009401c4142a$b06be720$fcca010a@lysydziadek>
	 <1080413063.2281.59.camel@pegasus>
	 <00a401c41436$58423520$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080418812.2281.78.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 27 Mar 2004 21:20:12 +0100

Hi Maciej,

> I wanna code which isn't useing system specific commands like ioctl() or
> other but simple sending bytes.

if you don't like the BlueZ code, don't use it. There are many Bluetooth
stacks on the market and you also have the freedom to write your own
one. But how do you expect help from us?

> The code from blueZ is fine and the answers are the same (almost) like those
> commented out examples. But after this i get only this vendor specific event
> and can't get answers to my commands like reading BT ADDR and other.
> If you know what is wrong please help. I have to use bits as a commands
> because I'm using only UART between my microchip and BT CSR chip. I red
> Bluetooth specification v1.1 , v1.2 and UART specification as you told me
> earlier but I alweys get the same answer and can't get through. When I read
> those bytes and then try to send wrong command like 0x00 0x00 0x09 it
> answers with a error event 04 10 01 fe and this is the only right answer I
> can get.

This is the general init code from BlueZ:

	< 01 03 10 00 
	> 04 0E 0C 01 03 10 00 2F BE 05 00 00 00 00 00 
	< 01 05 10 00 
	> 04 0E 0B 01 05 10 00 A0 02 00 06 00 00 00 

I got it by running BlueZ and using hcidump in raw mode. Decode it and
learn from it.

> I looked for other forums but I couldn't find any. If you can't answer to my
> questions and know proper forum please tell me because this is my work for
> master's degree and it's important for me.

Actually I can't do your research for your master degree.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
