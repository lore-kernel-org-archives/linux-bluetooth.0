Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PF_BLUETOOTH AF_BLUETOOTH redefinitions
From: Marcel Holtmann <marcel@holtmann.org>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221434.10203.ach@mpe.mpg.de>
References: <200401221347.32481.ach@mpe.mpg.de>
	<1074776673.3071.4.camel@pegasus>  <200401221434.10203.ach@mpe.mpg.de>
Content-Type: text/plain
Message-Id: <1073575676.7039.8.camel@merlin>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 08 Jan 2004 16:27:55 +0100

Hi Achim,

> That one solution, but why isn't it done by bluetooth.h itself?  Makes it header order
> independent, and fixes _once and forever_ annoying warnings like that.
> (that was my last try to convience you, promised ;)

it is not a nice programming style to include header files from another
header file. From my view only really needed headers should be included
from bluetooth.h and sys/socket.h is not needed at this point. It is
first needed when you start socket programming and if you do so I think
we can expect that you include sys/socket.h first.

> What about condition[0] etc in hci.h.  Should this be contition[] etc?
> 
> ach@allee(0) ~ $ fgrep '[0]' /usr/include/bluetooth/hci.h
>         uint8_t         condition[0];
>         uint8_t         data[0];
>         struct hci_dev_req dev_req[0];  /* hci_dev_req structures */
>         struct hci_conn_info conn_info[0];
>         struct hci_conn_info conn_info[0];

Maybe this is compiler problem, because this statement is correct.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
