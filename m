Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <csllc3$c6d$1@sea.gmane.org>
References: <82721080501190249144cfac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <82721080501190249144cfac0@mail.gmail.com>
Subject: [Bluez-users] Re: bluez-utils-2.14 compile error: make returns "cannot find -lbluetooth"
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
Date: Wed, 19 Jan 2005 13:55:30 +0100

Hello!

I guess your linker just can't find the bluetooth library because you 
have installed it into a non-standard path.
 > ./configure --prefix=/usr/local/bluez

make install runs the command `ldconfig -n /usr/local/bluez/lib' but the 
option -n forces ldconfig just to create the library links and not to 
update the cache. (man ldconfig)
Add this path to your /etc/ld.so.conf and re-run ldconfig as root.

`ldconfig -p | grep bluetooth' should show libbluetooth now!

Best regards,
Sebastian



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
