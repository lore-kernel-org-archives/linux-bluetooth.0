Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C04@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C04@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099081368.6912.30.camel@pegasus>
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
Date: Fri, 29 Oct 2004 22:22:48 +0200

Hi Abhi,

> > And btw I got the service level security for incoming RFCOMM channels
> > working on my development system and I did it without modifying the
> > current state machine and it is hopefully SMP safe. I think we need
> > another timer on the server side that kills the connection if nobody
> > wants to authenticate, but thats another thing to look at. So someone
> > owes me a crate full of beer :)
> That is great news!! When do i get to see the code:)

my plan is to get out another -mh patch for 2.6.9 after I checked that I
didn't broke the L2CAP part.

> I don't know 
> where you live or else you would have a crate full of beer delivered to you
> right about now:) Thanks a bunch.	

Bring it with you to the UPF-20 :)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
