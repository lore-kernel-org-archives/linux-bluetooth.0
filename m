Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: digger vermont <dv_mlist@verizon.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1074818667.1733.27.camel@localhost>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
	 <1074698544.7088.102.camel@pegasus>  <1074749699.2573.17.camel@myrna>
	 <1074775827.3071.1.camel@pegasus>  <1074814697.3159.3.camel@myrna>
	 <1074816664.3071.60.camel@pegasus>  <1074818667.1733.27.camel@localhost>
Content-Type: text/plain
Message-Id: <1074819483.3071.79.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Jan 2004 01:58:03 +0100

Hi Max,

> I can confirm that. Xircom PC cards don't work with 2.6 anymore.
> Everything seems to be ok. Serial driver recognizes UART, creates a
> port, etc. But hciattach always times out and I see only one or two
> interrupts on that port. Unfortunately I don't have much more details
> than that, didn't have time to investigate. I tried simple stuff like
> different baud rate, reset, different interrupts (ie setserial) etc.
> Nothing works.

I checked it with my Xircom some hours ago and yes, it don't works. I
have no explanation for that, so someone should write all this up and
prepare a post for the Linux serial mailing list and notify Rusty Russel
about it. Digger, will you do this?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
