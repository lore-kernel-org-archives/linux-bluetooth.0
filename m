Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] absolute clock
From: Marcel Holtmann <marcel@holtmann.org>
To: paolo2278@freemail.it
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040331104607.18049.qmail@mail.supereva.it>
References: <20040331104607.18049.qmail@mail.supereva.it>
Content-Type: text/plain
Message-Id: <1080730564.2674.2.camel@pegasus>
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
Date: Wed, 31 Mar 2004 12:56:04 +0200

Hi Paolo,

> I have a great problem, I'd like to know wich is the structure where I can find the value of the bluetooth's absolute clock, or the function that I could call for read this value.
> I created the hci command packet to get this information, but what I can see is only the lenght of the event parameters but not their values.

about what clock are you talking? With Bluetooth 1.1 you can only read
the clock offset of a remote device. With 1.2 you can also read the
local and remote clock values. Look at the HCI specification.

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
