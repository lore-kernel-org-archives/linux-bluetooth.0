Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Internal Bluetooth on dell latitude d610?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4292E9B9.7080907@logicacmg.com>
References: <4291DFA9.6010401@logicacmg.com>
	 <1116857742.30044.88.camel@pegasus>  <4292E9B9.7080907@logicacmg.com>
Content-Type: text/plain
Message-Id: <1116925311.30044.134.camel@pegasus>
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
Date: Tue, 24 May 2005 11:01:51 +0200

Hi Thomas,

> Fn+F2 as you suggested really moved me a bit further, unfortunately, 
> only to another error message:
> 
> usb 3-1: new full speed USB device using address 2
> usb 3-1: control timeout on ep0out
> 
> after this message, cat /proc/bus/usb/devices hangs on forever.
> Hm. Probably a kernel bug / unsupported BT device? I tried to do a 
> google search, found some similar questions but no answer :/

try a 2.6.12-rc4 kernel and you should really update the BlueZ packages.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
