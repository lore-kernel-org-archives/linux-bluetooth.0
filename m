Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Error messages from hid2hci
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qszis7lv8ho.fsf@mspacman.gpcc.itd.umich.edu>
References: <qszis7lv8ho.fsf@mspacman.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1101970554.15615.63.camel@pegasus>
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
Date: Thu, 02 Dec 2004 07:55:54 +0100

Hi Scott,

> After upgrading my D-Link DBT-120 with the Apple firmware, I have to
> use hid2hci to put it in hci mode.  hid2hci usually seems to work
> fine, except it prints out an error message:
> 
> If I plug the device directly in, I get:
> 
>   Switching device 0a12:1000 to HCI mode failed (Protocol error)
> 
> Through a hub, I get:
> 
>     Switching device 0a12:1000 to HCI mode failed (Invalid or incomplete multibyte or wide character)
> 
> This is with a very recent Bluetooth kernel from BK, bluez-libs-2.10,
> and bluez-utils-2.10

I think we should not print out certain error codes, because the switch
into HCI will be still succeed. However the error is correct, because
the device resets before the URB is completed.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
