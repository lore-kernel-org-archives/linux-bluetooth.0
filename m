Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't create socket.: No such file or directory
From: Marcel Holtmann <marcel@holtmann.org>
To: Carl Norum <carl.norum@usask.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <51279096-6253-11D8-9EE6-000393C5CB34@usask.ca>
References: <51279096-6253-11D8-9EE6-000393C5CB34@usask.ca>
Content-Type: text/plain
Message-Id: <1077186017.2685.18.camel@pegasus>
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
Date: Thu, 19 Feb 2004 11:20:17 +0100

Hi Carl,

> I've just finished installing BlueZ on a Mandrake machine of mine, but 
> I can't make l2ping work.  "hcitool scan" and "hcitool inq" both show 
> me the other bluetooth machine (iBook with 3Com dongle), and "hcitool 
> cc --role=m ...." appears to work too, as "hcitool con" shows the 
> connection.  l2ping however, just always says "Can't create socket.: No 
> such file or directory", and that's it.

load the l2cap.o kernel module.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
