Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <17ca747604072807081342839b@mail.gmail.com>
From: Carmine Pirro <carrip@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Fwd: [Bluez-devel] callback for L2CAP disconnection
In-Reply-To: <1091021474.3673.29.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <17ca74760407280608573db26d@mail.gmail.com> <1091021474.3673.29.camel@notepaq>
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
Date: Wed, 28 Jul 2004 16:08:18 +0200

The following is what i have to do:
a device A is connected to a device B.
When device A disconnects, a process on device B has to print the
device A bluetooth address on the screen with a appropriate message.

Thank you, Carmine.

---------- Forwarded message ----------
From: Marcel Holtmann <marcel@holtmann.org>
Date: Wed, 28 Jul 2004 15:31:14 +0200
Subject: Re: [Bluez-devel] callback for L2CAP disconnection
To: Carmine Pirro <carrip@gmail.com>
Cc: bluez-devel@lists.sourceforge.net

Hi Carmine,

> Does BlueZ stack provides a callback mechanism for L2CAP
> connections/disconnections?

what do you mean by callback? The BlueZ L2CAP implementation provides a
full sequential packet socket interface.

Regards

Marcel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
