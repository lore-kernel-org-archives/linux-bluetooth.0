Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan gives timeout on an ipaq 5500
From: Marcel Holtmann <marcel@holtmann.org>
To: Filipe Abrantes <fla@inescporto.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <415AF591.2040706@inescporto.pt>
References: <47EFEB1E.7010903@inescn.pt> <1096373451.4649.3.camel@notepaq>
	 <415AF591.2040706@inescporto.pt>
Content-Type: text/plain
Message-Id: <1096496864.6380.16.camel@pegasus>
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
Date: Thu, 30 Sep 2004 00:27:45 +0200

Hi Filipe,

> #hcidump -x
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
>   (#hcitool scan - (gives timeout) )
> 
> < HCI Command: Inquiry(0x01|0x0001) plen 5 
> 
>    33 8B 9E 08 0A
> 
>   (#hciconfig -a  - (also gives timeout)
> 
> < HCI Command: Read Local Name(0x03|0x0014) plen 0
> 
> 
> this is too cryptic for me, hope it helps you solving the problem, let 
> me know if you find something.

maybe the Bluetooth support for the iPAQ 5xxx is broken. They use some
weird Bluetooth chip and maybe you need some other settings for
hciattach, but I don't really not what are the best.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
