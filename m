Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unknown answer
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: devel Bluetooth <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000e01c4145d$904fa7f0$fcca010a@lysydziadek>
References: <000e01c4145d$904fa7f0$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080462748.2281.92.camel@pegasus>
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
Date: Sun, 28 Mar 2004 10:32:28 +0200

Hi Maciej,

your questions are annoying me and this will be the last one I answer.
Please stop posting non BlueZ related things to our mailing lists,
because otherwise I have to ban you.

> I'm sending these commands :
> 0x01 0x05  0x10  0x00
> 0x01 0x09  0x10  0x00
>  
> and I don't understand why I get answer like this:
>  
> 04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 00 00 00 00 00 04
> 0E 0B 01 05 10 00 C0 00 40 08 00 08 00 04 0E 0A 01 09 10 00 04 00 20
> DD 09 00 

You should have taken my advise and sit down and decode your results,
because then you had seen the answers.

04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 00 00 00 00 00

This is a vendor specific event. Ask your module manufacturer.

04 0E 0B 01 05 10 00 C0 00 40 08 00 08 00

And this is the result of the reading the buffer size.

04 0E 0A 01 09 10 00 04 00 20 DD 09 00

And here we have your local BD_ADDR, which is 00:09:dd:20:00:04

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
