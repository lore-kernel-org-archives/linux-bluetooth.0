Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ms explorer for bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: neoclust <n1c0l4s.l3@wanadoo.fr>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200410140046.41141.n1c0l4s.l3@wanadoo.fr>
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr>
	 <200410131143.26811.n1c0l4s.l3@wanadoo.fr>
	 <1097662706.4643.21.camel@notepaq>
	 <200410140046.41141.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1097753304.4640.47.camel@notepaq>
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
Date: Thu, 14 Oct 2004 13:28:24 +0200

Hi Nicholas,

> i don't know how but when i wanted to scan my pocket pc doing :
> 
> hcitool scan 00:04:3E:45:A7:9F
> 
> the answer was :
> 
> $ hcitool scan 00:04:3E:45:A7:9F
> Scanning ...
>         00:50:F2:80:A1:2B       Microsoft Keyboard
> 
> 
> but i don't find how to connect him with hciconfig :(

use "hcitool info 00:50:F2:80:A1:2B" as root. Maybe you need to pair and
the device is still waiting for the PIN. So enter a PIN on the number
key of your keyboard and press enter. If a PIN box pops up on your PC
enter the same PIN. And always run "hcidump -x" as root to see happens
on the link.

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
