Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hi all !
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A6046D.30800@xgarreau.org>
References: <41A6046D.30800@xgarreau.org>
Content-Type: text/plain
Message-Id: <1101423126.6465.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 Nov 2004 23:52:06 +0100

Hi Xavier,

> I'm currently teaching some students the bluetooth protocol stack
> 
> Next wednesday, we'll talk about bluetooth programming.
> 
> I have no problem with HCI, L2CAP or RFCOMM programming but I would like 
> to advertise a custom service using sdp calls.
> 
> I never used sdp api, did any of you wrote some white paper about 
> bluetooth programming involving sdp (i found 
> http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf but it's not 
> dealing with sdp)
> 
> My sample app for the session will be a time server working on top of 
> l2cap (PSM ccee) and I'd like to advertise it on sdp server. We'll also 
> be talking of rfcomm stream sockets.

the programs dund and pand show you how to advertise a SDP record.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
