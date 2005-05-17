Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RSSI from rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <428A0F38.5050902@bungtopia.com>
References: <5256d0b050514160856c4d194@mail.gmail.com>
	 <1116112975.8886.25.camel@pegasus>
	 <5256d0b05051416323a633e2d@mail.gmail.com>
	 <1116115930.8886.27.camel@pegasus>  <428A0F38.5050902@bungtopia.com>
Content-Type: text/plain
Message-Id: <1116366629.10063.119.camel@pegasus>
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
Date: Tue, 17 May 2005 23:50:29 +0200

Hi Michael,

> I'm using pretty standard sockets to create a bluetooth connection. I 
> can communicate fine with my J2ME app however I was wondering if it is 
> at all possible to read the RSSI from an RFCOMM layer connection. I can 
> read it fine if I make a lower level connection, but this is not at all 
> suited to my application..
> 
> So, how can I read the RSSI when I dont have access to all the data I 
> need to pass to the hci_read_rssi() method??

you only need the ACL connection handle and you can get this with a
getsockopt() call through RFCOMM. Check rctest for an example.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
