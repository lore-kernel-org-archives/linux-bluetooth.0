Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <404274D0.7040005@superbug.demon.co.uk>
References: <40421024.20602@superbug.demon.co.uk>
	 <1078074126.1942.31.camel@pegasus> <40423226.8050007@superbug.demon.co.uk>
	 <1078087109.1942.54.camel@pegasus> <4042575B.20305@superbug.demon.co.uk>
	 <1078092105.1942.93.camel@pegasus>  <404274D0.7040005@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078097902.1942.120.camel@pegasus>
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
Date: Mon, 01 Mar 2004 00:38:22 +0100

Hi James,

> So you want me to implement it in such a way that would add 10-20ms of 
> latency and have no audio/video syncronisation features?

yes, do it.

> We might as well stay with the current alsa over network sockets which 
> is what we have now.

We will see what the latency really is if we go directly from the ALSA
driver to the HCI SCO interface.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
