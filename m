Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: read_RSSI and others not thread-safe?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4166A8D8.3080707@uni-paderborn.de>
References: <41668ADE.7010004@uni-paderborn.de>
	 <4166A8D8.3080707@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1097249347.4407.21.camel@pegasus>
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
Date: Fri, 08 Oct 2004 17:29:08 +0200

Hi Stefan,

> I looked into the code and I think the problem is somewhere inside of 
> bluez-libs' "hci_send_req()". The connection handle field of the events 
> are not compared to the one from the request. Actually, this should be 
> no problem since there shold be some kind of pre-filtering inside the 
> kernel by the hci socket. I don't know. It doesn't seem to happen with 
> l2cap and so I'll use the "synchronized" workaround (which costs a 
> little performance). But if someone finds the problem, I'm interested in it.

there is no pre-filtering for this kind of stuff. Feel free to send in a
patch for checking the connection handle.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
