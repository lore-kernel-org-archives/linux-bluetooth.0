Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Patch for kernel oops while
	disconnecting	devices (hci_usb.c)
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FDFAC8D.7080500@ahsoftware.de>
References: <10800000.1071618502@[192.168.207.2]>
	 <1071622226.27570.35.camel@pegasus>  <3FDFAC8D.7080500@ahsoftware.de>
Content-Type: text/plain
Message-Id: <1071623889.27570.42.camel@pegasus>
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
Date: Wed, 17 Dec 2003 02:18:09 +0100

Hi Alexander,

> > what happens if you compile the HCI USB driver without SCO support?
> 
> The same as with this patch and SCO support, it works. Because that 
> pointer on the lkml I've found the fix/workaround relativly fast.

I never have worked on USB with ISOC transfers, so I don't know what is
the correct way to fix it. I propose that you send a full detailed bug
report (with ksymoops etc.) to the USB developer mailing list and let us
see what they say.

BTW the BT_DBG is not non-functional ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
