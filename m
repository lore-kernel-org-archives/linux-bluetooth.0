Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap xfer fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401281200.07012.mtortonesi@ing.unife.it>
References: <200401281135.58062.mtortonesi@ing.unife.it>
	 <200401281200.07012.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1075288960.12766.66.camel@pegasus>
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
Date: Wed, 28 Jan 2004 12:22:40 +0100

Hi Mauro,

> what i wanted to say is that i can transfer (over L2CAP) data from console, 
> but transfer of files redirected to stdin always fails. perhaps i am doing 
> something wrong? such as calling write(2) over L2CAP sockets with buffers 
> larger that 762 bytes?

I haven't checked the nc6 Bluetooth support so far, but the L2CAP is a
SOCK_SEQPACKET and it has an in and an out MTU. The default MTU is 672
and this means if you send data with a larger buffer, the write() will
fail.

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
