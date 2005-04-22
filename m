Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] fixing hidp keycodes
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050421220305.GA28534@externe.net>
References: <20050421220305.GA28534@externe.net>
Content-Type: text/plain
Message-Id: <1114164987.32265.53.camel@pegasus>
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
Date: Fri, 22 Apr 2005 12:16:27 +0200

Hi Guylhem,

> I'm trying to replace hidp keycodes for a dell axim bluetooth keyboard
> with has conflicting keycodes with my zaurus internal keys.
> 
> I tried to change the keycodes in hidp/core.c - However looks like my
> modifications are only half applied, certainly due to a stupid
> mistake.

do you applied the -mh patch? If yes, then you device may run in report
mode and thus hidp_keycodes[] is not used, because it is boot mode only.

> How could I easily syslog the keycode from hidp_keycodes[] array being
> sent to the input layer ?

Use things like printk() or BT_ERR().

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
