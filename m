Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: 2.6.2 errors with DBT-120 (B2)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Todd E. Johnson" <tejohnson@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402F99AC.7020500@yahoo.com>
References: <402E2E29.7040207@yahoo.com> <1076769794.14758.2.camel@pegasus>
	 <402E4E02.9020600@yahoo.com> <1076851622.14758.22.camel@pegasus>
	 <402F99AC.7020500@yahoo.com>
Content-Type: text/plain
Message-Id: <1076862048.2840.1.camel@pegasus>
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
Date: Sun, 15 Feb 2004 17:20:48 +0100

Hi Todd,

> If the SCO MTU for the device is too low prior to the URB submission, 
> would it generate the -90?
> 
> It seems 90 is defined as EMSGSIZE in:
> 
> errno.h:63:#define      EMSGSIZE        90      /* Message too long */
> 
> However, not remapped as other errors are in usb.h.
> 
> A quick grep of  hci_usb.c reveals the error is generated when:
> 
> Line 275:  err = usb_submit_urb(urb, GFP_ATOMIC);
> 
> Where a bit of the logic determines 'urb->transfer_buffer_length', then 
> submits with the resulting error.
> 
> Am I way off here?  I have attached the results of 'lsusb -v' to give 
> more info.  If you think I may be on the right track, I can _try_ to 
> play with it a bit, but it may take me some time since I am a bit rusty...

I am not an USB ISOC expert, so go ahead and play with it. If you have a
patch post it to the mailing list.

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
