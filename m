Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
	service happens on two systems trying to talk to each other
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Marc-Andr=E9_Laverdi=E8re?= <m_laverd@alcor.concordia.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077309735.4036712706cd0@alcor.concordia.ca>
References: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>
	 <1077022337.2841.15.camel@pegasus>
	 <1077033023.4032383f0b3d3@alcor.concordia.ca>
	 <1077034212.2665.19.camel@pegasus>
	 <1077309735.4036712706cd0@alcor.concordia.ca>
Content-Type: text/plain
Message-Id: <1077318893.1433.6.camel@pegasus>
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
Date: Sat, 21 Feb 2004 00:14:53 +0100

Hi Marc-Andre,

> Here's the situation in more Bluetooth-compliant terms:
> Configuration:
> Belkin FT0003 USB dongles
> RedHat 9 with kernel 2.4.28, from RedHat
> Running with latest released versions of BlueZ
> Running Impronto 1.18
> Running Java SDK 1.4.2.3

I can't tell you anything about the Java part, but the kernel version
that you are using don't exists ;)

> Bluetooth activity (all happening in Java):
> 
> Implicit: Inquiry Scan [device is set as GIAC]
> Thread 1: Inquiry [aka Device Discovery] [runs perpetually, with some sleeping
> between each iteration]
> Thread 2: Page Scan [opening a service and waiting for clients with
> acceptAndOpen()]
> Thread 3: SDP Paging + Connection [Service Discovery] [does so when new devices
> are found, could happen anytime. Sleeps most of the time]
> Thread 4: Paging + Connection [L2CAP Connection as a slave] [happens at user's
> input]
> 
> Computer A and Computer B are running this configuration
> Planned Test:
> Start program on both computers
> Wait for both Computer A and Computer B to discover each other via Inquiry
> User prompts Computer A to send a message to Computer B [creating a L2CAP
> connection]
> Computer B reads the message and closes the connection
> Both shut down their services and exit cleanly
> 
> What happens:
> Inconsistent behaviour. Service discovery can happen promptly on Computer A and
> never finish on Computer B. Sometimes, service discovery completes around 20
> seconds for both systems.
> The L2CAP connection may not establish itself. Behaviour varies at every test's
> run, but generally the results look like a deadlock has occured somewhere.
> Very low Bluetooth performance compared to the speed of other configurations.
> 
> I hope this makes more sense. I have to read more about the Bluetooth spec, see
> what I'm doing wrong Bluetooth-wise. Any sections particularly?

The problem that I see is that if device A runs an inquiry and device B
tries to page device A at the same time, this will fail. But this is a
topic for baseband experts and not for me. You can try to disable page
scan before you run an inquiry and re-enable it when your are finished.
Same goes for the inquiry scan.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
