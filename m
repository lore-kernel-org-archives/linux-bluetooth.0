Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Connection with a phone
	staysopenafterclosingRFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0503022132370.23041-100000@antilope>
References: <Pine.LNX.4.44.0503022132370.23041-100000@antilope>
Content-Type: text/plain
Message-Id: <1109800326.8284.35.camel@pegasus>
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
Date: Wed, 02 Mar 2005 22:52:06 +0100

Hi Victor,

> The /proc/bluetooth/rfcomm/{dlc,sock} are empty upon completion of the program. hcitool con gives:
> > ACL 00:0f:de:11:e4:42 handle 41  state 1 in SLAVE

and what does /proc/bluetooth/l2cap show?

In general if there are no more open RFCOMM channels, the DLCI 0 should
be closed and this should close the L2CAP connection on PSM 3. Seems
like we have a bug or a wrong reference counting somewhere. Please also
check lsmod for the "Used by" numbers. Do you see something unexpected.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
