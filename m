Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4032AA5C.3060505@plausible.org>
From: Andy Ross <andy@plausible.org>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM bug?
References: <40329CA6.7080302@mdolabs.com> <1077060827.2665.137.camel@pegasus>
In-Reply-To: <1077060827.2665.137.camel@pegasus>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 17 Feb 2004 15:57:16 -0800

Marcel Holtmann wrote:
> set the RFCOMM terminal device into raw mode and everything works
> fine.

Duh, dunno why I didn't try that.  A simple stty -cooked indeed fixes
the problem.

That said: isn't this still a bug?  Serial ports don't behave this way
by default, and an rfcomm device is supposed to look like an RS232
device.  Certainly a hardware tty *can* be made to echo to the remote
device, but that's the job of programs like getty to set up properly.
Something seems backwards here, is there a reason for making
/dev/rfcomm* work differently from /dev/ttyS*?

Andy


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
