Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT Initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: devel Bluetooth <bluez-devel@lists.sourceforge.net>
In-Reply-To: <009401c4142a$b06be720$fcca010a@lysydziadek>
References: <009401c4142a$b06be720$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080413063.2281.59.camel@pegasus>
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
Date: Sat, 27 Mar 2004 19:44:23 +0100

Hi Maciej,

> I'm setting CSR BT device using code from blueZ hciattach.c
> and after this when I'm trying to send some commands I get only this:
> 04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 00 00 00 00 00
> I get this even when I'm not sending anything. I looked for this event
> into specification and couldn't find it.
> I think that I have to send some command to set BT up and then it will
> listen to my other commands like reading BT ADDR.
> If someone could send me a code how to set up BT device and read
> BT ADDR for example I would be greatfull.

this is a vendor specific event and if you had looked into the BlueZ
source you would have seen that we send as first command the read local
supported features HCI command. Actually my question is what kind of
code do you wanna to see, because the complete BlueZ stack is open
source.

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
