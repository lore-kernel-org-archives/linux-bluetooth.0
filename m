Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Detecting RSSI without connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qsz653ndf21.fsf@asteroids.gpcc.itd.umich.edu>
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
	 <1099960170.29330.43.camel@pegasus>
	 <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
	 <1101413321.6465.6.camel@pegasus>
	 <qszzn10q72i.fsf@timepilot.gpcc.itd.umich.edu>
	 <1101792690.7562.54.camel@pegasus>
	 <qsz653ndf21.fsf@asteroids.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1101796897.7562.104.camel@pegasus>
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
Date: Tue, 30 Nov 2004 07:41:37 +0100

Hi Scott,

> > I maybe gonna change the complete interface to the inquiry stuff in the
> > future and so I haven't added support for inquiry with RSSI so far. 
> 
> OK.  I can find time to help test this and perhaps help with the
> coding when you're ready to add this support.

right now I like to wait until I get access to the Extended Inquiry
Response (EIR) proposal. The Bluetooth 2.0 specification deprecated
another field of the inquiry result events and the next interface must
be a little bit more generic.

> > You don't need to hack something on hcidump, simply use the HCI raw
> > socket interface. Send the inquiry command and wait for the
> > events. You will find example code for this and listening on the 1.1
> > inquiry event in the mailing list archive. It should be easy to
> > adapt.
> 
> Ah, this program:
> 
>     http://article.gmane.org/gmane.linux.bluez.user/1191
> 
> looks like a great place to start.  I'll hack at it for a bit over the
> next few days and post an update.

Exactly one of these (there are for examples).

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
