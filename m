Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rctest[3790]: Can't set L2CAP link mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <cqunik$ule$1@sea.gmane.org>
References: <cqunik$ule$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1104348843.6325.1.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Dec 2004 20:34:03 +0100

Hi,

> This is part of my lsmod output:
> 
> [soraberri@castejon temp]$ lsmod
> Module                  Size  Used by
> hci_usb                15041  3
> rfcomm                 36701  2
> l2cap                  25285  7 rfcomm
> bluetooth              46917  11 hci_usb,rfcomm,l2cap
> 
> sdpd and hcid are running
> 
> I think all the important stuff is there, and then why am I getting the 
> following error?
> 
> [soraberri@castejon temp]$rctest -r
> rctest[3790]: Can't set L2CAP link mode. Protocol not available(92)

this error is wrong and I actually fixed it in the CVS now.

> Well it seems that the error is born within the call to
> setsockopt(s, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt))
> in rctest.c

You need a kernel with RFCOMM service level security support. This is
not mainline yet.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
