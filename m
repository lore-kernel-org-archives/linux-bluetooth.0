Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Christoph Brill <egore@gmx.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
References: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
Date: Thu, 01 Nov 2007 22:38:07 +0100
Message-Id: <1193953087.10670.9.camel@egore912.egore.lan>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] multi-frequency scanning & US $2,000 'bounty'
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Mittwoch, den 31.10.2007, 19:56 -0800 schrieb Paul Huber:
> 1)  Spec out the hardware: With a budget of no more than US $40 per
> unit in quantities of 1,000, I need someone to say which USB Bluetooth
> dongle plus a antenna can be used to detect mobile phones as they pass
> through an area that is 6 meters x 6 meters.  I've ordered the
> following antenna already, which may be all that's needed:
> http://www.hyperlinktech.com/web/hg2412p.php   I would send you the
> antenna, the dongle, etc., so you could confirm it all works.  If it
> doesn't, and if you need to buy other dongles, antennas, or other
> hardware to do the testing, I will pay for that in addition to the
> bounty.  The hardware needs to be legal, such as not exceeding laws
> about radiation, but doesn't need to be Bluetooth certified. 

I think most if the dongles are able to to that. I used a cheap Anycom
dongle (~10 euros) that is able to detect mobile devices within an area
of 10 meters and even through walls. Reply times were very small when
the devices could see each other.

I did a similar software recently and it is able to find passing by
devices. The trick behind was to discover devices and cancel the
discovery after 3 to 5 seconds. This way you only get the "near ones".
After that immediately restart the discovery. The Anycom dongle was able
to handle this even with an internal antenna.

Maybe (ok, I'm sure!) there are better solutions out there (like
periodic discovery) but this one worked really fine.

> The software app can just write the mac + bluetooth id to stdout as
> the phones are detected.  That is sufficient for this, and I can do
> the rest.  I'd like the software to be in C or C++.  Ideally I'll
> probably use the 2.4 kernel for this since it seems lighter weight.
> But I'd need you to confirm that the bluetooth stuff works
> sufficiently well on 2.4, and we can go to 2.6 if needed.  It has to
> be reliable and accurate and detect a standard bluetooth phone that is
> not obscured by anything except perhaps fabric (ie in a pocket) 99% of
> the time.

I think using 2.4 because it's "lightweight" is nonesense. I use a 200
MHz epatec eTC-2300[1] with a 2.6.23 that is really stripped down. The
box is up in ~10 seconds and responses are great. It's even able to
handle the bluetooth 2 dongle.

[1] http://store.epatec.net/de/product_info.php?cPath=1&products_id=42


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
