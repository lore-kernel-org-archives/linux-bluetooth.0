Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050208134358.17173.qmail@web53202.mail.yahoo.com>
References: <20050208134358.17173.qmail@web53202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107880993.7327.190.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 08 Feb 2005 17:43:13 +0100

Hi Filipa,

> I do not want to push the discussion about BlueZ
> documentation further, however I found a document that
> could help some of you:
> 
> http://affix.sourceforge.net/affix-tech-doc/1.0/index.html
> 
> Although this document is written for Affix (another
> Bluetooth protocol stack for Linux - I know that this
> could be considered unpolite...) I believe that the
> "General Architecture" chapter should be similar to
> the BlueZ Architecture (Marcel, could you please
> confirm this?).

the core architecture is different, because BlueZ hardware is not a
network device. The IrDA stack made this mistake and so did Affix. The
BlueZ uses its own hardware interface. Our driver interface is a lot
much cleaner.

> This document help me understanding what parts of the
> stack are on the Kernel Space and on the User Space
> and how they interact. And... I did not have to
> "follow the code" yet ;))!

I wrote some articles for German magazines and there are also some
papers on the web. And a lot of my presentation slides are available.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
