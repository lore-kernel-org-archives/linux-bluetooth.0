Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] where is rfcomm souce code?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <310527409.26361@bjut.edu.cn>
References: <310527409.26361@bjut.edu.cn>
Content-Type: text/plain
Message-Id: <1110577369.8511.4.camel@pegasus>
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
Date: Fri, 11 Mar 2005 22:42:49 +0100

Hi,

> 	Hi, Marcel. As you said,the source code of RFCOMM protocol in Bluez could be
> found in linux-2.6.11,but I have found some source code about rfcomm in the
> bluez-utils-2.15. So I want to make it clearly that what is the difference between
> them.

the need the RFCOMM source in bluez-utils-2.15 to create the RFCOMM TTY
terminal emulation devices. It is like you need ifconfig to manage your
local ethernet interface.

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
