Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Network Access Point - pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: "D.W." <sword@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001201c4c128$5c9137d0$0300a8c0@supercomputer>
References: <001201c4c128$5c9137d0$0300a8c0@supercomputer>
Content-Type: text/plain
Message-Id: <1099440420.7125.16.camel@pegasus>
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
Date: Wed, 03 Nov 2004 01:07:00 +0100

Hi Daniel,

> I want to use bluez for a standalone network access point. All works
> fine(pand or dund), the thing is that the pairing doesn't work at
> first contact (client is a windows-pc). 
> 
> So I have to establish a rfcomm-connection manually(from the server
> side rfcomm connect 0 btad) first. This pairing works,  I disconnect
> and then I am able to connect the client to the NAT.
> 
> Does anybody know what's wrong and what I can do to make the pairing
> work without this manually initiated rfcomm-connnection ?

are we talking about security mode 2 or security mode 3? What kernel do
you use?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
