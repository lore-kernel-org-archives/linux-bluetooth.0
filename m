Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Power level & Scan Timing
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Vidal Aroca <rafael@3wt.com.br>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <413F701F.5020905@3wt.com.br>
References: <413F701F.5020905@3wt.com.br>
Content-Type: text/plain
Message-Id: <1094715184.5237.3.camel@notepaq>
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
Date: Thu, 09 Sep 2004 09:33:04 +0200

Hi Rafael,

>     i'm playing with my dbt-120 d-link usb dongle, and i'm not managing 
> to do some things i wanted...
> 
>     1) I want to decrease the power or my dongle, cause de devices work 
> over 20m....i want they to be detected just near the computer. I know 
> it's possible, but could not find documentaion...so the question is: how 
> can i decreate the power of my bluetooth adapter?

don't worry about it, because your Bluetooth chip does this automaticly
and it is the job of the link manager.

>     2) I'm using hcitool scan to constantly detect if my ipaq is near my 
> desktop. It seems to be really slow (from 10 to 15 seconds to 
> scan)...can this time be reduced? Does bluez do some kind of cache? (i 
> ask that because i can turn my ipaq of, and hcitool scan will not only 
> detect my ipaq anymore in about 12 seconds...)

Check the specification for periodic inquiry or use the HCI directly.
You can also use the HCI socket directly and look for inquiry result
events.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
