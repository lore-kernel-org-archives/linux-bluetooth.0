Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Question regarding rfcomm-timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Eller <te@identisys.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40570F3F.90607@identisys.de>
References: <40570F3F.90607@identisys.de>
Content-Type: text/plain
Message-Id: <1079448460.3307.96.camel@pegasus>
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
Date: Tue, 16 Mar 2004 15:47:40 +0100

Hi Thomas,

> I'm using the rfcomm executable from bluez-utils to connect to a 
> bluetooth device. It looks like this:
> 
> rfcomm connect 0 xx:xx:xx:xx:xx:xx 1
> 
> If the remote device is not present the rfcomm-connect ends with a 
> timeout after ~20s with the error-message: "Can't connect..... ...Host 
> is down."
> 
> Where can i push this 20s-timeout down to a lower value ???
> 
> I see in the source-code that a socket-connection is made, so possibly 
> there may be a parameter that can be configured through the 
> proc-filesystem ?!?

the timeout you talk about is the page timeout and it is a HCI specific
parameter.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
