Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth pand and isp116x problems partly solved
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opsfbotflbeocfdv@debian>
References: <opsfbotflbeocfdv@debian>
Content-Type: text/plain
Message-Id: <1096882112.20349.13.camel@pegasus>
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
Date: Mon, 04 Oct 2004 11:28:33 +0200

Hi Christoph,

> i wrote to the list a long time ago, because I had the problem, that a
> pand connection didn't work. And after trying this the usb dongle
> produced only timeouts.
> 
> You pointed me to the usb host controller that could be the
> problem and of course you ware right.
> 
> I found out that the host controller driver needed a 4 msec deelay in a
> function hc_submit_urb to work properly.
> But sadly I don't understand WHY this helps. I believe my solution is
> only a cure for the symptom not for the cause.
> And it's not the right playe for a delay in this function, I think.

ask the host controller driver maintainer about that and move this
question to the USB devel mailing list. Include the patch that you use
to make it working.

> What I would like to know now:
> Why is pand (or dund or ppp over rfcomm) so critical?
> l2ping gave no errors, and also other usb tasks were ok.

The HCI commands and events are control or interrupt URB and for all
other higher protocols based on L2CAP the bulk interrupts are used and
maybe our current URB handling in the hci_usb driver is not perfect.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
