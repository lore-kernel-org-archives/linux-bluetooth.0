Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp_search and l2cap concurrently
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41430846.4010006@uni-paderborn.de>
References: <41430846.4010006@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1094997749.5695.13.camel@pegasus>
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
Date: Sun, 12 Sep 2004 16:02:29 +0200

Hi Stefan,

> I've written a small library which uses the JNI to bring BlueZ to
> Java. Upon that, I'm writing a small "Location Aware
> Web-Service"-Demo. So my ClientApp has a DiscoveryThread which does
> non-cached inquiry and sdp_search() all the time, and an UpdateThread
> which uses the DiscoveryInfo to connect to the servers, measure RSSI
> and LQ and transmit the websites via L2CAP. Everything works fine
> while all devices are good in range, but if one device is at the edge
> of the range, sdp_search() blocks the DiscoveryThread and also seems
> to cripple/block the UpdateThread. I don't know why. I have seen that
> there is a hard coded 20s timeout in sdp_read_resp(). Is there a way
> to decrease this timeout or to make it a settable parameter in future
> versions? Anyway, sdp should not cripple l2cap, shold it? Any
> suggestions? Thanks in advance!

what do you mean by cripple L2CAP and use it concurrently. Explain in
more detail what your program is really doing and check how many low
level HCI connections are opened at the same time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
