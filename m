Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Pairing fails with RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <1076337219.2892.57.camel@localhost>
References: <1076087010.964.75.camel@localhost>
	 <1076097441.14418.40.camel@pegasus>  <1076337219.2892.57.camel@localhost>
Content-Type: text/plain
Message-Id: <1076338869.6869.174.camel@pegasus>
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
Date: Mon, 09 Feb 2004 16:01:09 +0100

Hi Nils,

> It seems that minicom implements a timeout on open()ing the tty. This
> times out before the authentication took place. When using rfcomm
> connect first or using cat the connect works.
> So this is indeed not a BlueZ/RFCOMM problem, because IMHO there is no
> real way to fix it (only possible solution would be to always allow
> open()ing the port, paired or not, connected or not).

this is not really a solution, because it moves the detection of
Bluetooth connection errors out of the scope.

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
