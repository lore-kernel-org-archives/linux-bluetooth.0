Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Detecting RSSI without connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qszzn10q72i.fsf@timepilot.gpcc.itd.umich.edu>
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
	 <1099960170.29330.43.camel@pegasus>
	 <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
	 <1101413321.6465.6.camel@pegasus>
	 <qszzn10q72i.fsf@timepilot.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1101792690.7562.54.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Nov 2004 06:31:30 +0100

Hi Scott,

> > If you buy a CSR based Bluetooth 1.2 device it will support inquiry with
> > RSSI. Also the 1.2 Silicon Wave based and the AVM BlueFRITZ! USB v2.0
> > have this support. However both have a bug, but you can work around it.
> > Maybe the easiest way is a D-Link DBT-120 Rev. B3 and then put the Apple
> > firmware update on it.
> 
> Thanks for the advice, I got a DBT-120 and put the Apple firmware on
> it (yet another reason I'm glad we bought a Mac for my wife), and I
> can now get the RSSI from an inquiry!
> 
> That is to say, I can see it in hcidump.  I don't see the results in
> "hcitool inq", and from a quick look at the source code it looks like
> that information isn't returned from the kernel.  Are there plans to
> provide this information via the kernel and libraries, or should I
> plan on hacking something up with hcidump?

I maybe gonna change the complete interface to the inquiry stuff in the
future and so I haven't added support for inquiry with RSSI so far. You
don't need to hack something on hcidump, simply use the HCI raw socket
interface. Send the inquiry command and wait for the events. You will
find example code for this and listening on the 1.1 inquiry event in the
mailing list archive. It should be easy to adapt.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
