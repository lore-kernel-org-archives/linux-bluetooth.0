Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4032B8FB.8050309@plausible.org>
From: Andy Ross <andy@plausible.org>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM bug?
References: <40329CA6.7080302@mdolabs.com>	 <1077060827.2665.137.camel@pegasus>  <4032AA5C.3060505@plausible.org> <1077062902.2665.158.camel@pegasus>
In-Reply-To: <1077062902.2665.158.camel@pegasus>
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
Date: Tue, 17 Feb 2004 16:59:39 -0800

Marcel Holtmann wrote:
> the question is what should be default? This is application specific
> and so the kernel can't (and shouldn't) do anything about it.

I don't follow.  The initialization state for a tty device is
obviously set by the kernel, not an application.  I'm simply saying
that the kernel should initialize rfcomm devices to a state that
matches RS232 devices, since that is what the user expects.

It's just a principle of least surprise argument.  I mean, the rfcomm module
*could* do anything by default.  But some choices make more sense than
others.

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
