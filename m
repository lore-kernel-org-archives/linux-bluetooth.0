Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange answer from HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000a01c41299$f48241d0$fcca010a@lysydziadek>
References: <000a01c41299$f48241d0$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080258434.2283.52.camel@pegasus>
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
Date: Fri, 26 Mar 2004 00:47:14 +0100

Hi Maciej,

> I'm programming a microchip to work with BT and when I send some bits
> I get in the answer sth like this: 04 10 01 FE.
> If someone knows what it means I would be greatfull for some help.
> How to set parameteres like pscan or read BD ADDR by sending bits to
> BT dongle. Does any one knows what bits are coresponding to what
> commends while setting parameteres of BT because I know bits for
> transmition from Specification.

it is all in the Bluetooth HCI specification. You should really read and
understand it. Your bytes mean

	HCI event, hardware error, error code 0xfe

The error codes are vendor specific, so I don't know what 0xfe means.

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
