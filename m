Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Disconnection Time Out
From: David Woodhouse <dwmw2@infradead.org>
To: Talbi <amine@baracoda.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200408041724.43186.amine@baracoda.com>
References: <200408021859.44496.harbaum@beecon.de>
	 <200408031529.40100.harbaum@beecon.de> <1091540708.4259.88.camel@pegasus>
	 <200408041724.43186.amine@baracoda.com>
Content-Type: text/plain
Message-Id: <1091658266.1438.0.camel@imladris.demon.co.uk>
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
Date: Wed, 04 Aug 2004 23:24:26 +0100

On Wed, 2004-08-04 at 17:24 +0200, Talbi wrote:
> first I use rfcomm to connect a Bluetooth device to my Dongle.
> when I shut down the Bluetooth device, the disconnection is detected only 
> after 20 seconds.

You're asking this in a reply to a mail about L2CAP dropping packets.
Why do you believe that your disconnection time outs are related to
L2CAP dropping packets?

-- 
dwmw2




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
