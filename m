Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
From: Marcel Holtmann <marcel@holtmann.org>
To: acr@acroberts.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46161.80.63.28.114.1075214415.squirrel@acroberts.com>
References: <31555.80.63.28.114.1075193693.squirrel@acroberts.com>
	 <1075211962.12766.3.camel@pegasus>
	 <46161.80.63.28.114.1075214415.squirrel@acroberts.com>
Content-Type: text/plain
Message-Id: <1075213551.12766.22.camel@pegasus>
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
Date: Tue, 27 Jan 2004 15:25:52 +0100

Hi Antony,

> Thanks for the answer. I don't see any reason why BlueZ can't be
> implemented on Windows. Obviously the hardware drivers will have to be
> completely rewritten, but surely the tricky stuff (L2CAP and RFCOMM) can
> be used in a Windows environment?

you have to rewrite all kernel stuff including L2CAP and RFCOMM. Take a
look at the source code of the kernel (for example net/bluetooth/) and
you will see that the code is full of Linux specific API calls. It is
much more easier to write a Bluetooth stack from scratch than porting
BlueZ to the Windows platform.

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
