Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011B0A@netbe01.net.unimis>
References: <E64BAD5A8AD46740828069A678D9DD73011B0A@netbe01.net.unimis>
Content-Type: text/plain
Message-Id: <1141845703.3098.4.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Rfcomm connection with pin number question
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
Date: Wed, 08 Mar 2006 16:21:42 -0300

Hi everybody,

I'm writing an application that uses rfcomm sockets to connect to remote
devices. I'm using some of the example code for how to use the blueZ
api, from Marcel. 

I wanted to know if there's a way of connecting to a remote device, that
needs a PIN number, without using the pin helper file or any of those
scripts... I just want to connect to the device passing, for example,
the pin code as a function parameter. 

Does anybody know if this can be achieved using the blueZ library, and
not using the pin helper file?

Thanks a lot!!!

Agustin Fusaro - Apexar Technologies



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
