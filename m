Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Error when executing rctest.c
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <B72A22937C14184DB0AF3324476E9C791A53F9@MBOX22.stu.nus.edu.sg>
References: <B72A22937C14184DB0AF3324476E9C791A53F9@MBOX22.stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1105960763.8080.25.camel@pegasus>
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
Date: Mon, 17 Jan 2005 12:19:23 +0100

Hi Teck,

> I can compile rctest.c, but I get the following error when executing rctest.c
>  
> Can't set L2CAP link mode. Protocol not available(92). 
>  
> I am using Fedora Core 3 with a Silicon Wave USB dongle. 

the error message is wrong. Use the latest version where this is fixed.
To set the link mode on a RFCOMM socket you need at least 2.6.10-mh1.
However RFCOMM service level security is not fully implemented at the
moment.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
