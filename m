Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PF_BLUETOOTH AF_BLUETOOTH redefinitions
From: Marcel Holtmann <marcel@holtmann.org>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401221347.32481.ach@mpe.mpg.de>
References: <200401221347.32481.ach@mpe.mpg.de>
Content-Type: text/plain
Message-Id: <1074776673.3071.4.camel@pegasus>
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
Date: Thu, 22 Jan 2004 14:04:33 +0100

Hi Achim,

> During compilation of some bluetooth apps I get lots of warings like this:
> 
> In file included from /usr/include/sys/socket.h:35,
>                  from connectiondlg.h:31,
>                  from connectiondlg.cpp:24:
> /usr/include/bits/socket.h:91: warning: `PF_BLUETOOTH' redefined
> /usr/include/bluetooth/bluetooth.h:43: warning: this is the location of the previous definition
> /usr/include/bits/socket.h:123: warning: `AF_BLUETOOTH' redefined
> /usr/include/bluetooth/bluetooth.h:42: warning: this is the location of the previous definition
> In file included from connectiondlg.h:35,
>                  from connectiondlg.cpp:24:
> /usr/include/bluetooth/hci.h:482: warning: ANSI C++ forbids zero-size array `condition'
> /usr/include/bluetooth/hci.h:909: warning: ANSI C++ forbids zero-size array `data'
> /usr/include/bluetooth/hci.h:1046: warning: ANSI C++ forbids zero-size array `dev_req'
> /usr/include/bluetooth/hci.h:1052: warning: ANSI C++ forbids zero-size array `conn_info'
> /usr/include/bluetooth/hci.h:1058: warning: ANSI C++ forbids zero-size array `conn_info'
> 
> Would be nice if bluetooth.h would not override stuff already defined
> 
> sys/socket.h:123:#define AF_BLUETOOTH    PF_BLUETOOTH
> 
> I would suggest that bluetooth.h includes itself sys/socket.h before checking if AF_BLUETOOTH
> is defined.   This removed the dependency on how headers are ordered in source files.
> Works for me ;)
> 
> hci.h may be due to old g++2.94.4 used on debian.  No idea about a workaround :(

include "sys/socket.h" before you include "bluetooth/bluetooth.h".

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
