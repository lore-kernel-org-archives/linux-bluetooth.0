Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN
From: Marcel Holtmann <marcel@holtmann.org>
To: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <d6795d5190.d5190d6795@estudiants.urv.es>
References: <d6795d5190.d5190d6795@estudiants.urv.es>
Content-Type: text/plain
Message-Id: <1082459219.23959.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Apr 2004 13:07:00 +0200

Hi Albert,

> Well, I already solved the problem with rfcomm, and
> now I'm trying to set up a PAN between two Belkin
> USB dongles. The thing is, when I have both USB
> plugged into my computer, I just can get one of them
> UP RUNNING, the other one is not possible to
> initialize, so it continues with DOWN, I want to
> create the PAN but I only have one computer to test
> it. Is this possible to do? 

getting both dongles running on the same computer is possible and you
can use up to 16 dongles, PCMCIA cards or serial adapters at the same
time. But it is not possible to create a PAN between two dongles on the
same computer. You won't see any traffic between them, because
everything goes over the loopback interface.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
