Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Changing baud default in CSR
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat@poczta.onet.pl
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200403041254.47428.zubiwat@poczta.onet.pl>
References: <200403041254.47428.zubiwat@poczta.onet.pl>
Content-Type: text/plain
Message-Id: <1078401373.5347.8.camel@pegasus>
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
Date: Thu, 04 Mar 2004 12:56:13 +0100

Hi Maciej,

> I have to change the default baud base in chip because it is set to 921600 and 
> I have to use microchip to translate this 921600 to 115200. Now it is the 
> only way for me to connect to my BT through RS232. I want to change this 
> default baud to be able to connect directly to my BT through RS232 without 
> any microchip between them.
> Please help to find a command or sth to change this - offcourse if it's 
> possible.

look for the pskey tool.

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
