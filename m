Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Windows Port
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: acr@acroberts.com, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>
Content-Type: text/plain
Message-Id: <1075276388.12766.49.camel@pegasus>
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
Date: Wed, 28 Jan 2004 08:53:08 +0100

Hi Peter,

> I may be stating the obvious, but do not forget about the 
> license issue. As far as I can tell from a quick search 
> through the BlueZ repository, only the code in libs2/lib 
> and utils2/lib is under LGPL, the rest (including the "old" 
> libraries) are under GPL. This means that any program or
> kernel driver that uses any of the GPLed parts need to be 
> GPLed too. (This, btw, goes for Linux applications too that 
> use or link with the GPLed parts.)

actually there is no problem with GPL or LGPL software on the Windows
platform, but you are right that every kernel driver or program must be
licensed under GPL, too.

The libs2 is not really LGPL at the moment (even if the header of the
files say so). Max and I already agreed that we should make the new
library LGPL, but there are still some code snippets that are copyright
by Qualcomm. And this code is GPL only at the moment, which means that
the complete code will be still under the GPL. Maybe it is a good time
to discuss this now. Max, what is the current status on this?

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
