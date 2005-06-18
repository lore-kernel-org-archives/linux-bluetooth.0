Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] TI BTS for hciattach
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B31512.8060301@sdgsystems.com>
References: <42B31512.8060301@sdgsystems.com>
Content-Type: text/plain
Message-Id: <1119137087.9217.3.camel@pegasus>
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
Date: Sun, 19 Jun 2005 01:24:46 +0200

Hi Todd,

> This proposed patch implements the TI BTS (Bluetooth script) mechanism.
> I have attached the diff and new files to be built along with hciattach.
> I have also attached a sample BTS file (the one that goes along with the
> BRF6150 plus firmware, as found in the iPAQ hx4700). The code is a bit
> chatty (prints BTS comment lines), but provides feedback as to what is
> being done with the chip. Comments / Suggestions welcome.

is it possible to get a development kit with the BRF6150 from TI? I like
to test this new code.

Do we get the full specification of BTS? I think we need to rewrite some
parts of the TI code. I don't like the coding style and parts of it look
too much like crappy Windows code.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
