Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] usb trendnet
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41DC8010.7050600@debiancolombia.org>
References: <41DC8010.7050600@debiancolombia.org>
Content-Type: text/plain
Message-Id: <1105014610.4299.28.camel@pegasus>
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
Date: Thu, 06 Jan 2005 13:30:10 +0100

Hi Fredy,

> I read the HW compatible list, and no is in it usb trendnet adapters, is 
> becouse are no tested or becouse are no soported?
> 
> I read the user and developer list archives whit the word trendnet and i 
> no get information.
> 
> I neds buy a usb adapter, the trendent TBW-102UB have 1000m, buy it?
> are any other 100m tested in linux?

you only know if it works if you buy it, but in general every USB
adapter works. However the CSR ones seem to work better than the rest,
but this is not a BlueZ problem.

After you get it working send us "hciconfig -a" and the content
of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
